# FyyUI API Reference

> Applies to FyyUI v0.13.0 · Updated 2026-07-24

This reference describes the public FyyUI v0.13.0 API. Destroyed menus, tabs, collapsibles, and controllers safely return `false, "destroyed"` or `nil, "destroyed"` instead of creating orphan UI.

## Module

```lua
local FyyUI = require(script.Parent.FyyUI)
```

| API | Description |
| --- | --- |
| `FyyUI.Version` | Current version string. |
| `FyyUI.Theme` | Built-in `Dark`, `Light`, and `Amoled` themes. |
| `FyyUI.Menu(options)` | Creates a menu. |
| `FyyUI.SetIconModule(module)` | Sets a trusted local icon provider. |
| `FyyUI.GetIconModule()` | Reads the current icon provider. |
| `FyyUI.LoadRemoteIconModule(...)` | Compatibility stub; always returns `false` and never executes code. |

## `FyyUI.Menu(options)`

| Option | Type | Default | Notes |
| --- | --- | --- | --- |
| `Title` | string | `"FyyUI"` | Window title. |
| `Theme` | string/table | `"Dark"` | Built-in name or custom theme table. |
| `ColorOverride` | table | nil | Merges color fields onto the chosen theme. |
| `Parent` | Instance | `CoreGui` | Explicit GUI parent. |
| `Size`, `Position` | UDim2 | default | Initial geometry. |
| `MinSize`, `MaxSize` | Vector2 | 320×300 / 850×560 | Positive finite bounds. |
| `Resizable` | boolean | false | Shows a resize grip. |
| `Responsive` | boolean | true | Reflows for viewport changes. |
| `CompactBreakpoint` | number | 640 | Compact-navigation width. |
| `SafePadding` | number | 12 | Viewport edge spacing. |
| `TouchTargetSize` | number | 36 | Minimum dropdown target; at least 24. Use 44 for touch-first UI. |
| `ReducedMotion` | boolean | false | Makes menu-owned transitions immediate. |
| `Scale` | number | 1 | Clamped to 0.75–1.35. |
| `Visible` | boolean | true | Initial visibility. |
| `Topbar` | table | `{}` | `ButtonsType` (`"Default"`/`"Mac"`) and `TitleAlignment`. |
| `PaletteMaxResults` | number | 60 | Command-palette result cap. |

### Menu methods

| Method | Result |
| --- | --- |
| `menu:Tab(options)` | Creates a tab with `Text` and optional `Icon`. |
| `menu:SelectTab(tab)` | Selects a tab. |
| `menu:SetVisible(v)`, `ToggleVisibility()`, `GetVisible()` | Visibility control. |
| `menu:SetTitle(text)` | Updates the title. |
| `menu:SetTheme(nameOrTable)` | Applies a built-in or merged custom theme. |
| `menu:SetScale(value)`, `GetScale()` | Updates or reads the clamped scale. |
| `menu:Notify(options)` | Shows a notification. |
| `menu:BindTooltip(instance, text)` | Binds help and returns an unbind function. |
| `menu:OpenCommandPalette()`, `CloseCommandPalette()`, `ToggleCommandPalette()` | Palette control. |
| `menu:ExportConfig(options)`, `ImportConfig(snapshot, options)` | Table persistence. |
| `menu:ExportConfigJSON()`, `ImportConfigJSON(json, options)` | JSON-safe persistence. |
| `menu:Destroy()` | Cleans UI and tracked connections. |

### Notifications

```lua
local handle = menu:Notify({ Text = "Settings updated.", Duration = 3 })
handle:Update("Done.")
handle:Dismiss()
```

`Text` may be multiline. Use a positive `Duration` for auto-dismiss or dismiss the returned handle yourself.

## Tabs and collapsibles

`menu:Tab({ Text = "Main", Icon = "home" })` returns a tab. Tabs provide:

```lua
tab:Toggle(options)
tab:Checkbox(options)
tab:Slider(options)
tab:Dropdown(options)
tab:Keybind(options)
tab:Input(options)
tab:Button(options)
tab:Label(options)
tab:BoldLabel(options)
tab:Divider()
tab:Collapsible(title, options)
```

Collapsibles support the same control factories (except nested collapsibles) plus `SetOpen(boolean)`, `ToggleOpen()`, `Open()`, `Close()`, `Destroy()`, and `ApplyTheme(theme)`.

All controls accept `Tooltip`. Flagged controls also accept `Flag` and participate in configuration export/import.

## Controllers

### Toggle and checkbox

```lua
local toggle = tab:Toggle({ Text = "Feature", Default = false, Callback = function(value) end })
toggle:SetValue(true [, instant] [, noCallback])
toggle:GetValue()
toggle:SetEnabled(boolean)      -- Toggle only
toggle:SetText(string)          -- Toggle only
toggle:SetDescription(string)   -- Toggle only
toggle:Destroy()
```

`Checkbox` supports `SetValue`, `GetValue`, `Destroy`, and `ApplyTheme`. Both require boolean values.

### Slider

```lua
local slider = tab:Slider({ Text = "Range", Min = 0, Max = 100, Step = 1, Default = 50, Suffix = "%" })
slider:SetValue(75 [, noCallback])
slider:GetValue()
```

`Min <= Max` and a positive finite `Step` are required. `SetValue` clamps programmatic values; pointer/touch input also rounds to the configured step.

### Dropdown

```lua
local dropdown = tab:Dropdown({ Text = "Mode", Options = { "A", "B" }, Default = "A" })
dropdown:SetValue("B" [, noCallback])
dropdown:SetOptions({ "A", "B", "C" } [, preferredValue] [, noCallback])
dropdown:Refresh(options [, preferredValue] [, noCallback])
dropdown:GetValue()
```

Set `Multi = true` for an ordered array result and callback snapshot. Set `AllowNone = true` to allow no selection. `SetOptions` rejects non-table lists and does not fire callbacks when the selection is unchanged.

### Keybind and input

```lua
local bind = tab:Keybind({ Text = "Open", Default = Enum.KeyCode.RightShift, Mode = "Toggle" })
bind:SetValue(Enum.KeyCode.F)
bind:SetMode("Hold") -- "Toggle" or "Hold"
bind:GetValue()

local input = tab:Input({ Text = "Name", Placeholder = "Player", Default = "" })
input:SetValue("Fyy")
input:GetValue()
input:Focus()
```

Numeric input uses `Numeric = true`; it accepts finite values or blank input. `IsEmpty()` distinguishes a blank numeric input from zero.

### Button, labels, and divider

`Button` accepts `Text`, optional `Description`, `Icon`, `Color`, `Tooltip`, and `Callback`. `Label` and `BoldLabel` accept `Text`, optional `Description`, `Color`, and `TextSize`. `Divider()` takes no options.

## Themes and return conventions

Pass a built-in theme name or a table merged with the default theme. Use `ColorOverride` for partial color changes. Icons may be raw `rbxassetid://...` values or names resolved by a trusted local provider.

Setters normally return `true` on success, or `false, "reason"` for validation/lifecycle errors. Factories return a new object, or `nil, "destroyed"` when the owner is destroyed. Configuration imports return `ok, details`; see [Configuration](CONFIGURATION.md).
