function Menu:_positionActiveBar(tab, animate)
	if not tab or not self.ActiveBar then
		return
	end
	local tabIdx = 0
	for i, candidate in ipairs(self.Tabs) do
		if candidate == tab then
			tabIdx = i
			break
		end
	end
	if tabIdx == 0 then
		return
	end

	if self._activeBarTween then
		self._activeBarTween:Cancel()
		self._activeBarTween = nil
	end

	local scrollY = self.SidebarList and self.SidebarList.CanvasPosition.Y or 0
	local position = UDim2.fromOffset(5, (tabIdx - 1) * 40 + 9 - scrollY)
	self.ActiveBar.BackgroundTransparency = 0
	if animate then
		local tween = self:_transition(self.ActiveBar, 0.22, { Position = position })
		self._activeBarTween = tween
		if tween then
			tween.Completed:Connect(function()
				if self._activeBarTween == tween then
					self._activeBarTween = nil
				end
			end)
		else
			self._activeBarTween = nil
		end
	else
		self.ActiveBar.Position = position
	end
end

function Menu:SelectTab(tab)
	if self.ActiveTab == tab then
		return
	end
	self:HideDropdownPopup()
	if self.ActiveTab and self.ActiveTab._isOverview then
		self:_releaseInput("OverviewWheel")
		self:_releaseInput("OverviewTouch")
	end
	local offsetY = 36

	-- Hide old tab content immediately (no glitchy slide-out)
	local hadPrevTab = self.ActiveTab ~= nil
	if self.ActiveTab then
		local old = self.ActiveTab
		old.Container.Visible = false
		old.Container.Position = UDim2.fromOffset(6, 6) -- reset
		old.TabButton.BackgroundTransparency = 1
		if old._glow then
			old._glow.BackgroundTransparency = 1
		end
		local lbl = old.TabButton:FindFirstChild("Label")
		if lbl then
			lbl.TextColor3 = self.Theme.SidebarText
		end
	end

	self.ActiveTab = tab
	if tab then
		-- New tab slides in from below
		tab.Container.Position = UDim2.fromOffset(6, offsetY)
		tab.Container.Visible = true
		self:_transition(tab.Container, 0.22, { Position = UDim2.fromOffset(6, 6) })

		self:_positionActiveBar(tab, hadPrevTab)

		-- Tab button visual
		tab.TabButton.BackgroundTransparency = 0
		tab.TabButton.BackgroundColor3 = self.Theme.TabActive
		if tab._glow then
			tab._glow.BackgroundTransparency = 0.85
		end
		local lbl = tab.TabButton:FindFirstChild("Label")
		if lbl then
			lbl.TextColor3 = self.Theme.SidebarTextActive
		end
	end
end

function Menu:ShowDropdownPopup(atPos, atSize, opts, selectedIdx, onClick, isMulti, dd, searchbar)
	if self._destroyed or not self.Gui or not self.Frame then
		return false, "destroyed"
	end
	if type(opts) ~= "table" then
		return false, "expected options table"
	end
	self:HideDropdownPopup()
	self._popupFocusReturn = self:_beginTransientFocus(dd and dd.SelectBtn)
	self._popupGen = (self._popupGen or 0) + 1 -- bump generation so stale close handlers bail out

	local uis = game:GetService("UserInputService")
	local theme = self.Theme
	local frameAbs = self.Frame.AbsolutePosition
	local frameSiz = self.Frame.AbsoluteSize
	atPos = typeof(atPos) == "Vector2" and atPos or frameAbs
	atSize = typeof(atSize) == "Vector2" and atSize or Vector2.new(0, 0)
	local py = 0
	isMulti = isMulti or false
	searchbar = searchbar == true
	dd = dd or self._activeDropdown -- fallback to _activeDropdown if not passed

	-- Determine panel width from the longest option, with room for the
	-- selection mark and comfortable right-side breathing space.
	local viewport = self:_viewportSize()
	local textService = game:GetService("TextService")
	local longestOptionWidth = 0
	for _, option in ipairs(opts) do
		local measured = textService:GetTextSize(tostring(option), theme.FontSize, theme.Font, Vector2.new(1000, 100)).X
		longestOptionWidth = math.max(longestOptionWidth, measured)
	end
	local PANEL_CHROME = 78
	local MIN_W = 160
	local PREF_W = math.ceil(math.max(MIN_W, longestOptionWidth + PANEL_CHROME))
	local COMFORT_W = math.min(140, PREF_W)
	local USABLE_W = 80 -- absolute minimum; below this the panel has negative/zero inner content
	local rightEdge = frameAbs.X + frameSiz.X
	local rightRoom = viewport.X - rightEdge - 4 -- 4px margin from screen edge
	local leftRoom = frameAbs.X - 4 -- space to the left of the menu
	local w, px
	local placement
	if not self._compact and rightRoom >= COMFORT_W then
		-- Right side: comfortable space for full panel
		w = math.min(PREF_W, rightRoom)
		px = frameSiz.X
		placement = "ExteriorRight"
	elseif not self._compact and leftRoom >= COMFORT_W then
		-- Right side insufficient → left fallback with comfortable width
		w = math.min(PREF_W, leftRoom)
		px = -w
		placement = "ExteriorLeft"
	else
		-- Compact fallback: keep the panel inside the menu, aligned to the right.
		placement = "InteriorRight"
		local interiorPadding = 8
		w = math.min(PREF_W, math.max(USABLE_W, frameSiz.X - interiorPadding * 2))
		px = frameSiz.X - interiorPadding - w
	end

	-- Side panels fill the menu height. Interior panels stay below the topbar.
	local OPT_H = math.max(32, self.TouchTargetSize)
	local clampedH = frameSiz.Y
	if placement == "InteriorRight" then
		local topInset = self.Topbar.AbsoluteSize.Y + 8
		local bottomInset = 8
		clampedH = math.max(80, frameSiz.Y - topInset - bottomInset)
		local triggerTop = atPos.Y - frameAbs.Y
		local belowY = triggerTop + atSize.Y + 4
		local aboveY = triggerTop - clampedH - 4
		if belowY + clampedH <= frameSiz.Y - bottomInset then
			py = belowY
		elseif aboveY >= topInset then
			py = aboveY
		else
			py = topInset
		end
	end
	local popupParent = self.Frame

	-- Create popup with 0 width → tween to slide in from right
	if placement == "InteriorRight" then
		self._popupCloser = U.Create("ImageButton", {
			Name = "DropdownCloser",
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			AutoButtonColor = false,
			Modal = true,
			ZIndex = 9999,
			Parent = self.Frame,
		})
		self._popupCloser.Activated:Connect(function()
			self:HideDropdownPopup()
		end)
	end
	local popup = U.Create("Frame", {
		Name = "DropdownPopup",
		Size = UDim2.fromOffset(0, clampedH),
		Position = UDim2.fromOffset(px, py),
		AnchorPoint = Vector2.new(0, 0),
		BackgroundColor3 = theme.Sidebar,
		BorderSizePixel = 0,
		ZIndex = 10000,
		Parent = popupParent,
	})
	U.Create("UICorner", { CornerRadius = UDim.new(0, 6), Parent = popup })
	U.Create("UIStroke", {
		Color = theme.Border,
		Thickness = 1,
		Transparency = 0.25,
		Parent = popup,
	})
	-- Content wrapper (avoids SideLine interfering with children)
	local content = U.Create("Frame", {
		Name = "Content",
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 10001,
		Parent = popup,
	})

	-- Separator line on the left, full height
	U.Create("Frame", {
		Name = "SideLine",
		Size = UDim2.new(0, 1, 1, 0),
		Position = UDim2.fromOffset(0, 0),
		BackgroundColor3 = theme.Border,
		BorderSizePixel = 0,
		BackgroundTransparency = 0.3,
		ZIndex = 10001,
		Visible = placement ~= "InteriorRight",
		Parent = popup,
	})

	local searchHeight = searchbar and 36 or 0
	local firstOptionButton
	local optionButtons = {}
	if #opts > 0 then
		-- ScrollingFrame for option list (content-aware)
		local optionList = U.Create("ScrollingFrame", {
			Name = "OptionList",
			Size = UDim2.new(1, -16, 1, -(16 + searchHeight)),
			Position = UDim2.fromOffset(8, 8 + searchHeight),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ScrollBarThickness = 3,
			ScrollBarImageColor3 = theme.ScrollBar,
			CanvasSize = UDim2.fromOffset(0, (#opts * OPT_H) + math.max(0, #opts - 1) * 2),
			ZIndex = 10001,
			Parent = content,
		})
		U.Create("UIListLayout", {
			Padding = UDim.new(0, 2),
			SortOrder = Enum.SortOrder.LayoutOrder,
			Parent = optionList,
		})

		-- Create option buttons with direct dropdown reference
		for i, opt in ipairs(opts) do
			local sel = false
			if isMulti then
				sel = dd and dd._selected[opt] or false
			else
				sel = dd and tostring(opt) == tostring(dd.Value) or false
			end
			local btn = U.Create("TextButton", {
				Name = "Option",
				Size = UDim2.new(1, -6, 0, OPT_H),
				Text = "",
				BackgroundColor3 = sel and theme.Accent or theme.Element,
				BackgroundTransparency = sel and 0.25 or 0.6,
				AutoButtonColor = false,
				ZIndex = 10001,
				Parent = optionList,
			})
			self:_makeSelectable(btn)
			table.insert(optionButtons, { Button = btn, Option = opt })
			if not firstOptionButton then
				firstOptionButton = btn
			end
			U.Create("UICorner", { CornerRadius = UDim.new(0, 4), Parent = btn })
			U.Create("UIStroke", { Color = theme.ElementBorder, Transparency = 0.5, Thickness = 1, Parent = btn })
			local textOffset = isMulti and 28 or 10
			U.Create("TextLabel", {
				Name = "Label",
				Size = UDim2.new(1, -(textOffset + 4), 1, 0),
				Position = UDim2.fromOffset(textOffset, 0),
				BackgroundTransparency = 1,
				Text = tostring(opt),
				Font = theme.Font,
				TextSize = theme.FontSize,
				TextColor3 = theme.SidebarTextActive,
				TextXAlignment = Enum.TextXAlignment.Left,
				ZIndex = 10002,
				Parent = btn,
			})
			btn.Activated:Connect(function()
				if isMulti then
					if dd then
						dd:SetValue(opt)
						local isSel = dd._selected[opt]
						btn.BackgroundColor3 = isSel and theme.Accent or theme.Element
						btn.BackgroundTransparency = isSel and 0.25 or 0.6
					end
				else
					onClick(i, opt)
					self:HideDropdownPopup()
				end
			end)
			btn.MouseEnter:Connect(function()
				btn.BackgroundColor3 = theme.Accent
				btn.BackgroundTransparency = 0.55
			end)
			btn.MouseLeave:Connect(function()
				local curSel = isMulti and (dd and dd._selected[opt])
					or (not isMulti and dd and tostring(opt) == tostring(dd.Value))
				if curSel then
					btn.BackgroundColor3 = theme.Accent
					btn.BackgroundTransparency = 0.25 -- back to normal selected
				else
					btn.BackgroundColor3 = theme.Element
					btn.BackgroundTransparency = 0.6
				end
			end)
		end
		if searchbar then
			local search = U.Create("TextBox", {
				Name = "Search",
				Size = UDim2.new(1, -16, 0, 28),
				Position = UDim2.fromOffset(8, 8),
				BackgroundColor3 = theme.Element,
				BorderSizePixel = 0,
				ClearTextOnFocus = false,
				PlaceholderText = "Search...",
				PlaceholderColor3 = theme.TextMuted,
				Text = "",
				Font = theme.Font,
				TextSize = theme.FontSize,
				TextColor3 = theme.TextPrimary,
				TextXAlignment = Enum.TextXAlignment.Left,
				ZIndex = 10002,
				Parent = content,
			})
			U.Create("UICorner", { CornerRadius = UDim.new(0, 4), Parent = search })
			U.Create("UIPadding", { PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8), Parent = search })
			local noResults = U.Create("TextLabel", {
				Name = "NoResults",
				Size = UDim2.new(1, -16, 0, OPT_H),
				Position = UDim2.fromOffset(8, 8 + searchHeight),
				BackgroundTransparency = 1,
				Text = "No results",
				Font = theme.Font,
				TextSize = theme.FontSize,
				TextColor3 = theme.TextMuted,
				TextXAlignment = Enum.TextXAlignment.Center,
				Visible = false,
				ZIndex = 10002,
				Parent = content,
			})
			self._popupSearchCon = search:GetPropertyChangedSignal("Text"):Connect(function()
				local needle = string.lower(search.Text)
				local visible = 0
				for _, record in ipairs(optionButtons) do
					local matches = needle == "" or string.find(string.lower(tostring(record.Option)), needle, 1, true)
					record.Button.Visible = matches ~= nil
					if matches then visible = visible + 1 end
				end
				optionList.CanvasSize = UDim2.fromOffset(0, visible * OPT_H + math.max(0, visible - 1) * 2)
				noResults.Visible = visible == 0
			end)
		end
	else
		-- Empty-state: centered in the panel area
		U.Create("TextLabel", {
			Name = "EmptyState",
			Size = UDim2.new(1, -12, 1, 0),
			Position = UDim2.fromOffset(6, 0),
			Text = "No options",
			Font = theme.Font,
			TextSize = theme.FontSize,
			TextColor3 = theme.TextMuted,
			TextTransparency = 0.4,
			BackgroundTransparency = 1,
			ZIndex = 10001,
			Parent = content,
		})
	end

	self._activePopupFrame = popup
	self._activePopupModal = false
	self._activePopupPlacement = placement
	self._activePopupBounds = {
		X = px,
		Y = py,
		Width = w,
		Height = clampedH,
		Placement = placement,
	}
	if placement == "InteriorRight" then
		local initialX = px + w
		popup:TweenPosition(UDim2.fromOffset(initialX, py), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0, true)
		popup.Position = UDim2.fromOffset(initialX, py)
		self:_transition(popup, 0.25, {
			Size = UDim2.fromOffset(w, clampedH),
			Position = UDim2.fromOffset(px, py),
		})
	else
		self:_transition(popup, 0.25, { Size = UDim2.fromOffset(w, clampedH) })
	end
	if self._popupFocusReturn and firstOptionButton and not searchbar then
		game:GetService("GuiService").SelectedObject = firstOptionButton
	end

	-- Close on click outside (generation-guarded: stale invocations after a new popup are no-ops)
	local closeGen = self._popupGen
	self._popupUISCon = uis.InputBegan:Connect(function(input, gpe)
		if gpe then
			return
		end
		if
			input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch
		then
			task.wait()
			if closeGen ~= self._popupGen then
				return
			end -- popup was replaced while yielding
			local activePopup = self._activePopupFrame
			if not activePopup then
				return
			end
			local point, popupPos, popupSize = input.Position, activePopup.AbsolutePosition, activePopup.AbsoluteSize
			local insidePopup = point.X >= popupPos.X
				and point.X <= popupPos.X + popupSize.X
				and point.Y >= popupPos.Y
				and point.Y <= popupPos.Y + popupSize.Y
			if not insidePopup then
				self:HideDropdownPopup()
			end
		end
	end)
	return true
end

function Menu:HideDropdownPopup()
	if self._popupSearchCon then
		self._popupSearchCon:Disconnect()
		self._popupSearchCon = nil
	end
	if self._popupUISCon then
		self._popupUISCon:Disconnect()
		self._popupUISCon = nil
	end
	if self._activePopupFrame then
		local popup = self._activePopupFrame
		local placement = self._activePopupPlacement
		local bounds = self._activePopupBounds
		self._activePopupFrame = nil
		self._activePopupPlacement = nil
		self._activePopupBounds = nil
		local curSize = popup.Size
		local closeProps = { Size = UDim2.fromOffset(0, curSize.Y.Offset) }
		if placement == "InteriorRight" and bounds then
			local rightX = bounds.X + bounds.Width
			closeProps.Position = UDim2.fromOffset(rightX, bounds.Y)
		end
		self:_transition(popup, 0.2, closeProps, Enum.EasingStyle.Quad, Enum.EasingDirection.In, function()
			pcall(function()
				popup:Destroy()
			end)
		end)
	end
	if self._activePopupOverlay then
		self._activePopupOverlay:Destroy()
		self._activePopupOverlay = nil
	end
	if self._popupCloser then
		self._popupCloser:Destroy()
		self._popupCloser = nil
	end
	self._activePopupModal = nil
	self._activePopupPlacement = nil
	self._activePopupBounds = nil
	local focusReturn = self._popupFocusReturn
	self._popupFocusReturn = nil
	self:_restoreTransientFocus(focusReturn)
	if self._activeDropdown then
		self._activeDropdown.Open = false
		if self._activeDropdown._arrow and self._activeDropdown._arrowDown then
			applyIconToLabel(self._activeDropdown._arrow, self._activeDropdown._arrowDown)
		end
		self._activeDropdown = nil
	end
end

function Menu:Tab(options)
	if self._destroyed then
		return nil, "destroyed"
	end
	options = options or {}
	return Tab.new(self, options)
end
