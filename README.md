# FyyUI

FyyUI is a local Roblox Luau UI library for tabs, controls, command-palette navigation, responsive layouts, and persisted settings.

Current release: **v0.16.0**.

## Quick start

1. Put `fyyui.lua` in a trusted Roblox **ModuleScript** named `FyyUI`.
2. Require that local ModuleScript. Do not download or execute UI code at runtime.
3. Create a menu and add a tab.

```lua
local FyyUI = require(script.Parent.FyyUI)

local menu = FyyUI.Menu({
	Title = "Example",
	Theme = "Dark",
	Resizable = true,
	Responsive = true,
	ReducedMotion = false,
})

local tab = menu:Tab({ Text = "Main", Icon = "home" })
tab:Toggle({
	Text = "Enabled",
	Default = true,
	Flag = "enabled",
	Callback = function(value)
		print("Enabled:", value)
	end,
})
```

You should see a window with a **Main** tab and an interactive toggle.

## Documentation

- [Getting started](docs/GETTING_STARTED.md) — installation and a complete first menu.
- [API reference](docs/API_REFERENCE.md) — menu, tab, control, theme, and utility APIs.
- [Configuration](docs/CONFIGURATION.md) — flags, legacy snapshots, JSON-safe v2, and import errors.
- [Accessibility and device support](docs/ACCESSIBILITY.md) — responsive layout, touch, keyboard, gamepad, and reduced motion.
- [Troubleshooting](docs/TROUBLESHOOTING.md) — setup, configuration, popup, and lifecycle fixes.

## Security model

FyyUI automatically loads the Lucide icon provider from the configured GitHub source, so controls can use names such as `crosshair`, `settings`, or `refresh-cw`. `FyyUI.LoadRemoteIconModule(url)` can reload or replace that provider, and `FyyUI.SetIconModule(module)` can override it directly.

## Requirements

- Roblox runtime services (`TweenService`, `UserInputService`, `GuiService`, and `HttpService` only for JSON configuration APIs).
- A trusted local ModuleScript installation.
- A GUI parent accepted by Roblox. By default FyyUI uses `CoreGui`; set `Parent` explicitly when your experience requires another parent.

## Release highlights

v0.16.0 adds responsive 1:1 Columns to Tabs and Collapsibles, including compact stacking and independent Collapsible flows, and removes notification exit jumps by freezing the exiting card before a smooth rightward fade.

## License and contributions

No license file is currently included in this repository. Confirm project ownership and licensing before redistributing the library.
