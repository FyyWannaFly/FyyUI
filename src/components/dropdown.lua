--[[ Dropdown ]]
local Dropdown = {}
Dropdown.__index = Dropdown

function Dropdown.new(parent, options, theme, menuRef)
	local self = setmetatable({}, Dropdown)
	self._menu = menuRef
	self.Text = options.Text or "Dropdown"
	self.Description = options.Description
	assert(options.Options == nil or type(options.Options) == "table", "FyyUI Dropdown: Options must be a table")
	self.Options = options.Options or {}
	local function hasOption(value)
		for _, option in ipairs(self.Options) do
			if option == value then
				return true
			end
		end
		return false
	end
	self.Multi = options.Multi or false -- Multi-Select mode
	-- AllowNone: if false, single-select always retains a valid option when options exist
	self.AllowNone = options.AllowNone
	if self.AllowNone == nil then
		self.AllowNone = true
	end
	self.Value = "" -- start empty; use Default to pre-select
	if options.Default ~= nil then
		self.Value = options.Default
	elseif self.Options[1] and not options.Placeholder then
		self.Value = self.Options[1] -- backward compat: auto-select first
	end
	-- AllowNone=false: ensure a valid selection when options exist
	if not self.Multi and not self.AllowNone and #self.Options > 0 and (self.Value == nil or self.Value == "") then
		self.Value = self.Options[1]
	end
	if not self.Multi and self.Value ~= nil and self.Value ~= "" and not hasOption(self.Value) then
		self.Value = self.AllowNone and "" or self.Options[1] or ""
	end
	self.Placeholder = options.Placeholder or "Not selected"
	self._selected = {} -- set of selected values (multi mode)
	self._selectedCount = 0
	if self.Multi then
		local defaults = {}
		if type(options.Default) == "table" then
			defaults = options.Default
		elseif options.Default ~= nil then
			defaults = { options.Default }
		end
		for _, v in ipairs(defaults) do
			if hasOption(v) and not self._selected[v] then
				self._selected[v] = true
				self._selectedCount = self._selectedCount + 1
			end
		end
	end
	self.Callback = options.Callback or function() end
	self.Flag = options.Flag
	self.Theme = theme
	self.Open = false
	self.HasDesc = self.Description ~= nil and self.Description ~= ""
	local h = self.HasDesc and theme.DescHeight or theme.ElementHeight
	local btnW = options._compactControl and 88 or 100

	self.Container = U.Create("Frame", {
		Name = "Dropdown",
		Size = UDim2.new(1, -12, 0, h + 6),
		Position = UDim2.fromOffset(6, 0),
		BackgroundColor3 = theme.Element,
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		Parent = parent,
	})
	U.Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = self.Container })
	U.Create("UIStroke", { Color = theme.ElementBorder, Transparency = 0.6, Thickness = 1, Parent = self.Container })

	U.Create("TextLabel", {
		Name = "Label",
		Size = UDim2.new(1, -(btnW + 28), 0, 20),
		Position = UDim2.fromOffset(10, self.HasDesc and 6 or (h + 6 - 20) / 2 + 1),
		BackgroundTransparency = 1,
		Text = self.Text,
		Font = theme.Font,
		TextSize = theme.FontSize,
		TextColor3 = theme.TextPrimary,
		TextXAlignment = Enum.TextXAlignment.Left,
		RichText = true,
		Parent = self.Container,
	})

	self.SelectBtn = U.Create("ImageButton", {
		Name = "Select",
		Size = UDim2.fromOffset(btnW, 26),
		Position = UDim2.new(1, -(btnW + 12), 0.5, -13),
		BackgroundColor3 = theme.ElementHover,
		AutoButtonColor = false,
		Parent = self.Container,
	})
	U.Create("UICorner", { CornerRadius = UDim.new(0, 6), Parent = self.SelectBtn })
	self._selectStroke = U.Create("UIStroke", {
		Color = theme.Accent,
		Thickness = 1,
		Transparency = self.Value and (self.Value ~= "" and self.Value ~= (self.Options[1] or "")) and 0.5 or 0.8,
		Parent = self.SelectBtn,
	})

	local function initSelectText()
		return self:_displayText()
	end
	local function initSelectColor()
		if self.Multi then
			return self._selectedCount > 0 and theme.TextPrimary or theme.TextMuted
		end
		return (self.Value and self.Value ~= "") and theme.TextPrimary or theme.TextMuted
	end
	self.SelectText = U.Create("TextLabel", {
		Name = "Text",
		Size = UDim2.new(1, -24, 1, 0),
		Position = UDim2.fromOffset(6, 0),
		BackgroundTransparency = 1,
		Text = initSelectText(),
		TextColor3 = initSelectColor(),
		Font = theme.Font,
		TextSize = theme.FontSize,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextTruncate = Enum.TextTruncate.AtEnd,
		Parent = self.SelectBtn,
	})

	self._arrowDown = resolveIcon("chevron-down") or { Image = "rbxassetid://134243273101015" }
	self._arrowRight = resolveIcon("chevron-right") or { Image = "rbxassetid://92473583511724" }
	self._arrow = renderIcon(self.SelectBtn, "chevron-down", {
		Name = "Arrow",
		Size = UDim2.fromOffset(16, 16),
		Position = UDim2.new(1, -20, 0.5, -8),
	})

	-- Find selected index
	local selectedIdx = 0
	for i, opt in ipairs(self.Options) do
		if opt == self.Value then
			selectedIdx = i
			break
		end
	end

	-- Dropdown toggle
	self.SelectBtn.Activated:Connect(function()
		if not self._menu then
			return
		end
		if self._menu._activePopupFrame then
			self.Open = false
			if self._arrow then
				applyIconToLabel(self._arrow, self._arrowDown)
			end
			if self._menu._activeDropdown == self then
				self._menu._activeDropdown = nil
			end
			self._menu:HideDropdownPopup()
		else
			if self._menu._activeDropdown and self._menu._activeDropdown ~= self then
				self._menu._activeDropdown.Open = false
				if self._menu._activeDropdown._arrow and self._menu._activeDropdown._arrowDown then
					applyIconToLabel(self._menu._activeDropdown._arrow, self._menu._activeDropdown._arrowDown)
				end
				self._menu:HideDropdownPopup()
			end
			local pos = self.SelectBtn.AbsolutePosition
			local siz = self.SelectBtn.AbsoluteSize
			self._selIdx = 0
			for i, opt in ipairs(self.Options) do
				if opt == self.Value then
					self._selIdx = i
					break
				end
			end
			local shown = self._menu:ShowDropdownPopup(pos, siz, self.Options, self._selIdx, function(idx, val)
				self:SetValue(val)
			end, self.Multi, self)
			if shown then
				self.Open = true
				if self._arrow then
					applyIconToLabel(self._arrow, self._arrowRight)
				end
				self._menu._activeDropdown = self
			else
				self.Open = false
				if self._arrow then
					applyIconToLabel(self._arrow, self._arrowDown)
				end
			end
		end
	end)

	if self.HasDesc then
		U.Create("TextLabel", {
			Name = "Description",
			Size = UDim2.new(1, -(btnW + 28), 0, 16),
			Position = UDim2.fromOffset(10, 28),
			BackgroundTransparency = 1,
			Text = self.Description,
			Font = theme.Font,
			TextSize = theme.FontSizeSmall,
			TextColor3 = theme.TextMuted,
			TextXAlignment = Enum.TextXAlignment.Left,
			RichText = true,
			Parent = self.Container,
		})
	end

	-- Tooltip from options
	if options.Tooltip and menuRef then
		menuRef:BindTooltip(self.Container, options.Tooltip)
	end

	return self
end

function Dropdown:_updateDisplay()
	-- Update display text from current state (used by SetOptions/Refresh)
	self.SelectText.Text = self:_displayText()
	if self.Multi then
		self.SelectText.TextColor3 = (self._selectedCount > 0) and self.Theme.TextPrimary or self.Theme.TextMuted
	else
		self.SelectText.TextColor3 = (self.Value ~= "") and self.Theme.TextPrimary or self.Theme.TextMuted
	end
end

function Dropdown:SetValue(v, noCallback)
	local isDestroyed, result, err = destroyedResult(self)
	if isDestroyed then
		return result, err
	end
	if self.Multi then
		-- Multi-select: toggle the value
		if not self:_optIndex(self.Options, v) then
			return false, "unknown option"
		end
		if self._selected[v] then
			self._selected[v] = nil
			self._selectedCount = math.max(0, self._selectedCount - 1)
		else
			self._selected[v] = true
			self._selectedCount = self._selectedCount + 1
		end
		-- Update display text
		self.SelectText.Text = self:_displayText()
		self.SelectText.TextColor3 = (self._selectedCount > 0) and self.Theme.TextPrimary or self.Theme.TextMuted
		if not noCallback then
			local snapshot = self:GetValue()
			task.spawn(function()
				self.Callback(snapshot)
			end)
		end
		return true
	end

	-- Single-select
	if v == self.Value then
		if self.AllowNone then
			-- Unselect when AllowNone=true and re-clicking the active option
			self.Value = ""
			self.SelectText.Text = self.Placeholder
			self.SelectText.TextColor3 = self.Theme.TextMuted
			if self._selectStroke then
				self._selectStroke.Transparency = 0.8
			end
			self._selIdx = 0
			self.Open = false
			if self._arrow then
				applyIconToLabel(self._arrow, self._arrowDown)
			end
			if self._menu and self._menu._activeDropdown == self then
				self._menu._activeDropdown = nil
				self._menu:HideDropdownPopup()
			end
			if not noCallback then
				task.spawn(function()
					self.Callback("")
				end)
			end
			return true
		end
		if self._arrow then
			applyIconToLabel(self._arrow, self._arrowDown)
		end
		if self._menu and self._menu._activeDropdown == self then
			self._menu._activeDropdown = nil
			self._menu:HideDropdownPopup()
		end
		return true
	end
	-- AllowNone guard: prevent clearing selection when AllowNone=false and options exist
	if not self.AllowNone and #self.Options > 0 and v == "" then
		if self._arrow then
			applyIconToLabel(self._arrow, self._arrowDown)
		end
		if self._menu and self._menu._activeDropdown == self then
			self._menu._activeDropdown = nil
			self._menu:HideDropdownPopup()
		end
		return true
	end
	if v ~= "" and not self:_optIndex(self.Options, v) then
		return false, "unknown option"
	end
	self.Value = v
	self.SelectText.Text = self:_displayText()
	self.SelectText.TextColor3 = (self.Value ~= "") and self.Theme.TextPrimary or self.Theme.TextMuted
	if self._selectStroke then
		self._selectStroke.Transparency = (self.Value ~= "") and 0.5 or 0.8
	end
	self._selIdx = 0
	for i, opt in ipairs(self.Options) do
		if opt == v then
			self._selIdx = i
			break
		end
	end
	self.Open = false
	if self._arrow then
		applyIconToLabel(self._arrow, self._arrowDown)
	end
	if self._menu and self._menu._activeDropdown == self then
		self._menu._activeDropdown = nil
		self._menu:HideDropdownPopup()
	end
	if not noCallback then
		task.spawn(function()
			self.Callback(v)
		end)
	end
	return true
end

function Dropdown:GetValue()
	if self.Multi then
		local result = {}
		for _, opt in ipairs(self.Options) do
			if self._selected[opt] then
				table.insert(result, opt)
			end
		end
		return result
	end
	return self.Value
end

function Dropdown:SetOptions(options, preferredValue, noCallback)
	local isDestroyed, result, err = destroyedResult(self)
	if isDestroyed then
		return result, err
	end
	if options == nil then
		options = {}
	end
	if type(options) ~= "table" then
		return false, "expected options table"
	end
	local oldValue = self:GetValue()
	local function sameSelection(a, b)
		if type(a) ~= "table" or type(b) ~= "table" then
			return a == b
		end
		if #a ~= #b then
			return false
		end
		for i, value in ipairs(a) do
			if b[i] ~= value then
				return false
			end
		end
		return true
	end

	-- Replace options list
	self.Options = {}
	for i, option in ipairs(options) do
		self.Options[i] = option
	end
	options = self.Options

	if self.Multi then
		-- Multi: remove selections that no longer exist in new options
		local optSet = {}
		for _, opt in ipairs(options) do
			optSet[opt] = true
		end
		for k in pairs(self._selected) do
			if not optSet[k] then
				self._selected[k] = nil
				self._selectedCount = math.max(0, self._selectedCount - 1)
			end
		end
	else
		-- Single-select: determine new value
		local newValue
		if preferredValue ~= nil then
			if self:_optIndex(options, preferredValue) then
				newValue = preferredValue
			elseif #options == 0 or self.AllowNone then
				newValue = ""
			else
				newValue = options[1]
			end
		elseif self.Value ~= "" and self:_optIndex(options, self.Value) then
			newValue = self.Value
		elseif #options == 0 or self.AllowNone then
			newValue = ""
		else
			newValue = options[1]
		end

		self.Value = newValue

		-- Update stroke
		if self._selectStroke then
			self._selectStroke.Transparency = (self.Value ~= "" and self.Value ~= (options[1] or "")) and 0.5 or 0.8
		end

		-- Update _selIdx
		self._selIdx = 0
		for i, opt in ipairs(options) do
			if opt == self.Value then
				self._selIdx = i
				break
			end
		end
	end

	-- Update display text
	self:_updateDisplay()

	-- Handle active popup: close and optionally re-open with new options
	if self._menu and self._menu._activeDropdown == self and self._menu._activePopupFrame then
		self._menu._activeDropdown = nil
		self._menu:HideDropdownPopup()
		if #options > 0 then
			local pos = self.SelectBtn.AbsolutePosition
			local siz = self.SelectBtn.AbsoluteSize
			local selIdx = 0
			for i, opt in ipairs(options) do
				if opt == self.Value then
					selIdx = i
					break
				end
			end
			local shown = self._menu:ShowDropdownPopup(pos, siz, options, selIdx, function(idx, val)
				self:SetValue(val)
			end, self.Multi, self)
			if shown then
				self.Open = true
				self._menu._activeDropdown = self
			else
				self.Open = false
				if self._arrow then
					applyIconToLabel(self._arrow, self._arrowDown)
				end
			end
		end
	end

	-- Fire callback if selection changed (and noCallback is not set)
	if not noCallback then
		if self.Multi then
			local newValue = self:GetValue()
			if not sameSelection(oldValue, newValue) then
				task.spawn(function()
					self.Callback(newValue)
				end)
			end
		else
			local newValue = self.Value
			if newValue ~= oldValue then
				task.spawn(function()
					self.Callback(newValue)
				end)
			end
		end
	end
	return true
end

-- Canonical display-summary helper used by constructor, _updateDisplay, SetValue, SetOptions/Refresh.
-- Single: shows value or Placeholder when empty.
-- Multi: shows Placeholder when empty; first option text when one selected;
--        "First +N-1" when multiple selected (N = total selected count).
function Dropdown:_displayText()
	if self.Multi then
		if self._selectedCount == 0 then
			return self.Placeholder
		end
		local first
		local extras = 0
		for _, opt in ipairs(self.Options) do
			if self._selected[opt] then
				if first == nil then
					first = opt
				else
					extras = extras + 1
				end
			end
		end
		if extras == 0 then
			return tostring(first)
		end
		return tostring(first) .. " +" .. extras
	end
	return (self.Value ~= "") and tostring(self.Value) or self.Placeholder
end

function Dropdown:_optIndex(list, value)
	for i, v in ipairs(list) do
		if v == value then
			return i
		end
	end
	return nil
end

function Dropdown:Refresh(options, preferredValue, noCallback)
	if options ~= nil then
		return self:SetOptions(options, preferredValue, noCallback)
	else
		-- Refresh from current options, preserve current selection
		return self:SetOptions(self.Options, self.Value, noCallback)
	end
end

function Dropdown:Destroy()
	if self._destroyed then
		return
	end
	cleanupController(self)
	if self.Container then
		self.Container:Destroy()
	end
end

function Dropdown:ApplyTheme(theme)
	self.Theme = theme
	if not self.Container then
		return
	end
	self.Container.BackgroundColor3 = theme.Element
	local stroke = self.Container:FindFirstChildOfClass("UIStroke")
	if stroke then
		stroke.Color = theme.ElementBorder
	end
	local lbl = self.Container:FindFirstChild("Label")
	if lbl then
		lbl.Font = theme.Font
		lbl.TextSize = theme.FontSize
		lbl.TextColor3 = theme.TextPrimary
	end
	local desc = self.Container:FindFirstChild("Description")
	if desc then
		desc.Font = theme.Font
		desc.TextSize = theme.FontSizeSmall
		desc.TextColor3 = theme.TextMuted
	end
	self.SelectBtn.BackgroundColor3 = theme.ElementHover
	self.SelectText.Font = theme.Font
	self.SelectText.TextSize = theme.FontSize
	self.SelectText.TextColor3 = theme.TextPrimary
	if self._selectStroke then
		self._selectStroke.Color = theme.Accent
	end
end
