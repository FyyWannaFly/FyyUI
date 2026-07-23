# FyyUI

FyyUI is a local Roblox Luau UI library for tabs, controls, command-palette navigation, responsive layouts, and persisted settings.

Current release: **v0.13.0**.

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

FyyUI is intended to be loaded from a trusted local ModuleScript. `LoadRemoteIconModule` is retained only as a compatibility stub and always returns `false`; it does not download or execute code. Supply a trusted local icon provider with `FyyUI.SetIconModule(module)` when needed.

## Requirements

- Roblox runtime services (`TweenService`, `UserInputService`, `GuiService`, and `HttpService` only for JSON configuration APIs).
- A trusted local ModuleScript installation.
- A GUI parent accepted by Roblox. By default FyyUI uses `CoreGui`; set `Parent` explicitly when your experience requires another parent.

## Release highlights

v0.13.0 adds practical keyboard/gamepad selection, 44px touch-friendly key targets, transient-overlay focus restoration, and reduced-motion coverage. See [Accessibility and device support](docs/ACCESSIBILITY.md) for device behavior.

## License and contributions

No license file is currently included in this repository. Confirm project ownership and licensing before redistributing the library.
