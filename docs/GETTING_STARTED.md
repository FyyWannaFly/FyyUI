# Getting Started with FyyUI

> Applies to FyyUI v0.13.0 · Updated 2026-07-24

This guide gets a local FyyUI menu running in Roblox Studio in a few minutes.

## Before you start

- Place the library in a trusted local **ModuleScript**. The examples call it `FyyUI`.
- Do not use `HttpGet`, `GetAsync`, or `loadstring` to bootstrap the library.
- Use Roblox Studio Play mode to verify interaction, touch layout, and input behavior.

## Create your first menu

```lua
local FyyUI = require(script.Parent.FyyUI)

local menu = FyyUI.Menu({
	Title = "Player Settings",
	Theme = "Dark",
	Size = UDim2.fromOffset(592, 340),
	Resizable = true,
	Responsive = true,
	CompactBreakpoint = 640,
	SafePadding = 12,
	TouchTargetSize = 44,
	ReducedMotion = false,
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
	Default = "High", Flag = "quality",
})

settings:Input({ Text = "Display name", Placeholder = "Optional", Flag = "displayName" })
```

`Flag` registers a control for `ExportConfig` and `ImportConfig`. Keep flags unique inside a menu.

## Organize a larger menu

```lua
local audio = settings:Collapsible("Audio", { DefaultOpen = true })
audio:Checkbox({ Text = "Mute when unfocused", Flag = "muteUnfocused" })
audio:Button({ Text = "Test sound", Callback = function() print("Play a preview") end })
```

Tabs and collapsibles expose the same common control factories. See the [API reference](API_REFERENCE.md) for the complete list.

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
