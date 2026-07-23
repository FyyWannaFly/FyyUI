# FyyUI UI/UX Audit

**Date:** 2026-07-23
**Audited version:** `0.10.6`
**Scope:** `fyyui.lua`, `demo.lua`, existing planning/QA artifacts, Git history, public Roblox guidance, and independent specialist reviews.
**Scope boundary:** This is an audit and design proposal only. No production UI behavior was changed as part of this report.

## Evidence Rules

| Label | Meaning |
| --- | --- |
| **Runtime verified** | Exercised in the connected Madium client in the preceding QA cycle. |
| **Confirmed static** | Directly established by current source and call-path inspection. |
| **Likely** | Strong source evidence, but needs a targeted runtime/visual assertion. |
| **Unverified** | Plausible concern without enough source or runtime evidence; not backlog-blocking. |

The report deliberately does not describe a visual defect as runtime-confirmed unless it was observed in the client. The runtime QA previously verified the `v0.10.6` Keybind default-value and minimize token regressions; they are **not** open findings here. No screenshot artifact was produced by the available MCP workflow, so visual claims below are source-backed unless marked otherwise. Independent reviews were consolidated only when their source references matched the current `v0.10.6` implementation; duplicate claims were collapsed and obsolete claims were rejected.

## 1. Executive Summary

FyyUI is functional and has a coherent compact desktop/sidebar direction, but it is not yet a complete design system. The strongest current surface is the basic window, tabs, common controls, themes, lifecycle cleanup, and new search/config/keybind/input capabilities. The largest user-facing weaknesses are the detached full-height dropdown popup, missing device/accessibility states, low-contrast secondary text, and inconsistent hard-coded visual behavior that bypasses theme tokens.

**UI condition:** functional with several high-impact presentation defects.
**UX condition:** desktop/mouse oriented, with useful recent additions but incomplete discovery, recovery, and cross-device behavior.
**Main risks:** dropdown placement/scrolling, lost off-screen window, mobile/gamepad exclusion, custom-theme inconsistency, undocumented APIs, and weak state feedback.
**Highest-priority work after approval:** repair popup geometry and viewport recovery, establish semantic tokens/state rules, then normalize component layout and feedback.

## 2. Current Feature Inventory

| Feature | Public surface | Status | Demo/docs | Evidence and limitations |
| --- | --- | --- | --- | --- |
| Window/topbar/drag/resize/minimize/maximize/destroy | `FyyUI.Menu`, `Menu:Destroy` | Functional but visually unfinished | Demo covers basic Menu only | Runtime verified lifecycle basics; drag is not viewport-clamped. |
| Tabs/sidebar | `Menu:Tab`, `Menu:SelectTab` | Complete core | Demo covered | Static source shows selection, hover, slide transition; no keyboard/gamepad selection. |
| Collapsible sections | `Tab:Collapsible` | Complete core | Demo covered | Runtime verified Open/Close/Toggle and nested factory; compact header only. |
| Toggle/Checkbox/Slider | `Tab:*`, `Collapsible:*` | Functional but visually unfinished | Demo covered | Toggle has enabled state; Checkbox/Slider do not expose comparable disabled state. |
| Dropdown/multi-select | `Dropdown:SetValue/SetOptions/Refresh` | Implemented but buggy | Demo basic only | Confirmed static popup placement, height, and scrolling problems. |
| Button/Label/BoldLabel/Divider | `Tab:*`, `Collapsible:*` | Functional but visually unfinished | Demo covered | Button press uses a hard-coded dark color; no disabled/loading/error model. |
| Keybind | `Tab:Keybind`, `Collapsible:Keybind` | Functional but undocumented | Demo uses old dropdown-style key choices, not API | Runtime verified default keyboard/mouse construction; no conflict/discoverability model. |
| Text input | `Tab:Input`, `Collapsible:Input` | Functional but undocumented | No example | Numeric invalid input silently reverts; no validation state. |
| Config snapshot | `ExportConfig`, `ImportConfig` | Functional but undocumented | No example | Table-only persistence; duplicate flags warn and overwrite. |
| Themes/scale/motion flag | `SetTheme`, `SetScale`, `GetScale` | Partially implemented | Demo only shows a non-wired theme dropdown and scale slider | Theme cascades to known controls; reduced motion only controls scale tween. |
| Command palette | `Open/Close/ToggleCommandPalette` | Functional but undocumented | No example | Ctrl+K, basic filtering and keyboard results; fixed 380x310 desktop geometry. |
| Tooltips | `BindTooltip`, `Tooltip` options | Functional but undocumented | No example | Mouse-only delayed hover; 300px truncation, no touch/focus equivalent. |
| Notifications | `Notify` | Functional but visually unfinished | Not demonstrated | Four colors exist, but type is color-only and fixed-height text can truncate. |
| Confirm-close modal | internal `_confirmClose` | Functional | No example | No generic dialog API, focus trap, or keyboard decision flow. |
| Color picker/status/loading/disabled/error states | none | Missing | None | No public component/state model. |

### Implemented Features vs. Documentation

The current `demo.lua` exercises Menu, tabs, collapsibles, Toggle, Checkbox, Slider, Dropdown, labels, Divider, Button, icons, Description, and several window options. It does **not** exercise Keybind, Input, flags/config import/export, runtime theme application, `SetScale`, ReducedMotion, tooltips, palette, dropdown refresh/AllowNone, notification types, custom parent, no-logo minimize, or lifecycle cleanup. There is no API reference, README, visual gallery, screenshot baseline, or automated UI test harness in the tracked project.

## 3. Missing and Unfinished Work

### Confirmed missing/partial states

* No ColorPicker, status/tag component, loading indicator, generic empty state, generic error state, or disabled-state contract.
* No keyboard focus order, visible focus ring, gamepad selection tree, or touch-specific affordances (`Selectable`, `NextSelection*`, and focus handling are absent).
* No mobile breakpoint, safe-area handling, orientation response, or mobile keyboard avoidance.
* ReducedMotion is local to `Menu:SetScale`; it does not govern tab, popup, modal, notification, tooltip, minimize, maximize, or button animation.
* Custom theme input is shallowly merged by `Theme:Override` (`fyyui.lua:128-135`) and has no required-token validation.
* `TopbarBorder` exists in every built-in theme but is not consistently consumed as the topbar visual boundary; several production colors are hard-coded.
* The external icon loader (`fyyui.lua:147-199`) has no loading/error UI state; absent icons simply reduce visual information.

### Documentation/test gaps

* `docs/IMPLEMENTATION_PLAN.md` describes an earlier planning snapshot, not the current `v0.10.6` public API.
* The only tracked demo still models Theme and menu keybind as ordinary Dropdown callbacks, so it does not prove the newer APIs are wired to behavior.
* Existing Madium QA validated lifecycle/keybind regressions, but no repeatable visual viewport matrix, touch matrix, gamepad matrix, or screenshot baseline exists. The repository has no tracked automated test harness.

## 4. Verified UI Bugs

| ID | Severity | Status | Exact location | Trigger / evidence | User impact | Correction and regression risk |
| --- | --- | --- | --- | --- | --- | --- |
| UI-01 | Resolved in v0.10.7 | Runtime verified | `Menu:ShowDropdownPopup` | The intentional right-hand panel now handles right/left available space safely; it does not convert to a trigger-anchored popup. | Preserves the product’s side-panel interaction while avoiding broken geometry. | Keep this intentional design; regression-test width branches. |
| UI-02 | Resolved in v0.10.7 | Runtime verified | `Menu:ShowDropdownPopup` | Short lists now use content-aware height; long lists use a bounded ScrollingFrame. | Side panel no longer reads as a full-height blank surface for short lists. | Preserve content-size/scroll behavior. |
| UI-03 | Resolved in v0.10.7 | Runtime verified | `Menu:ShowDropdownPopup`, `OptionList` | Long option lists now render within `OptionList` with CanvasSize larger than visible area. | Long lists are reachable without clipping. | Add this to future automated visual regression checks. |
| UI-04 | Resolved in v0.10.7 | Runtime verified | `Dropdown:_updateDisplay`, `SetValue` | Placeholder now uses muted text and selected value uses primary text. | Unset vs selected state is legible. | Preserve in SetOptions/Refresh coverage. |
| UI-05 | High | Confirmed static | `Menu:_minimize`, `:3411-3431`; no-logo restore construction `:2838-2863` | No-logo tween target is left-center but restore button is screen-center. | Visible jump in no-logo minimize flow. | Use one shared position source. Low risk. |
| UI-06 | Medium | Confirmed static | `Menu:_dragging`, `:3366-3403` | Drag position has no viewport clamp. | Menu can be moved fully off-screen without a recovery affordance. | Clamp to visible bounds/reset action. Low risk. |
| UI-07 | Medium | Confirmed static | no-logo restore control `:2838-2863` | Logo minimize control has drag handling; fallback restore button only clicks. | Inconsistent minimize behavior and poorer positioning control. | Share drag implementation. Low risk. |
| UI-08 | Medium | Confirmed static | `Slider` drag, `:457-481` | Drag termination relies on `Knob.InputEnded`, not global input end. | Releasing outside knob can leave drag state active. | Track input end through UIS and clean connection/state. Medium risk. |
| UI-09 | Medium | Likely | `Menu:_dragging`, `:3366-3394`; shadow `:2405-2426` | Shadow uses captured scale offsets; frame can use scale-based/custom positions and maximized transitions. | Shadow may drift from frame in non-default positions. | Recompute from frame absolute/UDim state after movement. Medium risk. |
| UI-10 | Medium | Likely | `Menu:Notify`, `:3313-3363` | Fixed 32px notification and one-line label without wrapping/truncation rule. | Long messages can clip or overlap visual hierarchy. | Define max width, wrapping, dynamic height and action/error treatment. Low risk. |
| UI-11 | Medium | Confirmed static | `Menu:SelectTab`, `fyyui.lua:3014-3026`; `SidebarList`, `:2691-2711` | ActiveBar uses a fixed index-derived Y target while tabs sit inside a scrollable list. | With enough tabs to scroll, active indicator can visually detach from its selected tab. | Base indicator on tab absolute position plus scroll state, or parent it to the list with layout-safe positioning. Medium risk. |

### False/obsolete claims rejected

* **Keybind default construction crash:** fixed in `v0.10.6`; runtime verified.
* **Stale minimize delayed callback after restore/destroy:** token invalidation exists in current source and was runtime verified.
* **Notification GUI surviving Menu:Destroy:** current `Menu:Destroy` destroys `_notifGui`; previous QA verified cleanup. Remaining notification tween concerns are only lifecycle-hardening candidates, not confirmed orphaning.

## 5. Verified UX Bugs

| ID | Severity | Status | Issue | Evidence / impact | Recommended correction |
| --- | --- | --- | --- | --- | --- |
| UX-01 | High | Confirmed static | Config import errors are swallowed per-control. | `ImportConfig` wraps calls in `pcall` but does not surface failed flag/value details (`:3270-3295`). Users cannot tell partial import from success. | Return structured import result and optional notification/callback. |
| UX-02 | High | Confirmed static | Numeric input rejects invalid values silently. | `TextInput` reverts on focus loss without error UI. | Inline validation/error text and persistent focus/error feedback. |
| UX-03 | High | Confirmed static | Command palette has no visible trigger/discovery cue. | It opens only with Ctrl+K or direct API (`:2899-2907`, `:4315`). | Optional topbar affordance and shortcut hint; preserve compact mode. |
| UX-04 | Medium | Confirmed static | Notification type is encoded only by accent bar color. | `Notify` maps Type to color only (`:3305-3311`). | Add icon/text label and semantic tokens. |
| UX-05 | Medium | Confirmed static | Keybind capture has no conflict disclosure or device hint. | Capture accepts keyboard/mouse only (`:2918-2925`) and allows overlapping bindings. | Surface conflict policy and current input modality. |
| UX-06 | Medium | Confirmed static | Demo settings controls imply behavior they do not perform. | `demo.lua:66-73` callbacks print rather than call `SetTheme`, `SetScale`, or Keybind API. | Make demo truthful and feature-complete. |
| UX-07 | Medium | Likely | Tooltip content is mouse-only and truncated at 300px. | `BindTooltip` uses MouseEnter/Leave; `_showTooltip` clamps width and label truncates. | Add focus/touch alternative and multi-line policy. |

## 6. Visual Design Problems

### Confirmed inconsistencies

* The theme declares `CornerRadius = 8`, but tabs use radius 6 (`Tab.new:1461`), dropdown/keybind/input fields use radius 6, tooltips use 4, modal/palette use 10, and resize grip uses 2. This can be intentional hierarchy, but it is undocumented and not consistently semantic.
* Horizontal rhythm mixes `6`, `8`, `10`, `12`, `14`, `16`, `18`, `20`, `42`, and `48` offsets. Examples: controls use 6px outer insets, labels 10px, sidebar tabs 3px, topbar 10px, content 6px. There is no declared layout scale.
* Component row heights differ beyond their semantic role: Toggle `h+6`, Slider/Button `h+8`, Dropdown/Input/Keybind use their own controls. The result is uneven density in mixed sections.
* Button press sets hard-coded `Color3.fromRGB(30,30,38)` (`Tab:Button:1653-1657`) rather than a theme press token; this is visibly wrong in Light and custom themes.
* Sidebar separator is hard-coded white at 50% transparency (`:2741-2750`), not `theme.Border`/`theme.Outline`; it weakens Light/Amoled consistency.
* Topbar hover turns the accent line fixed purple (`:2668-2677`), breaking the selected theme accent and custom ColorOverride intent.
* No-logo restore button stays hard-coded dark in `_ApplyTheme` (`:3828-3831`), which is inconsistent in Light theme.
* Custom icon resolution is process-global and remote-loaded (`:147-199`). A failed module load silently omits icons, so visual hierarchy changes without a fallback marker or developer-visible state.

### Component visual hierarchy gaps

* Most controls share the same Element panel treatment, so destructive, primary, neutral, and disabled actions lack a consistent hierarchy. Button `Color` only changes text, not a semantic action surface.
* Checkbox uses a Unicode checkmark (`✓`) rather than a controlled icon asset; cross-font visual weight is not guaranteed.
* There is no coherent icon color/size rule: tabs use 18px, button pointer uses 42px, title/window controls use separate hard-coded conventions.
* Empty, error, disabled, loading, success, and focus state visuals are absent across most components.

## 7. Color and Contrast Problems

Contrast calculations are static approximations; Roblox rendering and transparency require client validation. The following token pairs are nevertheless below common AA/non-text guidance and are priority readability candidates.

| Theme/pair | Approx. ratio | Status | Impact |
| --- | ---: | --- | --- |
| Dark `TextMuted #5F5F6E` on `Element #23232A` | 2.49:1 | Confirmed static | 14px component descriptions are difficult to read. |
| Dark `TextMuted` on `Background #121216` | 2.98:1 | Confirmed static | Muted standalone/help text is low contrast. |
| Dark `ScrollBar #41414E` on Background | 1.86:1 | Confirmed static | 3px scrollbar has weak discoverability. |
| Dark `Outline #282832` on Background | 1.60:1 before transparency | Confirmed static | Window boundary separation is weak. |
| Light `TextMuted #9494A2` on Background | about 2.8:1 | Confirmed static | Placeholder and description text fail normal-size readability expectations. |
| Amoled `TextMuted #4B4B5C` on black | below 4.5:1 | Confirmed static | Secondary content nearly disappears on OLED dark settings. |

Other color-system gaps: no semantic `Error`, `Warning`, `Success`, `Disabled`, `Focus`, `Overlay`, or `Pressed` tokens; notification colors are local hard-coded values; state is often communicated by color alone; and custom theme tables can omit keys without validation.

## 8. Spacing, Margin, Padding, and Grid Problems

* The main layout uses fixed offsets and fixed sidebar width (`150`) rather than responsive allocation (`Menu.new:2679-2734`). At `MinSize=320`, content width becomes narrow once sidebar and insets are removed.
* Tab content has only 3px top and 6px horizontal inset (`Tab.new:1501-1519`), while controls add their own 6px horizontal inset, creating stacked spacing rules rather than one content padding boundary.
* ActiveBar vertical target is calculated by index at 40px increments (`SelectTab:3014-3026`) while SidebarList itself scrolls. It does not account for list CanvasPosition, so it can become visually detached once many tabs scroll.
* SidebarList hides its scrollbar (`:2691-2700`); overflow tabs have reduced discoverability.
* Command palette is fixed at `380x310` (`:4344-4359`), notification width is fixed 320px (`:2760-2766`), and popup width is fixed 150px (`:3044`) without small-viewport adaptation.
* No layout token governs the 4px/6px/8px/10px padding patterns.

**Proposed future spacing scale:** `4, 8, 12, 16, 24, 32`; preserve 36px compact rows only for pointer-first desktop mode, and define 44px minimum interactive target for touch mode.

## 9. Typography Problems

* One SourceSans/SourceSansBold family is consistently applied, but the hierarchy is shallow: 18px title, 16px labels, and 14px descriptions/placeholders. There is no explicit section-heading, caption, feedback, or mono/keybinding scale.
* Many TextLabels do not declare `TextTruncate`, `TextWrapped`, or `AutomaticSize`; long tab labels, control labels, dropdown selections, notification content, modal copy, and button labels can clip depending on window scale.
* RichText is enabled on many labels sourced directly from options. This enables desired styling but leaves content semantics/escaping to the caller; docs do not establish an escaping policy.
* Terminology is mixed: `Input` public API versus `TextInput` internal name, “Not selected,” “None,” “Toggle,” and example dropdown-based “Toggle Menu” do not define a shared vocabulary.
* There is no visible input-label association/focus/error copy model beyond visual proximity.

## 10. Interaction and Navigation Problems

* Ctrl+K is implemented but not discoverable; its overlay is full-screen and fixed desktop geometry.
* Dropdown click-outside handling closes on any mouse click after yielding (`ShowDropdownPopup:3189-3198`); it lacks trigger-relative hit testing and reinforces the detached panel behavior.
* Tab hover, button hover, keybind hover, and input hover have inconsistent feedback mechanisms; Toggle/Checkbox/Slider rows lack equivalent full-row hover affordance.
* There is no undo/confirmation for config import, destructive Button actions, or theme changes; only close uses a confirmation dialog.
* `SetVisible`/minimize/restore state exists, but no standardized public window-state feedback or recovery shortcut exists when dragged off-screen.
* `Menu.new` accepts a broad unvalidated options table; misspelled option keys silently fall back to defaults. This is an API ergonomics issue rather than a rendering defect, but it creates confusing UX for library consumers.

## 11. Animation and Motion Problems

Current durations range from `0.06s` button press to `0.5s` palette emphasis, with repeated literal TweenInfo values. There is no motion token system.

* ReducedMotion affects scale tween only, not other movement/fade tweens.
* Slider values update immediately while Button has scale feedback; comparable interaction feedback is inconsistent.
* Popup `0.25s` slide-in/`0.2s` close, notification `0.2s`/`0.3s`, tooltip `0.12s`/`0.08s`, tabs `0.2s`, and minimize/maximize `0.25-0.3s` are individually reasonable but ungoverned.
* Some control/container tweens are not centrally owned, making destroy-time cancellation hard to guarantee. Treat this as a lifecycle-hardening item until targeted runtime traces prove errors.

**Proposed future motion categories:** instant `0ms`; feedback `80-120ms`; standard `160-200ms`; overlay/window `220-280ms`; all `Quad Out` by default; opacity-only or no motion when reduced motion is enabled.

## 12. Responsive and Device Problems

The library is primarily desktop/pointer-first. Roblox’s Adaptive Design guidance recommends layouts and controls that adapt across input types, screen sizes, and orientation.

| Surface | Current state | Status | Required future test |
| --- | --- | --- | --- |
| Desktop mouse | Main target; drag/resize/hover exist | Functional | 720p, 1080p, ultrawide, 4K scale matrix. |
| Small desktop | Fixed dimensions + minimum 320x300 | Likely constrained | 320/480 width with sidebar and palette. |
| Phone touch | Some drag/resize input includes Touch; targets remain compact | Partial | Portrait/landscape, keyboard overlap, safe zones. |
| Tablet | No layout breakpoint | Missing | Rotation and mixed touch/keyboard. |
| Keyboard | Text input/keybind/palette arrows exist | Partial | Tab traversal and focus visibility. |
| Gamepad | No selection tree | Missing | D-pad/stick/confirm/cancel traversal. |
| VR | No evidence | Unverified | Defer until product scope requires it. |

## 13. Accessibility Problems

* No keyboard focus indicator, focus order, or gamepad selection support. This is an FyyUI gap, not a Roblox platform limitation.
* 36px baseline rows and 14px secondary text are below a robust touch/low-vision comfort target; this is most acute when UI Scale is below 1.
* Information is color-only in notifications, toggle state, status text, and some selected/active state treatments.
* No response to Roblox `GuiService.PreferredTransparency`, preferred text size, or platform reduced-motion preference; only a library option exists for scale transition.
* TextInput invalid numeric input silently reverts with no error description. No disabled-state model identifies unavailable actions.
* Tooltips are mouse-hover only, excluding keyboard/touch users.

Official reference: [Roblox Accessibility Guidelines](https://create.roblox.com/docs/en-us/production/publishing/accessibility.md) recommend readable text, adequate contrast, transparency preference support, and reduced-motion accommodations. [Roblox Adaptive Design Guidelines](https://create.roblox.com/docs/en-us/production/publishing/adaptive-design.md) recommend input fluidity, responsive layout, dynamic sizing, and clear cross-device feedback.

## 14. Component-by-Component Review

| Component | Current state | Gaps / problems | Priority |
| --- | --- | --- | --- |
| Main window/topbar | Drag, resize option, minimize/maximize/close exist | no viewport clamp; fixed desktop sizing; hard-coded accent hover | Must fix |
| Sidebar/tabs | selected/hover/slide present | no keyboard/gamepad state; ActiveBar scroll desync; hidden overflow scrollbar | High |
| Collapsible | open/closed and hover present | no focus/disabled/loading/error; row density uses special 34px header | Recommended |
| Toggle | value, hover via switch, `SetEnabled` | color-only state; no focus; differing row treatment | High |
| Checkbox | value and hover box | no disabled API; unicode checkmark; no focus | High |
| Slider | click/drag value | release-outside drag risk; 6px track/14px knob poor touch target | Must fix |
| Dropdown/multi | selection, refresh, empty popup copy | detached full-height panel, no scrolling, placeholder color bug, no keyboard/navigation | Critical |
| Button | hover/press/callback | hard-coded press color, oversized decorative pointer, no disabled/loading state | High |
| Labels/dividers | simple content hierarchy | no truncation/wrap standards, static divider semantics | Recommended |
| Keybind | capture/toggle/hold/default | no conflict model, focus/device hints, disabled state | High |
| Input | text/numeric/focus API | silent invalid state, no error/disabled/clear affordance | Must fix |
| Notifications | type colors, stack, auto-dismiss | color-only type, fixed height, no action/progress/close | High |
| Confirm modal | overlay and two actions | no generic API, focus trap, keyboard/gamepad path | High |
| Tooltips | delayed mouse hover, theme support | mouse-only, max-width truncate, no rich placement policy | Recommended |
| Command palette | Ctrl+K, filter, arrows/enter/escape | no discoverability, fixed dimensions, no category/filter metadata | High |
| Minimized controls | logo/no-logo restore | no-logo position jump/drag parity | Must fix |
| Icons | remote Lucide-style resolver, optional image icons | silent remote failure, no local fallback/loading or per-menu ownership | High |

## 15. External Research Findings

**Facts:** Roblox recommends adaptive layouts, dynamic sizing, multiple input modes, readable text, and clear visual feedback. Its accessibility guidance specifically calls out contrast, text size, transparency preference, and reduced motion. Roblox’s UI styling documentation supports centralizing shared property values rather than scattering overrides.

Public-library comparison is qualitative, not a request to copy code:

| Pattern seen in public documentation | Relevance to FyyUI | Value / cost / priority |
| --- | --- | --- |
| Documented component catalog, config guides, icons, inputs, keybinds, color pickers, dialogs (e.g. [WindUI docs](https://footagesus.github.io/WindUI-Docs/docs)) | FyyUI has many APIs not represented in its demo/docs. | High user value; low-medium cost; **Now**. |
| Explicit production primitives and config/theming docs (e.g. [Rayfield docs](https://docs.sirius.menu/rayfield)) | Confirms the expectation of clear API references and reliable lifecycle contracts. | High value; medium documentation/test cost; **Now**. |
| Semantic/tokenized styles and state coverage | Fits FyyUI’s existing Theme table but requires token completion. | High value; medium migration cost; **Next**. |
| Gamepad/mobile-focused navigation | Relevant to Roblox broadly, but higher complexity for a desktop hub. | Medium value; high cost; **Later unless target expands**. |

## 16. Recommended Design System

This is a proposal, not an implementation decision.

### Tokens

* **Primitive colors:** each built-in theme owns neutral and accent ramps.
* **Semantic colors:** `surface.base`, `surface.raised`, `surface.interactive`, `text.primary/secondary/muted/disabled`, `border.subtle/strong/focus`, `accent.default/hover/pressed`, `state.success/warning/error/info`, `overlay.scrim`, `icon.default/muted`.
* **Typography:** `title 20 bold`, `section 16 bold`, `body 16 regular`, `caption 14 regular`, `micro 12 only where nonessential`; add a keybind/value style.
* **Spacing:** `4/8/12/16/24/32`; content padding 12, component gap 8, section gap 16.
* **Radii:** `4` micro, `8` controls/cards, `12` modal/palette; avoid arbitrary per-component radii.
* **Borders:** 1px subtle default; 1-2px accent focus; no hard-coded white/purple boundaries.
* **Shadows:** one window elevation token only; calculate from window bounds consistently.
* **Heights:** compact pointer mode: 36 row, 44 input/button, 52 description row; touch mode: 44 minimum actionable target.
* **States:** every interactive component must define default, hover, pressed, focused, selected/on, disabled, invalid/error, loading where asynchronous, and empty where collection-backed.

Migration risk is medium because consumers supply custom themes and may depend on current offsets/colors. Preserve legacy keys initially and validate/normalize at the public boundary before deprecating them.

## 17. Prioritized Improvement Backlog

### Critical

1. **UI-01 to UI-03:** Rebuild dropdown as trigger-anchored, viewport-clamped, content-sized scrolling popup. Acceptance: short and long lists stay associated with trigger, remain visible, and support multi-select.

### Must Fix

1. **UI-04:** Correct placeholder/selected text treatment.
2. **UI-05/UI-07:** Unify no-logo minimize target and drag behavior.
3. **UI-06:** Clamp/recover dragged window.
4. **UI-08:** End slider drag globally and test release outside control.
5. **UX-02:** Add visible input validation error feedback.
6. **UI-11:** Keep the active tab indicator aligned when the sidebar scrolls.

### High Priority

1. Establish semantic theme/state tokens and remove hard-coded press/divider/topbar/no-logo colors.
2. Bring text and scrollbar contrast to a tested readability target.
3. Add disabled/error/empty/loading state contract to component APIs.
4. Update demo and write API reference for all v0.10.x features.
5. Add palette discoverability and notification semantic icon/text.
6. Define responsive constraints for fixed palette/notification/sidebar widths.

### Recommended

1. Normalize spacing/radius/icon/motion rules.
2. Add tooltip keyboard/touch alternatives and a generic dialog API.
3. Validate custom theme completeness and report import errors structurally.
4. Add screenshot-based visual regression and runtime interaction matrix.

### Optional / Future

1. Color picker/status tags/loading components.
2. Full gamepad focus tree and mobile breakpoint architecture.
3. File-backed executor persistence adapter, explicitly optional to preserve portability.

### Rejected for now

* Full reactive-framework rewrite: high compatibility and maintenance cost; improve the existing Menu/component ownership first.
* Copying a third-party UI library: incompatible with the requested FyyUI identity and unnecessary for the identified fixes.

## 18. Suggested Implementation Phases

| Phase | Objective and scope | Risks | Acceptance criteria / required tests |
| --- | --- | --- | --- |
| 1. Rendering blockers | Dropdown geometry/scroll, slider release, minimize parity, viewport clamp | popup layering/regression | Madium tests at four window positions, short/long/multi dropdown lists, drag/release outside, logo/no-logo minimize. |
| 2. Token foundation | Add semantic tokens and validate custom themes | consumer custom theme compatibility | Dark/Light/Amoled/custom visual matrix; no hard-coded state color remains in scoped components. |
| 3. Layout normalization | Spacing, widths, component heights, icon rules | visual churn | screenshot baselines at 320/592/850 widths and common scales. |
| 4. Component states | disabled/error/empty/loading/focus models | API surface expansion | per-control state table and keyboard/touch manual test. |
| 5. Interaction feedback | palette affordance, notification semantics, config import results, dialog rules | user workflow changes | interaction tests prove discoverability, failure feedback, and recovery. |
| 6. Responsive/device | touch targets, safe layout, keyboard focus, gamepad strategy | high scope | phone/tablet/desktop/gamepad compatibility matrix. |
| 7. Motion/accessibility | centralized motion, reduced-motion application, contrast/text fixes | perceived visual change | preference-aware motion and contrast review in all themes. |
| 8. Documentation/QA | demo, API reference, screenshot/runtime regression harness | upkeep | every public API has example and automated/manual test case. |

## Approval Gates

Implementation should not start until the owner approves:

1. The compact desktop/sidebar design direction and proposed token/state system.
2. Whether mobile/gamepad is a current product requirement or deferred scope.
3. Whether to preserve the current detached side-panel dropdown behavior for compatibility, or replace it with the recommended trigger-anchored popup.
4. Whether executor filesystem config persistence is in scope after the universal table API.
5. Whether accessibility targets are best-effort or a stated release criterion.

After approval, begin with Phase 1 only; it has the clearest user impact and lowest design ambiguity.
