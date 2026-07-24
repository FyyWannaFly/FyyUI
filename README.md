# FyyUI

A polished Roblox Luau interface library focused on responsive layouts, consistent controls, smooth window behavior, and a compact one-file distribution.

**Current release:** `v0.17.0`

## Highlights

- Responsive tabbed window with desktop, touch, keyboard, and gamepad support.
- Toggle, checkbox, button, slider, dropdown, keybind, input, collapsible, and columns components.
- Fixed premium Overview for profile, game, server, and optional Discord support details.
- Command palette, tooltips, notifications, theme switching, reduced motion, and JSON configuration APIs.
- Modular development source compiled into one deterministic `fyyui.lua` bundle.

## Quick start

### Remote distribution

```lua
local source = game:HttpGet(
	"https://raw.githubusercontent.com/FyyWannaFly/FyyUI/main/fyyui.lua"
)
local FyyUI = assert(loadstring(source))()
```

### Local ModuleScript

Place `fyyui.lua` in a trusted ModuleScript named `FyyUI`, then require it:

```lua
local FyyUI = require(script.Parent.FyyUI)
```

### Create a menu

```lua
local menu = FyyUI.Menu({
	Title = "Fyy Community",
	Theme = "Dark",
	Resizable = true,
	Responsive = true,
	Stats = {
		Enabled = true,
		TabName = "Overview",
		ShowProfile = true,
		ShowGame = true,
		ShowServer = true,
	},
})

local main = menu:Tab({ Text = "Main", Icon = "home" })

main:Toggle({
	Text = "Enabled",
	Default = true,
	Flag = "enabled",
	Callback = function(value)
		print("Enabled:", value)
	end,
})
```

## Documentation

| Guide | Description |
| --- | --- |
| [Getting started](docs/GETTING_STARTED.md) | Installation and complete first-menu walkthrough. |
| [API reference](docs/API_REFERENCE.md) | Menu, tab, component, theme, and utility APIs. |
| [Configuration](docs/CONFIGURATION.md) | Flags, JSON-safe snapshots, import, and export. |
| [Accessibility](docs/ACCESSIBILITY.md) | Responsive layout, touch, keyboard, gamepad, and reduced motion. |
| [Troubleshooting](docs/TROUBLESHOOTING.md) | Setup, popup, configuration, and lifecycle fixes. |
| [Architecture](docs/ARCHITECTURE.md) | Modular source tree and deterministic one-file bundling. |

## Development

The 19 files under `src/` are the development source. Root `fyyui.lua` is the generated distribution consumed by remote loaders.

```bash
# Generate the distribution bundle
node scripts/build.js

# Confirm source and bundle are synchronized
node scripts/build.js --check

# Verify file count and deterministic output
node tests/verify-build.js
```

Do not edit root `fyyui.lua` directly. Update `src/`, rebuild, and commit the source changes together with the generated bundle.

## Requirements

- Roblox runtime services used by the library, including `TweenService`, `UserInputService`, `GuiService`, and `HttpService` for JSON configuration APIs.
- HTTP access when loading the remote distribution or default Lucide icon provider.
- A valid GUI parent. FyyUI uses `CoreGui` by default; provide `Parent` when another container is required.

## Icon provider

FyyUI loads its default Lucide icon provider from the configured GitHub source. Controls can use names such as `home`, `settings`, or `refresh-cw`.

```lua
FyyUI.SetIconModule(customModule)
FyyUI.LoadRemoteIconModule(customUrl)
```

Only load code and icon providers from sources you trust.

## License

Copyright © 2026 FyyWannaFly. All rights reserved.

FyyUI is **source-available, not open source**. The repository license permits use of an unmodified official distribution in personal, non-commercial Roblox projects. Copying, modification, redistribution, resale, mirroring, re-uploading, or removal of ownership notices requires prior written permission.

See [LICENSE](LICENSE) for the complete terms.
