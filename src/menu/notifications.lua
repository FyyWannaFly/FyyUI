function Menu:Notify(options)
	if self._destroyed or not self.NotifBox then
		return nil, "destroyed"
	end
	options = options or {}
	local title = options.Title or ""
	local content = options.Content or (options.Text and tostring(options.Text)) or ""
	local duration = options.Duration == nil and 3 or options.Duration
	assert(isFiniteNumber(duration) and duration >= 0, "FyyUI Notify: Duration must be a non-negative finite number")
	local notifType = options.Type or "Info"
	local theme = self.Theme

	-- Type configuration: accent + Lucide icon
	local typeDefs = {
		Info = { accent = Color3.fromRGB(0, 130, 250), icon = "info" },
		Success = { accent = Color3.fromRGB(0, 180, 80), icon = "circle-check" },
		Warning = { accent = Color3.fromRGB(220, 180, 40), icon = "triangle-alert" },
		Error = { accent = Color3.fromRGB(220, 60, 60), icon = "circle-x" },
	}
	local cfg = typeDefs[notifType] or typeDefs.Info
	local iconData = resolveIcon(cfg.icon)

	-- Layout constants
	local PAD = 12
	local GAP = 5
	local CARD_W = 320
	local ICON_SZ = 20
	local hasTitle = title ~= ""
	local hasContent = content ~= ""

	-- Compute content text height
	local contentW = CARD_W - PAD * 2
	local contentH = 0
	local textSvc = game:GetService("TextService")
	if hasContent then
		local sz = textSvc:GetTextSize(content, theme.FontSize, theme.Font, Vector2.new(contentW, 1000))
		contentH = sz.Y
	end

	-- Card height: top pad + icon row + (gap + content) + bottom pad + progress bar
	local bodyTop = PAD + ICON_SZ
	if hasContent then
		bodyTop = bodyTop + GAP + contentH
	end
	local cardH = math.max(bodyTop + PAD + 3, 54)

	-- ── Build card ──
	local frame = U.Create("Frame", {
		Name = "Notification",
		Size = UDim2.fromOffset(CARD_W, cardH),
		BackgroundColor3 = theme.Element,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		Parent = self.NotifBox,
	})
	U.Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = frame })
	U.Create("UIStroke", { Color = theme.ElementBorder, Transparency = 0.6, Thickness = 1, Parent = frame })

	-- Icon
	if iconData and iconData.Image then
		U.Create("ImageLabel", {
			Name = "Icon",
			Size = UDim2.fromOffset(ICON_SZ, ICON_SZ),
			Position = UDim2.fromOffset(PAD, PAD),
			BackgroundTransparency = 1,
			Image = iconData.Image,
			ImageColor3 = cfg.accent,
			Parent = frame,
		})
	end

	-- Title (right of icon)
	local titleLabel
	if hasTitle then
		local titleX = iconData and (PAD + ICON_SZ + 8) or PAD
		titleLabel = U.Create("TextLabel", {
			Name = "Title",
			Size = UDim2.new(0, CARD_W - titleX - PAD, 0, theme.FontSize + 2),
			Position = UDim2.fromOffset(titleX, PAD),
			BackgroundTransparency = 1,
			Text = title,
			Font = theme.FontBold,
			TextSize = theme.FontSize,
			TextColor3 = theme.TextPrimary,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Top,
			TextWrapped = false,
			Parent = frame,
		})
	end

	-- Content (below icon row, full width)
	local contentLabel
	if hasContent then
		local contentY = PAD + ICON_SZ + GAP
		contentLabel = U.Create("TextLabel", {
			Name = "Content",
			Size = UDim2.new(0, contentW, 0, contentH),
			Position = UDim2.fromOffset(PAD, contentY),
			BackgroundTransparency = 1,
			Text = content,
			Font = theme.Font,
			TextSize = theme.FontSize,
			TextColor3 = theme.TextSecondary,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Top,
			TextWrapped = true,
			Parent = frame,
		})
	end

	-- Progress track + fill (bottom of card)
	local progressTrack = U.Create("Frame", {
		Name = "ProgressTrack",
		Size = UDim2.new(1, -(PAD * 2), 0, 3),
		Position = UDim2.fromOffset(PAD, cardH - 9),
		BackgroundColor3 = theme.ElementHover,
		BorderSizePixel = 0,
		Parent = frame,
	})
	U.Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = progressTrack })
	local progressFill = U.Create("Frame", {
		Name = "ProgressFill",
		Size = UDim2.new(1, 0, 1, 0),
		Position = UDim2.fromOffset(0, 0),
		BackgroundColor3 = cfg.accent,
		BorderSizePixel = 0,
		Parent = progressTrack,
	})
	U.Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = progressFill })

	-- ── Entrance setup ──
	local ts = game:GetService("TweenService")
	local dismissed = false
	local progressTween
	local enterTween
	local dismissTask

	-- Record
	local record = {
		frame = frame,
		h = cardH,
		dismiss = nil,
		posTween = nil,
	}
	table.insert(self._activeNotifs, record)
	frame.AnchorPoint = Vector2.new(0, 1)
	self:_reflowNotifs(not self._reducedMotion, record)
	local bottomOffset = 0
	local GAP_BETWEEN = 4
	for _, rec in ipairs(self._activeNotifs) do
		if rec == record then
			break
		end
		bottomOffset = bottomOffset + rec.h + GAP_BETWEEN
	end
	local targetPosition = UDim2.new(0, 0, 1, -bottomOffset)

	-- Place at entrance offset, then animate to target
	if not self._reducedMotion then
		frame.Position = UDim2.new(0, 24, 1, 0)
		frame.BackgroundTransparency = 1
		for _, child in ipairs(frame:GetChildren()) do
			if child:IsA("TextLabel") then
				child.TextTransparency = 1
			end
			if child:IsA("ImageLabel") then
				child.ImageTransparency = 1
			end
			if child:IsA("Frame") then
				child.BackgroundTransparency = 1
			end
			if child:IsA("UIStroke") then
				child.Transparency = 1
			end
		end
		if progressTrack then
			progressTrack.BackgroundTransparency = 1
		end
		if progressFill then
			progressFill.BackgroundTransparency = 1
		end

		-- Entrance: slide in from right + fade
		enterTween = self:_transition(frame, 0.3, {
			Position = targetPosition,
			BackgroundTransparency = 0,
		}, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

		-- Fade children in alongside
		for _, child in ipairs(frame:GetChildren()) do
			if child:IsA("TextLabel") then
				self:_transition(child, 0.25, { TextTransparency = 0 })
			elseif child:IsA("ImageLabel") then
				self:_transition(child, 0.25, { ImageTransparency = 0 })
			elseif child:IsA("Frame") then
				self:_transition(child, 0.25, { BackgroundTransparency = 0 })
			elseif child:IsA("UIStroke") then
				self:_transition(child, 0.25, { Transparency = 0.6 })
			end
		end
		if progressTrack then
			self:_transition(progressTrack, 0.25, { BackgroundTransparency = 0 })
		end
		if progressFill then
			self:_transition(progressFill, 0.25, { BackgroundTransparency = 0 })
		end
	else
		frame.Position = targetPosition
		frame.BackgroundTransparency = 0
	end

	-- ── Local dismiss function ──
	local function dismiss()
		if dismissed or not frame or not frame.Parent then
			return false
		end
		dismissed = true

		-- Cancel scheduled dismiss & tweens
		if dismissTask then
			task.cancel(dismissTask)
			dismissTask = nil
		end
		if progressTween then
			progressTween:Cancel()
			progressTween = nil
		end
		if enterTween then
			enterTween:Cancel()
			enterTween = nil
		end

		-- Cancel any in-flight positional tween tracked on this record
		if record.posTween then
			record.posTween:Cancel()
			record.posTween = nil
		end

		-- The parent has fixed geometry, so preserving this local Y guarantees
		-- the card cannot move vertically while it exits.
		local exitPosition = frame.Position

		-- Remove from active layout while keeping the live card visible.
		for i, rec in ipairs(self._activeNotifs) do
			if rec.frame == frame then
				table.remove(self._activeNotifs, i)
				break
			end
		end

		if not self._reducedMotion then
			-- Reflow siblings immediately; the exiting card is no longer part of
			-- active layout and keeps its own frozen Y until destruction.
			self:_reflowNotifs(true)

			-- Exit: slide only on X. Y is copied without modification.
			self:_transition(
				frame,
				0.3,
				{
					Position = UDim2.new(
						exitPosition.X.Scale,
						exitPosition.X.Offset + 40,
						exitPosition.Y.Scale,
						exitPosition.Y.Offset
					),
					BackgroundTransparency = 1,
				},
				Enum.EasingStyle.Quint,
				Enum.EasingDirection.In,
				function()
					if frame and frame.Parent then
						frame:Destroy()
					end
				end
			)
			for _, child in ipairs(frame:GetDescendants()) do
				if child:IsA("TextLabel") then
					self:_transition(child, 0.2, { TextTransparency = 1 })
				elseif child:IsA("ImageLabel") then
					self:_transition(child, 0.2, { ImageTransparency = 1 })
				elseif child:IsA("Frame") then
					self:_transition(child, 0.2, { BackgroundTransparency = 1 })
				elseif child:IsA("UIStroke") then
					self:_transition(child, 0.2, { Transparency = 1 })
				end
			end
		else
			-- ReducedMotion: destroy + reflow immediately
			if frame then
				frame:Destroy()
			end
			self:_reflowNotifs(false)
		end
		return true
	end
	record.dismiss = dismiss

	-- ── Auto-dismiss ──
	if duration > 0 then
		if not self._reducedMotion then
			progressTween = ts:Create(progressFill, TweenInfo.new(duration, Enum.EasingStyle.Linear), {
				Size = UDim2.new(0, 0, 1, 0),
			})
			progressTween:Play()
		end
		dismissTask = task.delay(duration, function()
			if self._destroyed or dismissed or not frame or not frame.Parent then
				return
			end
			dismissTask = nil
			dismiss()
		end)
	end

	-- ── Handle ──
	local handle = {}
	function handle:Dismiss()
		return dismiss()
	end
	function handle:Update(...)
		if dismissed or not frame or not frame.Parent then
			return false, "dismissed"
		end
		local args = { ... }
		-- Backward-compat: single arg updates Content, clears Title
		if #args == 1 and type(args[1]) == "string" then
			content = args[1]
			title = ""
			hasTitle = false
			hasContent = content ~= ""
		elseif #args >= 2 then
			title = tostring(args[1] or "")
			content = tostring(args[2] or "")
			hasTitle = title ~= ""
			hasContent = content ~= ""
		end

		-- Recalculate height
		contentH = 0
		if hasContent then
			local sz = textSvc:GetTextSize(content, theme.FontSize, theme.Font, Vector2.new(contentW, 1000))
			contentH = sz.Y
		end
		local newBodyTop = PAD + ICON_SZ
		if hasContent then
			newBodyTop = newBodyTop + GAP + contentH
		end
		local newCardH = math.max(newBodyTop + PAD + 3, 54)

		-- Update labels
		if titleLabel then
			titleLabel.Text = title
			titleLabel.Visible = hasTitle
		elseif hasTitle then
			-- Need to create title label
			local titleX = iconData and (PAD + ICON_SZ + 8) or PAD
			titleLabel = U.Create("TextLabel", {
				Name = "Title",
				Size = UDim2.new(0, CARD_W - titleX - PAD, 0, theme.FontSize + 2),
				Position = UDim2.fromOffset(titleX, PAD),
				BackgroundTransparency = 1,
				Text = title,
				Font = theme.FontBold,
				TextSize = theme.FontSize,
				TextColor3 = theme.TextPrimary,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Top,
				TextWrapped = false,
				Parent = frame,
			})
		end
		if not hasTitle and titleLabel then
			titleLabel.Visible = false
		end

		if contentLabel then
			contentLabel.Text = content
			contentLabel.Size = UDim2.new(0, contentW, 0, contentH)
			local newContentY = PAD + ICON_SZ + GAP
			contentLabel.Position = UDim2.fromOffset(PAD, newContentY)
			contentLabel.Visible = hasContent
		elseif hasContent then
			local contentY = PAD + ICON_SZ + GAP
			contentLabel = U.Create("TextLabel", {
				Name = "Content",
				Size = UDim2.new(0, contentW, 0, contentH),
				Position = UDim2.fromOffset(PAD, contentY),
				BackgroundTransparency = 1,
				Text = content,
				Font = theme.Font,
				TextSize = theme.FontSize,
				TextColor3 = theme.TextSecondary,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Top,
				TextWrapped = true,
				Parent = frame,
			})
		end
		if not hasContent and contentLabel then
			contentLabel.Visible = false
		end

		-- Update frame size
		frame.Size = UDim2.fromOffset(CARD_W, newCardH)
		record.h = newCardH
		progressTrack.Position = UDim2.fromOffset(PAD, newCardH - 9)

		-- Reflow siblings
		self:_reflowNotifs(not self._reducedMotion)
		return true
	end

	return handle
end

function Menu:_reflowNotifs(animated, excludedRecord)
	if self._destroyed or not self._activeNotifs then
		return
	end
	if animated and self._reducedMotion then
		animated = false
	end
	local bottomOffset = 0
	local GAP = 4
	for i = 1, #self._activeNotifs do
		local rec = self._activeNotifs[i]
		local frame = rec.frame
		local target = UDim2.new(0, 0, 1, -bottomOffset)
		if rec ~= excludedRecord then
			bottomOffset = bottomOffset + rec.h + GAP
		end
		if rec ~= excludedRecord and frame and frame.Parent then
			if animated then
				-- Cancel any existing positional tween before starting a new one
				if rec.posTween then
					rec.posTween:Cancel()
					rec.posTween = nil
				end
				rec.posTween = self:_transition(frame, 0.25, {
					Position = target,
				}, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
			else
				frame.Position = target
			end
		end
	end
end
