-- One Tap - Sakura Edition
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

local Settings = {
    Aimbot = false,
    ESP = false,
    Tracers = false,
    Fly = false,
    SpeedHack = false,
    SpeedValue = 30,
    JumpHack = false,
    JumpValue = 50
}

local Connections = {}
local ESPDrawings = {}

local function ClearDrawings()
    for _, d in pairs(ESPDrawings) do
        pcall(function() d:Remove() end)
    end
    ESPDrawings = {}
end

-- ==================== SAKURA GUI ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SakuraOneTap"
ScreenGui.Parent = game:GetService("CoreGui")

-- Main Frame with sakura pink theme
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 280, 0, 350)
MainFrame.Position = UDim2.new(0.8, 0, 0.25, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 20, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

-- Decorative sakura border
local Border = Instance.new("Frame")
Border.Size = UDim2.new(1, 4, 1, 4)
Border.Position = UDim2.new(0, -2, 0, -2)
Border.BackgroundColor3 = Color3.fromRGB(255, 150, 180)
Border.BorderSizePixel = 0
Border.ZIndex = 0
Border.Parent = MainFrame
Instance.new("UICorner", Border).CornerRadius = UDim.new(0, 11)

-- Animated sakura border glow
task.spawn(function()
    local hue = 0.92
    while ScreenGui and ScreenGui.Parent do
        hue = hue + 0.002
        if hue > 0.97 then hue = 0.92 end
        pcall(function()
            Border.BackgroundColor3 = Color3.fromHSV(hue, 0.6, 1)
        end)
        task.wait(0.03)
    end
end)

-- Minimized sakura button
local MiniFrame = Instance.new("Frame")
MiniFrame.Size = UDim2.new(0, 180, 0, 35)
MiniFrame.Position = UDim2.new(0.5, -90, 0.02, 0)
MiniFrame.BackgroundColor3 = Color3.fromRGB(40, 25, 40)
MiniFrame.BorderSizePixel = 0
MiniFrame.Visible = false
MiniFrame.Active = true
MiniFrame.Draggable = true
MiniFrame.Parent = ScreenGui
Instance.new("UICorner", MiniFrame).CornerRadius = UDim.new(0, 8)

local MiniBorder = Instance.new("Frame")
MiniBorder.Size = UDim2.new(1, 4, 1, 4)
MiniBorder.Position = UDim2.new(0, -2, 0, -2)
MiniBorder.BackgroundColor3 = Color3.fromRGB(255, 150, 180)
MiniBorder.BorderSizePixel = 0
MiniBorder.Parent = MiniFrame
Instance.new("UICorner", MiniBorder).CornerRadius = UDim.new(0, 9)

local MiniLabel = Instance.new("TextLabel")
MiniLabel.Size = UDim2.new(1, 0, 1, 0)
MiniLabel.BackgroundTransparency = 1
MiniLabel.TextColor3 = Color3.fromRGB(255, 180, 200)
MiniLabel.Text = "🌸 Sakura - Press CTRL 🌸"
MiniLabel.Font = Enum.Font.SourceSansBold
MiniLabel.TextSize = 13
MiniLabel.Parent = MiniFrame

-- CTRL Toggle
UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.LeftControl or input.KeyCode == Enum.KeyCode.RightControl then
        MainFrame.Visible = not MainFrame.Visible
        MiniFrame.Visible = not MiniFrame.Visible
    end
end)

-- Title Bar with sakura flowers
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 38)
TitleBar.BackgroundColor3 = Color3.fromRGB(40, 22, 38)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 10)

-- Decorative sakura petals in title
local PetalLeft = Instance.new("TextLabel")
PetalLeft.Size = UDim2.new(0, 20, 0, 20)
PetalLeft.Position = UDim2.new(0.01, 0, 0, 9)
PetalLeft.BackgroundTransparency = 1
PetalLeft.TextColor3 = Color3.fromRGB(255, 180, 200)
PetalLeft.Text = "🌸"
PetalLeft.Font = Enum.Font.SourceSans
PetalLeft.TextSize = 16
PetalLeft.Parent = TitleBar

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(0.6, 0, 1, 0)
TitleText.Position = UDim2.new(0.08, 0, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.TextColor3 = Color3.fromRGB(255, 180, 210)
TitleText.Text = "Sakura One Tap"
TitleText.Font = Enum.Font.SourceSansBold
TitleText.TextSize = 18
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

local PetalRight = Instance.new("TextLabel")
PetalRight.Size = UDim2.new(0, 20, 0, 20)
PetalRight.Position = UDim2.new(0.65, 0, 0, 9)
PetalRight.BackgroundTransparency = 1
PetalRight.TextColor3 = Color3.fromRGB(255, 180, 200)
PetalRight.Text = "🌸"
PetalRight.Font = Enum.Font.SourceSans
PetalRight.TextSize = 16
PetalRight.Parent = TitleBar

-- Close Button
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 28, 0, 24)
CloseButton.Position = UDim2.new(1, -34, 0, 7)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 80)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Text = "✕"
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.TextSize = 14
CloseButton.Parent = TitleBar
Instance.new("UICorner", CloseButton).CornerRadius = UDim.new(0, 6)
CloseButton.MouseButton1Click:Connect(function()
    ClearDrawings()
    for _, c in pairs(Connections) do pcall(function() c:Disconnect() end) end
    ScreenGui:Destroy()
end)

-- Content Scrolling Frame
local ContentScroll = Instance.new("ScrollingFrame")
ContentScroll.Size = UDim2.new(1, -10, 1, -45)
ContentScroll.Position = UDim2.new(0, 5, 0, 42)
ContentScroll.BackgroundColor3 = Color3.fromRGB(35, 22, 35)
ContentScroll.BorderSizePixel = 0
ContentScroll.ScrollBarThickness = 4
ContentScroll.ScrollBarImageColor3 = Color3.fromRGB(255, 150, 180)
ContentScroll.CanvasSize = UDim2.new(0, 0, 0, 600)
ContentScroll.Parent = MainFrame

local ContentList = Instance.new("UIListLayout")
ContentList.Padding = UDim.new(0, 4)
ContentList.FillDirection = Enum.FillDirection.Vertical
ContentList.SortOrder = Enum.SortOrder.LayoutOrder
ContentList.Parent = ContentScroll

-- Sakura Divider Function
local function CreateDivider(text)
    local Div = Instance.new("Frame")
    Div.Size = UDim2.new(1, -4, 0, 24)
    Div.BackgroundColor3 = Color3.fromRGB(50, 30, 50)
    Div.Parent = ContentScroll
    Instance.new("UICorner", Div).CornerRadius = UDim.new(0, 4)
    
    local DivLabel = Instance.new("TextLabel")
    DivLabel.Size = UDim2.new(1, 0, 1, 0)
    DivLabel.BackgroundTransparency = 1
    DivLabel.TextColor3 = Color3.fromRGB(255, 180, 210)
    DivLabel.Text = "🌸 " .. text .. " 🌸"
    DivLabel.Font = Enum.Font.SourceSansBold
    DivLabel.TextSize = 12
    DivLabel.Parent = Div
end

-- Toggle Function
local function CreateToggle(name, settingKey)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -4, 0, 32)
    Frame.BackgroundColor3 = Color3.fromRGB(42, 28, 42)
    Frame.Parent = ContentScroll
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 5)

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.58, 0, 1, 0)
    Label.Position = UDim2.new(0.03, 0, 0, 0)
    Label.BackgroundTransparency = 1
    Label.TextColor3 = Color3.fromRGB(240, 220, 240)
    Label.Text = name .. " : OFF"
    Label.Font = Enum.Font.SourceSansSemibold
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Frame

    local Switch = Instance.new("TextButton")
    Switch.Size = UDim2.new(0, 42, 0, 22)
    Switch.Position = UDim2.new(0.92, -42, 0, 5)
    Switch.BackgroundColor3 = Color3.fromRGB(60, 40, 60)
    Switch.Text = ""
    Switch.Parent = Frame
    Instance.new("UICorner", Switch).CornerRadius = UDim.new(0, 11)

    local enabled = false
    Switch.MouseButton1Click:Connect(function()
        enabled = not enabled
        Settings[settingKey] = enabled
        Label.Text = name .. " : " .. (enabled and "ON" or "OFF")
        Switch.BackgroundColor3 = enabled and Color3.fromRGB(220, 120, 170) or Color3.fromRGB(60, 40, 60)
        Label.TextColor3 = enabled and Color3.fromRGB(255, 200, 220) or Color3.fromRGB(240, 220, 240)
    end)
end

-- Slider Function
local function CreateSlider(name, settingKey, min, max, default)
    Settings[settingKey] = default
    
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -4, 0, 48)
    Frame.BackgroundColor3 = Color3.fromRGB(42, 28, 42)
    Frame.Parent = ContentScroll
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
    Input.PlaceholderText = min .. "-" .. max
    Input.Parent = Frame
    Instance.new("UICorner", Input).CornerRadius = UDim.new(0, 4)

    Input.FocusLost:Connect(function()
        local val = tonumber(Input.Text)
        if val and val >= min and val <= max then
            Settings[settingKey] = val
            Label.Text = name .. " : " .. tostring(val)
        else
            Input.Text = tostring(Settings[settingKey])
        end
    end)
end

-- Build GUI Sections
CreateDivider("🎯 Combat")
CreateToggle("Aimbot (Right Click)", "Aimbot")

CreateDivider("👁️ Visuals")
CreateToggle("ESP (Box + Name)", "ESP")
CreateToggle("Tracers", "Tracers")

CreateDivider("🏃 Movement")
CreateSlider("Speed", "SpeedValue", 16, 100, 30)
CreateToggle("Speed Hack", "SpeedHack")
CreateSlider("Jump Power", "JumpValue", 50, 200, 50)
CreateToggle("Jump Hack", "JumpHack")
CreateToggle("Fly (WASD + Space/Shift)", "Fly")

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
        ClearDrawings()
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
                            
                            local name = Drawing.new("Text")
                            name.Text = player.Name
                            name.Color = Color3.fromRGB(255, 220, 240)
                            name.Size = 13
                            name.Position = Vector2.new(headPos.X, headPos.Y - 18)
                            name.Center = true
                            name.Visible = true
                            table.insert(ESPDrawings, name)
                            
                            local dist = math.floor((hrp.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude)
                            local distText = Drawing.new("Text")
                            distText.Text = dist .. "m"
                            distText.Color = Color3.fromRGB(255, 180, 200)
                            distText.Size = 11
                            distText.Position = Vector2.new(headPos.X, headPos.Y - 6)
                            distText.Center = true
                            distText.Visible = true
                            table.insert(ESPDrawings, distText)
                        end
                    end
                end
            end
        end
    end
end)

-- Tracers
task.spawn(function()
    while task.wait(0.02) do
        if Settings.Tracers then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local screenPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                        if onScreen then
                            local line = Drawing.new("Line")
                            line.Color = Color3.fromRGB(255, 180, 220)
                            line.Thickness = 0.6
                            line.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
                            line.To = Vector2.new(screenPos.X, screenPos.Y)
                            line.Visible = true
                            table.insert(ESPDrawings, line)
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
        if humanoid then
            humanoid.WalkSpeed = Settings.SpeedValue
        end
    end
end)

-- Jump Hack
RunService.Stepped:Connect(function()
    if Settings.JumpHack and LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.JumpPower = Settings.JumpValue
        end
    end
end)

-- Fly (WASD + Space/Shift)
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
                
                local moveDir = Vector3.zero
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir += Camera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir -= Camera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir -= Camera.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir += Camera.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir += Vector3.new(0, 1, 0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir -= Vector3.new(0, 1, 0) end
                
                vel.Velocity = moveDir * 50
            end
        end
    end
end)

-- Floating sakura petals effect on load
print("🌸 Sakura One Tap Loaded! 🌸")
print("💖 Right-Click Aimbot | ESP | Tracers | Fly | Speed | Jump")
print("🌸 Press CTRL to minimize | Made with love 🌸")
