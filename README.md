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
    Logo    = "rbxassetid://YOUR_ID",  -- optional logo beside title
})
```

> Press the **×** button or the configured keybind to hide/show the UI.
> The keybind can be changed via the **≡** menu (type the key name e.g. `F3`, `RightShift`, `k`).

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

### TextInput
```lua
Sec:AddTextInput({
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

> Dropdown stays open until clicked again or UI is hidden.

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

---

## Full Example

```lua
local UI  = require(game.ReplicatedStorage.KurooUI)

local Win = UI:CreateWindow({
    Title = "Dev Tools",
    W     = 450,
    H     = 380,
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
