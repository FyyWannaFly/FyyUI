function Menu:_ApplyTheme(theme)
	if not self.Frame then
		return
	end

	-- Main frame
	self.Frame.BackgroundColor3 = theme.Background
	local corner = self.Frame:FindFirstChildOfClass("UICorner")
	if corner then
		corner.CornerRadius = UDim.new(0, theme.CornerRadius)
	end
	local frameStroke = self.Frame:FindFirstChildOfClass("UIStroke")
	if frameStroke then
		frameStroke.Color = theme.Outline
	end

	-- Shadow
	if self._shadow then
		self._shadow.BackgroundColor3 = theme.Shadow
		local shadowCorner = self._shadow:FindFirstChildOfClass("UICorner")
		if shadowCorner then
			shadowCorner.CornerRadius = UDim.new(0, theme.CornerRadius + 2)
		end
	end

	-- Topbar
	self.Topbar.BackgroundColor3 = theme.Topbar
	local topCorner = self.Topbar:FindFirstChildOfClass("UICorner")
	if topCorner then
		topCorner.CornerRadius = UDim.new(0, theme.CornerRadius)
	end
	local topFill = self.Topbar:FindFirstChild("Fill")
	if topFill then
		topFill.BackgroundColor3 = theme.Topbar
	end

	-- Title
	self.Title.TextColor3 = theme.TextPrimary
	self.Title.Font = Enum.Font.BuilderSansBold
	self.Title.TextSize = 17
	if self.TitleAccent then
		self.TitleAccent.TextColor3 = theme.Accent
		self.TitleAccent.Font = Enum.Font.BuilderSansExtraBold
		self.TitleAccent.TextSize = 17
	end
	if self._refreshTitle then
		self._refreshTitle()
	end

	-- Accent line under topbar
	if self.AccentLine then
		self.AccentLine.BackgroundColor3 = theme.AccentLine
	end

	-- Sidebar
	self.Sidebar.BackgroundColor3 = theme.Sidebar

	-- ActiveBar
	if self.ActiveBar then
		self.ActiveBar.BackgroundColor3 = theme.Accent
	end

	-- Resize grip
	local grip = self.Frame:FindFirstChild("ResizeGrip")
	if grip then
		local visual = grip:FindFirstChild("Visual")
		if visual then
			visual.BackgroundColor3 = theme.TextMuted
		end
	end

	-- No-logo restore button (minimize affordance)
	if self._noLogoRestoreBtn then
		self._noLogoRestoreBtn.BackgroundColor3 = theme.Element
		self._noLogoRestoreBtn.TextColor3 = theme.TextPrimary
		local restoreStroke = self._noLogoRestoreBtn:FindFirstChildOfClass("UIStroke")
		if restoreStroke then
			restoreStroke.Color = theme.Accent
		end
	end
	if self._minFrame then
		self._minFrame.BackgroundColor3 = theme.Element
		local minStroke = self._minFrame:FindFirstChildOfClass("UIStroke")
		if minStroke then
			minStroke.Color = theme.Accent
		end
	end
	if self.SidebarLine then
		self.SidebarLine.BackgroundColor3 = theme.Border
	end

	-- Confirm-close popup (if open)
	if self._confirmPopup then
		local pop = self._confirmPopup.popup
		if pop then
			pop.BackgroundColor3 = theme.Sidebar
			local labels = pop:FindFirstChildOfClass("TextLabel")
			-- iterate all text labels
			for _, lbl in ipairs(pop:GetChildren()) do
				if lbl:IsA("TextLabel") then
					lbl.Font = theme.Font
				end
			end
		end
	end

	-- Active notification styling
	if self.NotifBox then
		for _, notif in ipairs(self.NotifBox:GetChildren()) do
			if notif:IsA("Frame") then
				notif.BackgroundColor3 = theme.Element
				local stroke = notif:FindFirstChildOfClass("UIStroke")
				if stroke then
					stroke.Color = theme.ElementBorder
				end
				local icon = notif:FindFirstChild("Icon")
				if icon and icon:IsA("ImageLabel") then
					icon.ImageColor3 = icon.ImageColor3 -- keep type accent, already set
				end
				local titleLbl = notif:FindFirstChild("Title")
				if titleLbl and titleLbl:IsA("TextLabel") then
					titleLbl.Font = theme.FontBold
					titleLbl.TextSize = theme.FontSize
					titleLbl.TextColor3 = theme.TextPrimary
				end
				local contentLbl = notif:FindFirstChild("Content")
				if contentLbl and contentLbl:IsA("TextLabel") then
					contentLbl.Font = theme.Font
					contentLbl.TextSize = theme.FontSize
					contentLbl.TextColor3 = theme.TextSecondary
				end
				local track = notif:FindFirstChild("ProgressTrack")
				if track and track:IsA("Frame") then
					track.BackgroundColor3 = theme.ElementHover
				end
			end
		end
	end

	-- Apply theme to all tabs (which cascade to their components)
	for _, tab in ipairs(self.Tabs) do
		tab:ApplyTheme(theme)
	end

	-- Tooltip
	if self._tooltipLabel then
		self._tooltipLabel.BackgroundColor3 = theme.Element
		self._tooltipLabel.Font = theme.Font
		self._tooltipLabel.TextSize = theme.FontSize
		self._tooltipLabel.TextColor3 = theme.TextPrimary
		local stroke = self._tooltipLabel:FindFirstChildOfClass("UIStroke")
		if stroke then
			stroke.Color = theme.Outline
		end
	end

	-- Command Palette (if currently open)
	if self._paletteFrame then
		self._paletteFrame.BackgroundColor3 = theme.Background
		local stroke = self._paletteFrame:FindFirstChildOfClass("UIStroke")
		if stroke then
			stroke.Color = theme.Outline
		end
		if self._paletteSearchBox then
			self._paletteSearchBox.BackgroundColor3 = theme.Element
			self._paletteSearchBox.Font = theme.Font
			self._paletteSearchBox.TextSize = theme.FontSize
			self._paletteSearchBox.TextColor3 = theme.TextPrimary
			self._paletteSearchBox.PlaceholderColor3 = theme.TextMuted
		end
		if self._paletteResults then
			self._paletteResults.ScrollBarImageColor3 = theme.ScrollBar
		end
		if self._paletteEmpty then
			self._paletteEmpty.Font = theme.Font
			self._paletteEmpty.TextSize = theme.FontSizeSmall
			self._paletteEmpty.TextColor3 = theme.TextMuted
		end
		if self._paletteSearchBox then
			self:_filterPaletteResults(self._paletteSearchBox.Text)
		end
	end
end

function Menu:SetTheme(themeOrName)
	if self._destroyed then
		return false, "destroyed"
	end
	if type(themeOrName) == "string" then
		local builtin = Theme[themeOrName]
		if not builtin then
			return false, "Unknown built-in theme: " .. tostring(themeOrName)
		end
		self.Theme = builtin
	elseif type(themeOrName) == "table" then
		self.Theme = Theme:Override(Theme.Dark, themeOrName)
	else
		return false, "Expected a theme name (string) or theme table"
	end
	self:_ApplyTheme(self.Theme)
	return true
end

function Menu:SetScale(value)
	if self._destroyed then
		return false, "destroyed"
	end
	if not isFiniteNumber(value) then
		return false, "expected finite number"
	end
	value = math.clamp(value, 0.75, 1.35)
	self.Scale = value
	self:_applyResponsiveLayout()
	if not self._uiScale then
		return true
	end
	if self._reducedMotion then
		self._uiScale.Scale = value
	else
		if self._scaleTween then
			self._scaleTween:Cancel()
		end
		self._scaleTween = game:GetService("TweenService"):Create(
			self._uiScale,
			TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{ Scale = value }
		)
		self._scaleTween:Play()
	end
	return true
end

function Menu:GetScale()
	if self._destroyed then
		return nil, "destroyed"
	end
	return self.Scale
end

--[[ Tooltip System ]]

--- Bind a tooltip to any Instance.
--- @param instance Instance — the GUI element that triggers the tooltip
--- @param text string — tooltip text (supports RichText)
--- @return function unbind — call to remove this tooltip binding
function Menu:BindTooltip(instance, text)
	if self._destroyed or not instance then
		return function() end
	end

	-- If already bound to this instance, unbind first
	if self._tooltips[instance] then
		self._tooltips[instance].unbind()
	end

	local conns = {}
	local boundInstance = instance

	local function disconnectAll()
		for _, c in ipairs(conns) do
			c:Disconnect()
		end
		conns = {}
		if self._tooltips then
			self._tooltips[boundInstance] = nil
		end
		if self._tooltipTarget == boundInstance then
			self._tooltipPending = false
			self._tooltipTarget = nil
			self:_hideTooltip()
		end
	end

	-- MouseEnter: start delay timer
	table.insert(
		conns,
		instance.MouseEnter:Connect(function()
			if self._destroyed then
				return
			end
			self._tooltipPending = true
			self._tooltipTarget = instance
			task.delay(0.4, function()
				if not self._tooltipPending or self._tooltipTarget ~= instance or self._destroyed then
					return
				end
				if not instance or not instance.Parent then
					self._tooltipPending = false
					self._tooltipTarget = nil
					return
				end
				self:_showTooltip(text)
			end)
		end)
	)

	-- MouseLeave: hide immediately
	table.insert(
		conns,
		instance.MouseLeave:Connect(function()
			self._tooltipPending = false
			self._tooltipTarget = nil
			self:_hideTooltip()
		end)
	)

	-- Click (any mouse button on the instance): hide
	table.insert(
		conns,
		instance.InputBegan:Connect(function(input)
			if
				input.UserInputType == Enum.UserInputType.MouseButton1
				or input.UserInputType == Enum.UserInputType.MouseButton2
				or input.UserInputType == Enum.UserInputType.MouseButton3
			then
				self._tooltipPending = false
				self._tooltipTarget = nil
				self:_hideTooltip()
			end
		end)
	)

	self._tooltips[instance] = { unbind = disconnectAll, text = text }
	return disconnectAll
end

function Menu:_showTooltip(text)
	if self._destroyed or not self._tooltipLabel then
		return
	end
	local label = self._tooltipLabel

	-- Set text and compute size
	label.Text = text
	label.Size = UDim2.fromOffset(2000, 26)
	local tb = label.TextBounds
	local tw = math.min(math.max(tb.X + 16, 24), 300)
	local th = math.max(tb.Y + 8, 26)
	label.Size = UDim2.fromOffset(tw, th)

	-- Position near cursor, clamped to frame
	local frameAbsPos = self.Frame.AbsolutePosition
	local frameSize = self.Frame.AbsoluteSize
	local relX = math.clamp(self._mousePos.X - frameAbsPos.X + 12, 0, math.max(0, frameSize.X - tw))
	local relY = math.clamp(self._mousePos.Y - frameAbsPos.Y + 20, 0, math.max(0, frameSize.Y - th))
	label.Position = UDim2.fromOffset(relX, relY)

	-- Fade in
	label.Visible = true
	label.BackgroundTransparency = 1
	label.TextTransparency = 1
	if self._tooltipTween then
		self._tooltipTween:Cancel()
	end
	self._tooltipTween = self:_transition(label, 0.12, {
		BackgroundTransparency = 0.08,
		TextTransparency = 0,
	})
	self._tooltipActive = true
end

function Menu:_hideTooltip()
	if not self._tooltipLabel or not self._tooltipActive then
		return
	end
	self._tooltipActive = false
	if self._tooltipTween then
		self._tooltipTween:Cancel()
		self._tooltipTween = nil
	end

	local label = self._tooltipLabel
	self:_transition(
		label,
		0.08,
		{
			BackgroundTransparency = 1,
			TextTransparency = 1,
		},
		Enum.EasingStyle.Quad,
		Enum.EasingDirection.In,
		function()
			label.Visible = false
		end
	)
end

function Menu:_updateTooltipPosition()
	if not self._tooltipLabel or not self._tooltipLabel.Visible then
		return
	end
	local label = self._tooltipLabel
	local size = label.Size
	local tw = size.X.Offset
	local th = size.Y.Offset
	local frameAbsPos = self.Frame.AbsolutePosition
	local frameSize = self.Frame.AbsoluteSize
	local relX = math.clamp(self._mousePos.X - frameAbsPos.X + 12, 0, math.max(0, frameSize.X - tw))
	local relY = math.clamp(self._mousePos.Y - frameAbsPos.Y + 20, 0, math.max(0, frameSize.Y - th))
	label.Position = UDim2.fromOffset(relX, relY)
end
