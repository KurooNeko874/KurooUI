# KurooUI

A lightweight Navy Neon UI library for Roblox developers.

---

## Installation

1. Place `KurooUI.lua` inside `ReplicatedStorage`
2. Require it in a `LocalScript`:

```lua
local UI = require(game.ReplicatedStorage.KurooUI)
```

---

## CreateWindow

```lua
local Win = UI:CreateWindow({
    Title   = "Dev Tools",   -- window title
    W       = 400,           -- width  (default: 400)
    H       = 350,           -- height (default: 350)
    Icon    = "rbxassetid://YOUR_ID",  -- optional icon beside title
    Theme   = "Cyan",        -- theme name (see Themes section)
    HideKey = Enum.KeyCode.K, -- default hide/show keybind
})
```

> Press the **×** button or the configured keybind to hide/show the UI.
> The keybind can be changed via the **≡** menu (type the key name e.g. `F3`, `RightShift`, `k`).
> Hide/show now animates with a smooth shrink-to-center transition.

---

## AddTab

```lua
local Tab = Win:AddTab({ Name = "Main" })
```

---

## AddSection

```lua
local Sec = Tab:AddSection({ Name = "Actions" })
```

---

## Components

### Button
```lua
Sec:AddButton({
    Name     = "Run",
    Callback = function()
        print("clicked!")
    end,
})
```

### Toggle
```lua
Sec:AddToggle({
    Name     = "God Mode",
    Default  = false,
    Callback = function(state)
        print("toggle:", state)
    end,
})
```

### Slider
```lua
Sec:AddSlider({
    Name     = "Speed",
    Min      = 0,
    Max      = 100,
    Default  = 50,
    Callback = function(val)
        print("slider:", val)
    end,
})
```

### Input
```lua
Sec:AddInput({
    Name        = "Username",
    Placeholder = "Enter name...",
    Callback    = function(text)
        print("input:", text)
    end,
})
```

### Dropdown
```lua
local DD = Sec:AddDropdown({
    Name     = "Quality",
    Options  = { "Low", "Medium", "High" },
    Default  = "Medium",
    Callback = function(val)
        print("selected:", val)
    end,
})

-- API
DD:Get()        -- returns current value
DD:Set("High")  -- set value programmatically
```

> Dropdown stays open until clicked again or you click outside it.

### Keybind
```lua
local KB = Sec:AddKeybind({
    Name     = "Sprint",
    Default  = Enum.KeyCode.LeftShift,
    Callback = function(key)
        print("pressed:", key)
    end,
})

KB:Get()  -- returns current KeyCode
```

### ColorPicker
```lua
local CP = Sec:AddColorPicker({
    Name     = "ESP Color",
    Color    = Color3.fromRGB(255, 0, 0),
    Callback = function(color)
        print("color:", color)
    end,
})

CP:Get()                              -- returns current Color3
CP:Set(Color3.fromRGB(0, 255, 0))     -- set value programmatically
```

---

## Themes

```lua
Win:SetTheme("Ruby")  -- switch preset theme anytime
```

| Theme | Style |
|---|---|
| `Cyan` | Navy + cyan outline |
| `Yellow` | Black + yellow accent |
| `Emerald` | Light green |
| `Ruby` | Light red / bright red |
| `Bloody` | Dark red / blood red |
| `Darkness` | Dark purple |
| `Sakura` | Soft pink |
| `Solar` | Dark brown + burnt orange |
| `Frost` | Light blue |
| `Toxic` | Dark green + neon green |
| `Monochrome` | Neutral gray |

Custom override:
```lua
Win:ModifyTheme({ BG = Color3.fromRGB(0, 0, 0) })
```

---

## Window Methods

```lua
Win:SetTheme("Toxic")
Win:ModifyTheme({ Neon = Color3.fromRGB(255, 0, 0) })
Win:Destroy()  -- cleanup, disconnects all connections
```

---

## Full Example

```lua
local UI  = require(game.ReplicatedStorage.KurooUI)

local Win = UI:CreateWindow({
    Title = "Dev Tools",
    W     = 450,
    H     = 380,
    Theme = "Cyan",
})

local Tab = Win:AddTab({ Name = "Main" })
local Sec = Tab:AddSection({ Name = "Player" })

Sec:AddToggle({
    Name     = "Fly",
    Default  = false,
    Callback = function(state)
        print("Fly:", state)
    end,
})

Sec:AddSlider({
    Name     = "WalkSpeed",
    Min      = 16,
    Max      = 200,
    Default  = 16,
    Callback = function(val)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = val
    end,
})
```
