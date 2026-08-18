--[[ Description Card ]]
-- Info card with optional Title / Description / Footer / Status fields.
-- Layout metrics replicate the proven AutoSpearInfo card: dark cardbox,
-- 9px corner, stroke 0.35, accent bar (theme.Accent) left, Title GothamBold
-- 13px. Rows lay out top-down; Description/Footer/Status support multi-line
-- text ("\n") and the card grows to fit. Accent bar spans full card height.
-- Runtime: SetTitle / SetInfo / SetFooter / SetStatus update text live and
-- trigger a full relayout so height/positions stay correct.
local Description = {}
Description.__index = Description

local PAD_TOP = 6
local PAD_BOTTOM = 10
local ROW_GAPS = { 6, 4, 4 } -- gap dari BOTTOM row-i ke TOP row berikutnya
local ROW_H = { 16, 16, 14, 16 } -- base height per row kind
local LINE_H = 14 -- extra height per wrapped line

local TextService = game:GetService("TextService")

local function lineCount(text)
	local n = 1
	local s = tostring(text or "")
	for _ in s:gmatch("\n") do
		n = n + 1
	end
	return n
end

-- Hitung tinggi row yang bener: gabung \n explicit + wrap otomatis dari
-- lebar label (TextService) — biar text panjang kayak RodShop gak ke-kanan
-- (clipped), tapi turun kebawah bikin card nambah tinggi sendiri.
local function rowHeight(kind, text, maxWidth, font)
	local idx = kind == "Title" and 1 or kind == "Description" and 2 or kind == "Footer" and 3 or 4
	local base = ROW_H[idx]
	if kind == "Title" then
		return base
	end
	local lines = lineCount(text)
	if maxWidth and maxWidth > 20 then
		local textSize = kind == "Footer" and 11 or 12
		local ok, measured = pcall(function()
			return TextService:GetTextSize(tostring(text), textSize, font, Vector2.new(maxWidth, 4096))
		end)
		if ok then
			lines = math.max(lines, math.ceil(measured.Y / (textSize + 6)))
		end
	end
	return base + math.max(lines - 1, 0) * LINE_H
end

function Description.new(parent, options, theme)
	local self = setmetatable({}, Description)
	options = options or {}
	self.Theme = theme
	self._rows = {} -- urutan kind yang aktif
	self._labels = {}
	-- Card background: default ke (18,22,28) — sama kayak card info custom
	-- yang udah proven (AutoSpearInfo/SnapFishingInfo) — lebih terang dari
	-- theme.Element Amoled (13,13,18) yang hampir hitam. Bisa di-override
	-- via options.Background.
	local bgColor = options.Background or Color3.fromRGB(18, 22, 28)

	local function relayout()
		if not self.Container then
			return
		end
		-- posisi row: PAD_TOP + akumulasi (height row sebelumnya + gap)
		-- → desc multi-line (lebih tinggi) otomatis dorong row berikutnya turun
		local y = PAD_TOP
		local maxW = self.Container.AbsoluteSize.X - 34 - 4
		for i, kind in ipairs(self._rows) do
			local label = self._labels[kind]
			if label then
				local h = rowHeight(kind, label.Text, maxW, theme.Font)
				label.Size = UDim2.new(1, -34, 0, h)
				label.Position = UDim2.fromOffset(22, y)
				y = y + h + (ROW_GAPS[i] or 4)
			end
		end
		-- total = posisi bottom row terakhir + PAD_BOTTOM
		local n = #self._rows
		local total = y - (n > 0 and (ROW_GAPS[n] or 4) or 0) + PAD_BOTTOM
		if n == 0 then
			total = theme.ElementHeight + 6
		elseif n == 1 then
			total = math.max(total, theme.ElementHeight + 6)
		end
		self.Container.Size = UDim2.new(1, -12, 0, total)
		if self.Container.Accent then
			self.Container.Accent.Size = UDim2.fromOffset(3, math.max(self.Container.AbsoluteSize.Y - PAD_TOP - PAD_BOTTOM, 8))
		end
	end

	self.Container = U.Create("Frame", {
		Name = "Description",
		Size = UDim2.new(1, -12, 0, theme.ElementHeight + 6),
		Position = UDim2.fromOffset(6, 0),
		BackgroundColor3 = bgColor,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		Parent = parent,
	})
	U.Create("UICorner", { CornerRadius = UDim.new(0, 9), Parent = self.Container })
	U.Create("UIStroke", { Color = theme.ElementBorder, Transparency = 0.35, Thickness = 1, Parent = self.Container })
	-- accent bar kiri (3px, full height, ngikut theme.Accent — BIRU)
	U.Create("Frame", {
		Name = "Accent",
		Size = UDim2.fromOffset(3, 8),
		Position = UDim2.fromOffset(10, 8),
		BackgroundColor3 = theme.Accent,
		BorderSizePixel = 0,
		Parent = self.Container,
	})
	U.Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = self.Container.Accent })

	-- Internal: ensure a row exists, set text, then relayout.
	local function setRow(kind, text, color)
		if text == nil or text == "" then
			return nil
		end
		if not self._labels[kind] then
			local isTitle = kind == "Title"
			local isStatus = kind == "Status"
			local isFooter = kind == "Footer"
			local idx = kind == "Title" and 1 or kind == "Description" and 2 or kind == "Footer" and 3 or 4
			local label = U.Create("TextLabel", {
				Name = kind,
				Size = UDim2.new(1, -34, 0, ROW_H[idx]),
				Position = UDim2.fromOffset(22, PAD_TOP),
				BackgroundTransparency = 1,
				Font = isTitle and Enum.Font.GothamBold or theme.Font,
				Text = text,
				TextSize = isTitle and 13 or (isFooter and 11 or 12),
				TextColor3 = isStatus and (color or theme.Accent) or (isTitle and theme.TextPrimary or theme.TextMuted),
				TextXAlignment = Enum.TextXAlignment.Left,
				TextWrapped = not isTitle,
				TextTruncate = isTitle and Enum.TextTruncate.AtEnd or nil,
				Parent = self.Container,
			})
			self._labels[kind] = label
			-- insert keep order: Title, Description, Footer, Status
			local order = { Title = 1, Description = 2, Footer = 3, Status = 4 }
			local pos = #self._rows + 1
			for i, existing in ipairs(self._rows) do
				if order[existing] > order[kind] then
					pos = i
					break
				end
			end
			table.insert(self._rows, pos, kind)
		else
			self._labels[kind].Text = text
			if color then
				self._labels[kind].TextColor3 = color
			end
		end
		relayout()
		return self._labels[kind]
	end

	-- Initial rows in order: Title, Description, Footer, Status
	if options.Title ~= nil and options.Title ~= "" then
		setRow("Title", options.Title)
	end
	if options.Description ~= nil and options.Description ~= "" then
		setRow("Description", options.Description)
	end
	if options.Footer ~= nil and options.Footer ~= "" then
		setRow("Footer", options.Footer)
	end
	if options.Status ~= nil and options.Status ~= "" then
		setRow("Status", options.Status)
	end

	-- Runtime API
	function self:SetTitle(text)
		setRow("Title", text)
	end

	function self:SetInfo(text)
		setRow("Description", text)
	end

	function self:SetFooter(text)
		setRow("Footer", text)
	end

	function self:SetStatus(text, color)
		setRow("Status", text, color)
	end

	function self:ApplyTheme(newTheme)
		theme = newTheme
		if not self.Container then
			return
		end
		self.Container.BackgroundColor3 = bgColor
		local stroke = self.Container:FindFirstChildOfClass("UIStroke")
		if stroke then
			stroke.Color = theme.ElementBorder
		end
		if self.Container.Accent then
			self.Container.Accent.BackgroundColor3 = theme.Accent
		end
		for kind, label in pairs(self._labels) do
			local isTitle = kind == "Title"
			local isStatus = kind == "Status"
			if isTitle then
				label.Font = Enum.Font.GothamBold
				label.TextColor3 = theme.TextPrimary
			elseif isStatus then
				label.Font = theme.Font
				label.TextColor3 = theme.Accent
			else
				label.Font = theme.Font
				label.TextColor3 = theme.TextMuted
			end
		end
	end

	function self:Destroy()
		if self.Container then
			self.Container:Destroy()
		end
	end

	return self
end
