local Theme = {
	Dark = {
		Background = Color3.fromRGB(18, 18, 22),
		Topbar = Color3.fromRGB(24, 24, 30),
		TopbarBorder = Color3.fromRGB(38, 38, 46),
		Accent = Color3.fromRGB(0, 130, 250),
		AccentLine = Color3.fromRGB(0, 150, 255),
		TextPrimary = Color3.fromRGB(225, 225, 235),
		TextSecondary = Color3.fromRGB(145, 145, 160),
		TextMuted = Color3.fromRGB(140, 140, 155),
		Element = Color3.fromRGB(35, 35, 42),
		ElementHover = Color3.fromRGB(45, 45, 54),
		ElementBorder = Color3.fromRGB(48, 48, 56),
		Outline = Color3.fromRGB(40, 40, 50),
		ToggleOn = Color3.fromRGB(0, 180, 80),
		ToggleOff = Color3.fromRGB(55, 55, 65),
		ToggleKnob = Color3.fromRGB(210, 210, 220),
		Border = Color3.fromRGB(40, 40, 48),
		ScrollBar = Color3.fromRGB(65, 65, 78),
		Shadow = Color3.fromRGB(0, 0, 0),
		Sidebar = Color3.fromRGB(22, 22, 28),
		SidebarText = Color3.fromRGB(135, 135, 150),
		SidebarTextActive = Color3.fromRGB(225, 225, 235),
		TabActive = Color3.fromRGB(35, 35, 42),
		TabHover = Color3.fromRGB(45, 45, 54),
		Font = Enum.Font.SourceSans,
		FontBold = Enum.Font.SourceSansBold,
		FontSize = 16,
		FontSizeTitle = 18,
		FontSizeSmall = 14,
		Padding = 10,
		CornerRadius = 8,
		TopbarHeight = 44,
		-- Card layout formula (unified across all controls):
		--   No description: height = ElementHeight + 6 = 42px
		--   With description: height = DescHeight + 6 = 58px
		--   Outer inset: 6px left/right (children use width 1,-12 + position 6)
		--   Inner text padding (left): 10px
		--   Corner radius: 8px, Stroke: 1px, Inter-child spacing: 6px
		ElementHeight = 36,
		DescHeight = 52,
		Spacing = 6,
		SidebarWidth = 150,
	},
	Light = {
		Background = Color3.fromRGB(242, 242, 247),
		Topbar = Color3.fromRGB(232, 232, 240),
		TopbarBorder = Color3.fromRGB(218, 218, 228),
		Accent = Color3.fromRGB(0, 115, 235),
		AccentLine = Color3.fromRGB(0, 130, 245),
		TextPrimary = Color3.fromRGB(28, 28, 36),
		TextSecondary = Color3.fromRGB(98, 98, 112),
		TextMuted = Color3.fromRGB(85, 85, 98),
		Element = Color3.fromRGB(222, 222, 232),
		ElementHover = Color3.fromRGB(212, 212, 224),
		ElementBorder = Color3.fromRGB(208, 208, 218),
		Outline = Color3.fromRGB(200, 200, 215),
		ToggleOn = Color3.fromRGB(0, 165, 75),
		ToggleOff = Color3.fromRGB(178, 178, 190),
		ToggleKnob = Color3.fromRGB(242, 242, 248),
		Border = Color3.fromRGB(208, 208, 220),
		ScrollBar = Color3.fromRGB(178, 178, 192),
		Shadow = Color3.fromRGB(0, 0, 0),
		Sidebar = Color3.fromRGB(235, 235, 242),
		SidebarText = Color3.fromRGB(105, 105, 120),
		SidebarTextActive = Color3.fromRGB(28, 28, 36),
		TabActive = Color3.fromRGB(212, 212, 224),
		TabHover = Color3.fromRGB(200, 200, 215),
		Font = Enum.Font.SourceSans,
		FontBold = Enum.Font.SourceSansBold,
		FontSize = 16,
		FontSizeTitle = 18,
		FontSizeSmall = 14,
		Padding = 10,
		CornerRadius = 8,
		TopbarHeight = 44,
		ElementHeight = 36,
		DescHeight = 52,
		Spacing = 6,
		SidebarWidth = 150,
	},
	Amoled = {
		Background = Color3.fromRGB(0, 0, 0),
		Topbar = Color3.fromRGB(7, 7, 10),
		TopbarBorder = Color3.fromRGB(18, 18, 26),
		Accent = Color3.fromRGB(140, 80, 255),
		AccentLine = Color3.fromRGB(140, 80, 255),
		TextPrimary = Color3.fromRGB(210, 210, 220),
		TextSecondary = Color3.fromRGB(130, 130, 145),
		TextMuted = Color3.fromRGB(125, 125, 142),
		Element = Color3.fromRGB(13, 13, 18),
		ElementHover = Color3.fromRGB(22, 22, 30),
		ElementBorder = Color3.fromRGB(25, 25, 36),
		Outline = Color3.fromRGB(16, 16, 24),
		ToggleOn = Color3.fromRGB(140, 80, 255),
		ToggleOff = Color3.fromRGB(22, 22, 32),
		ToggleKnob = Color3.fromRGB(195, 195, 210),
		Border = Color3.fromRGB(16, 16, 24),
		ScrollBar = Color3.fromRGB(40, 40, 56),
		Shadow = Color3.fromRGB(0, 0, 0),
		Sidebar = Color3.fromRGB(3, 3, 6),
		SidebarText = Color3.fromRGB(135, 135, 152),
		SidebarTextActive = Color3.fromRGB(210, 210, 220),
		TabActive = Color3.fromRGB(13, 13, 18),
		TabHover = Color3.fromRGB(22, 22, 30),
		Font = Enum.Font.SourceSans,
		FontBold = Enum.Font.SourceSansBold,
		FontSize = 16,
		FontSizeTitle = 18,
		FontSizeSmall = 14,
		Padding = 10,
		CornerRadius = 8,
		TopbarHeight = 44,
		ElementHeight = 36,
		DescHeight = 52,
		Spacing = 6,
		SidebarWidth = 150,
	},
}

function Theme:Override(base, overrides)
	base = type(base) == "string" and self[base] or base
	if not base then
		base = self.Dark
	end
	local m = {}
	for k, v in pairs(base) do
		m[k] = v
	end
	for k, v in pairs(overrides or {}) do
		m[k] = v
	end
	return m
end

local U = {}

function U.Create(c, props, children)
	local inst = Instance.new(c)
	if props then
		for k, v in pairs(props) do
			inst[k] = v
		end
	end
	if children then
		for _, ch in ipairs(children) do
			ch.Parent = inst
		end
	end
	return inst
end

local LIBRARY_VERSION = "0.17.0"
local CONFIG_V2_SCHEMA = "FyyUI.Config.v2"
local MAX_CONFIG_JSON_BYTES = 64 * 1024
local MAX_CONFIG_VALUES = 512
local MAX_CONFIG_ARRAY_ITEMS = 256
local MAX_CONFIG_STRING_BYTES = 16 * 1024
local MAX_CONFIG_NODES = 8192

--[[ Icon Module (Lucide/Solar/etc.) — auto-load from GitHub ]]
local IconModule = nil
local DEFAULT_ICON_URL = "https://raw.githubusercontent.com/Footagesus/Icons/refs/heads/main/lucide/dist/Icons.lua"

local function loadRemoteIconModule(url)
	url = url or DEFAULT_ICON_URL
	local raw
	local httpMethods = {
		function()
			return game:HttpGet(url)
		end,
		function()
			return game:GetService("HttpService"):GetAsync(url)
		end,
	}
	for _, method in ipairs(httpMethods) do
		local ok, result = pcall(method)
		if ok and type(result) == "string" and result ~= "" then
			raw = result
			break
		end
	end
	if not raw then
		return false, "Failed to download icon module"
	end

	local compiler = loadstring
	if type(compiler) ~= "function" then
		return false, "loadstring is unavailable"
	end
	local compiled, compileError = compiler(raw)
	if not compiled then
		return false, compileError or "Failed to compile icon module"
	end
	local ok, module = pcall(compiled)
	if not ok then
		return false, module
	end
	if type(module) ~= "table" then
		return false, "Icon module must return a table"
	end
	IconModule = module
	return true, module
end

loadRemoteIconModule(DEFAULT_ICON_URL)

local function isFiniteNumber(value)
	return type(value) == "number" and value == value and value ~= math.huge and value ~= -math.huge
end

local function consumeConfigBudget(budget, bytes)
	budget.Nodes = budget.Nodes + 1
	if budget.Nodes > MAX_CONFIG_NODES then
		return false, "config has too many values"
	end
	budget.Bytes = budget.Bytes + bytes
	if budget.Bytes > MAX_CONFIG_JSON_BYTES then
		return false, "config is too large"
	end
	return true
end

local function copyJSONSafeValue(value, budget, seen, depth)
	local valueType = type(value)
	if valueType == "string" then
		if #value > MAX_CONFIG_STRING_BYTES then
			return nil, "string value is too large"
		end
		local withinBudget, budgetError = consumeConfigBudget(budget, #value + 2)
		if not withinBudget then
			return nil, budgetError
		end
		return value
	end
	if valueType == "boolean" then
		local withinBudget, budgetError = consumeConfigBudget(budget, 5)
		if not withinBudget then
			return nil, budgetError
		end
		return value
	end
	if valueType == "number" then
		if not isFiniteNumber(value) then
			return nil, "expected finite number"
		end
		local withinBudget, budgetError = consumeConfigBudget(budget, 32)
		if not withinBudget then
			return nil, budgetError
		end
		return value
	end
	if valueType ~= "table" then
		return nil, "expected JSON-safe value"
	end
	if depth >= 8 then
		return nil, "config value is nested too deeply"
	end
	if seen[value] then
		return nil, "config value contains a cycle"
	end
	local withinBudget, budgetError = consumeConfigBudget(budget, 2)
	if not withinBudget then
		return nil, budgetError
	end

	seen[value] = true
	local count, maxIndex = 0, 0
	for index in pairs(value) do
		if type(index) ~= "number" or index < 1 or index % 1 ~= 0 then
			seen[value] = nil
			return nil, "expected dense array"
		end
		count = count + 1
		if count > MAX_CONFIG_ARRAY_ITEMS then
			seen[value] = nil
			return nil, "config array is too large"
		end
		if index > maxIndex then
			maxIndex = index
		end
	end
	if count ~= maxIndex then
		seen[value] = nil
		return nil, "expected dense array"
	end
	local copied = {}
	for index = 1, count do
		local item, err = copyJSONSafeValue(value[index], budget, seen, depth + 1)
		if err then
			seen[value] = nil
			return nil, err
		end
		copied[index] = item
	end
	seen[value] = nil
	return copied
end

local function estimateJSONSafeValueBytes(value)
	local valueType = type(value)
	if valueType == "string" then
		return (#value * 6) + 2
	end -- conservative escaping bound
	if valueType == "boolean" then
		return 5
	end
	if valueType == "number" then
		return 32
	end
	local total = 2
	for index = 1, #value do
		total = total + estimateJSONSafeValueBytes(value[index]) + 1
	end
	return total
end

local function validateConfigV2Envelope(snapshot)
	if type(snapshot) ~= "table" then
		return false, "Invalid config v2: expected a table"
	end
	local allowed = { Schema = true, SchemaVersion = true, Version = true, Values = true }
	for key in pairs(snapshot) do
		if not allowed[key] then
			return false, "Invalid config v2: unexpected envelope field"
		end
	end
	if snapshot.Schema ~= CONFIG_V2_SCHEMA or snapshot.SchemaVersion ~= 2 then
		return false, "Invalid config v2: unsupported schema"
	end
	if type(snapshot.Version) ~= "string" or snapshot.Version == "" or #snapshot.Version > 64 then
		return false, "Invalid config v2: invalid Version"
	end
	if type(snapshot.Values) ~= "table" then
		return false, "Invalid config v2: missing Values table"
	end

	local count = 0
	local budget = { Nodes = 4, Bytes = 64 }
	local normalized = {
		Schema = CONFIG_V2_SCHEMA,
		SchemaVersion = 2,
		Version = snapshot.Version,
		Values = {},
	}
	for flag, value in pairs(snapshot.Values) do
		count = count + 1
		if count > MAX_CONFIG_VALUES then
			return false, "Invalid config v2: too many values"
		end
		if type(flag) ~= "string" or flag == "" or #flag > 128 then
			return false, "Invalid config v2: invalid flag"
		end
		local withinBudget, budgetError = consumeConfigBudget(budget, #flag + 4)
		if not withinBudget then
			return false, "Invalid config v2: " .. budgetError
		end
		local copied, err = copyJSONSafeValue(value, budget, {}, 0)
		if err then
			return false, "Invalid config v2: " .. err
		end
		normalized.Values[flag] = copied
	end
	return true, normalized
end

local function destroyedResult(controller)
	if controller._destroyed then
		return true, false, "destroyed"
	end
	return false
end

local function destroyedFactoryResult(owner)
	if owner._destroyed or (owner.Menu and owner.Menu._destroyed) or (owner._menu and owner._menu._destroyed) then
		return true, nil, "destroyed"
	end
	return false
end

local function resolveIcon(icon)
	if not icon or type(icon) ~= "string" then
		return nil
	end
	-- Direct rbxassetid:// (no resolution needed)
	if icon:find("^rbxassetid://") then
		return { Image = icon }
	end
	-- Icon module available
	if IconModule then
		-- Class format (has Icon2 method) — from manual SetIconModule()
		if IconModule.Icon2 then
			local ok, result = pcall(IconModule.Icon2, IconModule, icon)
			if ok and result then
				return {
					Image = result[1],
					ImageRectSize = result[2].ImageRectSize,
					ImageRectOffset = result[2].ImageRectPosition,
				}
			end
		-- Flat table format (name → assetId) — from auto-load
		elseif type(IconModule) == "table" then
			-- Parse "lucide:zap" → "zap", or just "zap"
			local name = icon
			local colon = icon:find(":")
			if colon then
				name = icon:sub(colon + 1)
			end
			local assetId = IconModule[name]
			if assetId then
				return { Image = assetId }
			end
		end
	end
	return nil
end

-- Helper: renders an icon as either an ImageLabel or TextLabel depending on
-- what the configured icon provider returns. Callers pass
-- the same extra table for Size/Position/etc.; Image-only props are mapped
-- to text-equivalent properties when creating a TextLabel.
local function renderIcon(parent, icon, extra)
	if not parent or not icon then
		return nil
	end
	local resolved = resolveIcon(icon)
	if not resolved then
		return nil
	end
	if resolved.Text then
		local props = {
			Name = "Icon",
			Size = UDim2.fromOffset(18, 18),
			BackgroundTransparency = 1,
			Text = resolved.Text,
			Font = Enum.Font.SourceSans,
			TextSize = 16,
			TextColor3 = Color3.fromRGB(200, 200, 210),
			TextXAlignment = Enum.TextXAlignment.Center,
			Parent = parent,
		}
		if extra then
			for k, v in pairs(extra) do
				if k == "ImageColor3" then
					props.TextColor3 = v
				elseif k == "ImageTransparency" then
					props.TextTransparency = v
				elseif k ~= "Image" and k ~= "ImageRectSize" and k ~= "ImageRectOffset" then
					props[k] = v
				end
			end
		end
		return U.Create("TextLabel", props)
	else
		local props = {
			Name = "Icon",
			Size = UDim2.fromOffset(18, 18),
			BackgroundTransparency = 1,
			Image = resolved.Image,
			Parent = parent,
		}
		if resolved.ImageRectSize then
			props.ImageRectSize = resolved.ImageRectSize
		end
		if resolved.ImageRectOffset then
			props.ImageRectOffset = resolved.ImageRectOffset
		end
		if extra then
			for k, v in pairs(extra) do
				if k == "TextColor3" then
					if extra.ImageColor3 == nil then
						props.ImageColor3 = v
					end
				elseif k == "TextTransparency" then
					if extra.ImageTransparency == nil then
						props.ImageTransparency = v
					end
				elseif
					k ~= "Text"
					and k ~= "Font"
					and k ~= "TextSize"
					and k ~= "TextXAlignment"
					and k ~= "TextYAlignment"
				then
					props[k] = v
				end
			end
		end
		return U.Create("ImageLabel", props)
	end
end

-- Apply a resolved icon (from resolveIcon) to an existing ImageLabel or TextLabel.
-- Sets Image+ImageRect on ImageLabel, or Text on TextLabel.
local function applyIconToLabel(label, resolved)
	if not label or not resolved then
		return
	end
	if resolved.Image then
		label.Image = resolved.Image
		if resolved.ImageRectSize then
			label.ImageRectSize = resolved.ImageRectSize
		end
		if resolved.ImageRectOffset then
			label.ImageRectOffset = resolved.ImageRectOffset
		end
	elseif resolved.Text then
		label.Text = resolved.Text
	end
end

local function updateRenderedIcon(label, icon, parent, extra)
	local resolved = resolveIcon(icon)
	if not resolved then
		return label
	end
	local sameType = label
		and ((resolved.Text and label:IsA("TextLabel")) or (resolved.Image and label:IsA("ImageLabel")))
	if sameType then
		applyIconToLabel(label, resolved)
		return label
	end
	if label then
		label:Destroy()
	end
	return renderIcon(parent, icon, extra)
end

local function cleanupController(controller)
	if controller._destroyed then
		return
	end
	controller._destroyed = true
	local menu = controller._menu
	if not menu then
		return
	end
	menu:_untrackFlagged(controller)
	if menu._activeDropdown == controller then
		menu:HideDropdownPopup()
	end
end

-- Shared forward declarations for the mutually-recursive layout controllers.
local Collapsible, Columns
