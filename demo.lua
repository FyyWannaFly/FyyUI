local source = game:HttpGet("https://raw.githubusercontent.com/FyyWannaFly/FyyUI/main/FyyUIKeyService.lua")
local chunk, compileError = loadstring(source)
assert(chunk, "FyyUI compile error: " .. tostring(compileError))
local FyyUI = chunk()

local menu = FyyUI.Menu({
	Title = "FyyCommunity",
	Theme = "Amoled",
	Size = UDim2.fromOffset(601, 344),
	Resizable = true,
	HasOutline = true,
	Stats = {
		Enabled = true,
		TabName = "Overview",
		ShowProfile = true,
		ShowGame = true,
		ShowServer = true,
		ShowSupport = true,
	},
	Support = {
		Discord = "https://discord.gg/example",
	},
	Logo = true,
	Responsive = true,
	CompactBreakpoint = 640,
	SafePadding = 12,
	TouchTargetSize = 44,
	ReducedMotion = false,
})

local function notify(title, content, kind)
	menu:Notify({
		Title = title,
		Content = content,
		Type = kind or "Info",
		Duration = 3,
	})
end

-- Real portable Key Service adapter. Runtime ownership intentionally stays in
-- this main/demo script, not inside FyyUIKeyService.lua.
local HttpService = game:GetService("HttpService")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local API_ORIGIN = "https://lounge-marketplace-newark-operated.trycloudflare.com"
local UINT32 = 4294967296
local accessSession = nil
local accessSequence = 0
local accessHeartbeatToken = 0

local function environment()
	local ok, value = pcall(function() return getgenv and getgenv() or _G end)
	return ok and type(value) == "table" and value or _G
end

local function requestFunction()
	local env = environment()
	local synTable = rawget(env, "syn")
	local httpTable = rawget(env, "http")
	return rawget(env, "request")
		or rawget(env, "http_request")
		or (type(synTable) == "table" and synTable.request)
		or (type(httpTable) == "table" and httpTable.request)
end

local function currentHwid()
	local env = environment()
	for _, resolver in ipairs({
		function() return type(rawget(env, "gethwid")) == "function" and env.gethwid() or nil end,
		function() return type(gethwid) == "function" and gethwid() or nil end,
		function() return RbxAnalyticsService:GetClientId() end,
	}) do
		local ok, value = pcall(resolver)
		if ok and type(value) == "string" and value:match("%S") then return value end
	end
	return nil
end

local function requestJson(path, method, body)
	local requester = requestFunction()
	if type(requester) ~= "function" then return nil, "HTTP_UNSUPPORTED" end
	local options = {
		Url = API_ORIGIN .. path,
		Method = method,
		Headers = { ["Accept"] = "application/json", ["Cache-Control"] = "no-store" },
	}
	if body ~= nil then
		options.Headers["Content-Type"] = "application/json"
		options.Body = HttpService:JSONEncode(body)
	end
	local ok, response = pcall(requester, options)
	if not ok or type(response) ~= "table" then return nil, "REQUEST_FAILED" end
	local status = tonumber(response.StatusCode or response.Status or response.status_code) or 0
	local rawBody = response.Body or response.body or response.Response
	local decoded
	if type(rawBody) == "string" then pcall(function() decoded = HttpService:JSONDecode(rawBody) end) end
	if type(decoded) ~= "table" then return nil, status > 0 and "HTTP_" .. tostring(status) or "INVALID_RESPONSE" end
	if status < 200 or status >= 300 or decoded.status ~= "ok" then
		return nil, tostring(decoded.code or decoded.reasonCode or (status > 0 and "HTTP_" .. status) or "REQUEST_REJECTED"), decoded
	end
	return decoded, nil
end

local function toHex(value)
	return (value:gsub(".", function(character) return string.format("%02x", string.byte(character)) end))
end
local function fromHex(value)
	if type(value) ~= "string" or #value % 2 ~= 0 or value:find("[^%da-fA-F]") then return nil end
	return (value:gsub("..", function(byte) return string.char(tonumber(byte, 16)) end))
end
local function readU32LE(value, offset)
	local a, b, c, d = string.byte(value, offset, offset + 3)
	return (a or 0) + (b or 0) * 256 + (c or 0) * 65536 + (d or 0) * 16777216
end
local function writeU32LE(value)
	value = value % UINT32
	return string.char(value % 256, math.floor(value / 256) % 256, math.floor(value / 65536) % 256, math.floor(value / 16777216) % 256)
end
local function xteaBlock(v0, v1, key)
	local sum = 0
	for _ = 1, 32 do
		v0 = (v0 + bit32.bxor((bit32.lshift(v1, 4) + key[1]) % UINT32, (v1 + sum) % UINT32, bit32.rshift(v1, 5) + key[2])) % UINT32
		sum = (sum + 2654435769) % UINT32
		v1 = (v1 + bit32.bxor((bit32.lshift(v0, 4) + key[3]) % UINT32, (v0 + sum) % UINT32, bit32.rshift(v0, 5) + key[4])) % UINT32
	end
	return v0, v1
end
local function xteaCtr(value, nonce, keyBytes)
	local key = { readU32LE(keyBytes, 1), readU32LE(keyBytes, 5), readU32LE(keyBytes, 9), readU32LE(keyBytes, 13) }
	local nonceLow, nonceHigh = readU32LE(nonce, 1), readU32LE(nonce, 5)
	local output = table.create(math.ceil(#value / 8))
	for offset = 1, #value, 8 do
		local block = math.floor((offset - 1) / 8)
		local stream0, stream1 = xteaBlock(nonceLow, (nonceHigh + block) % UINT32, key)
		local stream = writeU32LE(stream0) .. writeU32LE(stream1)
		local chunk = table.create(math.min(8, #value - offset + 1))
		for index = 1, math.min(8, #value - offset + 1) do
			chunk[index] = string.char(bit32.bxor(string.byte(value, offset + index - 1), string.byte(stream, index)))
		end
		output[#output + 1] = table.concat(chunk)
	end
	return table.concat(output)
end
local function xteaMac(value, keyBytes)
	local key = { readU32LE(keyBytes, 1), readU32LE(keyBytes, 5), readU32LE(keyBytes, 9), readU32LE(keyBytes, 13) }
	local framed = writeU32LE(#value) .. writeU32LE(0) .. value
	local padding = (#framed % 8 == 0) and 0 or (8 - #framed % 8)
	framed = framed .. string.rep("\0", padding)
	local left, right = 0, 0
	for offset = 1, #framed, 8 do
		left = bit32.bxor(left, readU32LE(framed, offset))
		right = bit32.bxor(right, readU32LE(framed, offset + 4))
		left, right = xteaBlock(left, right, key)
	end
	return writeU32LE(left) .. writeU32LE(right)
end
local function portableNonce()
	local bytes = fromHex(HttpService:GenerateGUID(false):gsub("-", ""):sub(1, 16))
	return bytes or string.char(math.random(0, 255), math.random(0, 255), math.random(0, 255), math.random(0, 255), math.random(0, 255), math.random(0, 255), math.random(0, 255), math.random(0, 255))
end

local function authorizeRealKey(rawKey)
	local hwid = currentHwid()
	if not hwid then return { Success = false, State = "error", Message = "Device identity is unavailable in this executor." } end
	local challenge, challengeError = requestJson("/api/v1/check/challenge", "GET")
	if not challenge then return { Success = false, State = "error", Message = "Challenge failed: " .. tostring(challengeError) } end
	if challenge.algorithm ~= "XTEA-CTR+XTEA-CBC-MAC" then return { Success = false, State = "error", Message = "Unsupported server transport profile." } end
	local transportKey = fromHex(challenge.transportKey)
	if type(transportKey) ~= "string" or #transportKey ~= 32 then return { Success = false, State = "error", Message = "Invalid server challenge." } end
	local nonce = portableNonce()
	local plaintext = HttpService:JSONEncode({ licenseKey = rawKey, hwid = hwid })
	local ciphertext = xteaCtr(plaintext, nonce, transportKey:sub(1, 16))
	local tag = xteaMac(nonce .. ciphertext, transportKey:sub(17, 32))
	plaintext, transportKey, hwid = nil, nil, nil
	local response, responseError = requestJson("/api/v1/check", "POST", {
		challengeId = challenge.challengeId,
		nonce = toHex(nonce),
		data = toHex(ciphertext),
		tag = toHex(tag),
	})
	ciphertext, tag, nonce = nil, nil, nil
	if not response then
		local messages = {
			INVALID_KEY = "This license key is invalid.",
			BLACKLISTED = "This license is blocked.",
			EXPIRED = "This license has expired.",
			LICENSE_NOT_ACTIVE = "This license is not active.",
			REDEEM_REQUIRED = "Redeem this premium license from the Fyy Discord panel before using Key Service.",
			HWID_BLACKLISTED = "This device is blocked.",
			HWID_MISMATCH = "This premium license is bound to another device.",
		}
		return { Success = false, State = "invalid", Message = messages[responseError] or ("Authorization failed: " .. tostring(responseError)) }
	end
	return {
		Success = true,
		State = "authorized",
		Message = response.licenseType == "trial" and "Trial access granted. Heartbeat session started." or "Premium access granted. Heartbeat session started.",
		Metadata = response,
	}
end

local function stopAccessHeartbeat()
	accessHeartbeatToken += 1
	local session = accessSession
	accessSession = nil
	if session then
		accessSequence += 1
		task.spawn(function()
			pcall(requestJson, "/api/v1/check/heartbeat", "POST", {
				sessionId = session.sessionId,
				sessionToken = session.sessionToken,
				sequence = accessSequence,
				clientState = "stopping",
			})
		end)
	end
end

local function startAccessHeartbeat(session)
	stopAccessHeartbeat()
	accessSession = session
	accessSequence = 0
	accessHeartbeatToken += 1
	local token = accessHeartbeatToken
	task.spawn(function()
		while accessSession == session and accessHeartbeatToken == token do
			task.wait(math.max(5, tonumber(session.nextHeartbeatSeconds) or 30))
			if accessSession ~= session or accessHeartbeatToken ~= token then break end
			accessSequence += 1
			local heartbeat, heartbeatError = requestJson("/api/v1/check/heartbeat", "POST", {
				sessionId = session.sessionId,
				sessionToken = session.sessionToken,
				sequence = accessSequence,
				clientState = "running",
			})
			if not heartbeat or heartbeat.state ~= "active" then
				local reason = heartbeat and heartbeat.reasonCode or heartbeatError or "SESSION_ENDED"
				accessSession = nil
				notify("Access Ended", tostring(reason), "Error")
				break
			end
			session.nextHeartbeatSeconds = heartbeat.nextHeartbeatSeconds or 30
		end
	end)
end

local keyService = menu:KeyService({
	Mode = "Embedded",
	Enabled = true,
	TabName = "Access",
	TabIcon = "key-round",
	Title = "Fyy License Access",
	Description = "Validate a real premium or trial license through the live tunnel.",
	CardTitle = "LIVE KEY SERVICE",
	CardDescription = "Premium uses HWID binding. Trial remains device-unbound and supports concurrent sessions.",
	CardFooter = "Key and HWID are sent only inside a one-time portable envelope.",
	Placeholder = "FYY-PREMIUM-... or TRIAL-...",
	Validate = authorizeRealKey,
	GetKey = function(service)
		local url = API_ORIGIN .. "/free"
		local copied = false
		pcall(function()
			if type(setclipboard) == "function" then setclipboard(url); copied = true end
		end)
		service.Menu:Notify({ Title = "Get Key", Content = copied and "Free key URL copied." or url, Type = "Info", Duration = 3 })
	end,
	OnAuthorized = function(result)
		local response = result.Metadata
		assert(type(response) == "table" and type(response.session) == "table", "Missing heartbeat session")
		startAccessHeartbeat(response.session)
		notify("Access Granted", string.format("%s · %s", tostring(response.licenseType), tostring(response.devicePolicy)), "Success")
	end,
})
assert(keyService, "Key Service failed to mount")
menu:OnDestroy(stopAccessHeartbeat)

-- Combat
local combatTab = menu:Tab({ Text = "Combat", Icon = "crosshair", Tooltip = "Combat controls" })

local aimSection = combatTab:Collapsible("Aim Assist", { DefaultOpen = true })
aimSection:Toggle({
	Text = "Silent Aim",
	Description = "Target the nearest visible opponent",
	Default = true,
	Flag = "combat_silent_aim",
	Tooltip = "Main aim-assist switch",
})
aimSection:Checkbox({ Text = "Wall Check", Default = true, Flag = "combat_wall_check" })
aimSection:Slider({ Text = "Smoothness", Min = 1, Max = 100, Default = 45, Suffix = "%", Flag = "combat_smoothness" })
aimSection:Slider({ Text = "FOV Range", Min = 20, Max = 360, Default = 180, Suffix = "°", Flag = "combat_fov" })
aimSection:Dropdown({
	Text = "Hit Part",
	Options = { "Head", "Upper Torso", "Lower Torso", "Random" },
	Default = "Head",
	AllowNone = true,
	Searchbar = true,
	Flag = "combat_hit_part",
})
aimSection:Dropdown({
	Text = "Target Filters",
	Description = "Multi-select dropdown example",
	Options = { "Visible", "Enemy", "Alive", "On Screen", "Not Knocked" },
	Default = { "Visible", "Enemy", "Alive" },
	Multi = true,
	Flag = "combat_filters",
})

local weaponSection = combatTab:Collapsible("Weapon", { DefaultOpen = false })
weaponSection:Toggle({
	Text = "Trigger Bot",
	Description = "Fire while a target is under the crosshair",
	Flag = "combat_trigger",
})
weaponSection:Slider({
	Text = "Trigger Delay",
	Min = 0,
	Max = 500,
	Default = 80,
	Suffix = "ms",
	Step = 10,
	Flag = "combat_trigger_delay",
})
weaponSection:Keybind({
	Text = "Aim Key",
	Default = Enum.UserInputType.MouseButton2,
	Mode = "Hold",
	Flag = "combat_aim_key",
})

combatTab:Divider()
combatTab:Button({
	Text = "Test Target Lock",
	Description = "Preview a success notification",
	Icon = "rocket",
	Callback = function()
		notify("Target Locked", "Aim preview completed successfully.", "Success")
	end,
})

-- Automation
local automationTab = menu:Tab({ Text = "Automation", Icon = "zap", Tooltip = "Automation examples" })

local movementSection = automationTab:Collapsible("Movement", { DefaultOpen = true })
movementSection:Toggle({ Text = "Auto Sprint", Default = true, Flag = "auto_sprint" })
movementSection:Toggle({ Text = "Auto Jump", Flag = "auto_jump" })
movementSection:Checkbox({ Text = "Avoid Players", Default = true, Flag = "auto_avoid_players" })
movementSection:Slider({
	Text = "Walk Speed",
	Min = 16,
	Max = 100,
	Default = 24,
	Suffix = " studs",
	Flag = "auto_walk_speed",
})
movementSection:Dropdown({
	Text = "Movement Mode",
	Options = { "Legit", "Balanced", "Aggressive" },
	Default = "Balanced",
	AllowNone = false,
	Flag = "auto_movement_mode",
})

local farmingSection = automationTab:Collapsible("Farming", { DefaultOpen = false })
farmingSection:Toggle({ Text = "Auto Farm", Description = "Run the selected farming routine", Flag = "auto_farm" })
farmingSection:Dropdown({
	Text = "Farm Targets",
	Options = { "Coins", "Gems", "Crates", "Quests", "Bosses" },
	Default = { "Coins", "Gems" },
	Multi = true,
	Flag = "auto_targets",
})
farmingSection:Dropdown({
	Text = "Route",
	Options = { "Nearest", "Safest", "Highest Value" },
	Default = "Nearest",
	AllowNone = false,
	Flag = "auto_route",
})
farmingSection:Slider({
	Text = "Action Delay",
	Min = 0.1,
	Max = 2,
	Default = 0.5,
	Suffix = "s",
	Step = 0.1,
	Flag = "auto_delay",
})
farmingSection:Input({
	Text = "Stop After",
	Description = "Leave blank to run continuously",
	Placeholder = "Amount",
	Numeric = true,
	ClearOnFocus = false,
	Flag = "auto_stop_after",
})

automationTab:Divider()
automationTab:Button({
	Text = "Start Demo Routine",
	Description = "Shows how action buttons and notifications work together",
	Icon = "rocket",
	Callback = function()
		notify("Automation Ready", "The demo routine is ready to start.", "Success")
	end,
})

-- Interface
local configTab = menu:ConfigTab({
	Text = "Config",
	Icon = "settings-2",
	Folder = "FyyUI/DemoConfigs",
	DefaultProfile = "Default",
	AutoLoad = true,
	LoadCallbacks = false,
})

local interfaceTab = menu:Tab({ Text = "Interface", Icon = "settings", Tooltip = "Appearance and input settings" })

local appearanceSection = interfaceTab:Collapsible("Appearance", { DefaultOpen = true })
appearanceSection:Dropdown({
	Text = "Theme",
	Options = { "Amoled", "Dark", "Light" },
	Default = "Amoled",
	AllowNone = false,
	Flag = "ui_theme",
	Callback = function(value)
		menu:SetTheme(value)
	end,
})
appearanceSection:Slider({
	Text = "UI Scale",
	Min = 0.75,
	Max = 1.35,
	Default = 1,
	Suffix = "x",
	Step = 0.05,
	Flag = "ui_scale",
	Callback = function(value)
		menu:SetScale(value)
	end,
})
appearanceSection:Checkbox({ Text = "Show Notifications", Default = true, Flag = "ui_notifications" })
appearanceSection:Checkbox({ Text = "Compact Labels", Default = false, Flag = "ui_compact_labels" })

local inputSection = interfaceTab:Collapsible("Input & Navigation", { DefaultOpen = false })
inputSection:Keybind({
	Text = "Toggle Menu",
	Default = Enum.KeyCode.RightShift,
	Mode = "Toggle",
	Flag = "ui_toggle_key",
	Callback = function()
		menu:ToggleVisibility()
	end,
})
inputSection:Keybind({ Text = "Action Key", Default = Enum.KeyCode.E, Mode = "Hold", Flag = "ui_action_key" })
inputSection:Input({ Text = "Profile Name", Placeholder = "Fyy profile", ClearOnFocus = false, Flag = "profile_name" })
inputSection:Dropdown({
	Text = "Active Modules",
	Options = { "Combat", "Automation", "Visuals", "Utilities" },
	Default = { "Combat", "Utilities" },
	Multi = true,
	Flag = "active_modules",
})

interfaceTab:Divider()
interfaceTab:Button({
	Text = "Open Command Palette",
	Description = "Search tabs and available actions",
	Icon = "rocket",
	Callback = function()
		menu:ToggleCommandPalette()
	end,
})

-- Components
local componentsTab = menu:Tab({ Text = "Components", Icon = "layout-grid", Tooltip = "Full component showcase" })

componentsTab:BoldLabel({ Text = "Component Gallery", Description = "A clean preview of the public FyyUI controls" })
componentsTab:Label({ Text = "Use this tab as a quick API reference while building your own menu." })
componentsTab:Divider()

local componentColumns = componentsTab:Columns({ Ratio = { 1, 1 }, Gap = 8 })
local componentLeft = componentColumns:Column()
local componentRight = componentColumns:Column()

componentLeft:Toggle({ Text = "Left Toggle", Default = true })
componentLeft:Slider({ Text = "Left Slider", Min = 0, Max = 100, Default = 65, Suffix = "%" })
componentRight:Dropdown({ Text = "Right Dropdown", Options = { "Alpha", "Beta", "Gamma" }, Default = "Beta" })
componentRight:Checkbox({
	Text = "Right Checkbox",
	Default = true,
})

local panelColumns = componentsTab:Columns({ Gap = 8 })
local panelLeft = panelColumns:Column()
local panelRight = panelColumns:Column()
local leftPanel = panelLeft:Collapsible("Left Panel", { DefaultOpen = true })
local rightPanel = panelRight:Collapsible("Right Panel", { DefaultOpen = true })
leftPanel:Toggle({ Text = "Auto Collect", Default = true })
leftPanel:Dropdown({ Text = "Collect Type", Options = { "Coins", "Gems", "Crates" }, Default = "Coins" })
leftPanel:Slider({ Text = "Collect Range", Min = 10, Max = 100, Default = 45, Suffix = " studs" })
rightPanel:Checkbox({ Text = "Show Markers", Default = true })
rightPanel:Button({ Text = "Refresh Markers", Icon = "rocket" })

local nestedColumns = leftPanel:Columns({ Gap = 6 })
nestedColumns:Column():Checkbox({ Text = "Left Filter", Default = true })
nestedColumns:Column():Checkbox({ Text = "Right Filter", Default = false })

local controlsSection = componentsTab:Collapsible("Controls", { DefaultOpen = true })
controlsSection:Toggle({ Text = "Toggle", Description = "Animated on/off control", Default = true })
controlsSection:Checkbox({
	Text = "Checkbox",
	Description = "Accent color indicates the selected state",
	Default = true,
})
controlsSection:Slider({ Text = "Slider", Min = 0, Max = 10, Default = 6, Suffix = "/10" })
controlsSection:Dropdown({ Text = "Single Dropdown", Options = { "Alpha", "Beta", "Gamma" }, Default = "Beta" })
controlsSection:Dropdown({
	Text = "Multi Dropdown",
	Options = { "Red", "Green", "Blue", "Purple" },
	Default = { "Blue", "Purple" },
	Multi = true,
})
controlsSection:Input({ Text = "Text Input", Placeholder = "Type something...", ClearOnFocus = false })
controlsSection:Keybind({ Text = "Keybind", Default = Enum.KeyCode.K, Mode = "Toggle" })
controlsSection:Button({
	Text = "Icon Button",
	Description = "Lucide icons are loaded automatically and called by name",
	Icon = "rocket",
	Callback = function()
		notify("Icons Ready", "Lucide icon names are loading correctly.", "Info")
	end,
})

local feedbackSection = componentsTab:Collapsible("Notifications", { DefaultOpen = false })
feedbackSection:Button({
	Text = "Success",
	Icon = "rocket",
	Callback = function()
		notify("Success", "Everything completed successfully.", "Success")
	end,
})
feedbackSection:Button({
	Text = "Information",
	Icon = "rocket",
	Callback = function()
		notify("Information", "This is an informational message.", "Info")
	end,
})
feedbackSection:Button({
	Text = "Warning",
	Icon = "rocket",
	Callback = function()
		notify("Warning", "Review this action before continuing.", "Warning")
	end,
})
feedbackSection:Button({
	Text = "Error",
	Icon = "rocket",
	Callback = function()
		notify("Error", "The demo error notification is working.", "Error")
	end,
})

-- About
local aboutTab = menu:Tab({ Text = "About", Icon = "info", Tooltip = "Library information" })

aboutTab:BoldLabel({ Text = "FyyCommunity v" .. FyyUI.Version, Description = "Responsive Roblox UI library" })
aboutTab:BoldLabel({ Text = "● Ready", Color = Color3.fromRGB(70, 220, 120) })
aboutTab:Divider()
aboutTab:Label({ Text = "Named Lucide icons loaded automatically" })
aboutTab:Label({ Text = "Responsive mouse, touch, keyboard, and gamepad navigation" })
aboutTab:Label({ Text = "Versioned configuration export and import" })
aboutTab:Label({ Text = "Command palette and keybind capture" })
aboutTab:Divider()
aboutTab:Button({
	Text = "Export & Import Config",
	Description = "Runs a local JSON configuration roundtrip",
	Icon = "rocket",
	Callback = function()
		local json, exportError = menu:ExportConfigJSON()
		if not json then
			notify("Export Failed", tostring(exportError), "Error")
			return
		end

		local ok, details = menu:ImportConfigJSON(json, { NoCallbacks = true })
		if ok then
			notify("Config Restored", "Local JSON roundtrip completed.", "Success")
		else
			notify("Import Failed", tostring(details), "Error")
		end
	end,
})

menu:Notify({
	Title = "FyyUI Ready",
	Content = "Explore the clean component demo and multi-select dropdowns.",
	Type = "Success",
	Duration = 4,
})
