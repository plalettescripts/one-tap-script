-- One Tap - Sakura Edition Fixed
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

local Settings = {}
local Connections = {}
local ESPDrawings = {}
local TracerDrawings = {}

local function ClearESP()
    for _, d in pairs(ESPDrawings) do pcall(function() d:Remove() end) end
    ESPDrawings = {}
end

local function ClearTracers()
    for _, d in pairs(TracerDrawings) do pcall(function() d:Remove() end) end
    TracerDrawings = {}
end

-- ==================== GUI ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SakuraOneTap"
ScreenGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 260, 0, 360)
MainFrame.Position = UDim2.new(0.8, 0, 0.22, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 20, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

-- Border
local Border = Instance.new("Frame")
Border.Size = UDim2.new(1, 4, 1, 4)
Border.Position = UDim2.new(0, -2, 0, -2)
Border.BackgroundColor3 = Color3.fromRGB(255, 150, 180)
Border.BorderSizePixel = 0
Border.Parent = MainFrame
Instance.new("UICorner", Border).CornerRadius = UDim.new(0, 11)

task.spawn(function()
    local hue = 0.92
    while ScreenGui and ScreenGui.Parent do
        hue = hue + 0.003
        if hue > 0.97 then hue = 0.92 end
        pcall(function() Border.BackgroundColor3 = Color3.fromHSV(hue, 0.6, 1) end)
        task.wait(0.03)
    end
end)

-- Minimized Box
local MiniFrame = Instance.new("Frame")
MiniFrame.Size = UDim2.new(0, 200, 0, 50)
MiniFrame.Position = UDim2.new(0.5, -100, 0.02, 0)
MiniFrame.BackgroundColor3 = Color3.fromRGB(35, 20, 35)
MiniFrame.BorderSizePixel = 0
MiniFrame.Visible = false
MiniFrame.Active = true
MiniFrame.Draggable = true
MiniFrame.Parent = ScreenGui
Instance.new("UICorner", MiniFrame).CornerRadius = UDim.new(0, 8)

local SakuraArt = Instance.new("TextLabel")
SakuraArt.Size = UDim2.new(0, 45, 1, 0)
SakuraArt.Position = UDim2.new(0, 5, 0, 0)
SakuraArt.BackgroundTransparency = 1
SakuraArt.TextColor3 = Color3.fromRGB(255, 160, 200)
SakuraArt.Text = "✿\n◉\n✿"
SakuraArt.Font = Enum.Font.SourceSansBold
SakuraArt.TextSize = 12
SakuraArt.TextXAlignment = Enum.TextXAlignment.Center
SakuraArt.TextYAlignment = Enum.TextYAlignment.Center
SakuraArt.Parent = MiniFrame

local MiniLabel = Instance.new("TextLabel")
MiniLabel.Size = UDim2.new(0.7, 0, 1, 0)
MiniLabel.Position = UDim2.new(0.28, 0, 0, 0)
MiniLabel.BackgroundTransparency = 1
MiniLabel.TextColor3 = Color3.fromRGB(255, 180, 200)
MiniLabel.Text = "plalettescripts\nPress CTRL to open"
MiniLabel.Font = Enum.Font.SourceSansBold
MiniLabel.TextSize = 11
MiniLabel.TextXAlignment = Enum.TextXAlignment.Left
MiniLabel.Parent = MiniFrame

-- CTRL Toggle
UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.LeftControl or input.KeyCode == Enum.KeyCode.RightControl then
        MainFrame.Visible = not MainFrame.Visible
        MiniFrame.Visible = not MiniFrame.Visible
    end
end)

-- Title
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.BackgroundColor3 = Color3.fromRGB(40, 22, 38)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 10)

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(0.7, 0, 1, 0)
TitleText.Position = UDim2.new(0.06, 0, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.TextColor3 = Color3.fromRGB(255, 180, 210)
TitleText.Text = "🌸 Sakura One Tap 🌸"
TitleText.Font = Enum.Font.SourceSansBold
TitleText.TextSize = 16
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 28, 0, 24)
CloseBtn.Position = UDim2.new(1, -34, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 80)
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Text = "✕"
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 14
CloseBtn.Parent = TitleBar
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)
CloseBtn.MouseButton1Click:Connect(function()
    ClearESP()
    ClearTracers()
    for _, c in pairs(Connections) do pcall(function() c:Disconnect() end) end
    ScreenGui:Destroy()
end)

-- Scroll Frame
local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1, -8, 1, -40)
Scroll.Position = UDim2.new(0, 4, 0, 38)
Scroll.BackgroundColor3 = Color3.fromRGB(35, 22, 35)
Scroll.BorderSizePixel = 0
Scroll.ScrollBarThickness = 4
Scroll.ScrollBarImageColor3 = Color3.fromRGB(255, 150, 180)
Scroll.CanvasSize = UDim2.new(0, 0, 0, 750)
Scroll.Parent = MainFrame

local List = Instance.new("UIListLayout")
List.Padding = UDim.new(0, 3)
List.FillDirection = Enum.FillDirection.Vertical
List.SortOrder = Enum.SortOrder.LayoutOrder
List.Parent = Scroll

-- Divider
local function AddDivider(text)
    local Div = Instance.new("Frame")
    Div.Size = UDim2.new(1, -2, 0, 22)
    Div.BackgroundColor3 = Color3.fromRGB(50, 30, 50)
    Div.Parent = Scroll
    Instance.new("UICorner", Div).CornerRadius = UDim.new(0, 4)
    local Lbl = Instance.new("TextLabel")
    Lbl.Size = UDim2.new(1, 0, 1, 0)
    Lbl.BackgroundTransparency = 1
    Lbl.TextColor3 = Color3.fromRGB(255, 180, 210)
    Lbl.Text = "🌸 " .. text .. " 🌸"
    Lbl.Font = Enum.Font.SourceSansBold
    Lbl.TextSize = 11
    Lbl.Parent = Div
end

-- Toggle
local function AddToggle(name, key)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -2, 0, 32)
    Frame.BackgroundColor3 = Color3.fromRGB(42, 28, 42)
    Frame.Parent = Scroll
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 5)

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.55, 0, 1, 0)
    Label.Position = UDim2.new(0.03, 0, 0, 0)
    Label.BackgroundTransparency = 1
    Label.TextColor3 = Color3.fromRGB(240, 220, 240)
    Label.Text = name .. " : OFF"
    Label.Font = Enum.Font.SourceSansSemibold
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Frame

    local Switch = Instance.new("TextButton")
    Switch.Size = UDim2.new(0, 40, 0, 20)
    Switch.Position = UDim2.new(0.92, -40, 0, 6)
    Switch.BackgroundColor3 = Color3.fromRGB(60, 40, 60)
    Switch.Text = ""
    Switch.Parent = Frame
    Instance.new("UICorner", Switch).CornerRadius = UDim.new(0, 10)

    local enabled = false
    Switch.MouseButton1Click:Connect(function()
        enabled = not enabled
        Settings[key] = enabled
        Label.Text = name .. " : " .. (enabled and "ON" or "OFF")
        Switch.BackgroundColor3 = enabled and Color3.fromRGB(220, 120, 170) or Color3.fromRGB(60, 40, 60)
        Label.TextColor3 = enabled and Color3.fromRGB(255, 200, 220) or Color3.fromRGB(240, 220, 240)
    end)
end

-- Slider
local function AddSlider(name, key, min, max, default)
    Settings[key] = default
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -2, 0, 48)
    Frame.BackgroundColor3 = Color3.fromRGB(42, 28, 42)
    Frame.Parent = Scroll
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 5)

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 0, 18)
    Label.Position = UDim2.new(0.03, 0, 0, 3)
    Label.BackgroundTransparency = 1
    Label.TextColor3 = Color3.fromRGB(240, 220, 240)
    Label.Text = name .. " : " .. tostring(default)
    Label.Font = Enum.Font.SourceSans
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Frame

    local Input = Instance.new("TextBox")
    Input.Size = UDim2.new(0.3, 0, 0, 22)
    Input.Position = UDim2.new(0.35, 0, 0, 23)
    Input.BackgroundColor3 = Color3.fromRGB(50, 35, 50)
    Input.TextColor3 = Color3.fromRGB(255, 220, 240)
    Input.Text = tostring(default)
    Input.Font = Enum.Font.SourceSans
    Input.TextSize = 12
    Input.Parent = Frame
    Instance.new("UICorner", Input).CornerRadius = UDim.new(0, 4)

    Input.FocusLost:Connect(function()
        local val = tonumber(Input.Text)
        if val and val >= min and val <= max then
            Settings[key] = val
            Label.Text = name .. " : " .. tostring(val)
        else
            Input.Text = tostring(Settings[key])
        end
    end)
end

-- Credits
local function AddCredits()
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -2, 0, 260)
    Frame.BackgroundColor3 = Color3.fromRGB(42, 28, 42)
    Frame.Parent = Scroll
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 6)

    local Text = Instance.new("TextLabel")
    Text.Size = UDim2.new(1, -20, 1, -20)
    Text.Position = UDim2.new(0, 10, 0, 10)
    Text.BackgroundTransparency = 1
    Text.TextColor3 = Color3.fromRGB(240, 220, 240)
    Text.Text = [[
🌸 SAKURA ONE TAP 🌸

Created by: plalettescripts

GitHub:
plalettescripts/one-tap-script

🌸 Features:
  • Right-Click Aimbot
  • Box ESP with Distance
  • Tracers
  • Fly (WASD + Space/Shift)
  • Speed Hack
  • Jump Hack
  • Sakura Theme
  • CTRL Minimize

🎮 Controls:
  Right Click = Aimbot
  WASD = Fly
  Space = Fly Up
  Shift = Fly Down
  CTRL = Minimize

💖 Made with 🌸 by Plalette
]]
    Text.Font = Enum.Font.SourceSans
    Text.TextSize = 11
    Text.TextXAlignment = Enum.TextXAlignment.Left
    Text.TextYAlignment = Enum.TextYAlignment.Top
    Text.TextWrapped = true
    Text.Parent = Frame
end

-- ==================== BUILD GUI ====================
AddDivider("🎯 Combat")
AddToggle("Right-Click Aimbot", "Aimbot")

AddDivider("👁️ Visuals")
AddToggle("Player ESP (Box+Name)", "ESP")
AddToggle("Tracers", "Tracers")

AddDivider("🏃 Movement")
AddSlider("Walk Speed", "SpeedValue", 16, 150, 30)
AddToggle("Speed Hack", "SpeedHack")
AddSlider("Jump Power", "JumpValue", 50, 300, 50)
AddToggle("Jump Hack", "JumpHack")
AddSlider("Fly Speed", "FlySpeed", 20, 150, 50)
AddToggle("Fly (WASD+Space/Shift)", "Fly")

AddDivider("💖 Credits")
AddCredits()

-- ==================== FEATURES ====================

-- Right-Click Aimbot
UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.UserInputType == Enum.UserInputType.MouseButton2 and Settings.Aimbot then
        Connections.Aimbot = RunService.RenderStepped:Connect(function()
            local closest = math.huge
            local target = nil
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local head = player.Character:FindFirstChild("Head")
                    if head then
                        local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
                        local dist = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
                        if onScreen and dist < 350 and dist < closest then
                            closest = dist
                            target = player
                        end
                    end
                end
            end
            if target and target.Character and target.Character:FindFirstChild("Head") then
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Character.Head.Position)
            end
        end)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        if Connections.Aimbot then
            Connections.Aimbot:Disconnect()
            Connections.Aimbot = nil
        end
    end
end)

-- ESP (Box + Name)
task.spawn(function()
    while task.wait(0.03) do
        ClearESP()
        if Settings.ESP then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local head = player.Character:FindFirstChild("Head")
                    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                    if head and hrp then
                        local headPos, onScreen = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
                        local legPos = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))
                        if onScreen then
                            local height = math.abs(headPos.Y - legPos.Y)
                            local width = height / 2

                            local box = Drawing.new("Square")
                            box.Color = Color3.fromRGB(255, 150, 200)
                            box.Thickness = 1.2
                            box.Size = Vector2.new(width, height)
                            box.Position = Vector2.new(headPos.X - width/2, headPos.Y)
                            box.Filled = false
                            box.Visible = true
                            table.insert(ESPDrawings, box)

                            local nameTag = Drawing.new("Text")
                            nameTag.Text = player.Name
                            nameTag.Color = Color3.fromRGB(255, 220, 240)
                            nameTag.Size = 13
                            nameTag.Position = Vector2.new(headPos.X, headPos.Y - 18)
                            nameTag.Center = true
                            nameTag.Visible = true
                            table.insert(ESPDrawings, nameTag)
                        end
                    end
                end
            end
        end
    end
end)

-- Tracers
task.spawn(function()
    while task.wait(0.025) do
        ClearTracers()
        if Settings.Tracers then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local screenPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                        if onScreen then
                            local line = Drawing.new("Line")
                            line.Color = Color3.fromRGB(255, 180, 220)
                            line.Thickness = 0.7
                            line.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                            line.To = Vector2.new(screenPos.X, screenPos.Y)
                            line.Visible = true
                            table.insert(TracerDrawings, line)
                        end
                    end
                end
            end
        end
    end
end)

-- Speed Hack
RunService.Stepped:Connect(function()
    if Settings.SpeedHack and LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then humanoid.WalkSpeed = Settings.SpeedValue end
    end
end)

-- Jump Hack
RunService.Stepped:Connect(function()
    if Settings.JumpHack and LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then humanoid.JumpPower = Settings.JumpValue end
    end
end)

-- Fly
task.spawn(function()
    while task.wait() do
        if Settings.Fly and LocalPlayer.Character then
            local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local gyro = hrp:FindFirstChild("FlyGyro") or Instance.new("BodyGyro", hrp)
                local vel = hrp:FindFirstChild("FlyVel") or Instance.new("BodyVelocity", hrp)
                gyro.Name = "FlyGyro"
                gyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
                gyro.CFrame = Camera.CFrame
                vel.Name = "FlyVel"
                vel.MaxForce = Vector3.new(9e9, 9e9, 9e9)

                local speed = Settings.FlySpeed or 50
                local moveDir = Vector3.zero
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir += Camera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir -= Camera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir -= Camera.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir += Camera.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir += Vector3.new(0, 1, 0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir -= Vector3.new(0, 1, 0) end

                vel.Velocity = moveDir * speed
            end
        end
    end
end)

print("🌸 Sakura One Tap Fixed! 🌸")
print("💖 Aimbot | ESP | Tracers | Fly | Speed | Jump")
print("🌸 CTRL to minimize | All features working 🌸")
