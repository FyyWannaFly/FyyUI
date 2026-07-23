# Accessibility and Device Support

> Applies to FyyUI v0.13.0 · Updated 2026-07-24

FyyUI v0.13.0 supports pointer, touch, keyboard, and gamepad-oriented interaction. Test your own labels, custom colors, and callbacks because they can still affect usability.

## Responsive and touch layout

```lua
local menu = FyyUI.Menu({
	Responsive = true,
	CompactBreakpoint = 640,
	SafePadding = 12,
	TouchTargetSize = 44,
})
```

- Responsive menus react to viewport changes and stay inside safe padding.
- Narrow viewports compact the sidebar.
- Dropdowns use a centered modal fallback when neither side has usable room.
- Dropdown rows honor `TouchTargetSize`; use 44 for touch-first screens.
- Checkbox rows, window controls, and resize grip use larger practical hit areas.

Test at 320×568 and 360×800, open dropdowns at both edges, and rotate while a popup is open.

## Reduced motion

```lua
local menu = FyyUI.Menu({ ReducedMotion = true })
```

Menu-owned layout transitions, dropdowns, command palette, tooltips, notifications, collapsibles, active-tab movement, minimize/restore/maximize, and confirmation overlays become immediate. Callback code remains responsible for its own waits or tweens.

## Keyboard and gamepad

When the latest input is a gamepad and no text field/keybind capture is active, interactive FyyUI controls receive a predictable selection order. Dropdown and close-confirmation overlays direct focus to their first actionable control, then restore the prior selection on dismissal. Interactive targets use Roblox `Activated` behavior for gamepad activation.

FyyUI intentionally does not steal selection while a `TextBox` is focused or while it is capturing a keybind.

## Text and tooltip guidance

Use concise labels and descriptions. Put secondary context in `Tooltip`:

```lua
tab:Toggle({
	Text = "Enable preview",
	Tooltip = "Shows the effect without saving it.",
})
```

Built-in Dark, Light, and Amoled muted/sidebar colors were adjusted for more legible defaults. Recheck contrast whenever `ColorOverride` changes foreground or background colors.

## QA checklist

- [ ] Test pointer, touch, keyboard, and gamepad activation.
- [ ] Test 320px width and orientation changes.
- [ ] Test `ReducedMotion = true` with dropdown, palette, notification, minimize, and close confirmation.
- [ ] Test long labels in every shipped theme.
- [ ] Open an overlay, then destroy the menu; confirm no orphan GUI remains.
