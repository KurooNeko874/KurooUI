--[[
╔══════════════════════════════════════════════════════════════╗
║  version: 1.0.3                                              ║
║  SUPPORT:                                                    ║
║  ──────────────────────────────────────────────────────────  ║
║  Discord    : kuroneko4411                                   ║
║  GitHub     : https://github.com/KurooNeko874                ║
║  instagram  : @_kucing.hitam__                               ║
╠══════════════════════════════════════════════════════════════╣
║                                                              ║
║              ╔═══════════════════════════════╗               ║
║              ║                               ║               ║
║              ║       DEVELOPER: KUROO        ║               ║
║              ║                               ║               ║
║              ╚═══════════════════════════════╝               ║
║                                                              ║
╚══════════════════════════════════════════════════════════════╝
]]

local KurooUI = {}
KurooUI.__index = KurooUI

-- ─── Services ────────────────────────────────────────────────
local TweenService      = game:GetService("TweenService")
local UserInputService  = game:GetService("UserInputService")
local Players           = game:GetService("Players")

-- ─── Palette Warna ───────────────────────────────────────────
local C = {
	BG        = Color3.fromRGB(13,  27,  42),   -- Badan utama
	Panel     = Color3.fromRGB(8,   18,  32),   -- Panel & section
	Header    = Color3.fromRGB(5,   12,  24),   -- Header (paling gelap)
	Neon      = Color3.fromRGB(0,  207, 255),   -- Outline neon cyan
	NeonDim   = Color3.fromRGB(0,   80, 140),   -- Neon redup
	TextMain  = Color3.fromRGB(220, 240, 255),  -- Teks utama
	TextSub   = Color3.fromRGB(100, 170, 210),  -- Teks sekunder
	BtnBG     = Color3.fromRGB(10,  35,  60),   -- Background tombol
	BtnHover  = Color3.fromRGB(15,  55,  90),   -- Tombol hover
	TabActive = Color3.fromRGB(0,  100, 180),   -- Tab aktif
	TabInact  = Color3.fromRGB(8,   25,  48),   -- Tab tidak aktif
	ToggleOn  = Color3.fromRGB(0,  200, 255),   -- Toggle nyala
	ToggleOff = Color3.fromRGB(20,  45,  70),   -- Toggle mati
	SliderFill= Color3.fromRGB(0,  150, 220),   -- Isi slider
	InputBG   = Color3.fromRGB(5,   15,  30),   -- Background input
}

-- ─── Helper: UIStroke ────────────────────────────────────────
local function Stroke(parent, thickness, color, transparency)
	local s = Instance.new("UIStroke")
	s.Thickness       = thickness    or 1.5
	s.Color           = color        or C.Neon
	s.Transparency    = transparency or 0
	s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	s.Parent          = parent
	return s
end

-- ─── Helper: UICorner ────────────────────────────────────────
local function Corner(parent, radius)
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, radius or 6)
	c.Parent = parent
	return c
end

-- ─── Helper: UIPadding ───────────────────────────────────────
local function Pad(parent, top, right, bottom, left)
	local p = Instance.new("UIPadding")
	p.PaddingTop    = UDim.new(0, top    or 8)
	p.PaddingRight  = UDim.new(0, right  or 8)
	p.PaddingBottom = UDim.new(0, bottom or 8)
	p.PaddingLeft   = UDim.new(0, left   or 8)
	p.Parent = parent
	return p
end

-- ─── Helper: Animasi Tween ───────────────────────────────────
local function Tween(obj, props, t)
	TweenService:Create(
		obj,
		TweenInfo.new(t or 0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		props
	):Play()
end

-- ═══════════════════════════════════════════════════════════════
--  CREATE WINDOW
-- ═══════════════════════════════════════════════════════════════
function KurooUI:CreateWindow(config)
	config = config or {}
	local title      = config.Title   or "KurooUI"
	local defaultKey = config.HideKey or Enum.KeyCode.K
	local sizeW      = config.W       or 400
	local sizeH      = config.H       or 350
	local logoId     = config.Logo or nil

	local playerGui  = Players.LocalPlayer:WaitForChild("PlayerGui")

	-- State internal
	local currentKey    = defaultKey
	local isVisible     = true
	local tabs          = {}
	local activeTabData = nil

	-- ──────────────────────────────────────────────────────────
	-- [1] ScreenGui — wadah paling luar
	-- ──────────────────────────────────────────────────────────
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name           = "KurooUI_" .. title
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	ScreenGui.ResetOnSpawn   = false
	ScreenGui.IgnoreGuiInset = true
	local ok, err = pcall(function() ScreenGui.Parent = game:GetService("CoreGui") end)
	if not ok or ScreenGui.Parent == nil then 
		ScreenGui.Parent = playerGui 
	end
	ScreenGui.DisplayOrder   = 999

	-- ──────────────────────────────────────────────────────────
	-- [2] MainFrame — jendela utama
	-- ──────────────────────────────────────────────────────────
	local MainFrame = Instance.new("Frame")
	MainFrame.Name             = "MainFrame"
	MainFrame.Size             = UDim2.new(0, sizeW, 0, sizeH)
	MainFrame.Position         = UDim2.new(0.5, -sizeW/2, 0.5, -sizeH/2)
	MainFrame.BackgroundColor3 = C.BG
	MainFrame.BorderSizePixel  = 0
	MainFrame.ClipsDescendants = false
	MainFrame.Parent           = ScreenGui
	Corner(MainFrame, 6)
	Stroke(MainFrame, 5, C.Neon, 0)

	-- Bayangan di bawah jendela
	local Shadow = Instance.new("ImageLabel")
	Shadow.Size              = UDim2.new(1, 50, 1, 50)
	Shadow.Position          = UDim2.new(0, -25, 0, -25)
	Shadow.BackgroundTransparency = 1
	Shadow.Image             = "rbxassetid://6015897843"
	Shadow.ImageColor3       = Color3.fromRGB(0, 0, 0)
	Shadow.ImageTransparency = 0.55
	Shadow.ScaleType         = Enum.ScaleType.Slice
	Shadow.SliceCenter       = Rect.new(49, 49, 450, 450)
	Shadow.ZIndex            = -1
	Shadow.Parent            = MainFrame

	-- ──────────────────────────────────────────────────────────
	-- [3] Header — bar atas (42px)
	-- ──────────────────────────────────────────────────────────
	local Header = Instance.new("Frame")
	Header.Name             = "Header"
	Header.Size             = UDim2.new(1, 0, 0, 42)
	Header.BackgroundColor3 = C.Header
	Header.BorderSizePixel  = 0
	Header.ZIndex           = 2
	Header.Parent           = MainFrame
	Corner(Header, 8)

	-- Trick: tutup sudut bawah header supaya tidak melengkung
	local HeaderPatch = Instance.new("Frame")
	HeaderPatch.Size             = UDim2.new(1, 0, 0, 10)
	HeaderPatch.Position         = UDim2.new(0, 0, 1, -10)
	HeaderPatch.BackgroundColor3 = C.Header
	HeaderPatch.BorderSizePixel  = 0
	HeaderPatch.ZIndex           = 2
	HeaderPatch.Parent           = Header

	-- Garis neon pemisah bawah header
	local HeaderLine = Instance.new("Frame")
	HeaderLine.Size             = UDim2.new(1, 0, 0, 1)
	HeaderLine.Position         = UDim2.new(0, 0, 1, 0)
	HeaderLine.BackgroundColor3 = C.Neon
	HeaderLine.BorderSizePixel  = 0
	HeaderLine.ZIndex           = 3
	HeaderLine.Parent           = Header

	-- Label judul
	local TitleLabel = Instance.new("TextLabel")
	TitleLabel.Size              = UDim2.new(1, -100, 1, 0)
	TitleLabel.Position          = UDim2.new(0, 16, 0, 0)
	TitleLabel.BackgroundTransparency = 1
	TitleLabel.Text              = title
	TitleLabel.TextColor3        = C.TextMain
	TitleLabel.TextSize          = 15
	TitleLabel.Font              = Enum.Font.GothamBold
	TitleLabel.TextXAlignment    = Enum.TextXAlignment.Left
	TitleLabel.ZIndex            = 3
	TitleLabel.Parent            = Header

	if logoId then
		local Logo = Instance.new("ImageLabel")
		Logo.Size                = UDim2.new(0, 24, 0, 24)
		Logo.Position            = UDim2.new(0, 10, 0.5, -12)
		Logo.BackgroundTransparency = 1
		Logo.Image               = logoId
		Logo.ZIndex              = 3
		Logo.Parent              = Header

		-- geser TitleLabel biar tidak nabrak logo
		TitleLabel.Position = UDim2.new(0, 42, 0, 0)
	end

	-- Kontainer tombol header (kanan)
	local BtnContainer = Instance.new("Frame")
	BtnContainer.Size                = UDim2.new(0, 84, 0, 30)
	BtnContainer.Position            = UDim2.new(1, -92, 0.5, -15)
	BtnContainer.BackgroundTransparency = 1
	BtnContainer.ZIndex              = 3
	BtnContainer.Parent              = Header

	local BtnLayout = Instance.new("UIListLayout")
	BtnLayout.FillDirection       = Enum.FillDirection.Horizontal
	BtnLayout.VerticalAlignment   = Enum.VerticalAlignment.Center
	BtnLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	BtnLayout.Padding             = UDim.new(0, 6)
	BtnLayout.Parent              = BtnContainer

	-- Tombol ≡ (buka Settings)
	local SettingsBtn = Instance.new("TextButton")
	SettingsBtn.Size             = UDim2.new(0, 32, 0, 26)
	SettingsBtn.BackgroundColor3 = C.BtnBG
	SettingsBtn.Text             = "≡"
	SettingsBtn.TextColor3       = C.Neon
	SettingsBtn.TextSize         = 20
	SettingsBtn.Font             = Enum.Font.GothamBold
	SettingsBtn.BorderSizePixel  = 0
	SettingsBtn.ZIndex           = 4
	SettingsBtn.Parent           = BtnContainer
	Corner(SettingsBtn, 5)
	Stroke(SettingsBtn, 1, C.NeonDim, 0)

	-- Tombol ✕ (sembunyikan UI)
	local CloseBtn = Instance.new("TextButton")
	CloseBtn.Size             = UDim2.new(0, 32, 0, 26)
	CloseBtn.BackgroundColor3 = C.BtnBG
	CloseBtn.Text             = "×"
	CloseBtn.TextColor3       = Color3.fromRGB(255, 80, 80)
	CloseBtn.TextSize         = 20
	CloseBtn.Font             = Enum.Font.GothamBold
	CloseBtn.BorderSizePixel  = 0
	CloseBtn.ZIndex           = 4
	CloseBtn.Parent           = BtnContainer
	Corner(CloseBtn, 5)
	Stroke(CloseBtn, 1, Color3.fromRGB(140, 30, 30), 0)

	-- Hover effect tombol header
	for _, btn in ipairs({ SettingsBtn, CloseBtn }) do
		btn.MouseEnter:Connect(function()
			Tween(btn, { BackgroundColor3 = C.BtnHover }, 0.15)
		end)
		btn.MouseLeave:Connect(function()
			Tween(btn, { BackgroundColor3 = C.BtnBG }, 0.15)
		end)
	end

	-- ──────────────────────────────────────────────────────────
	-- [4] LeftPanel — panel tab di kiri
	-- ──────────────────────────────────────────────────────────
	local LeftPanel = Instance.new("Frame")
	LeftPanel.Name             = "LeftPanel"
	LeftPanel.Size             = UDim2.new(0, 140, 1, -43)
	LeftPanel.Position         = UDim2.new(0, 0, 0, 43)
	LeftPanel.BackgroundColor3 = C.Panel
	LeftPanel.BorderSizePixel  = 0
	LeftPanel.ZIndex           = 2
	LeftPanel.Parent           = MainFrame

	-- Garis pemisah kanan LeftPanel
	local LeftLine = Instance.new("Frame")
	LeftLine.Size             = UDim2.new(0, 1, 1, 0)
	LeftLine.Position         = UDim2.new(1, 0, 0, 0)
	LeftLine.BackgroundColor3 = C.NeonDim
	LeftLine.BorderSizePixel  = 0
	LeftLine.ZIndex           = 3
	LeftLine.Parent           = LeftPanel

	-- ScrollingFrame tab (bisa scroll kalau tab banyak)
	local TabScroll = Instance.new("ScrollingFrame")
	TabScroll.Name                 = "TabScroll"
	TabScroll.Size                 = UDim2.new(1, -4, 1, 0)
	TabScroll.BackgroundTransparency = 1
	TabScroll.BorderSizePixel      = 0
	TabScroll.ScrollBarThickness   = 2
	TabScroll.ScrollBarImageColor3 = C.Neon
	TabScroll.CanvasSize           = UDim2.new(0, 0, 0, 0)
	TabScroll.AutomaticCanvasSize  = Enum.AutomaticSize.Y
	TabScroll.ZIndex               = 3
	TabScroll.Parent               = LeftPanel
	Pad(TabScroll, 8, 6, 8, 6)

	local TabListLayout = Instance.new("UIListLayout")
	TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	TabListLayout.Padding   = UDim.new(0, 4)
	TabListLayout.Parent    = TabScroll

	-- ──────────────────────────────────────────────────────────
	-- [5] RightPanel — area konten tab
	-- ──────────────────────────────────────────────────────────
	local RightPanel = Instance.new("Frame")
	RightPanel.Name             = "RightPanel"
	RightPanel.Size             = UDim2.new(1, -141, 1, -43)
	RightPanel.Position         = UDim2.new(0, 141, 0, 43)
	RightPanel.BackgroundColor3 = C.BG
	RightPanel.BorderSizePixel  = 0
	RightPanel.ClipsDescendants = true   -- PENTING: untuk dropdown
	RightPanel.ZIndex           = 2
	RightPanel.Parent           = MainFrame

	local ContentScroll = Instance.new("ScrollingFrame")
	ContentScroll.Name                 = "ContentScroll"
	ContentScroll.Size                 = UDim2.new(1, -6, 1, -4)
	ContentScroll.Position             = UDim2.new(0, 3, 0, 2)
	ContentScroll.BackgroundTransparency = 1
	ContentScroll.BorderSizePixel      = 0
	ContentScroll.ScrollBarThickness   = 3
	ContentScroll.ScrollBarImageColor3 = C.Neon
	ContentScroll.CanvasSize           = UDim2.new(0, 0, 0, 0)
	ContentScroll.AutomaticCanvasSize  = Enum.AutomaticSize.Y
	ContentScroll.ClipsDescendants     = true
	ContentScroll.ZIndex               = 3
	ContentScroll.Parent               = RightPanel
	Pad(ContentScroll, 8, 8, 8, 8)

	local ContentLayout = Instance.new("UIListLayout")
	ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
	ContentLayout.Padding   = UDim.new(0, 8)
	ContentLayout.Parent    = ContentScroll

	-- ──────────────────────────────────────────────────────────
	-- [6] SettingsPanel — muncul saat klik ≡
	-- ──────────────────────────────────────────────────────────
	local SettingsPanel = Instance.new("Frame")
	SettingsPanel.Name             = "SettingsPanel"
	SettingsPanel.Size             = UDim2.new(0, 230, 0, 130)
	SettingsPanel.Position         = UDim2.new(1, -238, 0, 46)
	SettingsPanel.BackgroundColor3 = C.Panel
	SettingsPanel.BorderSizePixel  = 0
	SettingsPanel.Visible          = false
	SettingsPanel.ZIndex           = 15
	SettingsPanel.Parent           = MainFrame
	Corner(SettingsPanel, 8)
	Stroke(SettingsPanel, 1.5, C.Neon, 0)

	local SettingsTitle = Instance.new("TextLabel")
	SettingsTitle.Size                = UDim2.new(1, 0, 0, 38)
	SettingsTitle.BackgroundTransparency = 1
	SettingsTitle.Text                = "Settings Keybind"
	SettingsTitle.TextColor3          = C.TextMain
	SettingsTitle.TextSize            = 13
	SettingsTitle.Font                = Enum.Font.GothamBold
	SettingsTitle.TextXAlignment      = Enum.TextXAlignment.Left
	SettingsTitle.ZIndex              = 16
	SettingsTitle.Parent              = SettingsPanel
	Pad(SettingsTitle, 0, 0, 0, 14)

	local SettingsLine1 = Instance.new("Frame")
	SettingsLine1.Size             = UDim2.new(1, -16, 0, 1)
	SettingsLine1.Position         = UDim2.new(0, 8, 0, 38)
	SettingsLine1.BackgroundColor3 = C.NeonDim
	SettingsLine1.BorderSizePixel  = 0
	SettingsLine1.ZIndex           = 16
	SettingsLine1.Parent           = SettingsPanel

	local KeyInput = Instance.new("TextBox")
	KeyInput.Size                = UDim2.new(1, -16, 0, 30)
	KeyInput.Position            = UDim2.new(0, 8, 0, 48)
	KeyInput.BackgroundColor3    = C.InputBG
	KeyInput.Text                = currentKey.Name
	KeyInput.PlaceholderText     = "e.g. F3, K, RightShift"
	KeyInput.TextColor3          = C.TextMain
	KeyInput.PlaceholderColor3   = C.TextSub
	KeyInput.TextSize            = 12
	KeyInput.Font                = Enum.Font.GothamSemibold
	KeyInput.BorderSizePixel     = 0
	KeyInput.ClearTextOnFocus    = false
	KeyInput.ZIndex              = 16
	KeyInput.Parent              = SettingsPanel
	Corner(KeyInput, 6)
	Stroke(KeyInput, 1, C.NeonDim, 0)
	Pad(KeyInput, 0, 8, 0, 8)

	local SaveBtn = Instance.new("TextButton")
	SaveBtn.Size             = UDim2.new(1, -16, 0, 30)
	SaveBtn.Position         = UDim2.new(0, 8, 0, 88)
	SaveBtn.BackgroundColor3 = C.TabActive
	SaveBtn.Text             = "💾  Save"
	SaveBtn.TextColor3       = C.TextMain
	SaveBtn.TextSize         = 13
	SaveBtn.Font             = Enum.Font.GothamBold
	SaveBtn.BorderSizePixel  = 0
	SaveBtn.ZIndex           = 16
	SaveBtn.Parent           = SettingsPanel
	Corner(SaveBtn, 6)
	Stroke(SaveBtn, 1, C.Neon, 0)

	SaveBtn.MouseEnter:Connect(function()
		Tween(SaveBtn, { BackgroundColor3 = Color3.fromRGB(0, 130, 210) }, 0.15)
	end)
	SaveBtn.MouseLeave:Connect(function()
		Tween(SaveBtn, { BackgroundColor3 = C.TabActive }, 0.15)
	end)

	-- ──────────────────────────────────────────────────────────
	-- [7] Logic: Drag jendela
	-- ──────────────────────────────────────────────────────────
	local dragging, dragStart, frameStart

	Header.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging   = true
			dragStart  = input.Position
			frameStart = MainFrame.Position
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local d = input.Position - dragStart
			MainFrame.Position = UDim2.new(
				frameStart.X.Scale, frameStart.X.Offset + d.X,
				frameStart.Y.Scale, frameStart.Y.Offset + d.Y
			)
		end
	end)
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)

	-- ──────────────────────────────────────────────────────────
	-- [8] Logic: Hide / Show UI
	-- ──────────────────────────────────────────────────────────
	local ddClosers = {}
	local savedMouseBehavior = Enum.MouseBehavior.Default

	local function hideUI()
		isVisible = false
		for _, close in ipairs(ddClosers) do close() end
		MainFrame.Visible = false
	end

	local function showUI()
		isVisible = true
		MainFrame.Position = UDim2.new(0.5, -sizeW/2, 0.5, -sizeH/2)
		MainFrame.Visible  = true
	end

	-- Tombol ✕ → sembunyikan
	CloseBtn.MouseButton1Click:Connect(hideUI)

	-- Keybind → toggle show/hide
	UserInputService.InputBegan:Connect(function(input, processed)
		if processed then return end
		if input.KeyCode == currentKey then
			if isVisible then hideUI() else showUI() end
		end
	end)

	-- Tombol ≡ → toggle SettingsPanel
	SettingsBtn.MouseButton1Click:Connect(function()
		SettingsPanel.Visible = not SettingsPanel.Visible
	end)

	-- Tombol Simpan → apply keybind baru
	SaveBtn.MouseButton1Click:Connect(function()
		local key = Enum.KeyCode[KeyInput.Text:sub(1,1):upper() .. KeyInput.Text:sub(2)]
		if key then
			currentKey = key
		end
		SettingsPanel.Visible = false
	end)

	-- ═══════════════════════════════════════════════════════════
	-- WINDOW OBJECT (dikembalikan ke dev)
	-- ═══════════════════════════════════════════════════════════
	local Window = {}

	-- ──────────────────────────────────────────────────────────
	-- [9] Window:AddTab()
	-- ──────────────────────────────────────────────────────────
	function Window:AddTab(tabConfig)
		tabConfig = tabConfig or {}
		local tabName = tabConfig.Name or ("Tab " .. (#tabs + 1))

		-- Frame konten (satu per tab, disembunyikan bergantian)
		local TabContent = Instance.new("Frame")
		TabContent.Name               = "Content_" .. tabName
		TabContent.Size               = UDim2.new(1, 0, 0, 0)
		TabContent.AutomaticSize      = Enum.AutomaticSize.Y
		TabContent.BackgroundTransparency = 1
		TabContent.Visible            = false
		TabContent.ClipsDescendants   = false
		TabContent.LayoutOrder        = #tabs + 1
		TabContent.ZIndex             = 3
		TabContent.Parent             = ContentScroll

		local TCLayout = Instance.new("UIListLayout")
		TCLayout.SortOrder = Enum.SortOrder.LayoutOrder
		TCLayout.Padding   = UDim.new(0, 8)
		TCLayout.Parent    = TabContent

		-- Tombol tab di LeftPanel
		local TabBtn = Instance.new("TextButton")
		TabBtn.Name             = "Btn_" .. tabName
		TabBtn.Size             = UDim2.new(1, 0, 0, 34)
		TabBtn.BackgroundColor3 = C.TabInact
		TabBtn.Text             = tabName
		TabBtn.TextColor3       = C.TextSub
		TabBtn.TextSize         = 13
		TabBtn.Font             = Enum.Font.GothamSemibold
		TabBtn.BorderSizePixel  = 0
		TabBtn.TextXAlignment   = Enum.TextXAlignment.Left
		TabBtn.LayoutOrder      = #tabs + 1
		TabBtn.ZIndex           = 4
		TabBtn.Parent           = TabScroll
		Corner(TabBtn, 6)
		Pad(TabBtn, 0, 0, 0, 12)
		local TabBtnStroke = Stroke(TabBtn, 1, C.NeonDim, 0)

		local tabData = {
			button  = TabBtn,
			content = TabContent,
			bar     = ActiveBar,
			stroke  = TabBtnStroke,
		}
		table.insert(tabs, tabData)

		-- Fungsi internal: aktifkan tab ini
		local function activateTab()
			for _, t in ipairs(tabs) do
				t.content.Visible         = false
				t.button.BackgroundColor3 = C.TabInact
				t.button.TextColor3       = C.TextSub
				t.stroke.Color            = C.NeonDim
			end
			TabContent.Visible         = true
			TabBtn.BackgroundColor3    = C.TabActive
			TabBtn.TextColor3          = C.TextMain
			TabBtnStroke.Color         = C.Neon
			activeTabData              = tabData
			ContentScroll.CanvasPosition = Vector2.new(0, 0)
		end

		TabBtn.MouseButton1Click:Connect(activateTab)
		TabBtn.MouseEnter:Connect(function()
			if activeTabData ~= tabData then
				Tween(TabBtn, { BackgroundColor3 = C.BtnHover }, 0.15)
			end
		end)
		TabBtn.MouseLeave:Connect(function()
			if activeTabData ~= tabData then
				Tween(TabBtn, { BackgroundColor3 = C.TabInact }, 0.15)
			end
		end)

		-- Tab pertama langsung aktif otomatis
		if #tabs == 1 then activateTab() end

		-- ────────────────────────────────────────────────────
		-- TAB OBJECT
		-- ────────────────────────────────────────────────────
		local Tab = {}
		local sectionCount = 0

		-- ──────────────────────────────────────────────────
		-- [10] Tab:AddSection()
		-- ──────────────────────────────────────────────────
		function Tab:AddSection(secConfig)
			secConfig = secConfig or {}
			local secName = secConfig.Name or "Section"
			sectionCount  = sectionCount + 1

			local SecFrame = Instance.new("Frame")
			SecFrame.Name               = "Sec_" .. secName
			SecFrame.Size               = UDim2.new(1, 0, 0, 0)
			SecFrame.AutomaticSize      = Enum.AutomaticSize.Y
			SecFrame.BackgroundColor3   = C.Panel
			SecFrame.BorderSizePixel    = 0
			SecFrame.ClipsDescendants   = false
			SecFrame.LayoutOrder        = sectionCount
			SecFrame.ZIndex             = 4
			SecFrame.Parent             = TabContent
			Corner(SecFrame, 8)
			Stroke(SecFrame, 1, C.NeonDim, 0)
			Pad(SecFrame, 10, 10, 10, 10)

			local SecLayout = Instance.new("UIListLayout")
			SecLayout.SortOrder = Enum.SortOrder.LayoutOrder
			SecLayout.Padding   = UDim.new(0, 6)
			SecLayout.Parent    = SecFrame

			-- Label nama section
			local SecLabel = Instance.new("TextLabel")
			SecLabel.Size                = UDim2.new(1, 0, 0, 18)
			SecLabel.BackgroundTransparency = 1
			SecLabel.Text                = secName:upper()
			SecLabel.TextColor3          = C.Neon
			SecLabel.TextSize            = 10
			SecLabel.Font                = Enum.Font.GothamBold
			SecLabel.TextXAlignment      = Enum.TextXAlignment.Left
			SecLabel.LayoutOrder         = 0
			SecLabel.ZIndex              = 5
			SecLabel.Parent              = SecFrame

			-- Garis tipis bawah label
			local SecDiv = Instance.new("Frame")
			SecDiv.Size             = UDim2.new(1, 0, 0, 1)
			SecDiv.BackgroundColor3 = C.NeonDim
			SecDiv.BorderSizePixel  = 0
			SecDiv.LayoutOrder      = 1
			SecDiv.ZIndex           = 5
			SecDiv.Parent           = SecFrame

			local itemOrder = 1
			local function nextOrder()
				itemOrder = itemOrder + 1
				return itemOrder
			end

			-- ────────────────────────────────────────────
			-- SECTION OBJECT
			-- ────────────────────────────────────────────
			local Section = {}

			-- ──────────────────────────────────────────
			-- Section:AddButton()
			-- ──────────────────────────────────────────
			function Section:AddButton(cfg)
				cfg = cfg or {}
				local name     = cfg.Name     or "Button"
				local callback = cfg.Callback or function() end

				local Btn = Instance.new("TextButton")
				Btn.Size             = UDim2.new(1, 0, 0, 32)
				Btn.BackgroundColor3 = C.BtnBG
				Btn.Text             = name
				Btn.TextColor3       = C.TextMain
				Btn.TextSize         = 13
				Btn.Font             = Enum.Font.GothamSemibold
				Btn.BorderSizePixel  = 0
				Btn.LayoutOrder      = nextOrder()
				Btn.ZIndex           = 5
				Btn.Parent           = SecFrame
				Corner(Btn, 6)
				Stroke(Btn, 1, C.NeonDim, 0)

				Btn.MouseEnter:Connect(function()
					Tween(Btn, { BackgroundColor3 = C.BtnHover }, 0.15)
				end)
				Btn.MouseLeave:Connect(function()
					Tween(Btn, { BackgroundColor3 = C.BtnBG }, 0.15)
				end)
				Btn.MouseButton1Click:Connect(function()
					-- Flash neon saat klik
					Tween(Btn, { BackgroundColor3 = C.NeonDim }, 0.08)
					task.delay(0.12, function()
						Tween(Btn, { BackgroundColor3 = C.BtnBG }, 0.15)
					end)
					callback()
				end)

				return Btn
			end

			-- ──────────────────────────────────────────
			-- Section:AddToggle()
			-- ──────────────────────────────────────────
			function Section:AddToggle(cfg)
				cfg = cfg or {}
				local name     = cfg.Name     or "Toggle"
				local default  = cfg.Default  or false
				local callback = cfg.Callback or function() end

				local togState = default

				local TogRow = Instance.new("Frame")
				TogRow.Size             = UDim2.new(1, 0, 0, 32)
				TogRow.BackgroundColor3 = C.BtnBG
				TogRow.BorderSizePixel  = 0
				TogRow.LayoutOrder      = nextOrder()
				TogRow.ZIndex           = 5
				TogRow.Parent           = SecFrame
				Corner(TogRow, 6)
				Stroke(TogRow, 1, C.NeonDim, 0)
				Pad(TogRow, 0, 10, 0, 10)

				local TogLabel = Instance.new("TextLabel")
				TogLabel.Size                = UDim2.new(1, -50, 1, 0)
				TogLabel.BackgroundTransparency = 1
				TogLabel.Text                = name
				TogLabel.TextColor3          = C.TextMain
				TogLabel.TextSize            = 13
				TogLabel.Font                = Enum.Font.GothamSemibold
				TogLabel.TextXAlignment      = Enum.TextXAlignment.Left
				TogLabel.ZIndex              = 6
				TogLabel.Parent              = TogRow

				-- Background switch (oval)
				local SwBG = Instance.new("Frame")
				SwBG.Size             = UDim2.new(0, 40, 0, 20)
				SwBG.Position         = UDim2.new(1, -40, 0.5, -10)
				SwBG.BackgroundColor3 = togState and C.ToggleOn or C.ToggleOff
				SwBG.BorderSizePixel  = 0
				SwBG.ZIndex           = 6
				SwBG.Parent           = TogRow
				Corner(SwBG, 10)
				local SwStroke = Stroke(SwBG, 1, togState and C.Neon or C.NeonDim, 0)

				-- Knob
				local Knob = Instance.new("Frame")
				Knob.Size             = UDim2.new(0, 14, 0, 14)
				Knob.Position         = togState and UDim2.new(0, 23, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)
				Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Knob.BorderSizePixel  = 0
				Knob.ZIndex           = 7
				Knob.Parent           = SwBG
				Corner(Knob, 7)

				local function refreshToggle(state)
					if state then
						Tween(SwBG,     { BackgroundColor3 = C.ToggleOn },  0.2)
						Tween(Knob,     { Position = UDim2.new(0, 23, 0.5, -7) }, 0.2)
						Tween(SwStroke, { Color = C.Neon },    0.2)
					else
						Tween(SwBG,     { BackgroundColor3 = C.ToggleOff }, 0.2)
						Tween(Knob,     { Position = UDim2.new(0, 3, 0.5, -7) },  0.2)
						Tween(SwStroke, { Color = C.NeonDim }, 0.2)
					end
				end

				TogRow.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						togState = not togState
						refreshToggle(togState)
						callback(togState)
					end
				end)
				TogRow.MouseEnter:Connect(function()
					Tween(TogRow, { BackgroundColor3 = C.BtnHover }, 0.15)
				end)
				TogRow.MouseLeave:Connect(function()
					Tween(TogRow, { BackgroundColor3 = C.BtnBG }, 0.15)
				end)

				-- API untuk kontrol dari luar
				local ToggleAPI = {}
				function ToggleAPI:Set(val)
					togState = val
					refreshToggle(togState)
					callback(togState)
				end
				function ToggleAPI:Get() return togState end
				return ToggleAPI
			end

			-- ──────────────────────────────────────────
			-- Section:AddSlider()
			-- ──────────────────────────────────────────
			function Section:AddSlider(cfg)
				cfg = cfg or {}
				local name     = cfg.Name     or "Slider"
				local minVal   = cfg.Min      or 0
				local maxVal   = cfg.Max      or 100
				local defVal   = cfg.Default  or minVal
				local callback = cfg.Callback or function() end

				local curVal   = math.clamp(defVal, minVal, maxVal)

				local SlFrame = Instance.new("Frame")
				SlFrame.Size             = UDim2.new(1, 0, 0, 50)
				SlFrame.BackgroundColor3 = C.BtnBG
				SlFrame.BorderSizePixel  = 0
				SlFrame.LayoutOrder      = nextOrder()
				SlFrame.ZIndex           = 5
				SlFrame.Parent           = SecFrame
				Corner(SlFrame, 6)
				Stroke(SlFrame, 1, C.NeonDim, 0)
				Pad(SlFrame, 7, 10, 7, 10)

				local SlInner = Instance.new("UIListLayout")
				SlInner.Padding   = UDim.new(0, 5)
				SlInner.SortOrder = Enum.SortOrder.LayoutOrder
				SlInner.Parent    = SlFrame

				-- Row atas: nama + angka
				local TopRow = Instance.new("Frame")
				TopRow.Size               = UDim2.new(1, 0, 0, 16)
				TopRow.BackgroundTransparency = 1
				TopRow.LayoutOrder        = 0
				TopRow.ZIndex             = 6
				TopRow.Parent             = SlFrame

				local SlLabel = Instance.new("TextLabel")
				SlLabel.Size              = UDim2.new(0.65, 0, 1, 0)
				SlLabel.BackgroundTransparency = 1
				SlLabel.Text              = name
				SlLabel.TextColor3        = C.TextMain
				SlLabel.TextSize          = 12
				SlLabel.Font              = Enum.Font.GothamSemibold
				SlLabel.TextXAlignment    = Enum.TextXAlignment.Left
				SlLabel.ZIndex            = 6
				SlLabel.Parent            = TopRow

				local SlValue = Instance.new("TextLabel")
				SlValue.Size              = UDim2.new(0.35, 0, 1, 0)
				SlValue.Position          = UDim2.new(0.65, 0, 0, 0)
				SlValue.BackgroundTransparency = 1
				SlValue.Text              = tostring(curVal)
				SlValue.TextColor3        = C.Neon
				SlValue.TextSize          = 12
				SlValue.Font              = Enum.Font.GothamBold
				SlValue.TextXAlignment    = Enum.TextXAlignment.Right
				SlValue.ZIndex            = 6
				SlValue.Parent            = TopRow

				-- Track bar
				local pctInit = (curVal - minVal) / (maxVal - minVal)
				local Track = Instance.new("Frame")
				Track.Size             = UDim2.new(1, 0, 0, 8)
				Track.BackgroundColor3 = C.ToggleOff
				Track.BorderSizePixel  = 0
				Track.LayoutOrder      = 1
				Track.ZIndex           = 6
				Track.Parent           = SlFrame
				Corner(Track, 4)

				-- Fill (warna yang sudah terisi)
				local Fill = Instance.new("Frame")
				Fill.Size             = UDim2.new(pctInit, 0, 1, 0)
				Fill.BackgroundColor3 = C.SliderFill
				Fill.BorderSizePixel  = 0
				Fill.ZIndex           = 7
				Fill.Parent           = Track
				Corner(Fill, 4)

				-- Knob slider (lingkaran yang bisa di-drag)
				local SlKnob = Instance.new("Frame")
				SlKnob.Size             = UDim2.new(0, 14, 0, 14)
				SlKnob.Position         = UDim2.new(pctInit, -7, 0.5, -7)
				SlKnob.BackgroundColor3 = Color3.fromRGB(240, 250, 255)
				SlKnob.BorderSizePixel  = 0
				SlKnob.ZIndex           = 8
				SlKnob.Parent           = Track
				Corner(SlKnob, 7)
				Stroke(SlKnob, 1.5, C.Neon, 0)

				-- Drag logic
				local sliding = false

				local function applySlide(mouseX)
					local abs = Track.AbsolutePosition
					local sz  = Track.AbsoluteSize
					local pct = math.clamp((mouseX - abs.X) / sz.X, 0, 1)
					curVal        = math.floor(minVal + pct * (maxVal - minVal) + 0.5)
					SlValue.Text  = tostring(curVal)
					Fill.Size     = UDim2.new(pct, 0, 1, 0)
					SlKnob.Position = UDim2.new(pct, -7, 0.5, -7)
					callback(curVal)
				end

				Track.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						sliding = true
						applySlide(input.Position.X)
					end
				end)
				UserInputService.InputChanged:Connect(function(input)
					if sliding and input.UserInputType == Enum.UserInputType.MouseMovement then
						applySlide(input.Position.X)
					end
				end)
				UserInputService.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						sliding = false
					end
				end)

				local SliderAPI = {}
				function SliderAPI:Set(val)
					curVal = math.clamp(val, minVal, maxVal)
					local pct = (curVal - minVal) / (maxVal - minVal)
					SlValue.Text    = tostring(curVal)
					Fill.Size       = UDim2.new(pct, 0, 1, 0)
					SlKnob.Position = UDim2.new(pct, -7, 0.5, -7)
					callback(curVal)
				end
				function SliderAPI:Get() return curVal end
				return SliderAPI
			end

			-- ──────────────────────────────────────────
			-- Section:AddInput()
			-- ──────────────────────────────────────────
			function Section:AddInput(cfg)
				cfg = cfg or {}
				local name        = cfg.Name        or "Input"
				local placeholder = cfg.Placeholder or "Ketik di sini..."
				local callback    = cfg.Callback    or function() end

				local InFrame = Instance.new("Frame")
				InFrame.Size             = UDim2.new(1, 0, 0, 52)
				InFrame.BackgroundColor3 = C.BtnBG
				InFrame.BorderSizePixel  = 0
				InFrame.LayoutOrder      = nextOrder()
				InFrame.ZIndex           = 5
				InFrame.Parent           = SecFrame
				Corner(InFrame, 6)
				Stroke(InFrame, 1, C.NeonDim, 0)
				Pad(InFrame, 7, 10, 7, 10)

				local InLayout = Instance.new("UIListLayout")
				InLayout.Padding   = UDim.new(0, 4)
				InLayout.SortOrder = Enum.SortOrder.LayoutOrder
				InLayout.Parent    = InFrame

				local InLabel = Instance.new("TextLabel")
				InLabel.Size                = UDim2.new(1, 0, 0, 14)
				InLabel.BackgroundTransparency = 1
				InLabel.Text                = name
				InLabel.TextColor3          = C.TextSub
				InLabel.TextSize            = 10
				InLabel.Font                = Enum.Font.Gotham
				InLabel.TextXAlignment      = Enum.TextXAlignment.Left
				InLabel.LayoutOrder         = 0
				InLabel.ZIndex              = 6
				InLabel.Parent              = InFrame

				local InBox = Instance.new("TextBox")
				InBox.Size              = UDim2.new(1, 0, 0, 24)
				InBox.BackgroundColor3  = C.InputBG
				InBox.Text              = ""
				InBox.PlaceholderText   = placeholder
				InBox.PlaceholderColor3 = C.TextSub
				InBox.TextColor3        = C.TextMain
				InBox.TextSize          = 12
				InBox.Font              = Enum.Font.Gotham
				InBox.TextXAlignment    = Enum.TextXAlignment.Left
				InBox.BorderSizePixel   = 0
				InBox.ClearTextOnFocus  = false
				InBox.LayoutOrder       = 1
				InBox.ZIndex            = 6
				InBox.Parent            = InFrame
				Corner(InBox, 4)
				local InStroke = Stroke(InBox, 1, C.NeonDim, 0)
				Pad(InBox, 0, 6, 0, 6)

				-- Glow saat fokus
				InBox.Focused:Connect(function()
					Tween(InStroke, { Color = C.Neon }, 0.15)
				end)
				-- Callback saat Enter / klik keluar
				InBox.FocusLost:Connect(function(enter)
					Tween(InStroke, { Color = C.NeonDim }, 0.15)
					if enter then callback(InBox.Text) end
				end)

				local InputAPI = {}
				function InputAPI:Get() return InBox.Text end
				function InputAPI:Set(val) InBox.Text = val end
				return InputAPI
			end

			-- ──────────────────────────────────────────
			-- Section:AddDropdown()
			-- ──────────────────────────────────────────
			function Section:AddDropdown(cfg)
				cfg = cfg or {}
				local name     = cfg.Name     or "Dropdown"
				local options  = cfg.Options  or {}
				local default  = cfg.Default  or (options[1] or "")
				local callback = cfg.Callback or function() end

				local selected = default
				local isOpen   = false

				local DDFrame = Instance.new("Frame")
				DDFrame.Size             = UDim2.new(1, 0, 0, 52)
				DDFrame.BackgroundColor3 = C.BtnBG
				DDFrame.BorderSizePixel  = 0
				DDFrame.ClipsDescendants = false   -- PENTING: list harus bisa muncul ke bawah
				DDFrame.LayoutOrder      = nextOrder()
				DDFrame.ZIndex           = 6
				DDFrame.Parent           = SecFrame
				Corner(DDFrame, 6)
				Stroke(DDFrame, 1, C.NeonDim, 0)
				Pad(DDFrame, 7, 10, 7, 10)

				local DDLayout = Instance.new("UIListLayout")
				DDLayout.Padding   = UDim.new(0, 4)
				DDLayout.SortOrder = Enum.SortOrder.LayoutOrder
				DDLayout.Parent    = DDFrame

				local DDLabel = Instance.new("TextLabel")
				DDLabel.Size                = UDim2.new(1, 0, 0, 14)
				DDLabel.BackgroundTransparency = 1
				DDLabel.Text                = name
				DDLabel.TextColor3          = C.TextSub
				DDLabel.TextSize            = 10
				DDLabel.Font                = Enum.Font.Gotham
				DDLabel.TextXAlignment      = Enum.TextXAlignment.Left
				DDLabel.LayoutOrder         = 0
				DDLabel.ZIndex              = 7
				DDLabel.Parent              = DDFrame

				-- Tombol tampil nilai terpilih
				local DDBtn = Instance.new("TextButton")
				DDBtn.Size             = UDim2.new(1, 0, 0, 24)
				DDBtn.BackgroundColor3 = C.InputBG
				DDBtn.Text             = selected .. "  "
				DDBtn.TextColor3       = C.TextMain
				DDBtn.TextSize         = 12
				DDBtn.Font             = Enum.Font.GothamSemibold
				DDBtn.TextXAlignment   = Enum.TextXAlignment.Left
				DDBtn.BorderSizePixel  = 0
				DDBtn.LayoutOrder      = 1
				DDBtn.ZIndex           = 7
				DDBtn.Parent           = DDFrame
				Corner(DDBtn, 4)
				local DDBtnStroke = Stroke(DDBtn, 1, C.NeonDim, 0)
				Pad(DDBtn, 0, 6, 0, 6)

                local ArrowLabel = Instance.new("TextLabel")
                ArrowLabel.Size                = UDim2.new(0, 20, 1, 0)
                ArrowLabel.Position            = UDim2.new(1, -20, 0, 0)
                ArrowLabel.BackgroundTransparency = 1
                ArrowLabel.Text                = "▼"
                ArrowLabel.TextColor3          = C.TextSub
                ArrowLabel.TextSize            = 10
                ArrowLabel.Font                = Enum.Font.GothamBold
                ArrowLabel.TextXAlignment      = Enum.TextXAlignment.Center
                ArrowLabel.ZIndex              = 8
                ArrowLabel.Parent              = DDBtn

				-- List opsi (muncul ke bawah saat klik)
				local listH   = math.min(#options, 5) * 28 + 8
				local DDList  = Instance.new("Frame")
				DDList.Size             = UDim2.new(1, 0, 0, listH)
				DDList.Position         = UDim2.new(0, 0, 1, 6)
				DDList.BackgroundColor3 = C.Panel
				DDList.BorderSizePixel  = 0
				DDList.Visible          = false
				DDList.ClipsDescendants = false
				DDList.ZIndex           = 30
				DDList.Parent           = ScreenGui
				Corner(DDList, 6)
				Stroke(DDList, 1.5, C.Neon, 0)
				Pad(DDList, 4, 4, 4, 4)

				local DetectorBtn = Instance.new("TextButton")
				DetectorBtn.Size                   = UDim2.new(1, 0, 1, 0)
				DetectorBtn.BackgroundTransparency = 1
				DetectorBtn.Text                   = ""
				DetectorBtn.ZIndex                 = 29
				DetectorBtn.Visible                = false
				DetectorBtn.Parent                 = ScreenGui

				table.insert(ddClosers, function()
					isOpen                  = false
					DDList.Visible          = false
					DetectorBtn.Visible     = false
					Tween(DDBtnStroke, { Color = C.NeonDim }, 0.15)
				end)

				local DDCloseBar = Instance.new("TextButton")
				DDCloseBar.Size             = UDim2.new(1, 0, 0, 24)
				DDCloseBar.BackgroundColor3 = C.Header
				DDCloseBar.Text             = "▲"
				DDCloseBar.TextColor3       = C.TextSub
				DDCloseBar.TextSize         = 11
				DDCloseBar.Font             = Enum.Font.GothamSemibold
				DDCloseBar.TextXAlignment   = Enum.TextXAlignment.Right
				DDCloseBar.BorderSizePixel  = 0
				DDCloseBar.ZIndex           = 32
				DDCloseBar.Parent           = DDList
				Corner(DDCloseBar, 4)
				Pad(DDCloseBar, 0, 6, 0, 6)

				DDCloseBar.MouseButton1Click:Connect(function()
					isOpen              = false
					DDList.Visible      = false
					DetectorBtn.Visible = false
                    ArrowLabel.Text     = "▼"
					Tween(DDBtnStroke, { Color = C.NeonDim }, 0.15)
				end)

				-- ScrollingFrame di dalam list (kalau opsi banyak)
				local DDScroll = Instance.new("ScrollingFrame")
				DDScroll.Size                 = UDim2.new(1, 0, 1, 0)
				DDScroll.BackgroundTransparency = 1
				DDScroll.BorderSizePixel      = 0
				DDScroll.ScrollBarThickness   = 2
				DDScroll.ScrollBarImageColor3 = C.Neon
				DDScroll.CanvasSize           = UDim2.new(0, 0, 0, 0)
				DDScroll.AutomaticCanvasSize  = Enum.AutomaticSize.Y
				DDScroll.ZIndex               = 31
				DDScroll.Parent               = DDList
				DDScroll.Position = UDim2.new(0, 0, 0, 28)
				DDScroll.Size     = UDim2.new(1, 0, 1, -28)

				local DDSLayout = Instance.new("UIListLayout")
				DDSLayout.Padding   = UDim.new(0, 2)
				DDSLayout.SortOrder = Enum.SortOrder.LayoutOrder
				DDSLayout.Parent    = DDScroll

				-- Buat tombol per opsi
				for i, opt in ipairs(options) do
					local isSel  = opt == selected
					local OptBtn = Instance.new("TextButton")
					OptBtn.Size             = UDim2.new(1, 0, 0, 26)
					OptBtn.BackgroundColor3 = isSel and C.TabActive or C.BtnBG
					OptBtn.Text             = opt
					OptBtn.TextColor3       = isSel and C.TextMain or C.TextSub
					OptBtn.TextSize         = 12
					OptBtn.Font             = Enum.Font.GothamSemibold
					OptBtn.TextXAlignment   = Enum.TextXAlignment.Left
					OptBtn.BorderSizePixel  = 0
					OptBtn.LayoutOrder      = i
					OptBtn.ZIndex           = 32
					OptBtn.Parent           = DDScroll
					Corner(OptBtn, 4)
					Pad(OptBtn, 0, 6, 0, 8)

					OptBtn.MouseEnter:Connect(function()
						if opt ~= selected then
							Tween(OptBtn, { BackgroundColor3 = C.BtnHover }, 0.1)
						end
					end)
					OptBtn.MouseLeave:Connect(function()
						if opt ~= selected then
							Tween(OptBtn, { BackgroundColor3 = C.BtnBG }, 0.1)
						end
					end)
					OptBtn.MouseButton1Click:Connect(function()
						-- Reset semua opsi
						for _, child in ipairs(DDScroll:GetChildren()) do
							if child:IsA("TextButton") then
								Tween(child, { BackgroundColor3 = C.BtnBG }, 0.1)
								child.TextColor3 = C.TextSub
							end
						end
						-- Aktifkan opsi terpilih
						Tween(OptBtn, { BackgroundColor3 = C.TabActive }, 0.1)
						OptBtn.TextColor3    = C.TextMain
						selected             = opt
						DDBtn.Text = name .. ": " .. selected .. "  "
						Tween(DDBtnStroke, { Color = C.NeonDim }, 0.15)
						callback(selected)
					end)
				end

				-- Toggle list saat klik DDBtn
				DDBtn.MouseButton1Click:Connect(function()
					isOpen = not isOpen
                    ArrowLabel.Text = isOpen and "▲" or "▼"
					DetectorBtn.Visible = isOpen
					if isOpen then
						local abs  = DDBtn.AbsolutePosition
						local size = DDBtn.AbsoluteSize
						DDList.Position = UDim2.new(0, abs.X, 0, abs.Y + size.Y + 4)
						DDList.Size     = UDim2.new(0, size.X, 0, listH)
					end
					DDList.Visible = isOpen
					Tween(DDBtnStroke, { Color = isOpen and C.Neon or C.NeonDim }, 0.15)
				end)

				DetectorBtn.MouseButton1Click:Connect(function()
					isOpen             = false
					DDList.Visible     = false
					DetectorBtn.Visible = false
					Tween(DDBtnStroke, { Color = C.NeonDim }, 0.15)
				end)

				local DDAPI = {}
				function DDAPI:Get() return selected end
				function DDAPI:Set(val)
					if table.find(options, val) then
						selected   = val
						DDBtn.Text = selected .. "  ▼"
						callback(selected)
					end
				end
				return DDAPI
			end

			-- ──────────────────────────────────────────
			-- Section:AddKeybind()
			-- ──────────────────────────────────────────
			function Section:AddKeybind(cfg)
				cfg = cfg or {}
				local name     = cfg.Name     or "Keybind"
				local default  = cfg.Default  or Enum.KeyCode.Unknown
				local callback = cfg.Callback or function() end

				local currentBind = default
				local listening   = false

				local KBFrame = Instance.new("Frame")
				KBFrame.Size             = UDim2.new(1, 0, 0, 32)
				KBFrame.BackgroundColor3 = C.BtnBG
				KBFrame.BorderSizePixel  = 0
				KBFrame.LayoutOrder      = nextOrder()
				KBFrame.ZIndex           = 5
				KBFrame.Parent           = SecFrame
				Corner(KBFrame, 6)
				Stroke(KBFrame, 1, C.NeonDim, 0)
				Pad(KBFrame, 0, 10, 0, 10)

				local KBLabel = Instance.new("TextLabel")
				KBLabel.Size                = UDim2.new(1, -90, 1, 0)
				KBLabel.BackgroundTransparency = 1
				KBLabel.Text                = name
				KBLabel.TextColor3          = C.TextMain
				KBLabel.TextSize            = 13
				KBLabel.Font                = Enum.Font.GothamSemibold
				KBLabel.TextXAlignment      = Enum.TextXAlignment.Left
				KBLabel.ZIndex              = 6
				KBLabel.Parent              = KBFrame

				local KBBtn = Instance.new("TextButton")
				KBBtn.Size             = UDim2.new(0, 80, 0, 22)
				KBBtn.Position         = UDim2.new(1, -80, 0.5, -11)
				KBBtn.BackgroundColor3 = C.InputBG
				KBBtn.Text             = currentBind.Name
				KBBtn.TextColor3       = C.Neon
				KBBtn.TextSize         = 11
				KBBtn.Font             = Enum.Font.GothamBold
				KBBtn.BorderSizePixel  = 0
				KBBtn.ZIndex           = 6
				KBBtn.Parent           = KBFrame
				Corner(KBBtn, 4)
				local KBStroke = Stroke(KBBtn, 1, C.NeonDim, 0)

				-- Klik → mode mendengarkan (listening)
				KBBtn.MouseButton1Click:Connect(function()
					listening        = true
					KBBtn.Text       = "..."
					KBBtn.TextColor3 = Color3.fromRGB(255, 210, 0)
					Tween(KBStroke, { Color = Color3.fromRGB(200, 160, 0) }, 0.15)
				end)

				UserInputService.InputBegan:Connect(function(input, processed)
					if processed then return end

					if listening then
						-- Mode listening: tangkap key apapun
						if input.UserInputType == Enum.UserInputType.Keyboard then
							currentBind      = input.KeyCode
							KBBtn.Text       = currentBind.Name
							KBBtn.TextColor3 = C.Neon
							Tween(KBStroke, { Color = C.NeonDim }, 0.15)
							listening = false
						end
					else
						-- Mode normal: cek apakah key yang ditekan cocok
						if input.KeyCode == currentBind
							and currentBind ~= Enum.KeyCode.Unknown then
							callback(currentBind)
						end
					end
				end)

				local KBAPI = {}
				function KBAPI:Get() return currentBind end
				return KBAPI
			end

			return Section
		end -- AddSection

		return Tab
	end -- AddTab

	return Window
end -- CreateWindow

return KurooUI
