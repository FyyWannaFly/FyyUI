function Menu:_createOverview()
	if not self.StatsConfig.Enabled or self._overviewTab then
		return self._overviewTab
	end
	local theme = self.Theme
	local cfg = self.StatsConfig
	local support = self.SupportConfig
	local tab = Tab.new(self, { Text = cfg.TabName, Icon = cfg.TabIcon, Tooltip = "Account and session overview" })
	self._overviewTab = tab
	tab._isOverview = true
	local root = tab.Container
	root.Name = "OverviewContent"
	root.ScrollBarThickness = 0
	root.ScrollingEnabled = false
	root.CanvasSize = UDim2.fromOffset(0, 0)
	for _, child in ipairs(root:GetChildren()) do
		if child:IsA("UIListLayout") or child:IsA("UIPadding") then
			child:Destroy()
		end
	end

	local themed = {}
	local textStyles = {}
	local icons = {}
	local overviewConns = {}
	local profileEnabled = cfg.ShowProfile
	local infoEnabled = cfg.ShowGame or cfg.ShowServer
	local supportEnabled = cfg.ShowSupport and (support.Discord or support.Callback)
	local contentTop = 40
	local contentBottom = 276
	local sectionGap = 8
	local profileHeight = profileEnabled and 88 or 0
	local infoHeight = infoEnabled and 76 or 0
	local supportHeight = supportEnabled and 56 or 0
	local totalHeight = profileHeight
		+ infoHeight
		+ supportHeight
		+ (profileEnabled and infoEnabled and sectionGap or 0)
		+ (infoEnabled and supportEnabled and sectionGap or 0)
		+ (profileEnabled and not infoEnabled and supportEnabled and sectionGap or 0)
	local sectionY = contentTop + math.max(0, math.floor((contentBottom - contentTop - totalHeight) / 2))
	local function card(name, position, size, radius)
		local frame = U.Create("Frame", {
			Name = name,
			Position = position,
			Size = size,
			BackgroundColor3 = theme.Element,
			BorderSizePixel = 0,
			Parent = root,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(0, radius or 8), Parent = frame })
		local stroke = U.Create("UIStroke", {
			Color = theme.ElementBorder,
			Transparency = 0.6,
			Thickness = 1,
			Parent = frame,
		})
		table.insert(themed, { kind = "card", frame = frame, stroke = stroke })
		return frame
	end
	local function label(parent, text, position, size, font, textSize, color, colorRole, fontRole)
		local value = U.Create("TextLabel", {
			Position = position,
			Size = size,
			BackgroundTransparency = 1,
			Text = text,
			Font = font,
			TextSize = textSize,
			TextColor3 = color,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd,
			Parent = parent,
		})
		table.insert(textStyles, {
			label = value,
			colorRole = colorRole,
			fontRole = fontRole,
		})
		return value
	end

	label(
		root,
		string.upper(cfg.TabName),
		UDim2.fromOffset(2, 0),
		UDim2.new(1, -4, 0, 20),
		theme.FontBold,
		16,
		theme.TextPrimary,
		"TextPrimary",
		"FontBold"
	)
	label(
		root,
		"Your account and current session",
		UDim2.fromOffset(2, 19),
		UDim2.new(1, -4, 0, 16),
		theme.Font,
		13,
		theme.TextMuted,
		"TextMuted",
		"Font"
	)

	local players = game:GetService("Players")
	local player = players.LocalPlayer
	if cfg.ShowProfile then
		local profile = card("Profile", UDim2.new(0, 0, 0, sectionY), UDim2.new(1, 0, 0, profileHeight), 10)
		local accent = U.Create("Frame", {
			Name = "Accent",
			Position = UDim2.fromOffset(0, 12),
			Size = UDim2.fromOffset(3, 64),
			BackgroundColor3 = theme.Accent,
			BorderSizePixel = 0,
			Parent = profile,
		})
		table.insert(themed, { kind = "accent", frame = accent })
		local avatar = U.Create("ImageLabel", {
			Name = "Avatar",
			Position = UDim2.fromOffset(12, 12),
			Size = UDim2.fromOffset(64, 64),
			BackgroundColor3 = theme.ElementHover,
			BorderSizePixel = 0,
			Parent = profile,
		})
		U.Create("UICorner", { CornerRadius = UDim.new(0, 10), Parent = avatar })
		local avatarStroke =
			U.Create("UIStroke", { Color = theme.Accent, Transparency = 0.65, Thickness = 1, Parent = avatar })
		table.insert(themed, { kind = "avatar", frame = avatar, stroke = avatarStroke })
		local displayName = player and player.DisplayName or "Player"
		local userName = player and ("@" .. player.Name) or "@unknown"
		local accountInfo = player and (("%d days · ID %d"):format(player.AccountAge, player.UserId))
			or "Account unavailable"
		label(
			profile,
			displayName,
			UDim2.fromOffset(88, 13),
			UDim2.new(1, -174, 0, 20),
			theme.FontBold,
			16,
			theme.TextPrimary,
			"TextPrimary",
			"FontBold"
		)
		label(
			profile,
			userName,
			UDim2.fromOffset(88, 34),
			UDim2.new(1, -102, 0, 18),
			theme.Font,
			14,
			theme.TextSecondary,
			"TextSecondary",
			"Font"
		)
		label(
			profile,
			accountInfo,
			UDim2.fromOffset(88, 55),
			UDim2.new(1, -102, 0, 16),
			theme.Font,
			13,
			theme.TextMuted,
			"TextMuted",
			"Font"
		)
		label(
			profile,
			"● Ready",
			UDim2.new(1, -80, 0, 14),
			UDim2.fromOffset(68, 18),
			theme.FontBold,
			13,
			Color3.fromRGB(70, 220, 120),
			"Status",
			"FontBold"
		).TextXAlignment =
			Enum.TextXAlignment.Right
		if player then
			task.spawn(function()
				local ok, image = pcall(
					players.GetUserThumbnailAsync,
					players,
					player.UserId,
					Enum.ThumbnailType.HeadShot,
					Enum.ThumbnailSize.Size150x150
				)
				if ok and avatar and avatar.Parent then
					avatar.Image = image
				end
			end)
		end
	end

	if profileEnabled then
		sectionY += profileHeight + ((infoEnabled or supportEnabled) and sectionGap or 0)
	end
	local showGame, showServer = cfg.ShowGame, cfg.ShowServer
	local rowY = sectionY
	local rowGap = 8
	local function infoCard(name, xScale, xOffset, widthScale, widthOffset, iconName)
		local info = card(name, UDim2.new(xScale, xOffset, 0, rowY), UDim2.new(widthScale, widthOffset, 0, 76), 8)
		local icon = renderIcon(info, iconName, {
			Size = UDim2.fromOffset(16, 16),
			Position = UDim2.new(1, -26, 0, 10),
			ImageColor3 = theme.TextMuted,
		})
		if icon then
			table.insert(icons, { icon = icon, role = "TextMuted" })
		end
		return info
	end
	local gameCard = showGame
		and infoCard("Game", 0, 0, showServer and 0.5 or 1, showServer and -(rowGap / 2) or 0, "gamepad-2")
	local serverCard = showServer
		and infoCard(
			"Server",
			showGame and 0.5 or 0,
			showGame and (rowGap / 2) or 0,
			showGame and 0.5 or 1,
			showGame and -(rowGap / 2) or 0,
			"server"
		)
	if gameCard then
		label(
			gameCard,
			"GAME",
			UDim2.fromOffset(12, 8),
			UDim2.new(1, -44, 0, 16),
			theme.FontBold,
			12,
			theme.TextMuted,
			"TextMuted",
			"FontBold"
		)
		local gameName = label(
			gameCard,
			"Current Experience",
			UDim2.fromOffset(12, 29),
			UDim2.new(1, -24, 0, 19),
			theme.FontBold,
			15,
			theme.TextPrimary,
			"TextPrimary",
			"FontBold"
		)
		label(
			gameCard,
			"Place " .. tostring(game.PlaceId),
			UDim2.fromOffset(12, 51),
			UDim2.new(1, -24, 0, 15),
			theme.Font,
			12,
			theme.TextMuted,
			"TextMuted",
			"Font"
		)
		task.spawn(function()
			local marketplace = game:GetService("MarketplaceService")
			local fetched, details = pcall(marketplace.GetProductInfo, marketplace, game.PlaceId)
			if fetched and details and gameName and gameName.Parent then
				gameName.Text = details.Name or gameName.Text
			end
		end)
	end
	if serverCard then
		label(
			serverCard,
			"SERVER",
			UDim2.fromOffset(12, 8),
			UDim2.new(1, -44, 0, 16),
			theme.FontBold,
			12,
			theme.TextMuted,
			"TextMuted",
			"FontBold"
		)
		local playerCount = label(
			serverCard,
			"",
			UDim2.fromOffset(12, 29),
			UDim2.new(1, -24, 0, 19),
			theme.FontBold,
			15,
			theme.TextPrimary,
			"TextPrimary",
			"FontBold"
		)
		local function updatePlayers()
			if playerCount and playerCount.Parent then
				playerCount.Text = ("%d / %d Players"):format(#players:GetPlayers(), players.MaxPlayers)
			end
		end
		updatePlayers()
		label(
			serverCard,
			"● Connected",
			UDim2.fromOffset(12, 51),
			UDim2.new(1, -24, 0, 15),
			theme.Font,
			12,
			Color3.fromRGB(70, 220, 120),
			"Status",
			"Font"
		)
		table.insert(overviewConns, players.PlayerAdded:Connect(updatePlayers))
		table.insert(self._overviewConns, overviewConns[#overviewConns])
		table.insert(
			overviewConns,
			players.PlayerRemoving:Connect(function()
				task.defer(updatePlayers)
			end)
		)
		table.insert(self._overviewConns, overviewConns[#overviewConns])
	end

	if infoEnabled then
		sectionY += infoHeight + (supportEnabled and sectionGap or 0)
	end
	if supportEnabled then
		local supportCard = card("Support", UDim2.new(0, 0, 0, sectionY), UDim2.new(1, 0, 0, supportHeight), 8)
		label(
			supportCard,
			support.Title or "Need Support?",
			UDim2.fromOffset(12, 8),
			UDim2.new(1, -158, 0, 19),
			theme.FontBold,
			15,
			theme.TextPrimary,
			"TextPrimary",
			"FontBold"
		)
		label(
			supportCard,
			support.Description or "Get help or join the community",
			UDim2.fromOffset(12, 29),
			UDim2.new(1, -158, 0, 16),
			theme.Font,
			12,
			theme.TextMuted,
			"TextMuted",
			"Font"
		)
		local button = U.Create("ImageButton", {
			Name = "SupportButton",
			Position = UDim2.new(1, -138, 0.5, -14),
			Size = UDim2.fromOffset(126, 28),
			BackgroundColor3 = theme.ElementHover,
			AutoButtonColor = false,
			Parent = supportCard,
		})
		self:_makeSelectable(button)
		U.Create("UICorner", { CornerRadius = UDim.new(0, 7), Parent = button })
		local buttonStroke =
			U.Create("UIStroke", { Color = theme.Accent, Transparency = 0.5, Thickness = 1, Parent = button })
		local supportIcon = renderIcon(
			button,
			support.ButtonIcon or "message-circle",
			{ Size = UDim2.fromOffset(15, 15), Position = UDim2.fromOffset(9, 7), ImageColor3 = theme.TextPrimary }
		)
		if supportIcon then
			table.insert(icons, { icon = supportIcon, role = "TextPrimary" })
		end
		local supportLabel = label(
			button,
			support.ButtonText or "Join Discord",
			UDim2.fromOffset(30, 0),
			UDim2.new(1, -36, 1, 0),
			theme.FontBold,
			13,
			theme.TextPrimary,
			"TextPrimary",
			"FontBold"
		)
		supportLabel.TextXAlignment = Enum.TextXAlignment.Center
		table.insert(themed, { kind = "button", frame = button, stroke = buttonStroke })
		button.Activated:Connect(function()
			local url = support.Discord
			if type(support.Callback) == "function" then
				task.spawn(support.Callback, url)
				return
			end
			local env = type(getgenv) == "function" and getgenv() or _G
			local clipboard = type(env) == "table" and rawget(env, "setclipboard") or nil
			if type(clipboard) == "function" and url then
				local copied = pcall(clipboard, url)
				if copied then
					self:Notify({
						Title = "Discord Copied",
						Content = "Invite link copied to clipboard.",
						Type = "Success",
					})
				else
					self:Notify({ Title = "Discord", Content = url, Type = "Info" })
				end
			elseif url then
				self:Notify({ Title = "Discord", Content = url, Type = "Info" })
			end
		end)
	end
	local baseDestroy = tab.Destroy
	tab.Destroy = function(overview)
		if overview._destroyed then
			return
		end
		for _, connection in ipairs(overviewConns) do
			connection:Disconnect()
			for i = #self._overviewConns, 1, -1 do
				if self._overviewConns[i] == connection then
					table.remove(self._overviewConns, i)
				end
			end
		end
		table.clear(overviewConns)
		if self._overviewTab == overview then
			self._overviewTab = nil
		end
		baseDestroy(overview)
	end
	tab.ApplyTheme = function(overview, newTheme)
		overview.Theme = newTheme
		for _, entry in ipairs(themed) do
			if entry.frame and entry.frame.Parent then
				if entry.kind == "accent" then
					entry.frame.BackgroundColor3 = newTheme.Accent
				elseif entry.kind == "button" or entry.kind == "avatar" then
					entry.frame.BackgroundColor3 = newTheme.ElementHover
				else
					entry.frame.BackgroundColor3 = newTheme.Element
				end
			end
			if entry.stroke and entry.stroke.Parent then
				entry.stroke.Color = (entry.kind == "button" or entry.kind == "avatar") and newTheme.Accent
					or newTheme.ElementBorder
			end
		end
		for _, entry in ipairs(textStyles) do
			if entry.label and entry.label.Parent then
				entry.label.Font = newTheme[entry.fontRole]
				entry.label.TextColor3 = entry.colorRole == "Status" and Color3.fromRGB(70, 220, 120)
					or newTheme[entry.colorRole]
			end
		end
		for _, entry in ipairs(icons) do
			if entry.icon and entry.icon.Parent then
				if entry.icon:IsA("ImageLabel") then
					entry.icon.ImageColor3 = newTheme[entry.role]
				elseif entry.icon:IsA("TextLabel") then
					entry.icon.TextColor3 = newTheme[entry.role]
				end
			end
		end
		theme = newTheme
		Tab.ApplyTheme(overview, newTheme)
	end

	tab._overviewThemed = themed
	return tab
end
