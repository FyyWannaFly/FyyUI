--[[ Columns Layout ]]
local Column = {}
Column.__index = Column

-- Column helper: register a newly constructed child component
function Column:_mount(c, opts)
	if not c then
		return nil
	end
	table.insert(self.Components, c)
	if c.Flag and self._menu then
		self._menu:_trackFlagged(c)
	end
	if opts.Tooltip and self._menu and c.Container then
		self._menu:BindTooltip(c.Container, opts.Tooltip)
	end
	self._columns:_updateHeight()
	return c
end

function Column.new(columns, index, theme, menuRef)
	local self = setmetatable({}, Column)
	self._columns = columns
	self._menu = menuRef
	self.Theme = theme
	self.Components = {}
	self.Content = U.Create("Frame", {
		Name = "Column" .. index,
		Size = UDim2.fromOffset(0, 0),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Parent = columns.Container,
	})
	self._layout = U.Create("UIListLayout", {
		Padding = UDim.new(0, theme.Spacing),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = self.Content,
	})
	-- Recalculate Columns height whenever this column's content layout changes
	self._layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		if not columns._destroyed and not self._destroyed then
			columns:_updateHeight()
		end
	end)
	return self
end

function Column:_contentHeight()
	return self._layout and self._layout.AbsoluteContentSize.Y or 0
end

-- Pass-through factories (delegate via _mount to reuse registration logic)
function Column:Toggle(opts)
	if destroyedFactoryResult(self) then
		return nil, "destroyed"
	end
	opts = opts or {}
	return self:_mount(Toggle.new(self.Content, opts, self.Theme), opts)
end

function Column:Checkbox(opts)
	if destroyedFactoryResult(self) then
		return nil, "destroyed"
	end
	opts = opts or {}
	return self:_mount(Checkbox.new(self.Content, opts, self.Theme), opts)
end

function Column:Slider(opts)
	if destroyedFactoryResult(self) then
		return nil, "destroyed"
	end
	opts = opts or {}
	if self._columns._isOneToOne then
		local clo = {}
		for k, v in pairs(opts) do
			clo[k] = v
		end
		clo._inOneToOneColumn = true
		opts = clo
	end
	return self:_mount(Slider.new(self.Content, opts, self.Theme), opts)
end

function Column:Dropdown(opts)
	if destroyedFactoryResult(self) then
		return nil, "destroyed"
	end
	opts = opts or {}
	local dropdownOpts = {}
	for k, v in pairs(opts) do
		dropdownOpts[k] = v
	end
	dropdownOpts._compactControl = true
	return self:_mount(Dropdown.new(self.Content, dropdownOpts, self.Theme, self._menu), opts)
end

function Column:Keybind(opts)
	if destroyedFactoryResult(self) then
		return nil, "destroyed"
	end
	opts = opts or {}
	return self:_mount(Keybind.new(self.Content, opts, self.Theme, self._menu), opts)
end

function Column:Input(opts)
	if destroyedFactoryResult(self) then
		return nil, "destroyed"
	end
	opts = opts or {}
	return self:_mount(TextInput.new(self.Content, opts, self.Theme), opts)
end

function Column:Collapsible(title, opts)
	if destroyedFactoryResult(self) then
		return nil, "destroyed"
	end
	opts = opts or {}
	local c = Collapsible.new(self.Content, title, opts, self.Theme)
	c._menu = self._menu
	if self._columns._isOneToOne then
		c._inOneToOne = true
	end
	table.insert(self.Components, c)
	self._columns:_updateHeight()
	return c
end

function Column:Columns(opts)
	if destroyedFactoryResult(self) then
		return nil, "destroyed"
	end
	opts = opts or {}
	local columns = Columns.new(self.Content, opts, self.Theme, self._menu, function()
		self._columns:_updateHeight()
	end)
	table.insert(self.Components, columns)
	self._columns:_updateHeight()
	return columns
end

-- Inline factories (Button, Label, BoldLabel, Divider) — same pattern as Collapsible
function Column:Button(opts)
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
		local stroke = btn.Container:FindFirstChildOfClass("UIStroke")
		if stroke then
			stroke.Color = t.ElementBorder
		end
		local text = btn.Container:FindFirstChild("Text")
		if text then
			text.Font = t.Font
			text.TextSize = t.FontSize
			text.TextColor3 = _btnColor or t.TextPrimary
		end
		local desc = btn.Container:FindFirstChild("Description")
		if desc then
			desc.Font = t.Font
			desc.TextSize = t.FontSizeSmall
			desc.TextColor3 = t.TextMuted
		end
	end
	table.insert(self.Components, btn)
	self._columns:_updateHeight()
	return btn
end

function Column:Label(opts)
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
	lbl.SetText = function(text)
		lbl.TextLabel.Text = text
	end
	lbl.SetColor = function(c)
		lbl.TextLabel.TextColor3 = c
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
	self._columns:_updateHeight()
	return lbl
end

function Column:BoldLabel(opts)
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
	lbl.SetText = function(text)
		lbl.TextLabel.Text = text
	end
	lbl.SetColor = function(c)
		lbl.TextLabel.TextColor3 = c
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
	self._columns:_updateHeight()
	return lbl
end

function Column:Divider()
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
	self._columns:_updateHeight()
	return div
end

function Column:Destroy()
	if self._destroyed then
		return
	end
	self._destroyed = true
	for _, c in ipairs(self.Components) do
		if c.Destroy then
			c:Destroy()
		end
	end
	self.Components = {}
	if self.Content then
		self.Content:Destroy()
	end
end

function Column:ApplyTheme(theme)
	self.Theme = theme
	if not self.Content then
		return
	end
	if self._layout then
		self._layout.Padding = UDim.new(0, theme.Spacing)
	end
	for _, c in ipairs(self.Components) do
		if c.ApplyTheme then
			c:ApplyTheme(theme)
		end
	end
end

--[[ Columns controller ]]
Columns = {}
Columns.__index = Columns

function Columns.new(parent, options, theme, menuRef, parentUpdateCallback)
	local self = setmetatable({}, Columns)
	self._destroyed = false
	self._menu = menuRef
	self.Theme = theme
	self.Components = {}
	self._parentUpdate = parentUpdateCallback

	-- Parse & validate options
	self._ratio = options.Ratio or { 1, 1 }
	self._gap = options.Gap or 8
	self._stackCompact = options.StackOnCompact ~= false
	assert(
		type(self._ratio) == "table" and #self._ratio >= 2,
		"Columns: Ratio must be a table with at least 2 positive finite numbers"
	)
	for _, v in ipairs(self._ratio) do
		assert(isFiniteNumber(v) and v > 0, "Columns: each Ratio value must be a positive finite number")
	end
	assert(isFiniteNumber(self._gap) and self._gap >= 0, "Columns: Gap must be a non-negative finite number")

	self._isOneToOne = #self._ratio == 2 and self._ratio[1] == self._ratio[2]

	-- Container frame — children are positioned manually by _updateHeight
	self.Container = U.Create("Frame", {
		Name = "Columns",
		Size = UDim2.new(1, 0, 0, 0),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Parent = parent,
	})

	-- Re-layout when container width changes (responsive, resize, minimize restore)
	self._containerSizing = self.Container:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		if not self._destroyed then
			self:_updateHeight()
		end
	end)

	-- Create column children
	self._columns = {}
	self._nextColumn = 1
	for i = 1, #self._ratio do
		local col = Column.new(self, i, theme, menuRef)
		table.insert(self._columns, col)
		table.insert(self.Components, col)
	end

	-- Initial layout
	task.spawn(function()
		if not self._destroyed then
			self:_updateHeight()
		end
	end)

	return self
end

function Columns:_isCompact()
	if not self._stackCompact then
		return false
	end
	if self._menu and self._menu._compact ~= nil then
		return self._menu._compact
	end
	-- Derive from menu compact breakpoint if available
	if self._menu and self._menu.CompactBreakpoint then
		local viewport = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920, 1080)
		if viewport.X <= self._menu.CompactBreakpoint then
			return true
		end
	end
	-- Fallback: check parent container absolute width
	if self.Container then
		local w = self.Container.AbsoluteSize.X
		if w > 0 and w < 400 then
			return true
		end
	end
	return false
end

function Columns:_updateHeight()
	if self._destroyed or self._updating then
		return
	end
	self._updating = true

	local compact = self:_isCompact()
	local numCols = #self._columns
	local containerW = self.Container.AbsoluteSize.X

	-- Collect column content heights
	local colHeights = {}
	local maxH = 0
	local sumH = 0
	for i, col in ipairs(self._columns) do
		local h = col:_contentHeight()
		colHeights[i] = h
		if h > maxH then
			maxH = h
		end
		sumH = sumH + h
	end

	if compact and numCols > 0 then
		-- Compact: stack vertically in creation order, full width
		local y = 0
		for i = 1, numCols do
			local h = colHeights[i]
			local col = self._columns[i]
			col.Content.Size = UDim2.new(1, 0, 0, h)
			col.Content.Position = UDim2.fromOffset(0, y)
			if i < numCols then
				y = y + h + self._gap
			end
		end
		self.Container.Size = UDim2.new(1, 0, 0, sumH + math.max(0, numCols - 1) * self._gap)
	elseif numCols > 0 then
		-- Desktop: side by side, each column height = max content height
		local totalRatio = 0
		for _, r in ipairs(self._ratio) do
			totalRatio = totalRatio + r
		end
		local availableW = math.max(0, containerW - self._gap * (numCols - 1))
		local x = 0
		for i = 1, numCols do
			local w = math.floor(availableW * self._ratio[i] / totalRatio)
			local col = self._columns[i]
			col.Content.Size = UDim2.fromOffset(w, maxH)
			col.Content.Position = UDim2.fromOffset(math.floor(x), 0)
			if i < numCols then
				x = x + w + self._gap
			end
		end
		self.Container.Size = UDim2.new(1, 0, 0, maxH)
	end

	self._updating = false

	-- Notify parent Collapsible to recalculate its own size
	if self._parentUpdate then
		self._parentUpdate()
	end
end

-- Sequential column accessor: first call returns column 1, then 2, etc.
function Columns:Column(idx)
	if self._destroyed then
		return nil, "destroyed"
	end
	if idx ~= nil then
		return self._columns[idx]
	end
	local col = self._columns[self._nextColumn]
	if col then
		self._nextColumn = self._nextColumn + 1
	end
	return col
end

function Columns:Destroy()
	if self._destroyed then
		return
	end
	self._destroyed = true
	if self._containerSizing then
		self._containerSizing:Disconnect()
		self._containerSizing = nil
	end
	for _, col in ipairs(self._columns) do
		col:Destroy()
	end
	self._columns = {}
	self.Components = {}
	if self.Container then
		self.Container:Destroy()
	end
end

function Columns:ApplyTheme(theme)
	self.Theme = theme
	if not self.Container then
		return
	end
	for _, col in ipairs(self._columns) do
		col:ApplyTheme(theme)
	end
end
