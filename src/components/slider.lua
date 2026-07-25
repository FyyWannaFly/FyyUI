--[[ Slider ]]
local Slider = {}
Slider.__index = Slider

function Slider.new(parent, options, theme)
	local self = setmetatable({}, Slider)
	self.Text = options.Text or "Slider"
	self.Description = options.Description
	self.Min = options.Min == nil and 0 or options.Min
	self.Max = options.Max == nil and 100 or options.Max
	self.Step = options.Step == nil and 1 or options.Step
	assert(
		isFiniteNumber(self.Min) and isFiniteNumber(self.Max) and self.Min <= self.Max,
		"FyyUI Slider: Min and Max must be finite numbers with Min <= Max"
	)
	assert(isFiniteNumber(self.Step) and self.Step > 0, "FyyUI Slider: Step must be a finite number greater than zero")
	local default = options.Default == nil and self.Min or options.Default
	assert(isFiniteNumber(default), "FyyUI Slider: Default must be a finite number")
	self.Value = math.clamp(default, self.Min, self.Max)
	self.Suffix = options.Suffix or ""
	self.Callback = options.Callback or function() end
	self.Flag = options.Flag
	self.Theme = theme
	self.HasDesc = self.Description ~= nil and self.Description ~= ""
	self._inOneToOneColumn = options._inOneToOneColumn == true
	local baseH = self.HasDesc and theme.DescHeight or theme.ElementHeight
	local h = self._inOneToOneColumn and (baseH + 20) or baseH
	local trackW = 110
	local trackX = -(trackW + 74)
	local textWidth = self._inOneToOneColumn and -88 or -(trackW + 100)
	local textY = self.HasDesc and 6 or (self._inOneToOneColumn and 7 or (h + 6 - 20) / 2 + 1)

	self.Container = U.Create("Frame", {
		Name = "Slider",
		Size = UDim2.new(1, -12, 0, h + 6),
		Position = UDim2.fromOffset(6, 0),
		BackgroundColor3 = theme.Element,
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		Parent = parent,
	})
	U.Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = self.Container })
	U.Create("UIStroke", { Color = theme.ElementBorder, Transparency = 0.6, Thickness = 1, Parent = self.Container })

	self.Label = U.Create("TextLabel", {
		Name = "Label",
		Size = UDim2.new(1, textWidth, 0, 20),
		Position = UDim2.fromOffset(10, textY),
		BackgroundTransparency = 1,
		Text = self.Text,
		Font = theme.Font,
		TextSize = theme.FontSize,
		TextColor3 = theme.TextPrimary,
		TextXAlignment = Enum.TextXAlignment.Left,
		RichText = true,
		Parent = self.Container,
	})

	self.ValueLabel = U.Create("TextLabel", {
		Name = "Value",
		Size = UDim2.fromOffset(54, 20),
		Position = UDim2.new(1, -68, 0, textY),
		BackgroundTransparency = 1,
		Text = tostring(self.Value) .. self.Suffix,
		Font = theme.FontBold,
		TextSize = theme.FontSize,
		TextColor3 = theme.Accent,
		TextXAlignment = Enum.TextXAlignment.Right,
		RichText = true,
		Parent = self.Container,
	})

	local trackH = 8
	local fillPct = (self.Max ~= self.Min) and (self.Value - self.Min) / (self.Max - self.Min) or 0

	self.Track = U.Create("Frame", {
		Name = "Track",
		Size = self._inOneToOneColumn and UDim2.new(1, -24, 0, trackH) or UDim2.fromOffset(trackW, trackH),
		Position = self._inOneToOneColumn and UDim2.new(0, 12, 1, -18) or UDim2.new(1, trackX, 0.5, -(trackH / 2)),
		BackgroundColor3 = theme.ToggleOff,
		BorderSizePixel = 0,
		Parent = self.Container,
	})
	U.Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = self.Track })

	self.Fill = U.Create("Frame", {
		Name = "Fill",
		Size = UDim2.new(fillPct, 0, 1, 0),
		BackgroundColor3 = theme.Accent,
		BorderSizePixel = 0,
		Parent = self.Track,
	})
	U.Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = self.Fill })

	local knobSize = 14
	self.Knob = U.Create("ImageButton", {
		Name = "Knob",
		Size = UDim2.fromOffset(knobSize, knobSize),
		BackgroundColor3 = theme.Accent,
		AutoButtonColor = false,
		ZIndex = 2,
		Parent = self.Track,
	})
	U.Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = self.Knob })
	U.Create(
		"UIStroke",
		{ Color = Color3.fromRGB(255, 255, 255), Transparency = 0.5, Thickness = 1.5, Parent = self.Knob }
	)
	self:_updateKnobPos()

	local uis = game:GetService("UserInputService")

	local function roundToStep(v)
		return math.round(v / self.Step) * self.Step
	end

	local dragging = false
	local activeTrackTouch = false
	local function valueFromInput(input)
		local absPos = self.Track.AbsolutePosition.X
		local size = self.Track.AbsoluteSize.X
		if size <= 0 then
			return nil
		end
		local pct = math.clamp((input.Position.X - absPos) / size, 0, 1)
		local val = self.Min + (self.Max - self.Min) * pct
		return math.clamp(roundToStep(val), self.Min, self.Max)
	end
	self.Knob.InputBegan:Connect(function(input)
		local t = input.UserInputType
		if t == Enum.UserInputType.MouseButton1 or t == Enum.UserInputType.Touch then
			dragging = true
			if t == Enum.UserInputType.Touch then
				activeTrackTouch = true
			end
		end
	end)
	local dragCon
	dragCon = uis.InputChanged:Connect(function(input, processed)
		local t = input.UserInputType
		if t ~= Enum.UserInputType.MouseMovement and t ~= Enum.UserInputType.Touch then
			return
		end
		if dragging then
			if processed and t == Enum.UserInputType.MouseMovement then
				return
			end
			local val = valueFromInput(input)
			if val then
				self:SetValue(val)
			end
		end
	end)
	self.Knob.InputEnded:Connect(function(input)
		local t = input.UserInputType
		if t == Enum.UserInputType.MouseButton1 or t == Enum.UserInputType.Touch then
			dragging = false
			activeTrackTouch = false
		end
	end)
	-- Service-level InputEnded: catches mouse-up even when pointer is no longer over the knob
	self._sliderEndCon = uis.InputEnded:Connect(function(input)
		local t = input.UserInputType
		if t == Enum.UserInputType.MouseButton1 or t == Enum.UserInputType.Touch then
			dragging = false
			activeTrackTouch = false
		end
	end)
	self._dragCon = dragCon

	-- Track input: jump on click or drag on touch
	self.Track.InputBegan:Connect(function(input)
		local t = input.UserInputType
		if t == Enum.UserInputType.Touch then
			dragging = true
			activeTrackTouch = true
		end
		if t == Enum.UserInputType.MouseButton1 or t == Enum.UserInputType.Touch then
			local val = valueFromInput(input)
			if val then
				self:SetValue(val)
			end
		end
	end)

	if self.HasDesc then
		U.Create("TextLabel", {
			Name = "Description",
			Size = UDim2.new(1, self._inOneToOneColumn and -24 or -(trackW + 100), 0, 16),
			Position = UDim2.fromOffset(12, 34),
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

	return self
end

function Slider:_updateKnobPos()
	local pct = (self.Max ~= self.Min) and (self.Value - self.Min) / (self.Max - self.Min) or 0
	pct = math.clamp(pct, 0, 1)
	self.Knob.Position = UDim2.new(pct, -7, 0.5, -7)
end

function Slider:SetValue(v, noCallback)
	local isDestroyed, result, err = destroyedResult(self)
	if isDestroyed then
		return result, err
	end
	if not isFiniteNumber(v) then
		return false, "expected finite number"
	end
	v = math.clamp(v, self.Min, self.Max)
	if self.Value == v then
		return true
	end
	self.Value = v
	local pct = (self.Max ~= self.Min) and (v - self.Min) / (self.Max - self.Min) or 0
	pct = math.clamp(pct, 0, 1)
	self.Fill.Size = UDim2.new(pct, 0, 1, 0)
	self.Knob.Position = UDim2.new(pct, -7, 0.5, -7)
	self.ValueLabel.Text = tostring(v) .. self.Suffix
	if not noCallback then
		task.spawn(function()
			self.Callback(v)
		end)
	end
	return true
end

function Slider:GetValue()
	return self.Value
end
function Slider:Destroy()
	if self._destroyed then
		return
	end
	cleanupController(self)
	if self._dragCon then
		self._dragCon:Disconnect()
	end
	if self._sliderEndCon then
		self._sliderEndCon:Disconnect()
	end
	if self.Container then
		self.Container:Destroy()
	end
end

function Slider:ApplyTheme(theme)
	self.Theme = theme
	if not self.Container then
		return
	end
	self.Container.BackgroundColor3 = theme.Element
	local stroke = self.Container:FindFirstChildOfClass("UIStroke")
	if stroke then
		stroke.Color = theme.ElementBorder
	end
	self.Label.Font = theme.Font
	self.Label.TextSize = theme.FontSize
	self.Label.TextColor3 = theme.TextPrimary
	self.ValueLabel.Font = theme.FontBold
	self.ValueLabel.TextSize = theme.FontSize
	self.ValueLabel.TextColor3 = theme.Accent
	local desc = self.Container:FindFirstChild("Description")
	if desc then
		desc.Font = theme.Font
		desc.TextSize = theme.FontSizeSmall
		desc.TextColor3 = theme.TextMuted
	end
	self.Track.BackgroundColor3 = theme.ToggleOff
	self.Fill.BackgroundColor3 = theme.Accent
	self.Knob.BackgroundColor3 = theme.Accent
end
