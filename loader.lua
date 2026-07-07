-- One Tap - Sakura Edition v2
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

local Settings = {
    Aimbot = false,
    ESP = false,
    Tracers = false,
    Fly = false,
    FlySpeed = 50,
    SpeedHack = false,
    SpeedValue = 30,
    JumpHack = false,
    JumpValue = 50
}

local Connections = {}
local BoxDrawings = {}
local TracerDrawings = {}

local function ClearBoxes()
    for _, d in pairs(BoxDrawings) do pcall(function() d:Remove() end) end
    BoxDrawings = {}
end

local function ClearTracers()
    for _, d in pairs(TracerDrawings) do pcall(function() d:Remove() end) end
    TracerDrawings = {}
end

-- ==================== SAKURA GUI ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SakuraOneTap"
ScreenGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 290, 0, 380)
MainFrame.Position = UDim2.new(0.78, 0, 0.22, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 20, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

local Border = Instance.new("Frame")
Border.Size = UDim2.new(1, 4, 1, 4)
Border.Position = UDim2.new(0, -2, 0, -2)
Border.BackgroundColor3 = Color3.fromRGB(255, 150, 180)
Border.BorderSizePixel = 0
Border.ZIndex = 0
Border.Parent = MainFrame
Instance.new("UICorner", Border).CornerRadius = UDim.new(0, 11)

task.spawn(function()
    local hue = 0.92
    while ScreenGui and ScreenGui.Parent do
        hue = hue + 0.002
        if hue > 0.97 then hue = 0.92 end
        pcall(function() Border.BackgroundColor3 = Color3.fromHSV(hue, 0.6, 1) end)
        task.wait(0.03)
    end
end)

-- Minimized Sakura Flower Box
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

local MiniBorder = Instance.new("Frame")
MiniBorder.Size = UDim2.new(1, 4, 1, 4)
MiniBorder.Position = UDim2.new(0, -2, 0, -2)
MiniBorder.BackgroundColor3 = Color3.fromRGB(255, 150, 180)
MiniBorder.BorderSizePixel = 0
MiniBorder.Parent = MiniFrame
Instance.new("UICorner", MiniBorder).CornerRadius = UDim.new(0, 9)

-- Custom Sakura Flower design in minimized box
local SakuraArt = Instance.new("TextLabel")
SakuraArt.Size = UDim2.new(0, 45, 0, 45)
SakuraArt.Position = UDim2.new(0, 5, 0, 2)
SakuraArt.BackgroundTransparency = 1
SakuraArt.TextColor3 = Color3.fromRGB(255, 160, 200)
SakuraArt.Text = [[
   ✿
 ✿ ◉ ✿
   ✿
]]
SakuraArt.Font = Enum.Font.SourceSans
SakuraArt.TextSize = 11
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

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 38)
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
TitleText.TextSize = 18
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

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
    ClearBoxes()
    ClearTracers()
    for _, c in pairs(Connections) do pcall(function() c:Disconnect() end) end
    ScreenGui:Destroy()
end)

-- Tab System
local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(0, 80, 1, -43)
TabContainer.Position = UDim2.new(0, 3, 0, 41)
TabContainer.BackgroundColor3 = Color3.fromRGB(25, 16, 28)
TabContainer.BorderSizePixel = 0
TabContainer.Parent = MainFrame
Instance.new("UICorner", TabContainer).CornerRadius = UDim.new(0, 6)

local TabList = Instance.new("UIListLayout")
TabList.Padding = UDim.new(0, 2)
TabList.FillDirection = Enum.FillDirection.Vertical
TabList.SortOrder = Enum.SortOrder.LayoutOrder
TabList.Parent = TabContainer

local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -90, 1, -47)
ContentFrame.Position = UDim2.new(0, 86, 0, 41)
ContentFrame.BackgroundColor3 = Color3.fromRGB(35, 22, 35)
ContentFrame.BorderSizePixel = 0
ContentFrame.Parent = MainFrame
Instance.new("UICorner", ContentFrame).CornerRadius = UDim.new(0, 6)

local function CreateTab(name, icon)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(1, -6, 0, 28)
    TabBtn.Position = UDim2.new(0, 3, 0, 0)
    TabBtn.BackgroundColor3 = Color3.fromRGB(40, 28, 42)
    TabBtn.TextColor3 = Color3.fromRGB(200, 180, 200)
    TabBtn.Text = icon .. " " .. name
    TabBtn.Font = Enum.Font.SourceSansSemibold
    TabBtn.TextSize = 11
    TabBtn.TextXAlignment = Enum.TextXAlignment.Left
    TabBtn.Parent = TabContainer
    Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 4)

    local Content = Instance.new("ScrollingFrame")
    Content.Size = UDim2.new(1, -8, 1, -8)
    Content.Position = UDim2.new(0, 4, 0, 4)
    Content.BackgroundTransparency = 1
    Content.BorderSizePixel = 0
    Content.ScrollBarThickness = 3
    Content.ScrollBarImageColor3 = Color3.fromRGB(255, 150, 180)
    Content.CanvasSize = UDim2.new(0, 0, 0, 500)
    Content.Visible = false
    Content.Parent = ContentFrame

    local ContentList = Instance.new("UIListLayout")
    ContentList.Padding = UDim.new(0, 3)
    ContentList.FillDirection = Enum.FillDirection.Vertical
    ContentList.SortOrder = Enum.SortOrder.LayoutOrder
    ContentList.Parent = Content

    TabBtn.MouseButton1Click:Connect(function()
        for _, child in ipairs(ContentFrame:GetChildren()) do
            if child:IsA("ScrollingFrame") then child.Visible = false end
        end
        for _, child in ipairs(TabContainer:GetChildren()) do
            if child:IsA("TextButton") then
                child.BackgroundColor3 = Color3.fromRGB(40, 28, 42)
                child.TextColor3 = Color3.fromRGB(200, 180, 200)
            end
        end
        Content.Visible = true
        TabBtn.BackgroundColor3 = Color3.fromRGB(220, 120, 170)
        TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)

    local hasVisible = false
    for _, child in ipairs(ContentFrame:GetChildren()) do
        if child:IsA("ScrollingFrame") and child.Visible then hasVisible = true end
    end
    if not hasVisible then
        Content.Visible = true
        TabBtn.BackgroundColor3 = Color3.fromRGB(220, 120, 170)
        TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end

    local tab = {}

    function tab:CreateToggle(name, settingKey)
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(1, -2, 0, 32)
        Frame.BackgroundColor3 = Color3.fromRGB(42, 28, 42)
        Frame.Parent = Content
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
            Settings[settingKey] = enabled
            Label.Text = name .. " : " .. (enabled and "ON" or "OFF")
            Switch.BackgroundColor3 = enabled and Color3.fromRGB(220, 120, 170) or Color3.fromRGB(60, 40, 60)
            Label.TextColor3 = enabled and Color3.fromRGB(255, 200, 220) or Color3.fromRGB(240, 220, 240)
        end)
    end

    function tab:CreateSlider(name, settingKey, min, max, default)
        Settings[settingKey] = default
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(1, -2, 0, 48)
        Frame.BackgroundColor3 = Color3.fromRGB(42, 28, 42)
        Frame.Parent = Content
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
                Settings[settingKey] = val
                Label.Text = name .. " : " .. tostring(val)
            else
                Input.Text = tostring(Settings[settingKey])
            end
        end)
    end

    function tab:CreateDivider(text)
        local Div = Instance.new("Frame")
        Div.Size = UDim2.new(1, -2, 0, 22)
        Div.BackgroundColor3 = Color3.fromRGB(50, 30, 50)
        Div.Parent = Content
        Instance.new("UICorner", Div).CornerRadius = UDim.new(0, 4)
        local DivLabel = Instance.new("TextLabel")
        DivLabel.Size = UDim2.new(1, 0, 1, 0)
        DivLabel.BackgroundTransparency = 1
        DivLabel.TextColor3 = Color3.fromRGB(255, 180, 210)
        DivLabel.Text = "🌸 " .. text .. " 🌸"
        DivLabel.Font = Enum.Font.SourceSansBold
        DivLabel.TextSize = 11
        DivLabel.Parent = Div
    end

    return tab
end

-- Create Tabs
local CombatTab = CreateTab("Combat", "🎯")
local VisualsTab = CreateTab("Visuals", "👁")
local MovementTab = CreateTab("Move", "🏃")
local CreditsTab = CreateTab("Credits", "💖")

-- Combat Tab
CombatTab.CreateDivider("Aimbot")
CombatTab.CreateToggle("Right-Click Aimbot", "Aimbot")

-- Visuals Tab
VisualsTab.CreateDivider("ESP")
VisualsTab.CreateToggle("Player ESP (Box+Name)", "ESP")
VisualsTab.CreateToggle("Tracers", "Tracers")

-- Movement Tab
MovementTab.CreateDivider("Speed")
MovementTab.CreateSlider("Walk Speed", "SpeedValue", 16, 150, 30)
MovementTab.CreateToggle("Speed Hack", "SpeedHack")

MovementTab.CreateDivider("Jump")
MovementTab.CreateSlider("Jump Power", "JumpValue", 50, 300, 50)
MovementTab.CreateToggle("Jump Hack", "JumpHack")

MovementTab.CreateDivider("Fly")
MovementTab.CreateSlider("Fly Speed", "FlySpeed", 20, 150, 50)
MovementTab.CreateToggle("Fly (WASD+Space/Shift)", "Fly")

-- Credits Tab
local function BuildCredits(content)
    for _, child in ipairs(content:GetChildren()) do
        if child:IsA("Frame") and child.Name ~= "UIListLayout" then child:Destroy() end
    end

    local CreditFrame = Instance.new("Frame")
    CreditFrame.Size = UDim2.new(1, -2, 0, 360)
    CreditFrame.BackgroundColor3 = Color3.fromRGB(42, 28, 42)
    CreditFrame.Parent = content
    Instance.new("UICorner", CreditFrame).CornerRadius = UDim.new(0, 6)

    local CreditText = Instance.new("TextLabel")
    CreditText.Size = UDim2.new(1, -20, 1, -20)
    CreditText.Position = UDim2.new(0, 10, 0, 10)
    CreditText.BackgroundTransparency = 1
    CreditText.TextColor3 = Color3.fromRGB(240, 220, 240)
    CreditText.Text = [[
╔══════════════════════════╗
     🌸 SAKURA ONE TAP 🌸
╚══════════════════════════╝

    👤 Created by: plalettescripts

    📁 GitHub:
       plalettescripts/one-tap-script

    🌸 Features:
       • Right-Click Aimbot
       • Box ESP with Distance
       • Tracers
       • Fly (WASD + Space/Shift)
       • Speed Hack
       • Jump Hack
       • Sakura Themed GUI
       • CTRL Minimize

    🎮 Controls:
       Right Click = Aimbot Lock
       WASD = Fly Movement
       Space = Fly Up
       Shift = Fly Down
       CTRL = Minimize GUI

    💖 Special Thanks:
       • The Scripting Community
       • All Sakura Lovers
       • You, for using this script!

    ╔══════════════════════════╗
    ║  Made with 🌸 by Plalette ║
    ╚══════════════════════════╝
]]
    CreditText.Font = Enum.Font.SourceSans
    CreditText.TextSize = 11
    CreditText.TextXAlignment = Enum.TextXAlignment.Left
    CreditText.TextYAlignment = Enum.TextYAlignment.Top
    CreditText.TextWrapped = true
    CreditText.Parent = CreditFrame
end

BuildCredits(CreditsTab)

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
        ClearBoxes()
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
                            table.insert(BoxDrawings, box)

                            local nameTag = Drawing.new("Text")
                            nameTag.Text = player.Name
                            nameTag.Color = Color3.fromRGB(255, 220, 240)
                            nameTag.Size = 13
                            nameTag.Position = Vector2.new(headPos.X, headPos.Y - 18)
                            nameTag.Center = true
                            nameTag.Visible = true
                            table.insert(BoxDrawings, nameTag)
                        end
                    end
                end
            end
        end
    end
end)

-- Tracers (Fixed - separate drawing table, no conflict)
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

-- Fly (WASD + Space/Shift) with adjustable speed
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

print("🌸 Sakura One Tap v2 Loaded! 🌸")
print("💖 Aimbot | ESP | Tracers | Fly | Speed | Jump")
print("🌸 CTRL to minimize | Credits tab added 🌸")
