--[[ Tab ]]
local Tab = {}
Tab.__index = Tab

function Tab.new(menu, options)
	local self = setmetatable({}, Tab)
	self.Menu = menu
	self.Text = options.Text or "Tab"
	self.Theme = menu.Theme
	self.Components = {}
	local theme = self.Theme

	self.TabButton = U.Create("ImageButton", {
		Name = "TabButton",
		Size = UDim2.new(1, -6, 0, 38),
		Position = UDim2.fromOffset(3, 0),
		BackgroundTransparency = 1,
		AutoButtonColor = false,
		Parent = menu.SidebarList,
	})
	menu:_makeSelectable(self.TabButton)
	U.Create("UICorner", { CornerRadius = UDim.new(0, 6), Parent = self.TabButton })
	-- Active glow overlay (subtle white, visible when tab is selected)
	self._glow = U.Create("Frame", {
		Name = "Glow",
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 0,
		Parent = self.TabButton,
	})
	U.Create("UICorner", { CornerRadius = UDim.new(0, 6), Parent = self._glow })
	-- Icon (optional, uses renderIcon for image or emoji/text fallback)
	local _tabIcon = renderIcon(self.TabButton, options.Icon, {
		Size = UDim2.fromOffset(18, 18),
		Position = UDim2.fromOffset(14, 10),
	})
	local textX = _tabIcon and 40 or 18
	local textW = _tabIcon and -44 or -22
	U.Create("TextLabel", {
		Name = "Label",
		Size = UDim2.new(1, textW, 1, 0),
		Position = UDim2.fromOffset(textX, 0),
		BackgroundTransparency = 1,
		Text = self.Text,
		Font = theme.Font,
		TextSize = theme.FontSize,
		TextColor3 = theme.SidebarText,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = self.TabButton,
	})
	self.Container = U.Create("ScrollingFrame", {
		Name = "TabContent",
		Size = UDim2.new(1, -12, 1, -12),
		Position = UDim2.fromOffset(6, 6),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ScrollBarThickness = 3,
		ScrollBarImageColor3 = theme.ScrollBar,
		ScrollBarImageTransparency = 0.4,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		ScrollingDirection = Enum.ScrollingDirection.Y,
		Visible = false,
		Parent = menu.ContentArea,
	})
	local contentPadding = U.Create("UIPadding", {
		PaddingTop = UDim.new(0, 6),
		PaddingBottom = UDim.new(0, 12),
		Parent = self.Container,
	})
	local listLayout = U.Create("UIListLayout", {
		Padding = UDim.new(0, theme.Spacing),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = self.Container,
	})
	listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		if self.Container then
			self.Container.CanvasSize = UDim2.new(
				0,
				0,
				0,
				listLayout.AbsoluteContentSize.Y
					+ contentPadding.PaddingTop.Offset
					+ contentPadding.PaddingBottom.Offset
			)
		end
	end)

	self.TabButton.Activated:Connect(function()
		menu:SelectTab(self)
	end)
	self.TabButton.SelectionGained:Connect(function()
		if menu:_selectionIsAvailable() then
			menu:SelectTab(self)
		end
	end)
	self.TabButton.MouseEnter:Connect(function()
		if menu.ActiveTab ~= self then
			self.TabButton.BackgroundTransparency = 0
			self.TabButton.BackgroundColor3 = theme.TabHover
		end
	end)
	self.TabButton.MouseLeave:Connect(function()
		if menu.ActiveTab ~= self then
			self.TabButton.BackgroundTransparency = 1
		end
	end)

	-- Bind tooltip to TabButton if provided
	if options.Tooltip and menu then
		menu:BindTooltip(self.TabButton, options.Tooltip)
	end

	table.insert(menu.Tabs, self)
	if #menu.Tabs == 1 then
		menu:SelectTab(self)
	end

	return self
end

function Tab:Toggle(options)
	if destroyedFactoryResult(self) then
		return nil, "destroyed"
	end
	options = options or {}
	local toggle = Toggle.new(self.Container, options, self.Theme)
	table.insert(self.Components, toggle)
	self.Menu:_makeSelectable(toggle.Track)
	if toggle.Flag then
		self.Menu:_trackFlagged(toggle)
	end
	if options.Tooltip and self.Menu then
		self.Menu:BindTooltip(toggle.Container, options.Tooltip)
	end
	return toggle
end

function Tab:Button(options)
	if destroyedFactoryResult(self) then
		return nil, "destroyed"
	end
	options = options or {}
	local theme = self.Theme
	local hasDesc = options.Description ~= nil and options.Description ~= ""
	local h = hasDesc and theme.DescHeight or theme.ElementHeight
	local btn = {}
	local _btnTextColor = options.Color

	btn.Container = U.Create("ImageButton", {
		Name = "Button",
		Size = UDim2.new(1, -12, 0, h + 6),
		Position = UDim2.fromOffset(6, 0),
		BackgroundColor3 = theme.Element,
		BackgroundTransparency = 0,
		AutoButtonColor = false,
		BorderSizePixel = 0,
		Parent = self.Container,
	})
	self.Menu:_makeSelectable(btn.Container)
	U.Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = btn.Container })
	U.Create("UIStroke", { Color = theme.ElementBorder, Transparency = 0.6, Thickness = 1, Parent = btn.Container })

	-- Right-side icon (default: rocket, customizable via Icon option)
	renderIcon(btn.Container, options.Icon or "rocket", {
		Name = "Pointer",
		Size = UDim2.fromOffset(26, 26),
		Position = UDim2.new(1, -38, 0.5, -13),
		ImageTransparency = 0.5,
	})
	local btnIconX = 10
	local btnIconW = -54

	if hasDesc then
		U.Create("TextLabel", {
			Name = "Text",
			Size = UDim2.new(1, btnIconW, 0, 20),
			Position = UDim2.fromOffset(btnIconX, 5),
			BackgroundTransparency = 1,
			Text = options.Text or "Button",
			Font = theme.Font,
			TextSize = theme.FontSize,
			TextColor3 = options.Color or theme.TextPrimary,
			TextXAlignment = Enum.TextXAlignment.Left,
			Parent = btn.Container,
		})
		U.Create("TextLabel", {
			Name = "Description",
			Size = UDim2.new(1, btnIconW, 0, 16),
			Position = UDim2.fromOffset(btnIconX, 27),
			BackgroundTransparency = 1,
			Text = options.Description,
			Font = theme.Font,
			TextSize = theme.FontSizeSmall,
			TextColor3 = theme.TextMuted,
			TextXAlignment = Enum.TextXAlignment.Left,
			Parent = btn.Container,
		})
	else
		U.Create("TextLabel", {
			Name = "Text",
			Size = UDim2.new(1, btnIconW, 0, 20),
			Position = UDim2.fromOffset(btnIconX, (h + 6 - 20) / 2 + 1),
			BackgroundTransparency = 1,
			Text = options.Text or "Button",
			Font = theme.Font,
			TextSize = theme.FontSize,
			TextColor3 = options.Color or theme.TextPrimary,
			TextXAlignment = Enum.TextXAlignment.Left,
			Parent = btn.Container,
		})
	end

	btn.Container.MouseEnter:Connect(function()
		btn.Container.BackgroundColor3 = theme.ElementHover
		btn.Container.BackgroundTransparency = 0
	end)
	btn.Container.MouseLeave:Connect(function()
		btn.Container.BackgroundColor3 = theme.Element
		btn.Container.BackgroundTransparency = 0
	end)
	local _scale = U.Create("UIScale", { Parent = btn.Container })
	btn._scaleTween = nil
	btn.Container.MouseButton1Down:Connect(function()
		if btn._scaleTween then
			btn._scaleTween:Cancel()
		end
		btn.Container.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
		btn._scaleTween =
			game:GetService("TweenService")
				:Create(_scale, TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Scale = 0.97 })
		btn._scaleTween:Play()
	end)
	btn.Container.MouseButton1Up:Connect(function()
		if btn._scaleTween then
			btn._scaleTween:Cancel()
		end
		btn.Container.BackgroundColor3 = theme.ElementHover
		btn._scaleTween =
			game:GetService("TweenService")
				:Create(_scale, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Scale = 1 })
		btn._scaleTween:Play()
	end)
	btn.Container.MouseButton1Click:Connect(function()
		if options.Callback then
			options.Callback()
		end
	end)
	btn.SetText = function(text)
		local t = btn.Container:FindFirstChild("Text")
		if t then
			t.Text = text
		end
	end
	btn.SetCallback = function(cb)
		options.Callback = cb
	end
	btn.Destroy = function()
		if btn.Container then
			btn.Container:Destroy()
		end
	end
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
		local txt = btn.Container:FindFirstChild("Text")
		if txt then
			txt.Font = t.Font
			txt.TextSize = t.FontSize
			txt.TextColor3 = _btnTextColor or t.TextPrimary
		end
		local desc = btn.Container:FindFirstChild("Description")
		if desc then
			desc.Font = t.Font
			desc.TextSize = t.FontSizeSmall
			desc.TextColor3 = t.TextMuted
		end
	end

	if options.Tooltip and self.Menu then
		self.Menu:BindTooltip(btn.Container, options.Tooltip)
	end
	table.insert(self.Components, btn)
	return btn
end

function Tab:Label(options)
	if destroyedFactoryResult(self) then
		return nil, "destroyed"
	end
	options = options or {}
	local hasDesc = options.Description ~= nil and options.Description ~= ""
	local h = hasDesc and self.Theme.DescHeight or self.Theme.ElementHeight
	local lbl = {}
	local _labelColor = options.Color
	local _labelTextSize = options.TextSize or self.Theme.FontSize

	lbl.Container = U.Create("Frame", {
		Name = "Label",
		Size = UDim2.new(1, 0, 0, h),
		BackgroundTransparency = 1,
		Parent = self.Container,
	})

	lbl.TextLabel = U.Create("TextLabel", {
		Name = "Text",
		Size = UDim2.new(1, 0, 0, hasDesc and 20 or h),
		Position = UDim2.fromOffset(0, hasDesc and 2 or (h - 20) / 2 + 1),
		BackgroundTransparency = 1,
		Text = options.Text or "",
		Font = self.Theme.Font,
		TextSize = _labelTextSize,
		TextColor3 = _labelColor or self.Theme.TextSecondary,
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
			Text = options.Description,
			Font = self.Theme.Font,
			TextSize = self.Theme.FontSizeSmall,
			TextColor3 = self.Theme.TextMuted,
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
		lbl.TextLabel.TextSize = _labelTextSize
		lbl.TextLabel.TextColor3 = _labelColor or t.TextSecondary
		local d = lbl.Container:FindFirstChild("Description")
		if d then
			d.Font = t.Font
			d.TextSize = t.FontSizeSmall
			d.TextColor3 = t.TextMuted
		end
	end

	table.insert(self.Components, lbl)
	return lbl
end

function Tab:BoldLabel(options)
	if destroyedFactoryResult(self) then
		return nil, "destroyed"
	end
	options = options or {}
	local hasDesc = options.Description ~= nil and options.Description ~= ""
	local h = hasDesc and self.Theme.DescHeight or self.Theme.ElementHeight
	local lbl = {}
	local _blColor = options.Color
	local _blTextSize = options.TextSize or self.Theme.FontSizeTitle

	lbl.Container = U.Create("Frame", {
		Name = "BoldLabel",
		Size = UDim2.new(1, 0, 0, h),
		BackgroundTransparency = 1,
		Parent = self.Container,
	})

	lbl.TextLabel = U.Create("TextLabel", {
		Name = "Text",
		Size = UDim2.new(1, 0, 0, hasDesc and 22 or h),
		Position = UDim2.fromOffset(0, hasDesc and 2 or (h - 22) / 2 + 1),
		BackgroundTransparency = 1,
		Text = options.Text or "",
		Font = self.Theme.FontBold,
		TextSize = _blTextSize,
		TextColor3 = _blColor or self.Theme.TextPrimary,
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
			Text = options.Description,
			Font = self.Theme.Font,
			TextSize = self.Theme.FontSizeSmall,
			TextColor3 = self.Theme.TextMuted,
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
		lbl.TextLabel.TextSize = _blTextSize
		lbl.TextLabel.TextColor3 = _blColor or t.TextPrimary
		local d = lbl.Container:FindFirstChild("Description")
		if d then
			d.Font = t.Font
			d.TextSize = t.FontSizeSmall
			d.TextColor3 = t.TextMuted
		end
	end

	table.insert(self.Components, lbl)
	return lbl
end

function Tab:Divider()
	if destroyedFactoryResult(self) then
		return nil, "destroyed"
	end
	local div = {}
	div.Container = U.Create("Frame", {
		Name = "Divider",
		Size = UDim2.new(1, 0, 0, 14),
		BackgroundTransparency = 1,
		Parent = self.Container,
	})
	U.Create("Frame", {
		Name = "Line",
		Size = UDim2.new(1, 0, 0, 1),
		Position = UDim2.new(0, 0, 0.5, 0),
		BackgroundColor3 = self.Theme.Border,
		BorderSizePixel = 0,
		Parent = div.Container,
	})
	div.Destroy = function()
		if div.Container then
			div.Container:Destroy()
		end
	end
	div.ApplyTheme = function(_, t)
		t = t or _
		local line = div.Container:FindFirstChild("Line")
		if line then
			line.BackgroundColor3 = t.Border
		end
	end
	table.insert(self.Components, div)
	return div
end

function Tab:Slider(options)
	if destroyedFactoryResult(self) then
		return nil, "destroyed"
	end
	options = options or {}
	local slider = Slider.new(self.Container, options, self.Theme)
	table.insert(self.Components, slider)
	if slider.Flag then
		self.Menu:_trackFlagged(slider)
	end
	if options.Tooltip and self.Menu then
		self.Menu:BindTooltip(slider.Container, options.Tooltip)
	end
	return slider
end

function Tab:Dropdown(options)
	if destroyedFactoryResult(self) then
		return nil, "destroyed"
	end
	options = options or {}
	local dd = Dropdown.new(self.Container, options, self.Theme, self.Menu)
	table.insert(self.Components, dd)
	if dd.Flag then
		self.Menu:_trackFlagged(dd)
	end
	if options.Tooltip and self.Menu then
		self.Menu:BindTooltip(dd.Container, options.Tooltip)
	end
	return dd
end

function Tab:Keybind(options)
	if destroyedFactoryResult(self) then
		return nil, "destroyed"
	end
	options = options or {}
	local kb = Keybind.new(self.Container, options, self.Theme, self.Menu)
	table.insert(self.Components, kb)
	if kb.Flag then
		self.Menu:_trackFlagged(kb)
	end
	if options.Tooltip and self.Menu then
		self.Menu:BindTooltip(kb.Container, options.Tooltip)
	end
	return kb
end

function Tab:Input(options)
	if destroyedFactoryResult(self) then
		return nil, "destroyed"
	end
	options = options or {}
	local ti = TextInput.new(self.Container, options, self.Theme)
	table.insert(self.Components, ti)
	if ti.Flag then
		self.Menu:_trackFlagged(ti)
	end
	if options.Tooltip and self.Menu then
		self.Menu:BindTooltip(ti.Container, options.Tooltip)
	end
	return ti
end

--[[ Tab methods ]]
function Tab:Checkbox(options)
	if destroyedFactoryResult(self) then
		return nil, "destroyed"
	end
	options = options or {}
	local c = Checkbox.new(self.Container, options, self.Theme)
	table.insert(self.Components, c)
	self.Menu:_makeSelectable(c.Container)
	if c.Flag then
		self.Menu:_trackFlagged(c)
	end
	if options.Tooltip and self.Menu then
		self.Menu:BindTooltip(c.Container, options.Tooltip)
	end
	return c
end
function Tab:Collapsible(title, options)
	if destroyedFactoryResult(self) then
		return nil, "destroyed"
	end
	local c = Collapsible.new(self.Container, title, options, self.Theme)
	c._menu = self.Menu
	table.insert(self.Components, c)
	return c
end
function Tab:Columns(options)
	if destroyedFactoryResult(self) then
		return nil, "destroyed"
	end
	local c = Columns.new(self.Container, options or {}, self.Theme, self.Menu)
	table.insert(self.Components, c)
	return c
end
function Tab:Destroy()
	if self._destroyed then
		return
	end
	self._destroyed = true
	if self.Menu and not self.Menu._destroyed then
		local removedIndex
		for i, tab in ipairs(self.Menu.Tabs) do
			if tab == self then
				removedIndex = i
				table.remove(self.Menu.Tabs, i)
				break
			end
		end
		if self.Menu.ActiveTab == self then
			local replacement = removedIndex and self.Menu.Tabs[math.min(removedIndex, #self.Menu.Tabs)] or nil
			if replacement then
				self.Menu:SelectTab(replacement)
			else
				self.Menu.ActiveTab = nil
				if self.Menu.ActiveBar then
					self.Menu.ActiveBar.BackgroundTransparency = 1
				end
			end
		elseif self.Menu.ActiveTab and self.Menu.ActiveBar then
			self.Menu:_positionActiveBar(self.Menu.ActiveTab, false)
		end
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
	if self.TabButton then
		self.TabButton:Destroy()
	end
end

function Tab:ApplyTheme(theme)
	self.Theme = theme
	if not self.TabButton then
		return
	end
	-- Tab button label
	local lbl = self.TabButton:FindFirstChild("Label")
	if lbl then
		lbl.Font = theme.Font
		lbl.TextSize = theme.FontSize
	end
	-- Container (ScrollingFrame)
	if self.Container then
		self.Container.ScrollBarImageColor3 = theme.ScrollBar
		local layout = self.Container:FindFirstChildOfClass("UIListLayout")
		if layout then
			layout.Padding = UDim.new(0, theme.Spacing)
		end
	end
	-- Push to every child component
	for _, c in ipairs(self.Components) do
		if c.ApplyTheme then
			c:ApplyTheme(theme)
		end
	end
	-- Re-apply active/inactive styling
	if self.Menu and self.Menu.ActiveTab == self then
		self.TabButton.BackgroundTransparency = 0
		self.TabButton.BackgroundColor3 = theme.TabActive
		if self._glow then
			self._glow.BackgroundTransparency = 0.85
		end
		if lbl then
			lbl.TextColor3 = theme.SidebarTextActive
		end
	else
		self.TabButton.BackgroundTransparency = 1
		if lbl then
			lbl.TextColor3 = theme.SidebarText
		end
	end
end
