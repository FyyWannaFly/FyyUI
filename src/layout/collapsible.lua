--[[ Collapsible Section ]]
Collapsible = {}
Collapsible.__index = Collapsible

function Collapsible.new(parent, title, options, theme)
	local self = setmetatable({}, Collapsible)
	self.Theme = theme
	self.Components = {}
	self._isOpen = options and options.DefaultOpen ~= false
	self._tween = nil
	self._closed = false

	-- Container
	self.Container = U.Create("Frame", {
		Name = "Collapsible",
		Size = UDim2.new(1, -12, 0, 34),
		Position = UDim2.fromOffset(6, 0),
		BackgroundColor3 = theme.Element,
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		Parent = parent,
	})
	U.Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = self.Container })
	U.Create("UIStroke", { Color = theme.ElementBorder, Transparency = 0.6, Thickness = 1, Parent = self.Container })

	-- Header button
	self.Header = U.Create("ImageButton", {
		Name = "Header",
		Size = UDim2.new(1, 0, 0, 34),
		BackgroundColor3 = theme.ElementHover,
		BackgroundTransparency = 0.3,
		AutoButtonColor = false,
		Parent = self.Container,
	})
	U.Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = self.Header })
	-- Lucide chevron (far right, Active=false so clicks pass through Header)
	self.Arrow = renderIcon(self.Header, self._isOpen and "chevron-down" or "chevron-right", {
		Name = "Arrow",
		Size = UDim2.fromOffset(16, 16),
		Position = UDim2.new(1, -24, 0.5, -8),
		BackgroundTransparency = 1,
		ImageColor3 = theme.TextSecondary,
		TextColor3 = theme.TextSecondary,
		Active = false,
	})
	-- Title (left, Active=false so clicks pass through to Header)
	self.Title = U.Create("TextLabel", {
		Name = "Title",
		Size = UDim2.new(1, -40, 1, 0),
		Position = UDim2.fromOffset(12, 0),
		BackgroundTransparency = 1,
		Text = title,
		Font = theme.FontBold,
		TextSize = theme.FontSize,
		TextColor3 = theme.TextPrimary,
		TextXAlignment = Enum.TextXAlignment.Left,
		Active = false,
		Parent = self.Header,
	})

	-- Content area (children go here)
	-- NOTE: Children already have their own 6px outer inset (width 1,-12 + position 6).
	-- Content only provides deliberate top/bottom gaps; no left/right UIPadding.
	self.Content = U.Create("Frame", {
		Name = "Content",
		Size = UDim2.new(1, 0, 0, 0),
		Position = UDim2.fromOffset(0, 34),
		BackgroundTransparency = 1,
		Visible = self._isOpen,
		Parent = self.Container,
	})
	local layout = U.Create("UIListLayout", {
		Padding = UDim.new(0, theme.Spacing),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = self.Content,
	})
	local contentPadding = U.Create("UIPadding", {
		PaddingTop = UDim.new(0, 6),
		PaddingBottom = UDim.new(0, 6),
		Parent = self.Content,
	})
	self._layout = layout
	self._contentPadding = contentPadding

	-- Resize when content changes
	self._layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		if not self._closed then
			self:_updateSize()
		end
	end)

	-- Click header to toggle
	self.Header.MouseEnter:Connect(function()
		self.Header.BackgroundColor3 = theme.TabHover
		self.Header.BackgroundTransparency = 0
	end)
	self.Header.MouseLeave:Connect(function()
		self.Header.BackgroundColor3 = theme.ElementHover
		self.Header.BackgroundTransparency = 0.3
	end)
	self.Header.MouseButton1Click:Connect(function()
		self:ToggleOpen()
	end)

	-- Initialize height
	task.spawn(function()
		task.wait()
		if not self._closed then
			self:_updateSize(true)
		end
	end)

	return self
end

function Collapsible:_contentHeight()
	local layoutHeight = self._layout and self._layout.AbsoluteContentSize.Y or 0
	local paddingTop = self._contentPadding and self._contentPadding.PaddingTop.Offset or 0
	local paddingBottom = self._contentPadding and self._contentPadding.PaddingBottom.Offset or 0
	return layoutHeight + paddingTop + paddingBottom
end

function Collapsible:SetOpen(v)
	if self._destroyed then
		return false, "destroyed"
	end
	if type(v) ~= "boolean" then
		return false, "expected boolean"
	end
	if self._isOpen == v then
		return true
	end
	self._isOpen = v
	local transitionId = (self._transitionId or 0) + 1
	self._transitionId = transitionId
	if self.Arrow then
		self.Arrow = updateRenderedIcon(self.Arrow, v and "chevron-down" or "chevron-right", self.Header, {
			Name = "Arrow",
			Size = UDim2.fromOffset(16, 16),
			Position = UDim2.new(1, -24, 0.5, -8),
			BackgroundTransparency = 1,
			ImageColor3 = self.Theme.TextSecondary,
			TextColor3 = self.Theme.TextSecondary,
			Active = false,
		})
	end
	if self._tween then
		self._tween:Cancel()
	end
	if not self.Container then
		return false, "missing container"
	end
	if v and self.Content then
		self.Content.Visible = true
	end
	local contentHeight = self:_contentHeight()
	if self.Content then
		self.Content.Size = UDim2.new(1, 0, 0, contentHeight)
	end
	local targetH = v and (34 + contentHeight) or 34
	local function finishTransition()
		if self._transitionId == transitionId and not self._isOpen and self.Content then
			self.Content.Visible = false
		end
	end
	if self._menu then
		self._tween = self._menu:_transition(
			self.Container,
			0.25,
			{ Size = UDim2.new(1, -12, 0, targetH) },
			nil,
			nil,
			finishTransition
		)
	else
		self._tween = game:GetService("TweenService"):Create(
			self.Container,
			TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{ Size = UDim2.new(1, -12, 0, targetH) }
		)
		self._tween.Completed:Connect(finishTransition)
		self._tween:Play()
	end
	return true
end

function Collapsible:ToggleOpen()
	self:SetOpen(not self._isOpen)
end

function Collapsible:Open()
	self:SetOpen(true)
end
function Collapsible:Close()
	self:SetOpen(false)
end

function Collapsible:_updateSize(instant)
	if self._closed or not self._layout or not self.Container or not self.Container.Parent then
		return
	end
	if self._tween then
		self._tween:Cancel()
	end
	local contentHeight = self:_contentHeight()
	if self.Content then
		self.Content.Size = UDim2.new(1, 0, 0, contentHeight)
	end
	local targetH = self._isOpen and (34 + contentHeight) or 34
	if instant then
		self.Container.Size = UDim2.new(1, -12, 0, targetH)
	else
		if self._menu then
			self._tween = self._menu:_transition(self.Container, 0.15, { Size = UDim2.new(1, -12, 0, targetH) })
		else
			self._tween = game:GetService("TweenService"):Create(
				self.Container,
				TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{ Size = UDim2.new(1, -12, 0, targetH) }
			)
			self._tween:Play()
		end
	end
end

-- Pass-through methods (all default opts to {}; Tooltip auto-bound via self._menu)
function Collapsible:Toggle(opts)
	if destroyedFactoryResult(self) then
		return nil, "destroyed"
	end
	opts = opts or {}
	local c = Toggle.new(self.Content, opts, self.Theme)
	table.insert(self.Components, c)
	if c.Flag and self._menu then
		self._menu:_trackFlagged(c)
	end
	if opts.Tooltip and self._menu then
		self._menu:BindTooltip(c.Container, opts.Tooltip)
	end
	self:_updateSize()
	return c
end
function Collapsible:Checkbox(opts)
	if destroyedFactoryResult(self) then
		return nil, "destroyed"
	end
	opts = opts or {}
	local c = Checkbox.new(self.Content, opts, self.Theme)
	table.insert(self.Components, c)
	if c.Flag and self._menu then
		self._menu:_trackFlagged(c)
	end
	if opts.Tooltip and self._menu then
		self._menu:BindTooltip(c.Container, opts.Tooltip)
	end
	self:_updateSize()
	return c
end
function Collapsible:Slider(opts)
	if destroyedFactoryResult(self) then
		return nil, "destroyed"
	end
	opts = opts or {}
	if self._inOneToOne then
		local clo = {}
		for k, v in pairs(opts) do
			clo[k] = v
		end
		clo._inOneToOneColumn = true
		opts = clo
	end
	local c = Slider.new(self.Content, opts, self.Theme)
	table.insert(self.Components, c)
	if c.Flag and self._menu then
		self._menu:_trackFlagged(c)
	end
	if opts.Tooltip and self._menu then
		self._menu:BindTooltip(c.Container, opts.Tooltip)
	end
	self:_updateSize()
	return c
end
function Collapsible:Dropdown(opts)
	if destroyedFactoryResult(self) then
		return nil, "destroyed"
	end
	opts = opts or {}
	local dropdownOpts = {}
	for k, v in pairs(opts) do
		dropdownOpts[k] = v
	end
	dropdownOpts._compactControl = true
	local c = Dropdown.new(self.Content, dropdownOpts, self.Theme, self._menu or nil)
	table.insert(self.Components, c)
	if c.Flag and self._menu then
		self._menu:_trackFlagged(c)
	end
	if opts.Tooltip and self._menu then
		self._menu:BindTooltip(c.Container, opts.Tooltip)
	end
	self:_updateSize()
	return c
end
function Collapsible:Keybind(opts)
	if destroyedFactoryResult(self) then
		return nil, "destroyed"
	end
	opts = opts or {}
	local c = Keybind.new(self.Content, opts, self.Theme, self._menu or nil)
	table.insert(self.Components, c)
	if c.Flag and self._menu then
		self._menu:_trackFlagged(c)
	end
	if opts.Tooltip and self._menu then
		self._menu:BindTooltip(c.Container, opts.Tooltip)
	end
	self:_updateSize()
	return c
end
function Collapsible:Input(opts)
	if destroyedFactoryResult(self) then
		return nil, "destroyed"
	end
	opts = opts or {}
	local c = TextInput.new(self.Content, opts, self.Theme)
	table.insert(self.Components, c)
	if c.Flag and self._menu then
		self._menu:_trackFlagged(c)
	end
	if opts.Tooltip and self._menu then
		self._menu:BindTooltip(c.Container, opts.Tooltip)
	end
	self:_updateSize()
	return c
end
function Collapsible:Button(opts)
	if destroyedFactoryResult(self) then
		return nil, "destroyed"
	end
	opts = opts or {}
	local theme = self.Theme
	local hasDesc = opts.Description ~= nil and opts.Description ~= ""
	local h = hasDesc and theme.DescHeight or theme.ElementHeight
	local btn = {}
	btn.Container = U.Create("ImageButton", {
		Name = "Button",
		Size = UDim2.new(1, -12, 0, h + 6),
		Position = UDim2.fromOffset(6, 0),
		BackgroundColor3 = theme.Element,
		BackgroundTransparency = 0,
		AutoButtonColor = false,
		BorderSizePixel = 0,
		Parent = self.Content,
	})
	U.Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = btn.Container })
	U.Create("UIStroke", { Color = theme.ElementBorder, Transparency = 0.6, Thickness = 1, Parent = btn.Container })
	renderIcon(btn.Container, opts.Icon or "rocket", {
		Name = "Pointer",
		Size = UDim2.fromOffset(26, 26),
		Position = UDim2.new(1, -38, 0.5, -13),
		ImageTransparency = 0.5,
	})
	local ix = 10
	if hasDesc then
		U.Create("TextLabel", {
			Name = "Text",
			Size = UDim2.new(1, -20, 0, 20),
			Position = UDim2.fromOffset(ix, 5),
			BackgroundTransparency = 1,
			Text = opts.Text or "Button",
			Font = theme.Font,
			TextSize = theme.FontSize,
			TextColor3 = opts.Color or theme.TextPrimary,
			TextXAlignment = Enum.TextXAlignment.Left,
			Parent = btn.Container,
		})
		U.Create("TextLabel", {
			Name = "Description",
			Size = UDim2.new(1, -20, 0, 16),
			Position = UDim2.fromOffset(ix, 27),
			BackgroundTransparency = 1,
			Text = opts.Description,
			Font = theme.Font,
			TextSize = theme.FontSizeSmall,
			TextColor3 = theme.TextMuted,
			TextXAlignment = Enum.TextXAlignment.Left,
			RichText = true,
			Parent = btn.Container,
		})
	else
		U.Create("TextLabel", {
			Name = "Text",
			Size = UDim2.new(1, -20, 0, 20),
			Position = UDim2.fromOffset(ix, (h + 6 - 20) / 2 + 1),
			BackgroundTransparency = 1,
			Text = opts.Text or "Button",
			Font = theme.Font,
			TextSize = theme.FontSize,
			TextColor3 = opts.Color or theme.TextPrimary,
			TextXAlignment = Enum.TextXAlignment.Left,
			Parent = btn.Container,
		})
	end
	local _sc = U.Create("UIScale", { Parent = btn.Container })
	btn.Container.MouseEnter:Connect(function()
		btn.Container.BackgroundColor3 = theme.ElementHover
		btn.Container.BackgroundTransparency = 0
	end)
	btn.Container.MouseLeave:Connect(function()
		btn.Container.BackgroundColor3 = theme.Element
		btn.Container.BackgroundTransparency = 0
	end)
	btn.Container.MouseButton1Down:Connect(function()
		game:GetService("TweenService"):Create(_sc, TweenInfo.new(0.05), { Scale = 0.97 }):Play()
	end)
	btn.Container.MouseButton1Up:Connect(function()
		game:GetService("TweenService"):Create(_sc, TweenInfo.new(0.08), { Scale = 1 }):Play()
	end)
	btn.Container.MouseButton1Click:Connect(function()
		if opts.Callback then
			opts.Callback()
		end
	end)
	btn.Destroy = function()
		if btn.Container then
			btn.Container:Destroy()
		end
	end
	local _btnColor = opts.Color
	btn.ApplyTheme = function(_, t)
		t = t or _
		if not btn.Container then
			return
		end
		btn.Container.BackgroundColor3 = t.Element
		local s = btn.Container:FindFirstChildOfClass("UIStroke")
		if s then
			s.Color = t.ElementBorder
		end
		local txt = btn.Container:FindFirstChild("Text")
		if txt then
			txt.Font = t.Font
			txt.TextSize = t.FontSize
			txt.TextColor3 = _btnColor or t.TextPrimary
		end
		local d = btn.Container:FindFirstChild("Description")
		if d then
			d.Font = t.Font
			d.TextSize = t.FontSizeSmall
			d.TextColor3 = t.TextMuted
		end
	end
	if opts.Tooltip and self._menu then
		self._menu:BindTooltip(btn.Container, opts.Tooltip)
	end
	table.insert(self.Components, btn)
	self:_updateSize()
	return btn
end
function Collapsible:Label(opts)
	if destroyedFactoryResult(self) then
		return nil, "destroyed"
	end
	opts = opts or {}
	local theme = self.Theme
	local hasDesc = opts.Description ~= nil and opts.Description ~= ""
	local h = hasDesc and theme.DescHeight or theme.ElementHeight
	local lbl = {}
	local _lblColor = opts.Color
	local _lblTextSize = opts.TextSize or theme.FontSize
	lbl.Container = U.Create(
		"Frame",
		{ Name = "Label", Size = UDim2.new(1, 0, 0, h), BackgroundTransparency = 1, Parent = self.Content }
	)
	lbl.TextLabel = U.Create("TextLabel", {
		Name = "Text",
		Size = UDim2.new(1, 0, 0, hasDesc and 20 or h),
		Position = UDim2.fromOffset(0, hasDesc and 2 or (h - 20) / 2 + 1),
		BackgroundTransparency = 1,
		Text = opts.Text or "",
		Font = theme.Font,
		TextSize = _lblTextSize,
		TextColor3 = _lblColor or theme.TextSecondary,
		TextXAlignment = Enum.TextXAlignment.Left,
		RichText = true,
		Parent = lbl.Container,
	})
	if hasDesc then
		U.Create("TextLabel", {
			Name = "Description",
			Size = UDim2.new(1, 0, 0, 16),
			Position = UDim2.fromOffset(0, 24),
			BackgroundTransparency = 1,
			Text = opts.Description,
			Font = theme.Font,
			TextSize = theme.FontSizeSmall,
			TextColor3 = theme.TextMuted,
			TextXAlignment = Enum.TextXAlignment.Left,
			RichText = true,
			Parent = lbl.Container,
		})
	end
	lbl.Destroy = function()
		if lbl.Container then
			lbl.Container:Destroy()
		end
	end
	lbl.ApplyTheme = function(_, t)
		t = t or _
		if not lbl.TextLabel then
			return
		end
		lbl.TextLabel.Font = t.Font
		lbl.TextLabel.TextSize = _lblTextSize
		lbl.TextLabel.TextColor3 = _lblColor or t.TextSecondary
		local d = lbl.Container:FindFirstChild("Description")
		if d then
			d.Font = t.Font
			d.TextSize = t.FontSizeSmall
			d.TextColor3 = t.TextMuted
		end
	end
	table.insert(self.Components, lbl)
	self:_updateSize()
	return lbl
end
function Collapsible:BoldLabel(opts)
	if destroyedFactoryResult(self) then
		return nil, "destroyed"
	end
	opts = opts or {}
	local theme = self.Theme
	local hasDesc = opts.Description ~= nil and opts.Description ~= ""
	local h = hasDesc and theme.DescHeight or theme.ElementHeight
	local lbl = {}
	local _blblColor = opts.Color
	local _blblTextSize = opts.TextSize or theme.FontSizeTitle
	lbl.Container = U.Create(
		"Frame",
		{ Name = "BoldLabel", Size = UDim2.new(1, 0, 0, h), BackgroundTransparency = 1, Parent = self.Content }
	)
	lbl.TextLabel = U.Create("TextLabel", {
		Name = "Text",
		Size = UDim2.new(1, 0, 0, hasDesc and 22 or h),
		Position = UDim2.fromOffset(0, hasDesc and 2 or (h - 22) / 2 + 1),
		BackgroundTransparency = 1,
		Text = opts.Text or "",
		Font = theme.FontBold,
		TextSize = _blblTextSize,
		TextColor3 = _blblColor or theme.TextPrimary,
		TextXAlignment = Enum.TextXAlignment.Left,
		RichText = true,
		Parent = lbl.Container,
	})
	if hasDesc then
		U.Create("TextLabel", {
			Name = "Description",
			Size = UDim2.new(1, 0, 0, 16),
			Position = UDim2.fromOffset(0, 24),
			BackgroundTransparency = 1,
			Text = opts.Description,
			Font = theme.Font,
			TextSize = theme.FontSizeSmall,
			TextColor3 = theme.TextMuted,
			TextXAlignment = Enum.TextXAlignment.Left,
			RichText = true,
			Parent = lbl.Container,
		})
	end
	lbl.Destroy = function()
		if lbl.Container then
			lbl.Container:Destroy()
		end
	end
	lbl.ApplyTheme = function(_, t)
		t = t or _
		if not lbl.TextLabel then
			return
		end
		lbl.TextLabel.Font = t.FontBold
		lbl.TextLabel.TextSize = _blblTextSize
		lbl.TextLabel.TextColor3 = _blblColor or t.TextPrimary
		local d = lbl.Container:FindFirstChild("Description")
		if d then
			d.Font = t.Font
			d.TextSize = t.FontSizeSmall
			d.TextColor3 = t.TextMuted
		end
	end
	table.insert(self.Components, lbl)
	self:_updateSize()
	return lbl
end
function Collapsible:Divider()
	if destroyedFactoryResult(self) then
		return nil, "destroyed"
	end
	local div = {}
	div.Container = U.Create("Frame", {
		Name = "Divider",
		Size = UDim2.new(1, -20, 0, 1),
		Position = UDim2.fromOffset(10, 0),
		BackgroundColor3 = self.Theme.Border,
		BackgroundTransparency = 0.5,
		BorderSizePixel = 0,
		Parent = self.Content,
	})
	div.ApplyTheme = function(_, t)
		t = t or _
		if div.Container then
			div.Container.BackgroundColor3 = t.Border
		end
	end
	table.insert(self.Components, div)
	self:_updateSize()
	return div
end
function Collapsible:Columns(opts)
	if destroyedFactoryResult(self) then
		return nil, "destroyed"
	end
	opts = opts or {}
	local c = Columns.new(self.Content, opts, self.Theme, self._menu, function()
		self:_updateSize()
	end)
	table.insert(self.Components, c)
	return c
end
function Collapsible:Destroy()
	if self._destroyed then
		return
	end
	self._destroyed = true
	self._closed = true
	if self._tween then
		self._tween:Cancel()
	end
	for _, c in ipairs(self.Components) do
		if c.Destroy then
			c:Destroy()
		end
	end
	self.Components = {}
	if self.Container then
		self.Container:Destroy()
	end
end

function Collapsible:ApplyTheme(theme)
	self.Theme = theme
	if not self.Container then
		return
	end
	self.Container.BackgroundColor3 = theme.Element
	local stroke = self.Container:FindFirstChildOfClass("UIStroke")
	if stroke then
		stroke.Color = theme.ElementBorder
	end
	self.Header.BackgroundColor3 = theme.ElementHover
	if self.Arrow then
		if self.Arrow:IsA("ImageLabel") then
			self.Arrow.ImageColor3 = theme.TextSecondary
		end
		if self.Arrow:IsA("TextLabel") then
			self.Arrow.TextColor3 = theme.TextSecondary
		end
	end
	self.Title.Font = theme.FontBold
	self.Title.TextSize = theme.FontSize
	self.Title.TextColor3 = theme.TextPrimary
	if self._layout then
		self._layout.Padding = UDim.new(0, theme.Spacing)
	end
	for _, c in ipairs(self.Components) do
		if c.ApplyTheme then
			c:ApplyTheme(theme)
		end
	end
end
