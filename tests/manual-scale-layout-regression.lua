-- Roblox Studio / executor regression harness for visual scaling geometry.
-- Load local fyyui.lua into FyyUI, then call the returned function with FyyUI.
return function(FyyUI)
	local viewport = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920, 1080)

	local function visualCenter(menu)
		local position = menu.Frame.AbsolutePosition
		local size = menu.Frame.AbsoluteSize
		return Vector2.new(position.X + size.X / 2, position.Y + size.Y / 2)
	end

	local function closeTo(actual, expected, tolerance, message)
		assert(math.abs(actual - expected) <= tolerance, message .. (" (expected %.1f, got %.1f)"):format(expected, actual))
	end

	-- Resolve the visual centre from an unscaled menu. ScreenGui coordinates can
	-- differ from Camera.ViewportSize when the Roblox client reserves insets.
	local reference = FyyUI.Menu({
		Title = "FyyUI scale geometry reference",
		Size = UDim2.fromOffset(592, 340),
		Scale = 1,
		Responsive = false,
		ReducedMotion = true,
	})
	task.wait()
	local expectedCenter = visualCenter(reference)
	reference:Destroy()

	-- A default-positioned menu must stay visually centered at every supported scale.
	local fixed = FyyUI.Menu({
		Title = "FyyUI scale geometry fixed",
		Size = UDim2.fromOffset(592, 340),
		Scale = 1.35,
		Responsive = false,
		ReducedMotion = true,
		Shadow = true,
	})
	task.wait()
	local fixedCenter = visualCenter(fixed)
	closeTo(fixedCenter.X, expectedCenter.X, 1, "scaled desktop menu must remain horizontally centered")
	closeTo(fixedCenter.Y, expectedCenter.Y, 1, "scaled desktop menu must remain vertically centered")
	assert(fixed._shadow, "shadow must exist when requested")
	closeTo(fixed._shadow.AbsolutePosition.X, fixed.Frame.AbsolutePosition.X - 8, 1, "shadow must track scaled frame X")
	closeTo(fixed._shadow.AbsolutePosition.Y, fixed.Frame.AbsolutePosition.Y - 8, 1, "shadow must track scaled frame Y")
	closeTo(fixed._shadow.AbsoluteSize.X, fixed.Frame.AbsoluteSize.X + 16, 1, "shadow width must track scaled frame")
	closeTo(fixed._shadow.AbsoluteSize.Y, fixed.Frame.AbsoluteSize.Y + 16, 1, "shadow height must track scaled frame")

	assert(fixed:SetScale(0.75))
	task.wait()
	fixedCenter = visualCenter(fixed)
	closeTo(fixedCenter.X, expectedCenter.X, 1, "shrunk desktop menu must remain horizontally centered")
	closeTo(fixedCenter.Y, expectedCenter.Y, 1, "shrunk desktop menu must remain vertically centered")
	fixed:Destroy()

	-- A large responsive menu must fit the safe viewport at a large scale, then re-center
	-- when a smaller scale makes its preferred size viable again.
	local responsive = FyyUI.Menu({
		Title = "FyyUI scale geometry responsive",
		Size = UDim2.fromOffset(850, 560),
		Scale = 1.35,
		SafePadding = 12,
		Responsive = true,
		ReducedMotion = true,
	})
	task.wait()
	assert(responsive.Frame.AbsoluteSize.X <= viewport.X - 24 + 1, "scaled responsive width must fit safe viewport")
	assert(responsive.Frame.AbsoluteSize.Y <= viewport.Y - 24 + 1, "scaled responsive height must fit safe viewport")
	assert(responsive.Frame.AbsolutePosition.X >= 11 and responsive.Frame.AbsolutePosition.Y >= 11, "scaled responsive menu must keep safe padding")

	assert(responsive:SetScale(0.75))
	task.wait()
	local responsiveCenter = visualCenter(responsive)
	closeTo(responsiveCenter.X, expectedCenter.X, 1, "responsive menu must re-center when its preferred width fits")
	closeTo(responsiveCenter.Y, expectedCenter.Y, 1, "responsive menu must re-center when its preferred height fits")
	responsive:Destroy()

	-- Maximize uses the current scale, and restoring after a scale change returns
	-- to the original visual centre rather than the old unscaled offset.
	local maximized = FyyUI.Menu({
		Title = "FyyUI scale geometry maximize",
		Size = UDim2.fromOffset(592, 340),
		Scale = 1,
		Responsive = true,
		ReducedMotion = true,
	})
	task.wait()
	maximized:_toggleMaximize()
	assert(maximized.Maximized, "maximize must enter maximized state")
	assert(maximized:SetScale(1.35))
	maximized:_toggleMaximize()
	task.wait()
	assert(not maximized.Maximized, "maximize toggle must restore the window")
	local restoredCenter = visualCenter(maximized)
	closeTo(restoredCenter.X, expectedCenter.X, 1, "restored window must retain its pre-maximize horizontal centre")
	closeTo(restoredCenter.Y, expectedCenter.Y, 1, "restored window must retain its pre-maximize vertical centre")
	maximized:Destroy()

	-- Shadows must follow the frame throughout normal-motion geometry tweens, not
	-- only after the animation has finished.
	local animated = FyyUI.Menu({
		Title = "FyyUI scale geometry animation",
		Size = UDim2.fromOffset(592, 340),
		Scale = 1.1,
		Responsive = true,
		ReducedMotion = false,
		Shadow = true,
	})
	animated:_toggleMaximize()
	task.wait(0.1)
	closeTo(animated._shadow.AbsolutePosition.X, animated.Frame.AbsolutePosition.X - 8, 1, "shadow must follow maximize X during tween")
	closeTo(animated._shadow.AbsolutePosition.Y, animated.Frame.AbsolutePosition.Y - 8, 1, "shadow must follow maximize Y during tween")
	closeTo(animated._shadow.AbsoluteSize.X, animated.Frame.AbsoluteSize.X + 16, 1, "shadow must follow maximize width during tween")
	closeTo(animated._shadow.AbsoluteSize.Y, animated.Frame.AbsoluteSize.Y + 16, 1, "shadow must follow maximize height during tween")
	task.wait(0.2)
	animated:_toggleMaximize()
	task.wait(0.1)
	closeTo(animated._shadow.AbsolutePosition.X, animated.Frame.AbsolutePosition.X - 8, 1, "shadow must follow restore X during tween")
	closeTo(animated._shadow.AbsolutePosition.Y, animated.Frame.AbsolutePosition.Y - 8, 1, "shadow must follow restore Y during tween")
	animated:Destroy()
end
