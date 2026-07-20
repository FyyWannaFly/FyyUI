local FyyUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/FyyWannaFly/FyyUI/main/fyyui.lua"))()

local menu = FyyUI.Menu({
	Title = "FyyUI Hub",
	Resizable = true,
	HasOutline = true,
})

-- Tab 1: Main
local mainTab = menu:Tab({ Text = "Main" })

mainTab:Toggle({
	Text = "Auto Farm",
	Description = "Automatically farms ores",
	Default = false,
	Callback = function(v) print("[Auto Farm]", v) end,
})

mainTab:Toggle({
	Text = "Auto Collect",
	Description = "Collects dropped items",
	Default = true,
	Callback = function(v) print("[Auto Collect]", v) end,
})

mainTab:Divider()

mainTab:Button({
	Text = "Toggle All",
	Description = "Enable or disable all features",
	Callback = function() print("Toggle All!") end,
})

mainTab:Button({
	Text = "Stop",
	Description = "Stops all automation",
	Color = Color3.fromRGB(255, 80, 80),
	Callback = function() print("Stopped!") end,
})

-- Tab 2: Settings
local settingsTab = menu:Tab({ Text = "Settings" })

settingsTab:Slider({
	Text = "Speed",
	Description = "Adjust movement speed",
	Min = 1,
	Max = 200,
	Default = 50,
	Suffix = "%",
	Callback = function(v) print("[Speed]", v) end,
})

settingsTab:Slider({
	Text = "Range",
	Description = "Collection range",
	Min = 10,
	Max = 100,
	Default = 50,
	Suffix = "m",
	Step = 5,
	Callback = function(v) print("[Range]", v) end,
})

settingsTab:Divider()

settingsTab:Dropdown({
	Text = "Mode",
	Description = "Select automation mode",
	Options = { "Normal", "Advanced", "Expert" },
	Default = "Normal",
	Callback = function(v) print("[Mode]", v) end,
})

-- Tab 3: Info
local infoTab = menu:Tab({ Text = "Info" })

infoTab:Label({
	Text = "FyyUI v0.3.0",
	Description = "Roblox UI Library",
})

infoTab:Label({
	Text = "Status: Running",
	Color = Color3.fromRGB(0, 200, 100),
})

-- Toggle keybind
game:GetService("UserInputService").InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.KeyCode == Enum.KeyCode.RightShift then
		menu:ToggleVisibility()
	end
end)

-- Test notifications
menu:Notify({ Text = "FyyUI loaded successfully!", Duration = 3, Type = "Success" })
task.wait(3.5)
menu:Notify({ Text = "Auto Farm is ready", Duration = 2, Type = "Info" })

print("FyyUI loaded!")
