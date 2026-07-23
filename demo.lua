-- Put fyyui.lua in a trusted local ModuleScript named "FyyUI" beside this demo.
local FyyUI = require(script.Parent.FyyUI)

local menu = FyyUI.Menu({
	Title = "FyyCommunity",
	Resizable = true,
	HasOutline = true,
	Theme = "Amoled",
	Stats = true,
	Logo = true,
	-- QA: resize Studio/device viewport below 640px and verify the compact sidebar,
	-- centered long-option dropdown, safe padding, and 44px option targets.
	Responsive = true,
	CompactBreakpoint = 640,
	SafePadding = 12,
	TouchTargetSize = 44,
	ReducedMotion = false, -- QA: set true and verify tabs, window transitions, and confirm popups open/close instantly.
})

-- Accessibility QA: use a gamepad to move between ordered tab/control targets,
-- open/close a dropdown or close confirmation, and confirm focus returns safely.
-- Focus a text input or capture a keybind and verify menu shortcuts/navigation do not steal it.
-- On touch, tap the full checkbox row, each window control, and the lower-right resize grip.

-- Tab 1: Combat
local combatTab = menu:Tab({ Text = "Combat", Icon = "crosshair" })

local aimbot = combatTab:Collapsible("Aimbot", { DefaultOpen = true })
aimbot:Toggle({ Text = "Silent Aim", Description = "Silent aim at nearest target", Default = true })
aimbot:Checkbox({ Text = "Wall Check", Default = true })
aimbot:Slider({ Text = "Smoothness", Min = 1, Max = 100, Default = 50, Suffix = "%" })
aimbot:Slider({ Text = "FOV Range", Min = 1, Max = 360, Default = 180, Suffix = "°" })
aimbot:Dropdown({ Text = "Hit Part", Options = { "Head", "Torso", "Legs", "Random" }, Default = "Head" })
aimbot:Checkbox({ Text = "Draw FOV Circle", Default = false })

local triggerbot = combatTab:Collapsible("Trigger Bot")
triggerbot:Toggle({ Text = "Trigger Bot", Description = "Auto-shoot when target is in crosshair", Default = false })
triggerbot:Slider({ Text = "Delay", Min = 0, Max = 500, Default = 50, Suffix = "ms" })
triggerbot:Checkbox({ Text = "Only Visible", Default = true })
triggerbot:Dropdown({ Text = "Trigger Key", Options = { "Mouse Left", "Mouse Right", "Shift", "None" }, Default = "Mouse Left" })

combatTab:Divider()

local visuals = combatTab:Collapsible("Visuals", { DefaultOpen = true })
visuals:Toggle({ Text = "ESP Box", Description = "Draw boxes around players", Default = true })
visuals:Toggle({ Text = "Tracers", Description = "Draw lines to targets", Default = false })
visuals:Checkbox({ Text = "Health Bar", Default = true })
visuals:Checkbox({ Text = "Distance", Default = false })
visuals:Slider({ Text = "Max Render Distance", Min = 100, Max = 5000, Default = 1500, Suffix = "m", Step = 100 })
visuals:Dropdown({ Text = "Box Type", Options = { "2D", "Corner", "3D" }, Default = "2D" })
visuals:Dropdown({ Text = "Tracer Position", Options = { "Bottom", "Middle", "Top" }, Default = "Bottom" })

-- Tab 2: Automation
local autoTab = menu:Tab({ Text = "Auto", Icon = "zap" })

local farming = autoTab:Collapsible("Farming", { DefaultOpen = true })
farming:Toggle({ Text = "Auto Farm", Description = "Automatically farms ores", Default = true })
farming:Toggle({ Text = "Auto Collect", Description = "Collect dropped items", Default = true })
farming:Checkbox({ Text = "Ignore Gold", Default = false })
farming:Checkbox({ Text = "Auto Sell", Default = true })
farming:Slider({ Text = "Farm Range", Min = 10, Max = 200, Default = 75, Suffix = "m", Step = 5 })
farming:Slider({ Text = "Sell Interval", Min = 30, Max = 600, Default = 120, Suffix = "s", Step = 10 })

local movement = autoTab:Collapsible("Movement")
movement:Toggle({ Text = "Auto Jump", Description = "Auto jump when walking", Default = false })
movement:Toggle({ Text = "Speed Boost", Description = "Increases movement speed", Default = false })
movement:Slider({ Text = "Speed Multiplier", Min = 1, Max = 5, Default = 2, Suffix = "x", Step = 0.5 })
movement:Checkbox({ Text = "Bunny Hop", Default = true })

autoTab:Divider()

autoTab:Button({ Text = "Toggle All", Description = "Enable all automation features", Icon = "toggle-right", Callback = function() print("Toggled all!") end })
autoTab:Button({ Text = "Stop All", Description = "Disable all automation", Color = Color3.fromRGB(230, 60, 60), Icon = "square", Callback = function() print("Stopped all!") end })

-- Tab 3: Settings
local settingsTab = menu:Tab({ Text = "Settings", Icon = "settings" })

local general = settingsTab:Collapsible("General", { DefaultOpen = true })
general:Dropdown({
	Text = "Theme",
	Options = { "Dark", "Light", "Amoled" },
	Default = "Amoled",
	Callback = function(v)
		local ok, err = menu:SetTheme(v)
		if not ok then warn("[FyyUI] Theme switch failed:", err) end
	end,
})
general:Checkbox({ Text = "Show Watermark", Default = true })
general:Checkbox({ Text = "Auto Update", Default = true })
general:Dropdown({
	Text = "Mobile long-label / modal dropdown QA",
	Options = {
		"A deliberately long option label that must remain readable on a phone",
		"Another extended option for testing touch scrolling and selection",
		"Short fallback",
	},
	Placeholder = "Resize to a narrow viewport, then open me",
})
general:Slider({
	Text = "UI Scale",
	Min = 0.75,
	Max = 1.35,
	Default = 1,
	Suffix = "x",
	Step = 0.1,
	Callback = function(v) menu:SetScale(v) end,
})

local keybinds = settingsTab:Collapsible("Keybinds")
keybinds:Keybind({
	Text = "Toggle Menu",
	Default = Enum.KeyCode.RightShift,
	Mode = "Toggle",
	Callback = function() menu:ToggleVisibility() end,
})
keybinds:Keybind({ Text = "Panic Key", Default = nil, Mode = "Toggle", Callback = function() end })
keybinds:Checkbox({ Text = "Hold to Aim", Default = false })

-- Tab 4: Info
local infoTab = menu:Tab({ Text = "Info", Icon = "info" })

infoTab:BoldLabel({ Text = "FyyCommunity v" .. FyyUI.Version, Description = "Roblox UI Library" })
infoTab:BoldLabel({ Text = "Status: Running", Color = Color3.fromRGB(0, 200, 80) })

infoTab:Divider()

infoTab:BoldLabel({ Text = "Components" })
infoTab:Label({ Text = "Toggle, Checkbox, Button" })
infoTab:Label({ Text = "Slider, Dropdown, Label" })
infoTab:Label({ Text = "Collapsible Section" })

infoTab:Divider()

infoTab:Button({ Text = "Rejoin Game", Description = "Rejoin the current server", Icon = "refresh-cw", Callback = function() print("Rejoining...") end })

-- Safe persistence roundtrip: JSON APIs use the local Roblox HttpService only
-- for serialization. Persist `savedConfig` with your own trusted storage layer.
local savedConfig, saveErr = menu:ExportConfigJSON()
if savedConfig then
	local restored, restoreDetails = menu:ImportConfigJSON(savedConfig, { NoCallbacks = true })
	if not restored then warn("[FyyUI] Config restore failed:", restoreDetails) end
else
	warn("[FyyUI] Config export failed:", saveErr)
end

print("FyyUI v" .. FyyUI.Version .. " loaded successfully!")
