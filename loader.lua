-- One Tap Script
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

local Settings = {}
local Connections = {}
local Drawings = {}

local function ClearDrawings()
    for _, d in pairs(Drawings) do pcall(function() d:Remove() end) end
    Drawings = {}
end

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "OneTapGUI"
gui.Parent = game:GetService("CoreGui")

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 220, 0, 340)
Main.Position = UDim2.new(0.82, 0, 0.25, 0)
Main.BackgroundColor3 = Color3.fromRGB(30, 20, 30)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Visible = true
Main.Parent = gui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)

-- Border glow
local Border = Instance.new("Frame")
Border.Size = UDim2.new(1, 4, 1, 4)
Border.Position = UDim2.new(0, -2, 0, -2)
Border.BackgroundColor3 = Color3.fromRGB(255, 150, 180)
Border.BorderSizePixel = 0
Border.Parent = Main
Instance.new("UICorner", Border).CornerRadius = UDim.new(0, 9)

task.spawn(function()
    local hue = 0.92
    while gui and gui.Parent do
        hue = hue + 0.003
        if hue > 0.97 then hue = 0.92 end
        pcall(function() Border.BackgroundColor3 = Color3.fromHSV(hue, 0.6, 1) end)
        task.wait(0.03)
    end
end)

-- Minimized box
local Mini = Instance.new("Frame")
Mini.Size = UDim2.new(0, 200, 0, 45)
Mini.Position = UDim2.new(0.5, -100, 0.02, 0)
Mini.BackgroundColor3 = Color3.fromRGB(35, 20, 35)
Mini.BorderSizePixel = 0
Mini.Visible = false
Mini.Active = true
Mini.Draggable = true
Mini.Parent = gui
Instance.new("UICorner", Mini).CornerRadius = UDim.new(0, 8)

local SakuraFlower = Instance.new("TextLabel")
SakuraFlower.Size = UDim2.new(0, 40, 1, 0)
SakuraFlower.Position = UDim2.new(0, 5, 0, 0)
SakuraFlower.BackgroundTransparency = 1
SakuraFlower.TextColor3 = Color3.fromRGB(255, 160, 200)
SakuraFlower.Text = "✿\n◉\n✿"
SakuraFlower.Font = Enum.Font.SourceSansBold
SakuraFlower.TextSize = 13
SakuraFlower.TextXAlignment = Enum.TextXAlignment.Center
SakuraFlower.TextYAlignment = Enum.TextYAlignment.Center
SakuraFlower.Parent = Mini

local MiniText = Instance.new("TextLabel")
MiniText.Size = UDim2.new(0.7, 0, 1, 0)
MiniText.Position = UDim2.new(0.25, 0, 0, 0)
MiniText.BackgroundTransparency = 1
MiniText.TextColor3 = Color3.fromRGB(255, 180, 200)
MiniText.Text = "plalettescripts\nPress CTRL to open"
MiniText.Font = Enum.Font.SourceSansBold
MiniText.TextSize = 11
MiniText.TextXAlignment = Enum.TextXAlignment.Left
MiniText.Parent = Mini

-- CTRL Toggle
UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.LeftControl or input.KeyCode == Enum.KeyCode.RightControl then
        Main.Visible = not Main.Visible
        Mini.Visible = not Mini.Visible
    end
end)

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(40, 22, 38)
Title.TextColor3 = Color3.fromRGB(255, 180, 210)
Title.Text = "🌸 Sakura One Tap 🌸"
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 15
Title.Parent = Main

local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0, 26, 0, 22)
Close.Position = UDim2.new(1, -30, 0, 4)
Close.BackgroundColor3 = Color3.fromRGB(200, 50, 80)
Close.TextColor3 = Color3.fromRGB(255, 255, 255)
Close.Text = "X"
Close.Font = Enum.Font.SourceSansBold
Close.TextSize = 13
Close.Parent = Main
Close.MouseButton1Click:Connect(function()
    ClearDrawings()
    for _, c in pairs(Connections) do pcall(function() c:Disconnect() end) end
    gui:Destroy()
end)

-- Scroll
local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1, -10, 1, -38)
Scroll.Position = UDim2.new(0, 5, 0, 33)
Scroll.BackgroundColor3 = Color3.fromRGB(35, 22, 35)
Scroll.BorderSizePixel = 0
Scroll.ScrollBarThickness = 3
Scroll.ScrollBarImageColor3 = Color3.fromRGB(255, 150, 180)
Scroll.CanvasSize = UDim2.new(0, 0, 0, 620)
Scroll.Parent = Main

local List = Instance.new("UIListLayout")
List.Padding = UDim.new(0, 3)
List.FillDirection = Enum.FillDirection.Vertical
List.SortOrder = Enum.SortOrder.LayoutOrder
List.Parent = Scroll

-- Toggle function
local function AddToggle(name, key)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -2, 0, 30)
    Frame.BackgroundColor3 = Color3.fromRGB(42, 28, 42)
    Frame.Parent = Scroll
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 4)

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

    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0, 38, 0, 20)
    Btn.Position = UDim2.new(0.9, -38, 0, 5)
    Btn.BackgroundColor3 = Color3.fromRGB(60, 40, 60)
    Btn.Text = ""
    Btn.Parent = Frame
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 10)

    local on = false
    Btn.MouseButton1Click:Connect(function()
        on = not on
        Settings[key] = on
        Label.Text = name .. " : " .. (on and "ON" or "OFF")
        Btn.BackgroundColor3 = on and Color3.fromRGB(220, 120, 170) or Color3.fromRGB(60, 40, 60)
    end)
end

-- Slider function
local function AddSlider(name, key, min, max, default)
    Settings[key] = default
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -2, 0, 48)
    Frame.BackgroundColor3 = Color3.fromRGB(42, 28, 42)
    Frame.Parent = Scroll
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 4)

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

-- Divider
local function AddDivider(text)
    local Div = Instance.new("Frame")
    Div.Size = UDim2.new(1, -2, 0, 20)
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

-- Build GUI
AddDivider("Combat")
AddToggle("Aimbot (Right Click)", "Aimbot")

AddDivider("Visuals")
AddToggle("ESP (Box + Name)", "ESP")
AddToggle("Tracers", "Tracers")

AddDivider("Movement")
AddSlider("Walk Speed", "SpeedValue", 16, 150, 30)
AddToggle("Speed Hack", "SpeedHack")
AddSlider("Jump Power", "JumpValue", 50, 300, 50)
AddToggle("Jump Hack", "JumpHack")
AddSlider("Fly Speed", "FlySpeed", 20, 150, 50)
AddToggle("Fly (WASD+Space/Shift)", "Fly")

AddDivider("Credits")
local CreditFrame = Instance.new("Frame")
CreditFrame.Size = UDim2.new(1, -2, 0, 200)
CreditFrame.BackgroundColor3 = Color3.fromRGB(42, 28, 42)
CreditFrame.Parent = Scroll
Instance.new("UICorner", CreditFrame).CornerRadius = UDim.new(0, 6)

local CreditText = Instance.new("TextLabel")
CreditText.Size = UDim2.new(1, -16, 1, -16)
CreditText.Position = UDim2.new(0, 8, 0, 8)
CreditText.BackgroundTransparency = 1
CreditText.TextColor3 = Color3.fromRGB(240, 220, 240)
CreditText.Text = [[
🌸 Sakura One Tap 🌸

Created by: plalettescripts

GitHub: plalettescripts/one-tap-script

Features:
- Right-Click Aimbot
- Box ESP with Names
- Tracers
- Fly (WASD+Space/Shift)
- Speed Hack
- Jump Hack

Controls:
Right Click = Aimbot
WASD = Fly | Space = Up
Shift = Down | CTRL = Minimize

💖 Made by Plalette 💖
]]
CreditText.Font = Enum.Font.SourceSans
CreditText.TextSize = 11
CreditText.TextXAlignment = Enum.TextXAlignment.Left
CreditText.TextYAlignment = Enum.TextYAlignment.Top
CreditText.TextWrapped = true
CreditText.Parent = CreditFrame

-- ==================== FEATURES ====================

-- Aimbot
UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.UserInputType == Enum.UserInputType.MouseButton2 and Settings.Aimbot then
        Connections.Aimbot = RunService.RenderStepped:Connect(function()
            local closest = math.huge
            local target = nil
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character then
                    local head = p.Character:FindFirstChild("Head")
                    if head then
                        local pos, onScreen = Camera:WorldToViewportPoint(head.Position)
                        local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
                        if onScreen and dist < 350 and dist < closest then
                            closest = dist
                            target = p
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
        if Connections.Aimbot then Connections.Aimbot:Disconnect() Connections.Aimbot = nil end
    end
end)

-- ESP
task.spawn(function()
    while task.wait(0.03) do
        ClearDrawings()
        if Settings.ESP then
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character then
                    local head = p.Character:FindFirstChild("Head")
                    local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                    if head and hrp then
                        local headPos, onScreen = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
                        local legPos = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))
                        if onScreen then
                            local h = math.abs(headPos.Y - legPos.Y)
                            local w = h / 2
                            local box = Drawing.new("Square")
                            box.Color = Color3.fromRGB(255, 150, 200)
                            box.Thickness = 1.2
                            box.Size = Vector2.new(w, h)
                            box.Position = Vector2.new(headPos.X - w/2, headPos.Y)
                            box.Filled = false
                            box.Visible = true
                            table.insert(Drawings, box)

                            local name = Drawing.new("Text")
                            name.Text = p.Name
                            name.Color = Color3.fromRGB(255, 220, 240)
                            name.Size = 13
                            name.Position = Vector2.new(headPos.X, headPos.Y - 18)
                            name.Center = true
                            name.Visible = true
                            table.insert(Drawings, name)
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
        if Settings.Tracers then
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character then
                    local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local pos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                        if onScreen then
                            local line = Drawing.new("Line")
                            line.Color = Color3.fromRGB(255, 180, 220)
                            line.Thickness = 0.7
                            line.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
                            line.To = Vector2.new(pos.X, pos.Y)
                            line.Visible = true
                            table.insert(Drawings, line)
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
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = Settings.SpeedValue end
    end
end)

-- Jump Hack
RunService.Stepped:Connect(function()
    if Settings.JumpHack and LocalPlayer.Character then
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.JumpPower = Settings.JumpValue end
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
                local move = Vector3.zero
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then move += Camera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then move -= Camera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then move -= Camera.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then move += Camera.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0, 1, 0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then move -= Vector3.new(0, 1, 0) end
                vel.Velocity = move * speed
            end
        end
    end
end)

print("🌸 Sakura One Tap Loaded! 🌸")
