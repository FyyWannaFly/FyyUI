# Getting Started with FyyUI

> Applies to FyyUI v0.19.0 · Updated 2026-08-09

This guide gets a local FyyUI menu running in Roblox Studio in a few minutes.

## Before you start

- Place the library in a trusted local **ModuleScript**. The examples call it `FyyUI`.
- Do not use `HttpGet`, `GetAsync`, or `loadstring` to bootstrap the library.
- Use Roblox Studio Play mode to verify interaction, touch layout, and input behavior.

## Create your first menu

Tabs follow creation order, so Config can be placed between normal tabs:

```lua
menu:Tab({ Text = "Main", Icon = "home" })
menu:Tab({ Text = "Automation", Icon = "zap" })
menu:ConfigTab({ Text = "Config", Icon = "settings-2" })
menu:Tab({ Text = "About", Icon = "info" })
```

```lua
local FyyUI = require(script.Parent.FyyUI)

local menu = FyyUI.Menu({
	Title = "Player Settings",
	Theme = "Dark",
    Size = UDim2.fromOffset(601, 344),
	Resizable = true,
	Responsive = true,
	CompactBreakpoint = 640,
	SafePadding = 12,
	TouchTargetSize = 44,
	ReducedMotion = false,
	-- Opt in when callbacks must initialize runtime state from control defaults.
	InvokeDefaultCallbacks = true,
	Stats = {
		Enabled = true,
		TabName = "Overview",
		ShowProfile = true,
		ShowGame = true,
		ShowServer = true,
		ShowSupport = true,
	},
	Support = { Discord = "https://discord.gg/example" },
})

local settings = menu:Tab({ Text = "Settings", Icon = "settings" })
```

You should see a window with a **Settings** tab. On a narrow viewport, the menu keeps itself within safe padding and uses a compact sidebar.

## Add controls

```lua
settings:Toggle({
	Text = "Music",
	Description = "Play background music.",
	Default = true,
	Flag = "music",
	Callback = function(enabled)
		print("music", enabled)
	end,
})

settings:Slider({
	Text = "Volume", Min = 0, Max = 100, Step = 5,
	Default = 50, Suffix = "%", Flag = "volume",
})

settings:Dropdown({
	Text = "Quality", Options = { "Low", "Medium", "High" },
	Default = "High", Flag = "quality", Searchbar = true,
})

settings:Input({ Text = "Display name", Placeholder = "Optional", Flag = "displayName" })
```

`Flag` registers a control for `ExportConfig` and `ImportConfig`. Keep flags unique inside a menu. With `InvokeDefaultCallbacks = true`, supported state controls call their callbacks once after mounting, so runtime configuration immediately matches the displayed defaults.

## Organize a larger menu

```lua
local audio = settings:Collapsible("Audio", { DefaultOpen = true })
audio:Checkbox({ Text = "Mute when unfocused", Flag = "muteUnfocused" })
audio:Button({ Text = "Test sound", Callback = function() print("Play a preview") end })
```

Tabs and collapsibles expose the same common control factories. See the [API reference](API_REFERENCE.md) for the complete list.

## Add a custom component

```lua
local indicator = settings:Custom(function(context)
	local frame = context.Create("Frame", {
		Name = "Indicator", Size = UDim2.new(1, -12, 0, 32), BackgroundTransparency = 1, Parent = context.Parent,
	})
	return { Container = frame }
end)
```

Use `FyyUI.RegisterComponent("Name", factory)` and `settings:Component("Name", options)` for reusable components.

## Save and restore settings

```lua
local saved = menu:ExportConfig()
local ok, details = menu:ImportConfig(saved, { NoCallbacks = true })
assert(ok, details and details.Failed)
```

For JSON persistence, use the opt-in v2 APIs documented in [Configuration](CONFIGURATION.md). Verify that exporting, changing a value, and importing restores the expected value.

## Next steps

- Add `Tooltip = "Help text"` to controls.
- Call `menu:Notify({ Text = "Settings updated.", Duration = 3 })` after persistence succeeds.
- Test a 320px-wide viewport, touch input, `ReducedMotion = true`, and gamepad selection before shipping.
