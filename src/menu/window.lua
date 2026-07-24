function Menu:_dragging()
	local topbar = self.Topbar
	local frame = self.Frame
	local shadow = self._shadow
	local dragging, ds, sp
	local uis = game:GetService("UserInputService")
	local CLAMP_MARGIN = 40

	topbar.InputBegan:Connect(function(input)
		local t = input.UserInputType
		if t == Enum.UserInputType.MouseButton1 or t == Enum.UserInputType.Touch then
			dragging = true
			ds = input.Position
			sp = frame.Position
		end
	end)
	self._dragInputCon = uis.InputChanged:Connect(function(input, gpe)
		if gpe then
			return
		end
		if
			(input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch)
			and dragging
		then
			local delta = input.Position - ds
			-- Clamp so at least CLAMP_MARGIN px of the frame stays visible in the viewport
			local viewport = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920, 1080)
			local fs = frame.AbsoluteSize
			local rawX = sp.X.Scale * viewport.X + sp.X.Offset + delta.X
			local rawY = sp.Y.Scale * viewport.Y + sp.Y.Offset + delta.Y
			local clampedX = math.clamp(rawX, -fs.X + CLAMP_MARGIN, viewport.X - CLAMP_MARGIN)
			local clampedY = math.clamp(rawY, -fs.Y + CLAMP_MARGIN, viewport.Y - CLAMP_MARGIN)
			frame.Position = UDim2.new(
				sp.X.Scale,
				clampedX - sp.X.Scale * viewport.X,
				sp.Y.Scale,
				clampedY - sp.Y.Scale * viewport.Y
			)
			if shadow then
				shadow.Position = UDim2.new(
					sp.X.Scale,
					clampedX - sp.X.Scale * viewport.X - 8,
					sp.Y.Scale,
					clampedY - sp.Y.Scale * viewport.Y - 8
				)
			end
		end
	end)
	topbar.InputEnded:Connect(function(input)
		local t = input.UserInputType
		if t == Enum.UserInputType.MouseButton1 or t == Enum.UserInputType.Touch then
			dragging = false
		end
	end)
end

function Menu:_closeTransientUi()
	self:HideDropdownPopup()
	self:CloseCommandPalette()
	self._tooltipPending = false
	self._tooltipTarget = nil
	self:_hideTooltip()
	if self._confirmPopup then
		local confirm = self._confirmPopup
		self._confirmPopup = nil
		for _, instance in pairs(confirm) do
			pcall(function()
				instance:Destroy()
			end)
		end
	end
end

function Menu:_setInternalsVisible(visible)
	if self.Sidebar then
		self.Sidebar.Visible = visible
	end
	if self.ContentArea then
		self.ContentArea.Visible = visible
	end
	if self.SidebarLine then
		self.SidebarLine.Visible = visible
	end
	if self.TitleLogo then
		self.TitleLogo.Visible = visible
	end
	if self.TitleAccent then
		self.TitleAccent.Visible = visible and self._titleBranded
	end
	if self.Title then
		self.Title.Visible = visible
	end
	if self.Topbar then
		for _, child in ipairs(self.Topbar:GetChildren()) do
			if child:IsA("ImageButton") then
				child.Visible = visible
			end
		end
	end
end

function Menu:_setMenuTransitionVisual(scale, backgroundTransparency, shadowTransparency, outlineTransparency)
	if self._uiScale then
		self._uiScale.Scale = scale or self.Scale
	end
	if self.Frame and backgroundTransparency ~= nil then
		self.Frame.BackgroundTransparency = backgroundTransparency
	end
	if self._shadow and shadowTransparency ~= nil then
		self._shadow.BackgroundTransparency = shadowTransparency
	end
	local outline = self.Frame and self.Frame:FindFirstChildOfClass("UIStroke")
	if outline and outlineTransparency ~= nil then
		outline.Transparency = outlineTransparency
	end
end

function Menu:_refreshRestoredLayout()
	self:_applyResponsiveLayout(true)
	if not self.ContentArea then
		return
	end
	for _, child in ipairs(self.ContentArea:GetChildren()) do
		if child:IsA("ScrollingFrame") then
			local layout = child:FindFirstChildOfClass("UIListLayout")
			if layout then
				local padding = child:FindFirstChildOfClass("UIPadding")
				local paddingY = padding and (padding.PaddingTop.Offset + padding.PaddingBottom.Offset) or 0
				child.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + paddingY)
			end
		end
	end
end

function Menu:_minimize()
	if self._destroyed then
		return
	end
	if self.Minimized then
		return true
	end
	self:_closeTransientUi()
	self:_setInternalsVisible(false)
	self.Minimized = true
	self._minPrevSize = self.Frame.Size
	self._minPrevPos = self.Frame.Position

	self._minimizeToken = (self._minimizeToken or 0) + 1
	local minimizeToken = self._minimizeToken
	local pending = self._shadow and 3 or 2
	local function finishMinimize()
		pending -= 1
		if pending > 0 then
			return
		end
		if self._destroyed or self._minimizeToken ~= minimizeToken or not self.Minimized or not self.Visible then
			if self._minimizeToken == minimizeToken then
				self:_setInternalsVisible(true)
				self:_setMenuTransitionVisual(self.Scale, self._baseBackgroundTransparency, 0.55, 0.25)
			end
			return
		end
		if self._minGui then
			self._minFrame.Position = self._minSavedPos or self._minInitialPos
			self._minFrame.Active = true
			self._minFrame.BackgroundTransparency = 0
			if self._minScale then
				self._minScale.Scale = 1
			end
			local icon = self._minFrame:FindFirstChild("Icon")
			if icon then
				icon.ImageTransparency = 0
			end
			self._minGui.Enabled = true
			self._minGui.Parent = self.GuiParent
			self.Gui.Enabled = false
		elseif self._noLogoRestoreGui then
			if self._noLogoRestoreBtn and self._noLogoSavedPos then
				self._noLogoRestoreBtn.Position = self._noLogoSavedPos
			end
			self._noLogoRestoreGui.Enabled = true
			self._noLogoRestoreGui.Parent = self.GuiParent
			self.Gui.Enabled = false
		end
	end
	self:_transition(self.Frame, 0.22, {
		Position = self.Frame.Position + UDim2.fromOffset(0, 8),
		BackgroundTransparency = math.min(1, self._baseBackgroundTransparency + 0.72),
	}, Enum.EasingStyle.Quad, Enum.EasingDirection.In, finishMinimize)
	self:_transition(
		self._uiScale,
		0.22,
		{ Scale = self.Scale * 0.96 },
		Enum.EasingStyle.Quad,
		Enum.EasingDirection.In,
		finishMinimize
	)
	if self._shadow then
		self:_transition(self._shadow, 0.18, { BackgroundTransparency = 1 }, nil, nil, finishMinimize)
	end
end

function Menu:_restore()
	if self._destroyed or self._restoring or not self.Minimized then
		return
	end
	self._restoring = true
	self._minimizeToken = (self._minimizeToken or 0) + 1
	local restoreToken = self._minimizeToken
	self.Minimized = false
	local guiWasEnabled = self.Gui.Enabled
	local minGuiWasEnabled = self._minGui and self._minGui.Enabled or false
	local noLogoGuiWasEnabled = self._noLogoRestoreGui and self._noLogoRestoreGui.Enabled or false

	local restorePos = self._minPrevPos or self._initialPos
	self.Frame.Size = self._minPrevSize or self._initialSize
	self.Frame.Position = restorePos + UDim2.fromOffset(0, 8)
	self:_setMenuTransitionVisual(self.Scale * 0.96, math.min(1, self._baseBackgroundTransparency + 0.72), 1, 1)
	self.Gui.Enabled = true
	self:_refreshRestoredLayout()
	if self._minFrame and self._minGui and self._minGui.Enabled then
		self._minFrame.Active = false
		local icon = self._minFrame:FindFirstChild("Icon")
		self:_transition(
			self._minFrame,
			0.12,
			{ BackgroundTransparency = 1 },
			Enum.EasingStyle.Quad,
			Enum.EasingDirection.In
		)
		if self._minScale then
			self:_transition(self._minScale, 0.12, { Scale = 0.9 }, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
		end
		if icon then
			self:_transition(icon, 0.1, { ImageTransparency = 1 }, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
		end
		local function hideMinimizeGui()
			if self._destroyed or self._minimizeToken ~= restoreToken then
				return
			end
			self._minGui.Enabled = false
		end
		if self._reducedMotion then
			hideMinimizeGui()
		else
			task.delay(0.12, hideMinimizeGui)
		end
	elseif self._noLogoRestoreGui then
		self._noLogoRestoreGui.Enabled = false
	end

	local pending = self._shadow and 3 or 2
	local function finishRestore()
		pending -= 1
		if pending <= 0 then
			if self._destroyed or self._minimizeToken ~= restoreToken then
				if not self._destroyed then
					self.Minimized = true
					self.Gui.Enabled = guiWasEnabled
					if self._minGui then
						self._minGui.Enabled = minGuiWasEnabled
					end
					if self._noLogoRestoreGui then
						self._noLogoRestoreGui.Enabled = noLogoGuiWasEnabled
					end
				end
				self._restoring = false
				return
			end
			self:_setInternalsVisible(true)
			self._restoring = false
			if self._minFrame then
				self._minFrame.Active = true
				self._minFrame.BackgroundTransparency = 0
				if self._minScale then
					self._minScale.Scale = 1
				end
				local icon = self._minFrame:FindFirstChild("Icon")
				if icon then
					icon.ImageTransparency = 0
				end
			end
			if self._noLogoRestoreGui then
				self._noLogoRestoreGui.Enabled = false
			end
			self:_refreshRestoredLayout()
			local activeTab = self.ActiveTab
			if activeTab and activeTab.Components then
				for _, comp in ipairs(activeTab.Components) do
					if type(comp) == "table" and type(comp._updateSize) == "function" then
						pcall(comp._updateSize, comp, true)
					end
				end
			end
		end
	end
	self:_transition(
		self.Frame,
		0.24,
		{ Position = restorePos, BackgroundTransparency = self._baseBackgroundTransparency },
		Enum.EasingStyle.Quint,
		Enum.EasingDirection.Out,
		finishRestore
	)
	self:_transition(
		self._uiScale,
		0.24,
		{ Scale = self.Scale },
		Enum.EasingStyle.Quint,
		Enum.EasingDirection.Out,
		finishRestore
	)
	if self._shadow then
		self:_transition(self._shadow, 0.22, { BackgroundTransparency = 0.55 }, nil, nil, finishRestore)
	else
		-- Frame and scale are the only completion signals when no shadow exists.
		-- Keep the restoring lock until both callbacks above complete.
	end
end

function Menu:_toggleMaximize()
	if self._destroyed or self._maximizing then
		return
	end
	self._maximizing = true
	self.Maximized = not self.Maximized
	self.Gui.Enabled = true
	if self.Minimized then
		self.Minimized = false
		self:_setInternalsVisible(true)
		if self._minGui then
			self._minGui.Enabled = false
		end
		if self._noLogoRestoreGui then
			self._noLogoRestoreGui.Enabled = false
		end
	end

	if self._maximizeTween then
		self._maximizeTween:Cancel()
	end
	local viewport = self:_viewportSize()
	local targetSize, targetPosition
	if self.Maximized then
		self._maxPrevPos = self.Frame.Position
		self._maxPrevSize = self.Frame.Size
		targetSize = UDim2.fromOffset(viewport.X - 40, viewport.Y - 40)
		targetPosition = UDim2.fromOffset(20, 20)
	else
		targetSize = self._maxPrevSize or self._initialSize
		targetPosition = self._maxPrevPos or self._initialPos
	end

	self._maximizeTween = self:_transition(
		self.Frame,
		0.25,
		{ Size = targetSize, Position = targetPosition },
		Enum.EasingStyle.Quart,
		Enum.EasingDirection.Out,
		function()
			if self._destroyed then
				return
			end
			self._maximizing = false
			self._maximizeTween = nil
			if self._updateShadow then
				self._updateShadow()
			end
		end
	)
end

function Menu:_resizable()
	local grip = U.Create("ImageButton", {
		Name = "ResizeGrip",
		Size = UDim2.fromOffset(44, 44),
		Position = UDim2.new(1, -44, 1, -44),
		BackgroundTransparency = 1,
		AutoButtonColor = false,
		Active = true,
		Parent = self.Frame,
	})
	local gripVisual = U.Create("Frame", {
		Name = "Visual",
		Size = UDim2.fromOffset(14, 14),
		Position = UDim2.new(1, -14, 1, -14),
		BackgroundColor3 = self.Theme.TextMuted,
		BackgroundTransparency = 0.6,
		BorderSizePixel = 0,
		Parent = grip,
	})
	U.Create("UICorner", { CornerRadius = UDim.new(0, 2), Parent = gripVisual })

	local frame = self.Frame
	local shadow = self._shadow
	local uis = game:GetService("UserInputService")
	local resizing, rs, rsiz, resizeInputObj

	grip.InputBegan:Connect(function(input)
		local t = input.UserInputType
		if t == Enum.UserInputType.MouseButton1 or t == Enum.UserInputType.Touch then
			resizing = true
			resizeInputObj = input
			rs = input.Position
			rsiz = frame.Size
		end
	end)
	self._resizeInputCon = uis.InputChanged:Connect(function(input, _)
		local t = input.UserInputType
		-- gpe guard removed: while actively resizing we must follow all mouse/touch movement.
		-- For touch, only follow the specific initiating touch (not unrelated touches).
		local isOurTouch = (t == Enum.UserInputType.Touch and input == resizeInputObj)
		if ((t == Enum.UserInputType.MouseMovement) or isOurTouch) and resizing then
			local delta = input.Position - rs
			local nw = math.max(200, rsiz.X.Offset + delta.X)
			local nh = math.max(140, rsiz.Y.Offset + delta.Y)
			if self.MinSize then
				nw = math.max(nw, self.MinSize.X)
				nh = math.max(nh, self.MinSize.Y)
			end
			if self.MaxSize then
				nw = math.min(nw, self.MaxSize.X)
				nh = math.min(nh, self.MaxSize.Y)
			end
			frame.Size = UDim2.fromOffset(nw, nh)
			if not self._responsiveApplied and not self.Maximized then
				self._responsiveBaseSize = frame.Size
				self._responsiveBasePosition = frame.Position
			end
			if shadow then
				shadow.Size = UDim2.fromOffset(nw + 16, nh + 16)
			end
		end
	end)
	self._resizeEndCon = uis.InputEnded:Connect(function(input, _)
		local t = input.UserInputType
		-- gpe guard removed: must always stop resize on release.
		-- Mouse: any MouseButton1 release stops resize.
		-- Touch: only the specific initiating touch release stops resize.
		if resizing then
			if t == Enum.UserInputType.MouseButton1 or (t == Enum.UserInputType.Touch and input == resizeInputObj) then
				resizing = false
				resizeInputObj = nil
			end
		end
	end)
end

function Menu:SetVisible(v)
	if self._destroyed then
		return false, "destroyed"
	end
	if type(v) ~= "boolean" then
		return false, "expected boolean"
	end
	self.Visible = v
	if not self.Gui then
		return false, "missing gui"
	end
	if v then
		-- Restore visibility without accidentally unminimizing
		if self.Minimized then
			self.Gui.Enabled = false
			if self._minGui then
				self._minGui.Enabled = true
				self._minGui.Parent = self.GuiParent
			elseif self._noLogoRestoreGui then
				self._noLogoRestoreGui.Enabled = true
				self._noLogoRestoreGui.Parent = self.GuiParent
			end
		else
			self.Gui.Enabled = true
			self:_setMenuTransitionVisual(self.Scale, self._baseBackgroundTransparency, 0.55, 0.25)
			self:_setInternalsVisible(true)
		end
		if self._notifGui then
			self._notifGui.Enabled = true
		end
	else
		-- Deliberately hidden: close dropdown, suppress restore/notif GUIs
		self:_closeTransientUi()
		if self._minGui then
			self._minGui.Enabled = false
		end
		if self._noLogoRestoreGui then
			self._noLogoRestoreGui.Enabled = false
		end
		if self._notifGui then
			self._notifGui.Enabled = false
		end
		self.Gui.Enabled = false
	end
	return true
end

function Menu:ToggleVisibility()
	return self:SetVisible(not self.Visible)
end
function Menu:GetVisible()
	return self.Visible
end
function Menu:SetTitle(t)
	if self._destroyed or not self.Title then
		return false, "destroyed"
	end
	if type(t) ~= "string" then
		return false, "expected string"
	end
	self._titleText = t
	self._refreshTitle()
	return true
end

function Menu:_confirmClose()
	if self._confirmPopup then
		return
	end
	-- Close any active dropdown first so it cannot overlay the confirmation UI
	self:HideDropdownPopup()
	self._confirmFocusReturn = self:_beginTransientFocus(self.Topbar)
	local theme = self.Theme
	local frame = self.Frame

	-- Overlay (below popup, blocks background)
	local overlay = U.Create("ImageButton", {
		Name = "ConfirmOverlay",
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 10,
		AutoButtonColor = false,
		Parent = frame,
	})

	-- Shadow behind popup
	local shadow = U.Create("Frame", {
		Size = UDim2.fromOffset(268, 138),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundTransparency = 0.65,
		BorderSizePixel = 0,
		ZIndex = 11,
		Parent = frame,
	})
	U.Create("UICorner", { CornerRadius = UDim.new(0, 14), Parent = shadow })

	-- Popup (always fully visible, ZIndex above everything)
	local popup = U.Create("Frame", {
		Name = "ConfirmPop",
		Size = UDim2.fromOffset(260, 130),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = theme.Sidebar,
		BackgroundTransparency = 0.1,
		BorderSizePixel = 0,
		ZIndex = 12,
		Parent = frame,
	})
	U.Create("UICorner", { CornerRadius = UDim.new(0, 12), Parent = popup })
	U.Create("UIStroke", { Color = Color3.fromRGB(255, 255, 255), Transparency = 0.88, Thickness = 1, Parent = popup })

	-- Title
	U.Create("TextLabel", {
		Size = UDim2.new(1, -20, 0, 40),
		Position = UDim2.fromOffset(10, 18),
		BackgroundTransparency = 1,
		Text = "Close Menu?",
		Font = theme.FontBold,
		TextSize = 20,
		TextColor3 = theme.TextPrimary,
		TextXAlignment = Enum.TextXAlignment.Center,
		ZIndex = 13,
		Parent = popup,
	})
	U.Create("TextLabel", {
		Size = UDim2.new(1, -20, 0, 20),
		Position = UDim2.fromOffset(10, 54),
		BackgroundTransparency = 1,
		Text = "Are you sure you want to exit?",
		Font = theme.Font,
		TextSize = 14,
		TextColor3 = theme.TextMuted,
		TextXAlignment = Enum.TextXAlignment.Center,
		ZIndex = 13,
		Parent = popup,
	})

	-- Buttons (inside popup, always clickable)
	local function makeBtn(text, xOff, defColor, hovColor, cb)
		local b = U.Create("ImageButton", {
			Size = UDim2.fromOffset(100, 30),
			Position = UDim2.fromOffset(xOff, 85),
			BackgroundColor3 = defColor,
			BackgroundTransparency = 0.25,
			AutoButtonColor = false,
			ZIndex = 14,
			Parent = popup,
		})
		self:_makeSelectable(b)
		U.Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = b })
		local bs = U.Create("UIScale", { Parent = b, Scale = 1 })
		U.Create("TextLabel", {
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			Text = text,
			Font = theme.FontBold,
			TextSize = 15,
			TextColor3 = Color3.fromRGB(255, 255, 255),
			ZIndex = 15,
			Parent = b,
		})
		b.MouseEnter:Connect(function()
			self:_transition(b, 0.12, { BackgroundColor3 = hovColor, BackgroundTransparency = 0.05 })
		end)
		b.MouseLeave:Connect(function()
			self:_transition(b, 0.12, { BackgroundColor3 = defColor, BackgroundTransparency = 0.25 })
		end)
		b.MouseButton1Down:Connect(function()
			self:_transition(bs, 0.05, { Scale = 0.95 })
		end)
		b.MouseButton1Up:Connect(function()
			self:_transition(bs, 0.08, { Scale = 1 })
		end)
		b.Activated:Connect(cb)
		return b
	end

	self._confirmPopup = { popup = popup, overlay = overlay, shadow = shadow }

	-- Fade IN: only overlay dims (popup already fully visible & clickable)
	self:_transition(overlay, 0.2, { BackgroundTransparency = 0.5 })

	-- Close
	local closing = false
	local function closePopup(cb)
		if closing then
			return
		end
		closing = true
		self:_transition(overlay, 0.2, { BackgroundTransparency = 1 }, nil, nil, function()
			if self._destroyed then
				return
			end
			if overlay then
				overlay:Destroy()
			end
			if popup then
				popup:Destroy()
			end
			if shadow then
				shadow:Destroy()
			end
			self._confirmPopup = nil
			local focusReturn = self._confirmFocusReturn
			self._confirmFocusReturn = nil
			self:_restoreTransientFocus(focusReturn)
			if cb then
				cb()
			end
		end)
	end

	local noButton = makeBtn("No", 20, Color3.fromRGB(55, 55, 68), Color3.fromRGB(75, 75, 90), function()
		closePopup(nil)
	end)
	makeBtn("Yes", 140, Color3.fromRGB(170, 45, 45), Color3.fromRGB(210, 60, 60), function()
		closePopup(function()
			self:SetVisible(false)
		end)
	end)
	if self._confirmFocusReturn then
		game:GetService("GuiService").SelectedObject = noButton
	end
end

function Menu:Destroy()
	if self._destroyed then
		return
	end
	self:_closeTransientUi()
	self._destroyed = true
	self._minimizeToken = (self._minimizeToken or 0) + 1
	if self._activeNotifs then
		local activeNotifs = table.clone(self._activeNotifs)
		for _, record in ipairs(activeNotifs) do
			if record.frame then
				record.frame:Destroy()
			end
		end
		table.clear(self._activeNotifs)
	end

	-- Disconnect all service-level connections
	if self._heartbeatCon then
		self._heartbeatCon:Disconnect()
		self._heartbeatCon = nil
	end
	for _, connection in ipairs(self._overviewConns or {}) do
		connection:Disconnect()
	end
	self._overviewConns = {}
	if self._popupUISCon then
		self._popupUISCon:Disconnect()
		self._popupUISCon = nil
	end
	if self._dragInputCon then
		self._dragInputCon:Disconnect()
		self._dragInputCon = nil
	end
	if self._minDragInputCon then
		self._minDragInputCon:Disconnect()
		self._minDragInputCon = nil
	end
	if self._noLogoDragCon then
		self._noLogoDragCon:Disconnect()
		self._noLogoDragCon = nil
	end
	if self._sidebarScrollCon then
		self._sidebarScrollCon:Disconnect()
		self._sidebarScrollCon = nil
	end
	if self._resizeInputCon then
		self._resizeInputCon:Disconnect()
		self._resizeInputCon = nil
	end
	if self._resizeEndCon then
		self._resizeEndCon:Disconnect()
		self._resizeEndCon = nil
	end
	if self._cameraCon then
		self._cameraCon:Disconnect()
		self._cameraCon = nil
	end
	if self._cameraViewportCon then
		self._cameraViewportCon:Disconnect()
		self._cameraViewportCon = nil
	end
	if self._keybindInputCon then
		self._keybindInputCon:Disconnect()
		self._keybindInputCon = nil
	end
	if self._keybindEndCon then
		self._keybindEndCon:Disconnect()
		self._keybindEndCon = nil
	end
	if self._scaleTween then
		self._scaleTween:Cancel()
		self._scaleTween = nil
	end
	if self._activeBarTween then
		self._activeBarTween:Cancel()
		self._activeBarTween = nil
	end

	-- Destroy external ScreenGuis owned by this menu
	if self._notifGui then
		self._notifGui:Destroy()
		self._notifGui = nil
	end
	if self._minGui then
		self._minGui:Destroy()
		self._minGui = nil
	end
	if self._noLogoRestoreGui then
		self._noLogoRestoreGui:Destroy()
		self._noLogoRestoreGui = nil
	end

	-- Destroy any active confirm-close popup
	if self._confirmPopup then
		if self._confirmPopup.overlay then
			self._confirmPopup.overlay:Destroy()
		end
		if self._confirmPopup.popup then
			self._confirmPopup.popup:Destroy()
		end
		if self._confirmPopup.shadow then
			self._confirmPopup.shadow:Destroy()
		end
		self._confirmPopup = nil
	end

	-- Close any active dropdown popup
	if self._activePopupFrame then
		self._activePopupFrame:Destroy()
		self._activePopupFrame = nil
	end
	if self._activePopupOverlay then
		self._activePopupOverlay:Destroy()
		self._activePopupOverlay = nil
	end
	if self._activeDropdown then
		self._activeDropdown = nil
	end

	-- Tooltip cleanup
	self._tooltipPending = false
	self._tooltipTarget = nil
	self._tooltipActive = false
	if self._tooltipTween then
		self._tooltipTween:Cancel()
		self._tooltipTween = nil
	end
	if self._mouseCon then
		self._mouseCon:Disconnect()
		self._mouseCon = nil
	end
	for _, data in pairs(self._tooltips) do
		if data.unbind then
			data.unbind()
		end
	end
	self._tooltips = {}
	if self._tooltipLabel then
		self._tooltipLabel:Destroy()
		self._tooltipLabel = nil
	end

	-- Destroy tabs
	for _, tab in ipairs(self.Tabs) do
		tab:Destroy()
	end
	self.Tabs = {}

	-- Destroy main GUI last
	if self.Gui then
		self.Gui:Destroy()
		self.Gui = nil
	end
end
