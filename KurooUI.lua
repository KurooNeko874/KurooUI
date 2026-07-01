--[[
╔══════════════════════════════════════════════════════════════╗
║  version: 1.1.0                                              ║
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

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

-- ================================================================
-- PALETTE TEMA (2 opsi, dipilih via config.Theme di CreateWindow)
-- Keduanya sama-sama background NAVY, bedanya cuma warna outline/aksen:
--   Theme = "Cyan"   -> BG navy, outline & aksen CYAN,   teks kuning
--   Theme = "Yellow" -> BG navy, outline & aksen KUNING, teks kuning
-- ================================================================
local THEMES = {
	Cyan = {
		BG        = Color3.fromRGB(13,  27,  42),
		Panel     = Color3.fromRGB(8,   18,  32),
		Header    = Color3.fromRGB(5,   12,  24),
		Neon      = Color3.fromRGB(0,  207, 255),   -- outline/stroke -> cyan
		NeonDim   = Color3.fromRGB(0,   80, 140),   -- outline/stroke redup -> cyan

		TextMain  = Color3.fromRGB(0,  208, 255),   -- teks utama -> kuning
		TextSub   = Color3.fromRGB(0,  208, 255),   -- teks sekunder -> kuning redup
		TextAccent= Color3.fromRGB(0,  208, 255),   -- teks aksen (angka, terpilih) -> kuning

		BtnBG     = Color3.fromRGB(10,  35,  60),
		BtnHover  = Color3.fromRGB(15,  55,  90),
		TabActive = Color3.fromRGB(0,  100, 180),
		TabInact  = Color3.fromRGB(8,   25,  48),
		ToggleOn  = Color3.fromRGB(0,  200, 255),
		ToggleOff = Color3.fromRGB(20,  45,  70),
		SliderFill= Color3.fromRGB(0,  150, 220),
		InputBG   = Color3.fromRGB(5,   15,  30),

		TabTextActive = Color3.fromRGB(62, 176, 194),
		TabTextInact  = Color3.fromRGB(25, 138, 132),
	},

	Yellow = {
		BG        = Color3.fromRGB(0,   0,   0 ),
		Panel     = Color3.fromRGB(0,   0,   0 ),
		Header    = Color3.fromRGB(0,   0,   0 ),
		Neon      = Color3.fromRGB(255, 210, 40),   -- outline/stroke -> kuning
		NeonDim   = Color3.fromRGB(140, 115, 20),   -- outline/stroke redup -> kuning gelap

		TextMain  = Color3.fromRGB(255, 221, 51),   -- teks utama -> kuning
		TextSub   = Color3.fromRGB(200, 175, 60),   -- teks sekunder -> kuning redup
		TextAccent= Color3.fromRGB(255, 221, 51),   -- teks aksen -> kuning

		BtnBG     = Color3.fromRGB(56,  53,  39),
		BtnHover  = Color3.fromRGB(56,  53,  39),
		TabActive = Color3.fromRGB(178, 191,  0),   -- aksen tab aktif -> kuning tua/navy campur
		TabInact  = Color3.fromRGB(73, 77, 0),
		ToggleOn  = Color3.fromRGB(255, 210, 40),   -- toggle nyala -> kuning
		ToggleOff = Color3.fromRGB(43,  36,   8),
		SliderFill= Color3.fromRGB(255, 200, 30),   -- isi slider -> kuning
		InputBG   = Color3.fromRGB(41,  33,   0),

		TabTextActive = Color3.fromRGB(20,  16,  4),   -- di atas BG kuning (TabActive), teks gelap biar kebaca
		TabTextInact  = Color3.fromRGB(200, 175, 60),
	},

	Emerald = {
		BG        = Color3.fromRGB(235, 250, 240),
		Panel     = Color3.fromRGB(220, 242, 228),
		Header    = Color3.fromRGB(200, 232, 212),
		Neon      = Color3.fromRGB(0,   180, 90),
		NeonDim   = Color3.fromRGB(120, 200, 160),

		TextMain  = Color3.fromRGB(10,  90,  50),
		TextSub   = Color3.fromRGB(40,  120, 80),
		TextAccent= Color3.fromRGB(0,   150, 75),

		BtnBG     = Color3.fromRGB(210, 238, 220),
		BtnHover  = Color3.fromRGB(190, 228, 205),
		TabActive = Color3.fromRGB(0,   170, 85),
		TabInact  = Color3.fromRGB(200, 232, 212),
		ToggleOn  = Color3.fromRGB(0,   190, 95),
		ToggleOff = Color3.fromRGB(180, 210, 190),
		SliderFill= Color3.fromRGB(0,   170, 85),
		InputBG   = Color3.fromRGB(245, 253, 248),

		TabTextActive = Color3.fromRGB(255, 255, 255),
		TabTextInact  = Color3.fromRGB(50,  110, 75),
	},

	Ruby = {
		BG        = Color3.fromRGB(255, 235, 235),
		Panel     = Color3.fromRGB(250, 218, 218),
		Header    = Color3.fromRGB(245, 200, 200),
		Neon      = Color3.fromRGB(230, 20,  50),
		NeonDim   = Color3.fromRGB(240, 130, 140),

		TextMain  = Color3.fromRGB(140, 0,   30),
		TextSub   = Color3.fromRGB(170, 40,  55),
		TextAccent= Color3.fromRGB(210, 10,  40),

		BtnBG     = Color3.fromRGB(248, 210, 212),
		BtnHover  = Color3.fromRGB(242, 190, 195),
		TabActive = Color3.fromRGB(220, 20,  55),
		TabInact  = Color3.fromRGB(245, 205, 208),
		ToggleOn  = Color3.fromRGB(225, 25,  60),
		ToggleOff = Color3.fromRGB(230, 190, 192),
		SliderFill= Color3.fromRGB(215, 20,  50),
		InputBG   = Color3.fromRGB(253, 245, 245),

		TabTextActive = Color3.fromRGB(255, 255, 255),
		TabTextInact  = Color3.fromRGB(150, 40,  55),
	},

	Bloody = {
		BG        = Color3.fromRGB(18,  4,   6 ),
		Panel     = Color3.fromRGB(12,  2,   4 ),
		Header    = Color3.fromRGB(8,   1,   2 ),
		Neon      = Color3.fromRGB(200, 0,   20),
		NeonDim   = Color3.fromRGB(90,  0,   15),

		TextMain  = Color3.fromRGB(220, 30,  40),
		TextSub   = Color3.fromRGB(160, 20,  30),
		TextAccent= Color3.fromRGB(255, 40,  50),

		BtnBG     = Color3.fromRGB(30,  6,   9 ),
		BtnHover  = Color3.fromRGB(45,  9,   13),
		TabActive = Color3.fromRGB(150, 0,   20),
		TabInact  = Color3.fromRGB(22,  4,   6 ),
		ToggleOn  = Color3.fromRGB(200, 0,   25),
		ToggleOff = Color3.fromRGB(35,  8,   10),
		SliderFill= Color3.fromRGB(180, 0,   20),
		InputBG   = Color3.fromRGB(10,  2,   3 ),

		TabTextActive = Color3.fromRGB(255, 220, 220),
		TabTextInact  = Color3.fromRGB(140, 40,  45),
	},

	Darkness = {
		BG        = Color3.fromRGB(15,  8,   22 ),
		Panel     = Color3.fromRGB(10,  5,   16 ),
		Header    = Color3.fromRGB(6,   3,   11 ),
		Neon      = Color3.fromRGB(160, 60,  230),
		NeonDim   = Color3.fromRGB(80,  30,  120),

		TextMain  = Color3.fromRGB(190, 130, 240),
		TextSub   = Color3.fromRGB(140, 90,  180),
		TextAccent= Color3.fromRGB(200, 100, 255),

		BtnBG     = Color3.fromRGB(24,  12,  34 ),
		BtnHover  = Color3.fromRGB(36,  18,  50 ),
		TabActive = Color3.fromRGB(120, 40,  190),
		TabInact  = Color3.fromRGB(18,  9,   27 ),
		ToggleOn  = Color3.fromRGB(170, 70,  240),
		ToggleOff = Color3.fromRGB(28,  16,  40 ),
		SliderFill= Color3.fromRGB(150, 60,  220),
		InputBG   = Color3.fromRGB(8,   4,   13 ),

		TabTextActive = Color3.fromRGB(255, 255, 255),
		TabTextInact  = Color3.fromRGB(120, 80,  160),
	},

	Sakura = {
		-- pink lembut, BG putih kemerahmudaan — kontras manis buat UI casual
		BG        = Color3.fromRGB(255, 240, 245),
		Panel     = Color3.fromRGB(250, 222, 232),
		Header    = Color3.fromRGB(245, 205, 220),
		Neon      = Color3.fromRGB(255, 110, 160),
		NeonDim   = Color3.fromRGB(240, 170, 195),

		TextMain  = Color3.fromRGB(160, 20,  70 ),
		TextSub   = Color3.fromRGB(190, 70,  110),
		TextAccent= Color3.fromRGB(230, 30,  110),

		BtnBG     = Color3.fromRGB(248, 214, 226),
		BtnHover  = Color3.fromRGB(242, 195, 210),
		TabActive = Color3.fromRGB(255, 100, 150),
		TabInact  = Color3.fromRGB(246, 210, 222),
		ToggleOn  = Color3.fromRGB(255, 105, 155),
		ToggleOff = Color3.fromRGB(232, 195, 205),
		SliderFill= Color3.fromRGB(255, 95,  145),
		InputBG   = Color3.fromRGB(253, 246, 249),

		TabTextActive = Color3.fromRGB(255, 255, 255),
		TabTextInact  = Color3.fromRGB(170, 60,  90 ),
	},

	Solar = {
		-- oranye terbakar, BG gelap kecoklatan — beda dari Yellow, lebih "hangat"
		BG        = Color3.fromRGB(20,  12,  6  ),
		Panel     = Color3.fromRGB(14,  8,   4  ),
		Header    = Color3.fromRGB(9,   5,   2  ),
		Neon      = Color3.fromRGB(255, 130, 20 ),
		NeonDim   = Color3.fromRGB(150, 75,  15 ),

		TextMain  = Color3.fromRGB(255, 170, 80 ),
		TextSub   = Color3.fromRGB(200, 130, 60 ),
		TextAccent= Color3.fromRGB(255, 150, 40 ),

		BtnBG     = Color3.fromRGB(30,  18,  9  ),
		BtnHover  = Color3.fromRGB(45,  27,  13 ),
		TabActive = Color3.fromRGB(220, 100, 15 ),
		TabInact  = Color3.fromRGB(22,  13,  6  ),
		ToggleOn  = Color3.fromRGB(255, 140, 25 ),
		ToggleOff = Color3.fromRGB(35,  22,  11 ),
		SliderFill= Color3.fromRGB(240, 120, 20 ),
		InputBG   = Color3.fromRGB(7,   4,   2  ),

		TabTextActive = Color3.fromRGB(20,  10,  4  ),
		TabTextInact  = Color3.fromRGB(180, 110, 50 ),
	},

	Frost = {
		-- biru es, BG putih kebiruan — clean & cerah
		BG        = Color3.fromRGB(235, 245, 255),
		Panel     = Color3.fromRGB(215, 232, 250),
		Header    = Color3.fromRGB(195, 218, 245),
		Neon      = Color3.fromRGB(60,  150, 255),
		NeonDim   = Color3.fromRGB(140, 190, 240),

		TextMain  = Color3.fromRGB(10,  60,  120),
		TextSub   = Color3.fromRGB(50,  100, 160),
		TextAccent= Color3.fromRGB(20,  110, 220),

		BtnBG     = Color3.fromRGB(205, 225, 248),
		BtnHover  = Color3.fromRGB(185, 212, 242),
		TabActive = Color3.fromRGB(40,  130, 240),
		TabInact  = Color3.fromRGB(200, 222, 246),
		ToggleOn  = Color3.fromRGB(50,  145, 250),
		ToggleOff = Color3.fromRGB(190, 210, 230),
		SliderFill= Color3.fromRGB(35,  135, 245),
		InputBG   = Color3.fromRGB(245, 250, 255),

		TabTextActive = Color3.fromRGB(255, 255, 255),
		TabTextInact  = Color3.fromRGB(60,  100, 150),
	},

	Toxic = {
		-- hijau neon racun, BG hitam kehijauan
		BG        = Color3.fromRGB(8,   18,  10 ),
		Panel     = Color3.fromRGB(5,   13,  7  ),
		Header    = Color3.fromRGB(3,   9,   4  ),
		Neon      = Color3.fromRGB(140, 255, 40 ),
		NeonDim   = Color3.fromRGB(70,  150, 30 ),

		TextMain  = Color3.fromRGB(170, 255, 90 ),
		TextSub   = Color3.fromRGB(110, 190, 60 ),
		TextAccent= Color3.fromRGB(150, 255, 50 ),

		BtnBG     = Color3.fromRGB(14,  26,  15 ),
		BtnHover  = Color3.fromRGB(20,  38,  22 ),
		TabActive = Color3.fromRGB(100, 220, 20 ),
		TabInact  = Color3.fromRGB(10,  20,  11 ),
		ToggleOn  = Color3.fromRGB(150, 255, 45 ),
		ToggleOff = Color3.fromRGB(24,  35,  20 ),
		SliderFill= Color3.fromRGB(130, 240, 35 ),
		InputBG   = Color3.fromRGB(4,   10,  5  ),

		TabTextActive = Color3.fromRGB(5,   15,  3  ),
		TabTextInact  = Color3.fromRGB(90,  150, 55 ),
	},

	Monochrome = {
		-- abu-abu murni, BG putih bersih — netral, minimalis
		BG        = Color3.fromRGB(245, 245, 245),
		Panel     = Color3.fromRGB(225, 225, 225),
		Header    = Color3.fromRGB(200, 200, 200),
		Neon      = Color3.fromRGB(60,  60,  60 ),
		NeonDim   = Color3.fromRGB(160, 160, 160),

		TextMain  = Color3.fromRGB(20,  20,  20 ),
		TextSub   = Color3.fromRGB(90,  90,  90 ),
		TextAccent= Color3.fromRGB(0,   0,   0  ),

		BtnBG     = Color3.fromRGB(215, 215, 215),
		BtnHover  = Color3.fromRGB(195, 195, 195),
		TabActive = Color3.fromRGB(50,  50,  50 ),
		TabInact  = Color3.fromRGB(210, 210, 210),
		ToggleOn  = Color3.fromRGB(40,  40,  40 ),
		ToggleOff = Color3.fromRGB(190, 190, 190),
		SliderFill= Color3.fromRGB(30,  30,  30 ),
		InputBG   = Color3.fromRGB(250, 250, 250),

		TabTextActive = Color3.fromRGB(255, 255, 255),
		TabTextInact  = Color3.fromRGB(80,  80,  80 ),
	},
}

-- Palette aktif (default Cyan). Diisi ulang di dalam CreateWindow
-- sesuai config.Theme, lalu semua elemen dibuat memakai C ini.
local C = THEMES.Cyan

-- ================================================================
-- HELPERS
-- ================================================================
local function new(class, props, children)
	local inst = Instance.new(class)
	if props then
		for k, v in pairs(props) do
			inst[k] = v
		end
	end
	if children then
		for _, c in ipairs(children) do
			c.Parent = inst
		end
	end
	return inst
end

local function corner(radius)
	return new("UICorner", { CornerRadius = UDim.new(0, radius or 6) })
end

local function stroke(color, thickness, transparency)
	return new("UIStroke", {
		Color = color or C.NeonDim,
		Thickness = thickness or 1,
		Transparency = transparency or 0,
	})
end

local function pad(l, t, r, b)
	return new("UIPadding", {
		PaddingLeft = UDim.new(0, l or 0),
		PaddingTop = UDim.new(0, t or 0),
		PaddingRight = UDim.new(0, r or l or 0),
		PaddingBottom = UDim.new(0, b or t or 0),
	})
end

local function tween(obj, info, props)
	local t = TweenService:Create(obj, info, props)
	t:Play()
	return t
end

local QUICK = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local SMOOTH = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

-- ----------------------------------------------------------------
-- FIX #1: Draggable yang benar
-- Sebelumnya pakai "Enum.InputUserState" (typo/invalid) sehingga
-- dragging tidak pernah berhenti. Sekarang pakai koneksi global
-- UserInputService.InputEnded yang benar dan selalu ter-disconnect
-- dengan rapi melalui tabel `connections` yang dikembalikan.
-- ----------------------------------------------------------------
-- ----------------------------------------------------------------
-- FIX DRAGGABLE (v3 - final):
-- Percobaan sebelumnya masih gagal karena GuiObject.InputBegan pada
-- Frame biasa kadang tidak reliable menangkap event walau Active=true
-- sudah di-set (tergantung ZIndexBehavior, ClipsDescendants parent,
-- dan urutan render). Solusi paling stabil (dipakai banyak UI library
-- production seperti Rayfield/Fluent) adalah:
--   1. Tangkap InputBegan LANGSUNG dari UserInputService (global),
--      lalu cek apakah posisi mouse/touch berada di dalam batas
--      (bounds) dragHandle saat itu terjadi.
--   2. Gunakan input.UserInputState untuk tahu kapan dimulai/berakhir
--      (bukan bergantung pada GuiObject event yang bisa "diserap"
--      elemen lain).
-- Pendekatan ini tidak bergantung pada Active/ZIndex sama sekali.
-- ----------------------------------------------------------------
local function isPointInGui(guiObject, x, y)
	local pos = guiObject.AbsolutePosition
	local size = guiObject.AbsoluteSize
	return x >= pos.X and x <= pos.X + size.X
		and y >= pos.Y and y <= pos.Y + size.Y
end

local function makeDraggable(frame, dragHandle, connectionsTable)
	local dragging = false
	local dragStart, startPos

	local c1 = UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then return end -- klik sudah kena tombol lain (mis. Close/Settings)
		if input.UserInputType ~= Enum.UserInputType.MouseButton1
			and input.UserInputType ~= Enum.UserInputType.Touch then
			return
		end
		local pos = input.Position
		if isPointInGui(dragHandle, pos.X, pos.Y) then
			dragging = true
			dragStart = Vector2.new(pos.X, pos.Y)
			startPos = frame.Position
		end
	end)

	local c2 = UserInputService.InputChanged:Connect(function(input)
		if not dragging then return end
		if input.UserInputType ~= Enum.UserInputType.MouseMovement
			and input.UserInputType ~= Enum.UserInputType.Touch then
			return
		end
		local pos = input.Position
		local delta = Vector2.new(pos.X, pos.Y) - dragStart
		frame.Position = UDim2.new(
			startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y
		)
	end)

	local c3 = UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)

	if connectionsTable then
		table.insert(connectionsTable, c1)
		table.insert(connectionsTable, c2)
		table.insert(connectionsTable, c3)
	end
end

-- ----------------------------------------------------------------
-- FIX #4: Parser keybind yang benar (PascalCase penuh, bukan cuma
-- huruf pertama), plus validasi terhadap Enum.KeyCode asli.
-- ----------------------------------------------------------------
local function parseKeyCodeInput(text)
	if not text or text == "" then return nil end
	-- Coba exact match dulu (case sensitive langsung ke Enum)
	local direct = Enum.KeyCode[text]
	if direct then return direct end

	-- Normalisasi: hapus spasi, PascalCase tiap kata alfabet
	local cleaned = text:gsub("%s+", "")
	local pascal = cleaned:sub(1,1):upper() .. cleaned:sub(2):lower()
	local ok, result = pcall(function() return Enum.KeyCode[pascal] end)
	if ok and result then return result end

	-- Coba juga uppercase penuh untuk single-letter (K, F1, dst)
	local upperAll = cleaned:upper()
	ok, result = pcall(function() return Enum.KeyCode[upperAll] end)
	if ok and result then return result end

	return nil
end

-- ================================================================
-- LIBRARY UTAMA
-- ================================================================
local KurooUILib = {}

function KurooUILib.new()

	local KurooUI = {}

	local ScreenGui = new("ScreenGui", {
		Name = "KurooUI_Enhanced",
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		DisplayOrder = 100,
		Enabled = true,
	})

	local function parentScreenGui()
		if ScreenGui.Parent then return end
		local isStudio = RunService:IsStudio()
		if isStudio then
			local player = Players.LocalPlayer or Players:WaitForChild("LocalPlayer")
			ScreenGui.Parent = player:WaitForChild("PlayerGui")
		elseif typeof(gethui) == "function" then
			ScreenGui.Parent = gethui()
		elseif typeof(syn) == "table" and syn.protect_gui then
			syn.protect_gui(ScreenGui)
			ScreenGui.Parent = CoreGui
		else
			local ok = pcall(function() ScreenGui.Parent = CoreGui end)
			if not ok or ScreenGui.Parent ~= CoreGui then
				local player = Players.LocalPlayer or Players:WaitForChild("LocalPlayer")
				ScreenGui.Parent = player:WaitForChild("PlayerGui")
			end
		end
	end

	-- ================================================================
	-- CREATE WINDOW
	-- ================================================================
	function KurooUI:CreateWindow(config)
		config = config or {}
		local title      = config.Title   or "KurooUI"
		local defaultKey = config.HideKey or Enum.KeyCode.K
		local sizeW      = config.W       or 400
		local sizeH      = config.H       or 350
		local icon 		 = config.Icon    or nil

		-- Pilih tema: config.Theme = "Cyan" (default) atau "Yellow"
		-- Contoh pemakaian di script lain:
		--   Window = KurooUI:CreateWindow({ Title = "App", Theme = "Yellow" })
		local themeName = config.Theme or "Cyan"
		if not THEMES[themeName] then
			warn("[KurooUI] Theme '" .. tostring(themeName) .. "' tidak ditemukan, pakai 'Cyan'.")
			themeName = "Cyan"
		end
		C = THEMES[themeName]

		parentScreenGui()

		local currentKey = defaultKey
		local isVisible  = true
		local tabs       = {}
		local activeTab  = nil

		-- Registry untuk cleanup total (FIX #6)
		local allConnections = {}
		local themeables = {} -- { instance = ..., prop = "BackgroundColor3", key = "BG" }

		local function trackConn(conn)
			table.insert(allConnections, conn)
			return conn
		end

		local function themed(inst, prop, key)
			table.insert(themeables, { inst = inst, prop = prop, key = key })
			return inst
		end

		-- ============================================================
		-- MAIN FRAME
		-- ============================================================
		local MainFrame = new("Frame", {
			Name = "MainFrame",
			Parent = ScreenGui,
			Size = UDim2.new(0, sizeW, 0, sizeH),
			Position = UDim2.new(0.5, -sizeW/2, 0.5, -sizeH/2),
			BackgroundColor3 = C.BG,
			BorderSizePixel = 0,
			ClipsDescendants = true,
		}, { corner(8), stroke(C.Neon, 5, 0) })
		themed(MainFrame, "BackgroundColor3", "BG")

		MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
		MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
		local CLOSE_ANIM = TweenInfo.new(0.4, Enum.EasingStyle.Exponential)

		local Shadow = new("ImageLabel", {
			Parent = MainFrame,
			Size = UDim2.new(1, 50, 1, 50),
			Position = UDim2.new(0, -25, 0, -25),
			BackgroundTransparency = 1,
			Image = "rbxassetid://6015897843",
			ImageColor3 = Color3.fromRGB(0, 0, 0),
			ImageTransparency = 0.55,
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = Rect.new(49, 49, 450, 450),
			ZIndex = -1,
		})

		-- ============================================================
		-- HEADER
		-- ============================================================
		local Header = new("Frame", {
			Name = "Header",
			Parent = MainFrame,
			Size = UDim2.new(1, 0, 0, 42),
			BackgroundColor3 = C.Header,
			BorderSizePixel = 0,
			ZIndex = 2,
		}, { corner(8) })
		themed(Header, "BackgroundColor3", "Header")

		local HeaderPatch = new("Frame", {
			Parent = Header,
			Size = UDim2.new(1, 0, 0, 10),
			Position = UDim2.new(0, 0, 1, -10),
			BackgroundColor3 = C.Header,
			BorderSizePixel = 0,
			ZIndex = 2,
		})
		themed(HeaderPatch, "BackgroundColor3", "Header")

		local HeaderLine = new("Frame", {
			Parent = Header,
			Size = UDim2.new(1, 0, 0, 1),
			Position = UDim2.new(0, 0, 1, 0),
			BackgroundColor3 = C.Neon,
			BorderSizePixel = 0,
			ZIndex = 3,
		})
		themed(HeaderLine, "BackgroundColor3", "Neon")

		local IconImage
		if icon then
			IconImage = new("ImageLabel", {
				Parent = Header,
				Size = UDim2.new(0, 27, 0, 27),
				Position = UDim2.new(0, 14, 0.5, -11),
				BackgroundTransparency = 1,
				Image = icon,
				ZIndex = 3,
			})
		end

		local TitleLabel = new("TextLabel", {
			Parent = Header,
			Size = UDim2.new(1, -100, 1, 0),
			Position = icon and UDim2.new(0, 44, 0, 0) or UDim2.new(0, 16, 0, 0),
			BackgroundTransparency = 1,
			Text = title,
			TextColor3 = C.TextMain,
			TextSize = 15,
			Font = Enum.Font.GothamBold,
			TextXAlignment = Enum.TextXAlignment.Left,
			ZIndex = 3,
		})
		themed(TitleLabel, "TextColor3", "TextMain")

		local BtnContainer = new("Frame", {
			Parent = Header,
			Size = UDim2.new(0, 84, 0, 30),
			Position = UDim2.new(1, -92, 0.5, -15),
			BackgroundTransparency = 1,
			ZIndex = 3,
		})
		new("UIListLayout", {
			Parent = BtnContainer,
			FillDirection = Enum.FillDirection.Horizontal,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			HorizontalAlignment = Enum.HorizontalAlignment.Right,
			Padding = UDim.new(0, 6),
		})

		local function headerButton(text, color)
			local btn = new("TextButton", {
				Parent = BtnContainer,
				Size = UDim2.new(0, 32, 0, 26),
				BackgroundColor3 = C.BtnBG,
				Text = text,
				TextColor3 = color,
				TextSize = 20,
				Font = Enum.Font.GothamBold,
				BorderSizePixel = 0,
				ZIndex = 4,
			}, { corner(5) })
			themed(btn, "BackgroundColor3", "BtnBG")
			trackConn(btn.MouseEnter:Connect(function() tween(btn, QUICK, { BackgroundColor3 = C.BtnHover }) end))
			trackConn(btn.MouseLeave:Connect(function() tween(btn, QUICK, { BackgroundColor3 = C.BtnBG }) end))
			return btn
		end

		local SettingsBtn = headerButton("≡", C.Neon)
		local CloseBtn   = headerButton("×", Color3.fromRGB(255, 80, 80))

		-- FIX #1 + #8: drag hanya di Header, tapi tombol2 di dalamnya
		-- otomatis "menang" karena TextButton menyerap InputBegan duluan
		-- (event tidak bubble ke Header untuk MouseButton1 pada child
		-- GuiButton), jadi tidak perlu guard tambahan -- namun kita tetap
		-- pastikan drag pakai listener global yang benar.
		makeDraggable(MainFrame, Header, allConnections)

		-- ============================================================
		-- LEFT PANEL (Tabs)
		-- ============================================================
		local LeftPanel = new("Frame", {
			Parent = MainFrame,
			Size = UDim2.new(0, 140, 1, -43),
			Position = UDim2.new(0, 0, 0, 43),
			BackgroundColor3 = C.Panel,
			BorderSizePixel = 0,
			ZIndex = 2,
		})
		themed(LeftPanel, "BackgroundColor3", "Panel")

		local LeftDivider = new("Frame", {
			Parent = LeftPanel,
			Size = UDim2.new(0, 1, 1, 0),
			Position = UDim2.new(1, 0, 0, 0),
			BackgroundColor3 = C.NeonDim,
			BorderSizePixel = 0,
			ZIndex = 3,
		})
		themed(LeftDivider, "BackgroundColor3", "NeonDim")

		local TabScroll = new("ScrollingFrame", {
			Parent = LeftPanel,
			Size = UDim2.new(1, -4, 1, 0),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ScrollBarThickness = 2,
			ScrollBarImageColor3 = C.Neon,
			CanvasSize = UDim2.new(0, 0, 0, 0),
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			ZIndex = 3,
		}, { pad(8, 6, 8, 6) })
		new("UIListLayout", {
			Parent = TabScroll,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 4),
		})

		-- ============================================================
		-- RIGHT PANEL (Content)
		-- ============================================================
		local RightPanel = new("Frame", {
			Parent = MainFrame,
			Size = UDim2.new(1, -141, 1, -43),
			Position = UDim2.new(0, 141, 0, 43),
			BackgroundColor3 = C.BG,
			BorderSizePixel = 0,
			ClipsDescendants = true,
			ZIndex = 2,
		})
		themed(RightPanel, "BackgroundColor3", "BG")

		local ContentScroll = new("ScrollingFrame", {
			Parent = RightPanel,
			Size = UDim2.new(1, -6, 1, -4),
			Position = UDim2.new(0, 3, 0, 2),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ScrollBarThickness = 3,
			ScrollBarImageColor3 = C.Neon,
			CanvasSize = UDim2.new(0, 0, 0, 0),
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			ClipsDescendants = true,
			ZIndex = 3,
		}, { pad(8, 8, 8, 8) })
		new("UIListLayout", {
			Parent = ContentScroll,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 8),
		})

		-- ============================================================
		-- SETTINGS PANEL (keybind hide/show UI)
		-- ============================================================
		local SettingsPanel = new("Frame", {
			Parent = MainFrame,
			Size = UDim2.new(0, 230, 0, 130),
			Position = UDim2.new(1, -238, 0, 46),
			BackgroundColor3 = C.Panel,
			BorderSizePixel = 0,
			Visible = false,
			ZIndex = 15,
		}, { corner(8), stroke(C.Neon, 1.5, 0) })
		themed(SettingsPanel, "BackgroundColor3", "Panel")

		new("TextLabel", {
			Parent = SettingsPanel,
			Size = UDim2.new(1, 0, 0, 38),
			BackgroundTransparency = 1,
			Text = "Settings Keybind",
			TextColor3 = C.TextMain,
			TextSize = 13,
			Font = Enum.Font.GothamBold,
			TextXAlignment = Enum.TextXAlignment.Left,
			ZIndex = 16,
		}, { pad(0, 0, 0, 14) })

		new("Frame", {
			Parent = SettingsPanel,
			Size = UDim2.new(1, -16, 0, 1),
			Position = UDim2.new(0, 8, 0, 38),
			BackgroundColor3 = C.NeonDim,
			BorderSizePixel = 0,
			ZIndex = 16,
		})

		local KeyInput = new("TextBox", {
			Parent = SettingsPanel,
			Size = UDim2.new(1, -16, 0, 30),
			Position = UDim2.new(0, 8, 0, 48),
			BackgroundColor3 = C.InputBG,
			Text = currentKey.Name,
			PlaceholderText = "e.g. F3, K, RightShift",
			TextColor3 = C.TextMain,
			PlaceholderColor3 = C.TextSub,
			TextSize = 12,
			Font = Enum.Font.GothamSemibold,
			BorderSizePixel = 0,
			ClearTextOnFocus = false,
			ZIndex = 16,
		}, { corner(6), pad(0, 8, 0, 8) })

		local SaveBtn = new("TextButton", {
			Parent = SettingsPanel,
			Size = UDim2.new(1, -16, 0, 30),
			Position = UDim2.new(0, 8, 0, 88),
			BackgroundColor3 = C.TabActive,
			Text = "💾  Save",
			TextColor3 = C.TextMain,
			TextSize = 13,
			Font = Enum.Font.GothamBold,
			BorderSizePixel = 0,
			ZIndex = 16,
		}, { corner(6) })
		trackConn(SaveBtn.MouseEnter:Connect(function() tween(SaveBtn, QUICK, { BackgroundColor3 = Color3.fromRGB(0, 130, 210) }) end))
		trackConn(SaveBtn.MouseLeave:Connect(function() tween(SaveBtn, QUICK, { BackgroundColor3 = C.TabActive }) end))

		-- ============================================================
		-- SPLIT-CLOSE OVERLAY (untuk animasi hide/unhide)
		-- ============================================================
		local TopPanel = new("Frame", {
			Name = "TopPanel",
			Parent = MainFrame,
			Size = UDim2.new(1, 0, 0, 0), -- start collapsed
			Position = UDim2.new(0, 0, 0, 0),
			BackgroundColor3 = C.BG,
			BorderSizePixel = 0,
			ZIndex = 50,
			Visible = false,
			ClipsDescendants = true,
		})
		themed(TopPanel, "BackgroundColor3", "BG")

		local BottomPanel = new("Frame", {
			Name = "BottomPanel",
			Parent = MainFrame,
			Size = UDim2.new(1, 0, 0, 0), -- start collapsed
			Position = UDim2.new(0, 0, 1, 0),
			AnchorPoint = Vector2.new(0, 1),
			BackgroundColor3 = C.BG,
			BorderSizePixel = 0,
			ZIndex = 50,
			Visible = false,
			ClipsDescendants = true,
		})
		themed(BottomPanel, "BackgroundColor3", "BG")

		local CLOSE_ANIM = TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut)

		-- ============================================================
		-- LOGIC: Hide / Show (animated split)
		-- ============================================================
		local animating = false

		local function hideUI()
			if animating or not isVisible then return end
			animating = true
			isVisible = false

			tween(MainFrame, CLOSE_ANIM, { Size = UDim2.new(0, sizeW, 0, 0) })

			task.delay(0.4, function()
				if not isVisible then
					MainFrame.Visible = false
					animating = false
				end
			end)
		end

		local function showUI()
			if animating or isVisible then return end
			animating = true
			isVisible = true

			MainFrame.Visible = true
			tween(MainFrame, CLOSE_ANIM, { Size = UDim2.new(0, sizeW, 0, sizeH) })

			task.delay(0.4, function()
				animating = false
			end)
		end

		trackConn(CloseBtn.MouseButton1Click:Connect(hideUI))

		trackConn(UserInputService.InputBegan:Connect(function(input, processed)
			if processed then return end
			if input.KeyCode == currentKey then
				if isVisible then hideUI() else showUI() end
			end
		end))

		trackConn(SettingsBtn.MouseButton1Click:Connect(function()
			SettingsPanel.Visible = not SettingsPanel.Visible
		end))

		trackConn(SaveBtn.MouseButton1Click:Connect(function()
			local key = parseKeyCodeInput(KeyInput.Text)
			if key then
				currentKey = key
				KeyInput.Text = key.Name
			else
				local stroke_ = KeyInput:FindFirstChildOfClass("UIStroke")
				if stroke_ then
					tween(stroke_, QUICK, { Color = Color3.fromRGB(255, 80, 80) })
					task.delay(0.5, function()
						if stroke_ and stroke_.Parent then
							tween(stroke_, QUICK, { Color = C.NeonDim })
						end
					end)
				end
			end
			SettingsPanel.Visible = false
		end))

		-- ============================================================
		-- WINDOW OBJECT
		-- ============================================================
		local Window = {}

		-- ============================================================
		-- TAB
		-- ============================================================
		function Window:AddTab(tabConfig)
			tabConfig = tabConfig or {}
			local tabName = tabConfig.Name or ("Tab " .. (#tabs + 1))

			local TabContent = new("Frame", {
				Parent = ContentScroll,
				Size = UDim2.new(1, 0, 0, 0),
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				Visible = false,
				ClipsDescendants = false,
				LayoutOrder = #tabs + 1,
				ZIndex = 3,
			})
			new("UIListLayout", {
				Parent = TabContent,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 8),
			})

			-- Poin 1: text center di dalam tab button
			-- Poin 2: warna teks tab jadi kuning
			-- Poin 7: outline (stroke) tab dipertebal & lebih terlihat
			local TabBtn = new("TextButton", {
				Parent = TabScroll,
				Size = UDim2.new(1, 0, 0, 34),
				BackgroundColor3 = C.TabInact,
				Text = tabName,
				TextColor3 = C.Neon,
				TextSize = 13,
				Font = Enum.Font.GothamSemibold,
				BorderSizePixel = 1,
				TextXAlignment = Enum.TextXAlignment.Center, -- FIX poin 1: center
				TextYAlignment = Enum.TextYAlignment.Center,
				LayoutOrder = #tabs + 1,
				ZIndex = 4,
			}, { corner(6), stroke(C.NeonDim, 0, 0) }) -- FIX poin 7: outline lebih tebal (1 -> 1.5) & selalu tampak

			local tabData = { button = TabBtn, content = TabContent, stroke = TabBtn:FindFirstChildOfClass("UIStroke") }
			table.insert(tabs, tabData)

			local function activateTab()
				for _, t in ipairs(tabs) do
					t.content.Visible = false
					t.button.BackgroundColor3 = C.TabInact
					t.button.TextColor3 = C.TabTextInact
					if t.stroke then t.stroke.Color = C.NeonDim end
				end
				TabContent.Visible = true
				TabBtn.BackgroundColor3 = C.TabActive
				TabBtn.TextColor3 = C.TabTextActive
				if tabData.stroke then tabData.stroke.Color = C.Neon end
				activeTab = tabData
				ContentScroll.CanvasPosition = Vector2.new(0, 0)
			end

			trackConn(TabBtn.MouseButton1Click:Connect(activateTab))
			trackConn(TabBtn.MouseEnter:Connect(function()
				if activeTab ~= tabData then
					tween(TabBtn, QUICK, { BackgroundColor3 = C.BtnHover })
				end
			end))
			trackConn(TabBtn.MouseLeave:Connect(function()
				if activeTab ~= tabData then
					tween(TabBtn, QUICK, { BackgroundColor3 = C.TabInact })
				end
			end))

			if #tabs == 1 then activateTab() end

			local Tab = {}
			local sectionCount = 0

			-- ------------------------------------------------------------
			-- SECTION
			-- ------------------------------------------------------------
			function Tab:AddSection(secConfig)
				secConfig = secConfig or {}
				local secName = secConfig.Name or "Section"
				sectionCount = sectionCount + 1

				local SecFrame = new("Frame", {
					Parent = TabContent,
					Size = UDim2.new(1, 0, 0, 0),
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundColor3 = C.Panel,
					BorderSizePixel = 0,
					ClipsDescendants = false,
					LayoutOrder = sectionCount,
					ZIndex = 4,
				}, { corner(8), stroke(C.NeonDim, 1, 0), pad(10, 10, 10, 10) })
				new("UIListLayout", {
					Parent = SecFrame,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, 6),
				})

				new("TextLabel", {
					Parent = SecFrame,
					Size = UDim2.new(1, 0, 0, 18),
					BackgroundTransparency = 1,
					Text = secName:upper(),
					TextColor3 = C.TextAccent,
					TextSize = 10,
					Font = Enum.Font.GothamBold,
					TextXAlignment = Enum.TextXAlignment.Left,
					LayoutOrder = 0,
					ZIndex = 5,
				})
				new("Frame", {
					Parent = SecFrame,
					Size = UDim2.new(1, 0, 0, 1),
					BackgroundColor3 = C.NeonDim,
					BorderSizePixel = 0,
					LayoutOrder = 1,
					ZIndex = 5,
				})

				local itemOrder = 1
				local function nextOrder()
					itemOrder = itemOrder + 1
					return itemOrder
				end

				local Section = {}

				-- ------------------------------------------------------------
				-- BUTTON
				-- ------------------------------------------------------------
				function Section:AddButton(cfg)
					cfg = cfg or {}
					local name = cfg.Name or "Button"
					local callback = cfg.Callback or function() end

					local Btn = new("TextButton", {
						Parent = SecFrame,
						Size = UDim2.new(1, 0, 0, 32),
						BackgroundColor3 = C.BtnBG,
						Text = name,
						TextColor3 = C.TextMain,
						TextSize = 13,
						Font = Enum.Font.GothamSemibold,
						BorderSizePixel = 0,
						LayoutOrder = nextOrder(),
						ZIndex = 5,
					}, { corner(6) })

					trackConn(Btn.MouseEnter:Connect(function() tween(Btn, QUICK, { BackgroundColor3 = C.BtnHover }) end))
					trackConn(Btn.MouseLeave:Connect(function() tween(Btn, QUICK, { BackgroundColor3 = C.BtnBG }) end))

					trackConn(Btn.MouseButton1Click:Connect(function()
						tween(Btn, QUICK, { BackgroundColor3 = C.NeonDim })
						task.delay(0.12, function()
							if Btn and Btn.Parent then
								tween(Btn, QUICK, { BackgroundColor3 = C.BtnBG })
							end
						end)
						local ok, err = pcall(callback)
						if not ok then warn("[KurooUI] Button callback error: " .. tostring(err)) end
					end))
					return Btn
				end

				-- ------------------------------------------------------------
				-- TOGGLE
				-- ------------------------------------------------------------
				function Section:AddToggle(cfg)
					cfg = cfg or {}
					local name = cfg.Name or "Toggle"
					local default = cfg.Default or false
					local callback = cfg.Callback or function() end

					local state = default

					local TogRow = new("Frame", {
						Parent = SecFrame,
						Size = UDim2.new(1, 0, 0, 32),
						BackgroundColor3 = C.BtnBG,
						BorderSizePixel = 0,
						LayoutOrder = nextOrder(),
						ZIndex = 5,
					}, { corner(6), stroke(C.NeonDim, 1, 0), pad(0, 10, 0, 10) })

					new("TextLabel", {
						Parent = TogRow,
						Size = UDim2.new(1, -50, 1, 0),
						Position = UDim2.new(1, -390, 0.8, -10),
						BackgroundTransparency = 1,
						Text = name,
						TextColor3 = C.TextMain,
						TextSize = 13,
						Font = Enum.Font.GothamSemibold,
						TextXAlignment = Enum.TextXAlignment.Left,
						ZIndex = 6,
					})

					local SwBG = new("Frame", {
						Parent = TogRow,
						Size = UDim2.new(0, 40, 0, 20),
						Position = UDim2.new(1, -45, 0.5, -10),
						BackgroundColor3 = state and C.ToggleOn or C.ToggleOff,
						BorderSizePixel = 0,
						ZIndex = 6,
					}, { corner(10) })
					local SwStroke = stroke(C.NeonDim, 1, 0)
					SwStroke.Parent = SwBG

					local Knob = new("Frame", {
						Parent = SwBG,
						Size = UDim2.new(0, 14, 0, 14),
						Position = state and UDim2.new(0, 23, 0.5, -7) or UDim2.new(0, 3, 0.5, -7),
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BorderSizePixel = 0,
						ZIndex = 7,
					}, { corner(7) })

					local function refreshToggle(val)
						state = val
						tween(SwBG, SMOOTH, { BackgroundColor3 = val and C.ToggleOn or C.ToggleOff })
						tween(Knob, SMOOTH, { Position = val and UDim2.new(0, 23, 0.5, -7) or UDim2.new(0, 3, 0.5, -7) })
						tween(SwStroke, SMOOTH, { Color = val and C.Neon or C.NeonDim })
						local ok, err = pcall(callback, val)
						if not ok then warn("[KurooUI] Toggle callback error: " .. tostring(err)) end
					end

					trackConn(TogRow.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1
							or input.UserInputType == Enum.UserInputType.Touch then
							refreshToggle(not state)
						end
					end))
					trackConn(TogRow.MouseEnter:Connect(function() tween(TogRow, QUICK, { BackgroundColor3 = C.BtnHover }) end))
					trackConn(TogRow.MouseLeave:Connect(function() tween(TogRow, QUICK, { BackgroundColor3 = C.BtnBG }) end))

					local api = {}
					function api:Set(val) refreshToggle(val) end
					function api:Get() return state end
					return api
				end

				-- ------------------------------------------------------------
				-- SLIDER
				-- ------------------------------------------------------------
				function Section:AddSlider(cfg)
					cfg = cfg or {}
					local name = cfg.Name or "Slider"
					local minVal = cfg.Min or 0
					local maxVal = cfg.Max or 100
					local defVal = cfg.Default or minVal
					local callback = cfg.Callback or function() end

					local curVal = math.clamp(defVal, minVal, maxVal)

					local SlFrame = new("Frame", {
						Parent = SecFrame,
						Size = UDim2.new(1, 0, 0, 50),
						BackgroundColor3 = C.BtnBG,
						BorderSizePixel = 0,
						LayoutOrder = nextOrder(),
						ZIndex = 5,
					}, { corner(6), stroke(C.NeonDim, 1, 0), pad(7, 10, 7, 10) })
					new("UIListLayout", {
						Parent = SlFrame,
						Padding = UDim.new(0, 5),
						SortOrder = Enum.SortOrder.LayoutOrder,
					})

					local TopRow = new("Frame", {
						Parent = SlFrame,
						Size = UDim2.new(1, 0, 0, 16),
						BackgroundTransparency = 1,
						LayoutOrder = 0,
						ZIndex = 6,
					})
					new("TextLabel", {
						Parent = TopRow,
						Size = UDim2.new(0.65, 0, 1, 0),
						BackgroundTransparency = 1,
						Text = name,
						TextColor3 = C.TextMain,
						TextSize = 12,
						Font = Enum.Font.GothamSemibold,
						TextXAlignment = Enum.TextXAlignment.Left,
						ZIndex = 6,
					})
					local SlValue = new("TextLabel", {
						Parent = TopRow,
						Size = UDim2.new(0.35, 0, 1, 0),
						Position = UDim2.new(0.65, 0, 0, 0),
						BackgroundTransparency = 1,
						Text = tostring(curVal),
						TextColor3 = C.TextAccent,
						TextSize = 12,
						Font = Enum.Font.GothamBold,
						TextXAlignment = Enum.TextXAlignment.Right,
						ZIndex = 6,
					})

					local pct = (curVal - minVal) / (maxVal - minVal)
					local Track = new("Frame", {
						Parent = SlFrame,
						Size = UDim2.new(1, 0, 0, 8),
						BackgroundColor3 = C.ToggleOff,
						BorderSizePixel = 0,
						LayoutOrder = 1,
						ZIndex = 6,
					}, { corner(4) })
					local Fill = new("Frame", {
						Parent = Track,
						Size = UDim2.new(pct, 0, 1, 0),
						BackgroundColor3 = C.SliderFill,
						BorderSizePixel = 0,
						ZIndex = 7,
					}, { corner(4) })
					local SlKnob = new("Frame", {
						Parent = Track,
						Size = UDim2.new(0, 14, 0, 14),
						Position = UDim2.new(pct, -7, 0.5, -7),
						BackgroundColor3 = Color3.fromRGB(240, 250, 255),
						BorderSizePixel = 0,
						ZIndex = 8,
					}, { corner(7), stroke(C.Neon, 1.5, 0) })

					-- FIX poin 4 (v2): sebelumnya Track adalah Frame biasa tanpa
					-- Active=true, sehingga InputBegan sering tidak konsisten
					-- menangkap event mouse -- akibatnya slider cuma bisa
					-- "tap" di titik tertentu tapi tidak bisa di-drag mengikuti
					-- cursor. Fix: set Active=true pada Track & SlKnob supaya
					-- Frame benar2 menangkap Input, dan gunakan
					-- UserInputService.InputChanged dengan pengecekan
					-- MouseMovement + Touch secara eksplisit (bukan cuma
					-- menyamakan UserInputType saat drag dimulai).
					Track.Active = true

					local sliding = false

					local function applySlide(mouseX)
						local abs = Track.AbsolutePosition
						local sz  = Track.AbsoluteSize
						local p = math.clamp((mouseX - abs.X) / sz.X, 0, 1)
						curVal = math.floor(minVal + p * (maxVal - minVal) + 0.5)
						SlValue.Text = tostring(curVal)
						-- Saat drag aktif, update posisi langsung tanpa tween
						-- supaya knob benar2 mengikuti cursor real-time
						Fill.Size = UDim2.new(p, 0, 1, 0)
						SlKnob.Position = UDim2.new(p, -7, 0.5, -7)
						SlValue.Text = tostring(curVal)
						local ok, err = pcall(callback, curVal)
						if not ok then warn("[KurooUI] Slider callback error: " .. tostring(err)) end
					end

					trackConn(Track.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1
							or input.UserInputType == Enum.UserInputType.Touch then
							sliding = true
							applySlide(input.Position.X)
						end
					end))
					trackConn(UserInputService.InputChanged:Connect(function(input)
						if sliding and (input.UserInputType == Enum.UserInputType.MouseMovement
							or input.UserInputType == Enum.UserInputType.Touch) then
							applySlide(input.Position.X)
						end
					end))
					trackConn(UserInputService.InputEnded:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1
							or input.UserInputType == Enum.UserInputType.Touch then
							sliding = false
						end
					end))

					local api = {}
					function api:Set(val)
						curVal = math.clamp(val, minVal, maxVal)
						local p = (curVal - minVal) / (maxVal - minVal)
						SlValue.Text = tostring(curVal)
						Fill.Size = UDim2.new(p, 0, 1, 0)
						SlKnob.Position = UDim2.new(p, -7, 0.5, -7)
						local ok, err = pcall(callback, curVal)
						if not ok then warn("[KurooUI] Slider callback error: " .. tostring(err)) end
					end
					function api:Get() return curVal end
					return api
				end

				-- ------------------------------------------------------------
				-- INPUT
				-- ------------------------------------------------------------
				function Section:AddInput(cfg)
					cfg = cfg or {}
					local name = cfg.Name or "Input"
					local placeholder = cfg.Placeholder or "Ketik di sini..."
					local callback = cfg.Callback or function() end

					local InFrame = new("Frame", {
						Parent = SecFrame,
						Size = UDim2.new(1, 0, 0, 52),
						BackgroundColor3 = C.BtnBG,
						BorderSizePixel = 0,
						LayoutOrder = nextOrder(),
						ZIndex = 5,
					}, { corner(6), stroke(C.NeonDim, 1, 0), pad(7, 10, 7, 10) })
					new("UIListLayout", {
						Parent = InFrame,
						Padding = UDim.new(0, 4),
						SortOrder = Enum.SortOrder.LayoutOrder,
					})

					new("TextLabel", {
						Parent = InFrame,
						Size = UDim2.new(1, 0, 0, 14),
						BackgroundTransparency = 1,
						Text = name,
						TextColor3 = C.TextSub,
						TextSize = 10,
						Font = Enum.Font.Gotham,
						TextXAlignment = Enum.TextXAlignment.Left,
						LayoutOrder = 0,
						ZIndex = 6,
					})

					-- Poin 6: placeholder & text textfield sekarang center
					local InBox = new("TextBox", {
						Parent = InFrame,
						Size = UDim2.new(1, 0, 0, 24),
						BackgroundColor3 = C.InputBG,
						Text = "",
						PlaceholderText = placeholder,
						PlaceholderColor3 = C.TextSub,
						TextColor3 = C.TextMain,
						TextSize = 12,
						Font = Enum.Font.Gotham,
						TextXAlignment = Enum.TextXAlignment.Center,
						TextYAlignment = Enum.TextYAlignment.Center,
						BorderSizePixel = 0,
						ClearTextOnFocus = false,
						LayoutOrder = 1,
						ZIndex = 6,
					}, { corner(4), pad(0, 6, 0, 6) })

					trackConn(InBox.FocusLost:Connect(function(enter)
						if enter then
							local ok, err = pcall(callback, InBox.Text)
							if not ok then warn("[KurooUI] Input callback error: " .. tostring(err)) end
						end
					end))

					local api = {}
					function api:Get() return InBox.Text end
					function api:Set(val) InBox.Text = val end
					return api
				end

				-- ------------------------------------------------------------
				-- DROPDOWN (FIX #3: single source of truth untuk close)
				-- ------------------------------------------------------------
				function Section:AddDropdown(cfg)
					cfg = cfg or {}
					local name = cfg.Name or "Dropdown"
					local options = cfg.Options or {}
					local default = cfg.Default or (options[1] or "")
					local callback = cfg.Callback or function() end

					local selected = default
					local isOpen = false

					local DDFrame = new("Frame", {
						Parent = SecFrame,
						Size = UDim2.new(1, 0, 0, 59),
						BackgroundColor3 = C.BtnBG,
						BorderSizePixel = 0,
						ClipsDescendants = false,
						LayoutOrder = nextOrder(),
						ZIndex = 6,
					}, { corner(6), stroke(C.NeonDim, 1, 0), pad(7, 10, 7, 10) })
					new("UIListLayout", {
						Parent = DDFrame,
						Padding = UDim.new(0, 4),
						SortOrder = Enum.SortOrder.LayoutOrder,
					})

					new("TextLabel", {
						Parent = DDFrame,
						Size = UDim2.new(1, 0, 0, 14),
						BackgroundTransparency = 1,
						Text = name,
						TextColor3 = C.TextSub,
						TextSize = 10,
						Font = Enum.Font.Gotham,
						TextXAlignment = Enum.TextXAlignment.Left,
						LayoutOrder = 0,
						ZIndex = 7,
					})

					-- Poin 5: padding kiri diperbesar (6 -> 12) supaya teks
					-- dropdown tidak mepet ke tepi kiri
					local DDBtn = new("TextButton", {
						Parent = DDFrame,
						Size = UDim2.new(1, 0, 0, 24),
						BackgroundColor3 = C.InputBG,
						Text = selected .. "  ",
						TextColor3 = C.TextMain,
						TextSize = 12,
						Font = Enum.Font.GothamSemibold,
						TextXAlignment = Enum.TextXAlignment.Left,
						BorderSizePixel = 0,
						LayoutOrder = 1,
						ZIndex = 7,
					}, { corner(4), pad(12, 6, 6, 6) })

					local Arrow = new("TextLabel", {
						Parent = DDBtn,
						Size = UDim2.new(0, 20, 1, 0),
						Position = UDim2.new(1, -20, 0, 0),
						BackgroundTransparency = 1,
						Text = "▼",
						TextColor3 = C.TextSub,
						TextSize = 10,
						Font = Enum.Font.GothamBold,
						TextXAlignment = Enum.TextXAlignment.Center,
						ZIndex = 8,
					})

					-- List di ScreenGui supaya tidak ke-clip oleh ContentScroll
					local listH = math.min(#options, 5) * 28 + 8
					local DDList = new("Frame", {
						Parent = ScreenGui,
						Size = UDim2.new(0, 100, 0, listH),
						Position = UDim2.new(0, 0, 0, 0),
						BackgroundColor3 = C.Panel,
						BorderSizePixel = 0,
						Visible = false,
						ClipsDescendants = true,
						ZIndex = 30,
					}, { corner(6), stroke(C.Neon, 1.5, 0), pad(4, 4, 4, 4) })

					-- Detector overlay = satu-satunya cara "klik di luar utk tutup"
					local DetectorBtn = new("TextButton", {
						Parent = ScreenGui,
						Size = UDim2.new(1, 0, 1, 0),
						BackgroundTransparency = 1,
						Text = "",
						AutoButtonColor = false,
						ZIndex = 29,
						Visible = false,
					})

					local DDScroll = new("ScrollingFrame", {
						Parent = DDList,
						Size = UDim2.new(1, 0, 1, 0),
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						ScrollBarThickness = 2,
						ScrollBarImageColor3 = C.Neon,
						CanvasSize = UDim2.new(0, 0, 0, 0),
						AutomaticCanvasSize = Enum.AutomaticSize.Y,
						ZIndex = 31,
					})
					new("UIListLayout", {
						Parent = DDScroll,
						Padding = UDim.new(0, 2),
						SortOrder = Enum.SortOrder.LayoutOrder,
					})

					-- FIX #3: satu fungsi close terpusat
					local function closeDropdown()
						isOpen = false
						DDList.Visible = false
						DetectorBtn.Visible = false
						tween(Arrow, QUICK, { Rotation = 0 })
					end

					local function openDropdown()
						isOpen = true
						local abs  = DDBtn.AbsolutePosition
						local size = DDBtn.AbsoluteSize
						DDList.Position = UDim2.new(0, abs.X, 0, abs.Y + size.Y + 4)
						DDList.Size = UDim2.new(0, size.X, 0, listH)
						DDList.Visible = true
						DetectorBtn.Visible = true
						tween(Arrow, QUICK, { Rotation = 180 })
					end

					for _, opt in ipairs(options) do
						local isSel = (opt == selected)
						local OptBtn = new("TextButton", {
							Parent = DDScroll,
							Size = UDim2.new(1, 0, 0, 26),
							BackgroundColor3 = isSel and C.TabActive or C.BtnBG,
							Text = opt,
							TextColor3 = isSel and C.TextMain or C.TextSub,
							TextSize = 12,
							Font = Enum.Font.GothamSemibold,
							TextXAlignment = Enum.TextXAlignment.Left,
							BorderSizePixel = 0,
							ZIndex = 32,
						}, { corner(4), pad(0, 6, 0, 8) })

						trackConn(OptBtn.MouseEnter:Connect(function()
							if opt ~= selected then
								tween(OptBtn, QUICK, { BackgroundColor3 = C.BtnHover })
							end
						end))
						trackConn(OptBtn.MouseLeave:Connect(function()
							if opt ~= selected then
								tween(OptBtn, QUICK, { BackgroundColor3 = C.BtnBG })
							end
						end))

						trackConn(OptBtn.MouseButton1Click:Connect(function()
							for _, child in ipairs(DDScroll:GetChildren()) do
								if child:IsA("TextButton") then
									tween(child, QUICK, { BackgroundColor3 = C.BtnBG })
									child.TextColor3 = C.TextSub
								end
							end
							tween(OptBtn, QUICK, { BackgroundColor3 = C.TabActive })
							OptBtn.TextColor3 = C.TextMain
							selected = opt
							DDBtn.Text = selected .. "  "
							local ok, err = pcall(callback, selected)
							if not ok then warn("[KurooUI] Dropdown callback error: " .. tostring(err)) end
							closeDropdown()
						end))
					end

					trackConn(DDBtn.MouseButton1Click:Connect(function()
						if isOpen then
							closeDropdown()
						else
							openDropdown()
						end
					end))

					trackConn(DetectorBtn.MouseButton1Click:Connect(closeDropdown))

					local api = {}
					function api:Get() return selected end
					function api:Set(val)
						if table.find(options, val) then
							selected = val
							DDBtn.Text = selected .. "  "
							local ok, err = pcall(callback, selected)
							if not ok then warn("[KurooUI] Dropdown callback error: " .. tostring(err)) end
						end
					end
					return api
				end

				-- ------------------------------------------------------------
				-- KEYBIND
				-- ------------------------------------------------------------
				function Section:AddKeybind(cfg)
					cfg = cfg or {}
					local name = cfg.Name or "Keybind"
					local default = cfg.Default or Enum.KeyCode.Unknown
					local callback = cfg.Callback or function() end

					local currentBind = default
					local listening = false

					local KBFrame = new("Frame", {
						Parent = SecFrame,
						Size = UDim2.new(1, 0, 0, 32),
						BackgroundColor3 = C.BtnBG,
						BorderSizePixel = 0,
						LayoutOrder = nextOrder(),
						ZIndex = 5,
					}, { corner(6), stroke(C.NeonDim, 1, 0), pad(0, 10, 0, 10) })

					new("TextLabel", {
						Parent = KBFrame,
						Size = UDim2.new(1, -100, 1, 0),
						BackgroundTransparency = 1,
						Text = name,
						TextColor3 = C.TextMain,
						TextSize = 13,
						Font = Enum.Font.GothamSemibold,
						TextXAlignment = Enum.TextXAlignment.Left,
						ZIndex = 6,
					})

					-- Poin 8: geser tombol keybind lebih ke kiri (jarak dari
					-- tepi kanan diperbesar dari 10px -> 20px) supaya tidak
					-- terlalu menempel ke pinggir kanan frame
					local KBBtn = new("TextButton", {
						Parent = KBFrame,
						Size = UDim2.new(0, 70, 0, 22),
						Position = UDim2.new(1, -90, 0.5, -11),
						BackgroundColor3 = C.InputBG,
						Text = currentBind.Name,
						TextColor3 = C.TextAccent,
						TextSize = 11,
						Font = Enum.Font.GothamBold,
						BorderSizePixel = 0,
						ZIndex = 6,
					}, { corner(4) })

					trackConn(KBBtn.MouseButton1Click:Connect(function()
						listening = true
						KBBtn.Text = "..."
						KBBtn.TextColor3 = Color3.fromRGB(255, 210, 0)
						tween(KBBtn, QUICK, { BackgroundColor3 = Color3.fromRGB(40, 32, 0) })
					end))

					trackConn(UserInputService.InputBegan:Connect(function(input, processed)
						if listening then
							if input.UserInputType == Enum.UserInputType.Keyboard then
								currentBind = input.KeyCode
								KBBtn.Text = currentBind.Name
								KBBtn.TextColor3 = C.TextAccent
								tween(KBBtn, QUICK, { BackgroundColor3 = C.InputBG })
								listening = false
							end
						else
							if processed then return end
							if input.KeyCode == currentBind and currentBind ~= Enum.KeyCode.Unknown then
								local ok, err = pcall(callback, currentBind)
								if not ok then warn("[KurooUI] Keybind callback error: " .. tostring(err)) end
							end
						end
					end))

					local api = {}
					function api:Get() return currentBind end
					return api
				end

				-- ------------------------------------------------------------
				-- COLOR PICKER (FIX #2: expand tidak lagi "bocor" ke bawah)
				-- ------------------------------------------------------------
				function Section:AddColorPicker(cfg)
					cfg = cfg or {}
					local name = cfg.Name or "Color"
					local color = cfg.Color or Color3.fromRGB(255, 255, 255)
					local callback = cfg.Callback or function() end

					local h, s, v = color:ToHSV()
					local open = false

					-- Wrapper: SATU frame dengan AutomaticSize + ClipsDescendants
					-- yang benar2 mengontrol tinggi berdasarkan isinya sendiri,
					-- bukan absolute position yang bisa "bocor" ke section lain.
					local CP = new("Frame", {
						Parent = SecFrame,
						Size = UDim2.new(1, 0, 0, 38),
						BackgroundColor3 = C.BtnBG,
						ClipsDescendants = true,
						LayoutOrder = nextOrder(),
						ZIndex = 5,
					}, { corner(6), stroke(C.NeonDim, 1, 0) })

					local HeaderRow = new("Frame", {
						Parent = CP,
						Size = UDim2.new(1, 0, 0, 38),
						BackgroundTransparency = 1,
						ZIndex = 6,
					})

					new("TextLabel", {
						Parent = HeaderRow,
						BackgroundTransparency = 1,
						Position = UDim2.new(0, 10, 0, 0),
						Size = UDim2.new(0.6, 0, 1, 0),
						Font = Enum.Font.Gotham,
						Text = name,
						TextColor3 = C.TextMain,
						TextSize = 13,
						TextXAlignment = Enum.TextXAlignment.Left,
						ZIndex = 6,
					})

					local Swatch = new("TextButton", {
						Parent = HeaderRow,
						AnchorPoint = Vector2.new(1, 0.5),
						Position = UDim2.new(1, -10, 0.5, 0),
						Size = UDim2.new(0, 32, 0, 18),
						BackgroundColor3 = color,
						Text = "",
						AutoButtonColor = false,
						ZIndex = 7,
					}, { corner(4) })

					-- Panel HSV: child dari CP (bukan floating absolute),
					-- posisinya relatif TEPAT di bawah HeaderRow, dan dia ikut
					-- di-clip oleh CP.ClipsDescendants=true saat CP masih 38px.
					local Panel = new("Frame", {
						Parent = CP,
						Position = UDim2.new(0, 10, 0, 44),
						Size = UDim2.new(1, -20, 0, 100),
						BackgroundTransparency = 1,
						ZIndex = 6,
					}, {
						new("UIListLayout", { Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder }),
					})

					local function makeChannelSlider(label, value)
						local row = new("Frame", { Parent = Panel, Size = UDim2.new(1, 0, 0, 26), BackgroundTransparency = 1, ZIndex = 6 })
						new("TextLabel", {
							Parent = row,
							BackgroundTransparency = 1,
							Size = UDim2.new(0, 20, 1, 0),
							Font = Enum.Font.Gotham,
							Text = label,
							TextColor3 = C.TextMain,
							TextSize = 12,
							ZIndex = 6,
						})
						local bar = new("Frame", {
							Parent = row,
							Position = UDim2.new(0, 25, 0.5, -4),
							Size = UDim2.new(1, -30, 0, 8),
							BackgroundColor3 = C.ToggleOff,
							ZIndex = 6,
						}, { corner(4) })
						local fill = new("Frame", {
							Parent = bar,
							Size = UDim2.new(value, 0, 1, 0),
							BackgroundColor3 = C.SliderFill,
							ZIndex = 7,
						}, { corner(4) })
						local hitbox = new("TextButton", { Parent = bar, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0), Text = "", ZIndex = 8 })
						return bar, fill, hitbox
					end

					local hueBar, hueFill, hueHit = makeChannelSlider("H", h)
					local satBar, satFill, satHit = makeChannelSlider("S", s)
					local valBar, valFill, valHit = makeChannelSlider("V", v)

					local function updateColor()
						local c = Color3.fromHSV(h, s, v)
						Swatch.BackgroundColor3 = c
						tween(hueFill, SMOOTH, { Size = UDim2.new(h, 0, 1, 0) })
						tween(satFill, SMOOTH, { Size = UDim2.new(s, 0, 1, 0) })
						tween(valFill, SMOOTH, { Size = UDim2.new(v, 0, 1, 0) })
						local ok, err = pcall(callback, c)
						if not ok then warn("[KurooUI] ColorPicker callback error: " .. tostring(err)) end
					end

					-- FIX poin 4 (v2): sama seperti slider biasa -- hitbox perlu
					-- Active=true supaya Frame benar2 menangkap input, dan
					-- pengecekan InputChanged pakai MouseMovement/Touch
					-- eksplisit (bukan menyamakan UserInputType awal) supaya
					-- knob HSV benar2 mengikuti cursor selama drag, bukan cuma
					-- merespon saat di-tap.
					local function bindDrag(bar, hit, setter)
						hit.Active = true
						local dragging = false
						trackConn(hit.InputBegan:Connect(function(input)
							if input.UserInputType == Enum.UserInputType.MouseButton1
								or input.UserInputType == Enum.UserInputType.Touch then
								dragging = true
								setter(math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1))
							end
						end))
						trackConn(UserInputService.InputEnded:Connect(function(input)
							if input.UserInputType == Enum.UserInputType.MouseButton1
								or input.UserInputType == Enum.UserInputType.Touch then
								dragging = false
							end
						end))
						trackConn(UserInputService.InputChanged:Connect(function(input)
							if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
								or input.UserInputType == Enum.UserInputType.Touch) then
								setter(math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1))
							end
						end))
					end

					bindDrag(hueBar, hueHit, function(r) h = r; updateColor() end)
					bindDrag(satBar, satHit, function(r) s = r; updateColor() end)
					bindDrag(valBar, valHit, function(r) v = r; updateColor() end)

					trackConn(Swatch.MouseButton1Click:Connect(function()
						open = not open
						-- FIX #2: karena Panel adalah child CP dengan posisi
						-- relatif tetap (bukan mendorong layout luar), expand
						-- CP hanya mengubah tinggi CP itu sendiri, section lain
						-- di bawahnya otomatis menyesuaikan lewat UIListLayout
						-- SecFrame yang membaca ukuran CP yang baru -- tidak
						-- ada lagi elemen yang "kebawa turun" secara visual
						-- salah karena tidak ada absolute leak lagi.
						tween(CP, SMOOTH, { Size = open and UDim2.new(1, 0, 0, 38 + 100 + 16) or UDim2.new(1, 0, 0, 38) })
					end))

					local api = {}
					function api:Set(newColor)
						h, s, v = newColor:ToHSV()
						updateColor()
					end
					function api:Get()
						return Color3.fromHSV(h, s, v)
					end
					return api
				end

				return Section
			end -- AddSection

			return Tab
		end -- AddTab

		-- ============================================================
		-- METHOD: ModifyTheme (FIX #7: sekarang menyapu semua elemen)
		-- ============================================================
		function Window:ModifyTheme(newTheme)
			for k, v in pairs(newTheme) do
				C[k] = v
			end
			for _, entry in ipairs(themeables) do
				if entry.inst and entry.inst.Parent then
					entry.inst[entry.prop] = C[entry.key]
				end
			end
		end

		-- Shortcut: ganti ke preset tema penuh ("Cyan" / "Yellow")
		-- Contoh: Window:SetTheme("Yellow")
		function Window:SetTheme(themeName)
			if not THEMES[themeName] then
				warn("[KurooUI] Theme '" .. tostring(themeName) .. "' tidak ditemukan.")
				return
			end
			Window:ModifyTheme(THEMES[themeName])
		end

		-- Jalankan sekali di awal supaya semua elemen yang sudah tercatat
		-- di `themeables` langsung sinkron dengan tema terpilih.
		Window:ModifyTheme(C)

		-- ============================================================
		-- METHOD: Destroy (FIX #6: cleanup total, mencegah leak)
		-- ============================================================
		function Window:Destroy()
			for _, conn in ipairs(allConnections) do
				if conn.Connected then
					conn:Disconnect()
				end
			end
			table.clear(allConnections)
			ScreenGui:Destroy()
		end

		return Window
	end

	return KurooUI
end

-- Backward-compat: kalau dipakai langsung require(...) tanpa .new(),
-- module ini tetap sediakan satu instance default agar tidak breaking
-- terhadap kode lama yang memanggil `local KurooUI = require(...)`.
return KurooUILib.new()
