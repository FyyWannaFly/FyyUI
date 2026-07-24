local source = game:HttpGet("https://raw.githubusercontent.com/FyyWannaFly/FyyUI/main/fyyui.lua")
local chunk, compileError = loadstring(source)
assert(chunk, "FyyUI compile error: " .. tostring(compileError))
local FyyUI = chunk()

local menu = FyyUI.Menu({
	Title = "FyyCommunity",
	Theme = "Amoled",
	Resizable = true,
	HasOutline = true,
	Stats = true,
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
	Icon = "crosshair",
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
	Icon = "search",
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

componentLeft:Toggle({ Text = "Left Toggle", Description = "Independent left-column flow", Default = true })
componentLeft:Slider({ Text = "Left Slider", Min = 0, Max = 100, Default = 65, Suffix = "%" })
componentRight:Dropdown({ Text = "Right Dropdown", Options = { "Alpha", "Beta", "Gamma" }, Default = "Beta" })
componentRight:Checkbox({
	Text = "Right Checkbox",
	Description = "Cards stay aligned without equal-height panels",
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
rightPanel:Button({ Text = "Refresh Markers", Icon = "refresh-cw" })

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
	Icon = "smile",
	Callback = function()
		notify("Icons Ready", "Lucide icon names are loading correctly.", "Info")
	end,
})

local feedbackSection = componentsTab:Collapsible("Notifications", { DefaultOpen = false })
feedbackSection:Button({
	Text = "Success",
	Icon = "circle-check",
	Callback = function()
		notify("Success", "Everything completed successfully.", "Success")
	end,
})
feedbackSection:Button({
	Text = "Information",
	Icon = "info",
	Callback = function()
		notify("Information", "This is an informational message.", "Info")
	end,
})
feedbackSection:Button({
	Text = "Warning",
	Icon = "triangle-alert",
	Callback = function()
		notify("Warning", "Review this action before continuing.", "Warning")
	end,
})
feedbackSection:Button({
	Text = "Error",
	Icon = "circle-x",
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
	Icon = "refresh-cw",
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
