--[[ Command Palette ]]

-- Build a flat search index from all tabs and their components (including collapsible children)
function Menu:_buildPaletteIndex()
	self._paletteIndex = {}
	for _, tab in ipairs(self.Tabs) do
		if not tab._destroyed then
			table.insert(self._paletteIndex, {
				type = "tab",
				text = tab.Text,
				tab = tab,
				collapsible = nil,
				ref = nil,
			})
			self:_indexTabComponents(tab.Components, tab, nil)
		end
	end
end

function Menu:_indexTabComponents(components, tab, collapsible)
	for _, comp in ipairs(components) do
		if type(comp) == "table" and comp._destroyed then
			continue
		end
		-- Collapsible detection (has _closed field)
		if type(comp) == "table" and comp._closed ~= nil then
			if comp.Title then
				table.insert(self._paletteIndex, {
					type = "section",
					text = comp.Title.Text,
					tab = tab,
					collapsible = comp,
					ref = comp,
				})
			end
			if comp.Components then
				self:_indexTabComponents(comp.Components, tab, comp)
			end
		else
			local text = nil
			if type(comp) == "table" then
				if comp.Text then
					text = tostring(comp.Text)
				end
				if not text and comp.Container and not comp.Container:IsA("ScrollingFrame") then
					local txtChild = comp.Container:FindFirstChild("Text")
					if txtChild and txtChild:IsA("TextLabel") then
						text = txtChild.Text
					end
				end
			end
			if text and text ~= "" then
				table.insert(self._paletteIndex, {
					type = "component",
					text = text,
					tab = tab,
					collapsible = collapsible,
					ref = comp,
				})
			end
		end
	end
end

-- Filter search index against query and rebuild result buttons
function Menu:_filterPaletteResults(query)
	for _, btn in ipairs(self._paletteResultButtons) do
		pcall(function()
			btn:Destroy()
		end)
	end
	self._paletteResultButtons = {}

	local q = query:lower()
	local filtered = {}
	for _, item in ipairs(self._paletteIndex) do
		if (#q == 0 or item.text:lower():find(q, 1, true)) and #filtered < self._paletteMaxResults then
			table.insert(filtered, item)
		end
	end
	self._paletteFilteredResults = filtered

	if self._paletteEmpty then
		self._paletteEmpty.Visible = #filtered == 0
	end
	if not self._paletteFrame then
		return
	end
	local theme = self.Theme

	for i, result in ipairs(filtered) do
		local btn = U.Create("TextButton", {
			Name = "Result",
			Size = UDim2.new(1, 0, 0, 30),
			BackgroundTransparency = 0.6,
			AutoButtonColor = false,
			Text = "",
			ZIndex = 100002,
			Parent = self._paletteResults,
		})
		-- Row highlight
		local selection = U.Create("Frame", {
			Name = "Selection",
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ZIndex = 100002,
			Parent = btn,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(0, 4), Parent = selection })
		-- Label
		U.Create("TextLabel", {
			Name = "Label",
			Size = UDim2.new(1, -70, 1, 0),
			Position = UDim2.fromOffset(10, 0),
			BackgroundTransparency = 1,
			Text = result.text,
			Font = theme.Font,
			TextSize = theme.FontSize,
			TextColor3 = theme.TextPrimary,
			TextXAlignment = Enum.TextXAlignment.Left,
			ZIndex = 100003,
			Parent = btn,
		})
		-- Source tag
		local src = result.type == "tab" and "Tab"
			or (result.type == "section" and "Section")
			or (result.collapsible and result.collapsible.Title.Text or result.tab.Text)
		U.Create("TextLabel", {
			Name = "Source",
			Size = UDim2.new(0, 60, 1, 0),
			Position = UDim2.new(1, -64, 0, 0),
			BackgroundTransparency = 1,
			Text = src,
			Font = theme.Font,
			TextSize = theme.FontSizeSmall,
			TextColor3 = theme.TextMuted,
			TextXAlignment = Enum.TextXAlignment.Right,
			TextTruncate = Enum.TextTruncate.AtEnd,
			ZIndex = 100003,
			Parent = btn,
		})
		-- Click
		btn.MouseButton1Click:Connect(function()
			self:_paletteActivateResult(result)
		end)
		table.insert(self._paletteResultButtons, btn)
	end

	if #filtered == 0 then
		self._paletteSelectedIndex = 0
	else
		self._paletteSelectedIndex = math.clamp(self._paletteSelectedIndex, 1, #filtered)
	end
	self:_updatePaletteSelection()
end

function Menu:_updatePaletteSelection()
	for i, btn in ipairs(self._paletteResultButtons) do
		local sel = btn:FindFirstChild("Selection")
		if sel then
			if i == self._paletteSelectedIndex then
				sel.BackgroundColor3 = self.Theme.Accent
				sel.BackgroundTransparency = 0.55
			else
				sel.BackgroundTransparency = 1
			end
		end
	end
end

function Menu:_paletteSelectNext()
	local n = #self._paletteFilteredResults
	if n == 0 then
		return
	end
	self._paletteSelectedIndex = self._paletteSelectedIndex + 1
	if self._paletteSelectedIndex > n then
		self._paletteSelectedIndex = 1
	end
	self:_updatePaletteSelection()
end

function Menu:_paletteSelectPrev()
	local n = #self._paletteFilteredResults
	if n == 0 then
		return
	end
	self._paletteSelectedIndex = self._paletteSelectedIndex - 1
	if self._paletteSelectedIndex < 1 then
		self._paletteSelectedIndex = n
	end
	self:_updatePaletteSelection()
end

function Menu:_paletteActivateSelected()
	local results = self._paletteFilteredResults or {}
	local idx = self._paletteSelectedIndex
	if idx > 0 and idx <= #results then
		self:_paletteActivateResult(results[idx])
	end
end

function Menu:_paletteActivateResult(result)
	if not result then
		return
	end
	if result.type == "tab" then
		self:SelectTab(result.tab)
		self:CloseCommandPalette()
		return
	end
	-- Component / section
	self:SelectTab(result.tab)
	local needsOpen = result.collapsible and not result.collapsible._isOpen
	if needsOpen then
		result.collapsible:Open()
	end
	self:CloseCommandPalette()
	local target = result.ref
	local container = target and (target.Container or (target.Title and target.Container))
	if container then
		if needsOpen then
			task.wait(0.26)
		end
		self:_emphasizeComponent(result.tab, container)
	end
end

function Menu:_emphasizeComponent(tab, container)
	if not tab.Container or not container or not container:IsDescendantOf(tab.Container) then
		return
	end
	local scroll = tab.Container
	-- Scroll the container into view
	task.spawn(function()
		task.wait(0.05)
		if not scroll or not container or not container:IsDescendantOf(scroll) then
			return
		end
		local absC = container.AbsolutePosition
		local absS = scroll.AbsolutePosition
		local relY = absC.Y - absS.Y + scroll.CanvasPosition.Y - 16
		local ts = game:GetService("TweenService")
		ts:Create(scroll, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			CanvasPosition = Vector2.new(0, math.max(0, relY)),
		}):Play()
	end)
	-- Brief emphasize flash
	local origColor = container.BackgroundColor3
	local origTrans = container.BackgroundTransparency
	container.BackgroundColor3 = self.Theme.Accent
	container.BackgroundTransparency = 0.65
	task.delay(0.5, function()
		if not container or container.Parent == nil then
			return
		end
		local ts = game:GetService("TweenService")
		ts:Create(container, TweenInfo.new(0.4), { BackgroundTransparency = origTrans }):Play()
		task.delay(0.1, function()
			if container then
				container.BackgroundColor3 = origColor
			end
		end)
	end)
end

function Menu:OpenCommandPalette()
	if self._destroyed or not self.Visible or self.Minimized then
		return false, "not visible"
	end
	if self._paletteOpen then
		self:CloseCommandPalette()
	end
	self:HideDropdownPopup()
	self:_buildPaletteIndex()
	self._paletteOpen = true
	self._paletteSelectedIndex = 0

	local gui = self.Gui
	local theme = self.Theme
	local ts = game:GetService("TweenService")
	local uis = game:GetService("UserInputService")

	-- Full-frame dim overlay (ImageButton to catch clicks, parented to Gui for max layering)
	self._paletteOverlay = U.Create("ImageButton", {
		Name = "PaletteOverlay",
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 100000,
		AutoButtonColor = false,
		Parent = gui,
		Visible = false,
	})
	self._paletteOverlay.MouseButton1Click:Connect(function()
		self:CloseCommandPalette()
	end)

	-- Palette frame (centered on screen relative to gui)
	local palW, palH = self:_modalSize(380, 310, 180, 180)
	self._paletteFrame = U.Create("Frame", {
		Name = "CommandPalette",
		Size = UDim2.fromOffset(palW, palH),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = theme.Background,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		ZIndex = 100001,
		Parent = gui,
		Visible = false,
	})
	U.Create("UICorner", { CornerRadius = UDim.new(0, 10), Parent = self._paletteFrame })
	U.Create("UIStroke", { Color = theme.Outline, Thickness = 1, Transparency = 0.15, Parent = self._paletteFrame })

	-- Search box
	self._paletteSearchBox = U.Create("TextBox", {
		Name = "SearchBox",
		Size = UDim2.new(1, -16, 0, 34),
		Position = UDim2.fromOffset(8, 8),
		BackgroundColor3 = theme.Element,
		BackgroundTransparency = 0,
		Text = "",
		PlaceholderText = "Search tabs and components...",
		Font = theme.Font,
		TextSize = theme.FontSize,
		TextColor3 = theme.TextPrimary,
		PlaceholderColor3 = theme.TextMuted,
		ClearTextOnFocus = false,
		ZIndex = 100002,
		Parent = self._paletteFrame,
	})
	U.Create("UICorner", { CornerRadius = UDim.new(0, 6), Parent = self._paletteSearchBox })

	-- Results list
	self._paletteResults = U.Create("ScrollingFrame", {
		Name = "Results",
		Size = UDim2.new(1, -16, 1, -(34 + 12)),
		Position = UDim2.fromOffset(8, 34 + 8 + 4),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ScrollBarThickness = 3,
		ScrollBarImageColor3 = theme.ScrollBar,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		ZIndex = 100002,
		Parent = self._paletteFrame,
	})
	local resLayout = U.Create("UIListLayout", {
		Padding = UDim.new(0, 2),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = self._paletteResults,
	})
	resLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		if self._paletteResults then
			self._paletteResults.CanvasSize = UDim2.new(0, 0, 0, resLayout.AbsoluteContentSize.Y)
		end
	end)

	-- Empty state
	self._paletteEmpty = U.Create("TextLabel", {
		Name = "EmptyState",
		Size = UDim2.new(1, -16, 0, 60),
		Position = UDim2.fromOffset(8, 34 + 8 + 4),
		BackgroundTransparency = 1,
		Text = "No results found",
		Font = theme.Font,
		TextSize = theme.FontSizeSmall,
		TextColor3 = theme.TextMuted,
		TextXAlignment = Enum.TextXAlignment.Center,
		ZIndex = 100002,
		Visible = false,
		Parent = self._paletteFrame,
	})

	-- Show all results initially
	self:_filterPaletteResults("")

	-- Connections
	local conns = {}
	table.insert(
		conns,
		self._paletteSearchBox:GetPropertyChangedSignal("Text"):Connect(function()
			self:_filterPaletteResults(self._paletteSearchBox.Text)
		end)
	)
	table.insert(
		conns,
		uis.InputBegan:Connect(function(pi, pgpe)
			if not self._paletteOpen then
				return
			end
			if pi.UserInputType ~= Enum.UserInputType.Keyboard then
				return
			end
			local pk = pi.KeyCode
			if pk == Enum.KeyCode.Escape then
				self:CloseCommandPalette()
			elseif pk == Enum.KeyCode.Up then
				self:_paletteSelectPrev()
			elseif pk == Enum.KeyCode.Down then
				self:_paletteSelectNext()
			elseif pk == Enum.KeyCode.Return then
				self:_paletteActivateSelected()
			end
		end)
	)
	self._paletteConns = conns

	-- Show frames
	self._paletteOverlay.Visible = true
	self._paletteFrame.Visible = true

	-- Animate in
	self:_transition(self._paletteOverlay, 0.15, { BackgroundTransparency = 0.45 })
	self._paletteFrame.Size = UDim2.fromOffset(0, 0)
	self:_transition(self._paletteFrame, 0.2, { Size = UDim2.fromOffset(palW, palH) })

	-- Focus search box after a tick
	task.spawn(function()
		task.wait(0.1)
		if self._paletteSearchBox then
			self._paletteSearchBox:CaptureFocus()
		end
	end)
	return true
end

function Menu:CloseCommandPalette()
	if not self._paletteOpen then
		return
	end
	self._paletteOpen = false

	if self._paletteConns then
		for _, c in ipairs(self._paletteConns) do
			pcall(function()
				c:Disconnect()
			end)
		end
		self._paletteConns = {}
	end
	self._paletteResultButtons = {}
	self._paletteFilteredResults = {}
	self._paletteSelectedIndex = 0

	if self._paletteOverlay then
		self._paletteOverlay:Destroy()
		self._paletteOverlay = nil
	end
	if self._paletteFrame then
		self._paletteFrame:Destroy()
		self._paletteFrame = nil
	end
	self._paletteSearchBox = nil
	self._paletteResults = nil
	self._paletteEmpty = nil
end

function Menu:ToggleCommandPalette()
	if self._paletteOpen then
		self:CloseCommandPalette()
	else
		self:OpenCommandPalette()
	end
end
