-- One Tap Script - Undetected
local plr = game:GetService("Players")
local run = game:GetService("RunService")
local uis = game:GetService("UserInputService")
local ws = game:GetService("Workspace")
local lp = plr.LocalPlayer
local cam = ws.CurrentCamera
local mouse = lp:GetMouse()

local cfg = {
    aim = false,
    esp = false,
    tracers = false,
    fly = false,
    speed = false
}

local conn = {}
local draws = {}

local function clr()
    for _, d in pairs(draws) do pcall(function() d:Remove() end) end
    draws = {}
end

local function dcon()
    for _, c in pairs(conn) do pcall(function() c:Disconnect() end) end
    conn = {}
end

local function geth(pl)
    if pl and pl.Character then
        return pl.Character:FindFirstChild("Head")
    end
    return nil
end

local function gethrp(pl)
    if pl and pl.Character then
        return pl.Character:FindFirstChild("HumanoidRootPart")
    end
    return nil
end

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = math.random(1000000, 9999999)
gui.Parent = game:GetService("CoreGui")

local mf = Instance.new("Frame")
mf.Size = UDim2.new(0, 200, 0, 280)
mf.Position = UDim2.new(0.85, 0, 0.3, 0)
mf.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
mf.BorderSizePixel = 0
mf.Active = true
mf.Draggable = true
mf.Parent = gui
Instance.new("UICorner", mf).CornerRadius = UDim.new(0, 6)

local ti = Instance.new("TextLabel")
ti.Size = UDim2.new(1, 0, 0, 25)
ti.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
ti.TextColor3 = Color3.fromRGB(255, 255, 255)
ti.Text = "One Tap"
ti.Font = Enum.Font.SourceSansBold
ti.TextSize = 14
ti.Parent = mf

local sf = Instance.new("ScrollingFrame")
sf.Size = UDim2.new(1, -8, 1, -33)
sf.Position = UDim2.new(0, 4, 0, 28)
sf.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
sf.BorderSizePixel = 0
sf.ScrollBarThickness = 3
sf.CanvasSize = UDim2.new(0, 0, 0, 220)
sf.Parent = mf

local sl = Instance.new("UIListLayout")
sl.Padding = UDim.new(0, 3)
sl.FillDirection = Enum.FillDirection.Vertical
sl.SortOrder = Enum.SortOrder.LayoutOrder
sl.Parent = sf

local function crt(name, cb)
    local fr = Instance.new("Frame")
    fr.Size = UDim2.new(1, -2, 0, 30)
    fr.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
    fr.Parent = sf
    Instance.new("UICorner", fr).CornerRadius = UDim.new(0, 4)

    local lb = Instance.new("TextLabel")
    lb.Size = UDim2.new(0.55, 0, 1, 0)
    lb.Position = UDim2.new(0.03, 0, 0, 0)
    lb.BackgroundTransparency = 1
    lb.TextColor3 = Color3.fromRGB(255, 255, 255)
    lb.Text = name .. " : OFF"
    lb.Font = Enum.Font.SourceSans
    lb.TextSize = 12
    lb.TextXAlignment = Enum.TextXAlignment.Left
    lb.Parent = fr

    local bt = Instance.new("TextButton")
    bt.Size = UDim2.new(0, 40, 0, 20)
    bt.Position = UDim2.new(0.92, -40, 0, 5)
    bt.BackgroundColor3 = Color3.fromRGB(55, 55, 70)
    bt.Text = ""
    bt.Parent = fr
    Instance.new("UICorner", bt).CornerRadius = UDim.new(0, 10)

    local on = false
    bt.MouseButton1Click:Connect(function()
        on = not on
        lb.Text = name .. " : " .. (on and "ON" or "OFF")
        bt.BackgroundColor3 = on and Color3.fromRGB(0, 140, 0) or Color3.fromRGB(55, 55, 70)
        cb(on)
    end)
end

crt("Right-Click Aimbot", function(s) cfg.aim = s end)
crt("Wallhack ESP", function(s) cfg.esp = s end)
crt("Tracers", function(s) cfg.tracers = s end)
crt("Fly", function(s) cfg.fly = s end)
crt("Speed Hack", function(s) cfg.speed = s end)

-- Aimbot
uis.InputBegan:Connect(function(inp, proc)
    if proc then return end
    if inp.UserInputType == Enum.UserInputType.MouseButton2 and cfg.aim then
        conn.aim = run.RenderStepped:Connect(function()
            local cl, tp = math.huge, nil
            for _, p in ipairs(plr:GetPlayers()) do
                if p ~= lp then
                    local h = geth(p)
                    if h then
                        local ps, os = cam:WorldToViewportPoint(h.Position)
                        local d = (Vector2.new(ps.X, ps.Y) - Vector2.new(mouse.X, mouse.Y)).Magnitude
                        if os and d < 400 and d < cl then
                            cl = d
                            tp = p
                        end
                    end
                end
            end
            if tp then
                local h = geth(tp)
                if h then
                    cam.CFrame = CFrame.new(cam.CFrame.Position, h.Position)
                end
            end
        end)
    end
end)
uis.InputEnded:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton2 then
        if conn.aim then conn.aim:Disconnect() conn.aim = nil end
    end
end)

-- Wallhack ESP (Chams)
task.spawn(function()
    while task.wait(0.5) do
        if cfg.esp then
            for _, p in ipairs(plr:GetPlayers()) do
                if p ~= lp and p.Character then
                    for _, pr in ipairs(p.Character:GetChildren()) do
                        if pr:IsA("BasePart") and pr.Transparency < 0.5 then
                            pr.Material = Enum.Material.ForceField
                        end
                    end
                    local hl = p.Character:FindFirstChild("wesp")
                    if not hl then
                        hl = Instance.new("Highlight")
                        hl.Name = "wesp"
                        hl.FillColor = Color3.fromRGB(255, 0, 0)
                        hl.FillTransparency = 0.3
                        hl.OutlineColor = Color3.fromRGB(255, 50, 50)
                        hl.OutlineTransparency = 0
                        hl.Parent = p.Character
                    end
                end
            end
        else
            for _, p in ipairs(plr:GetPlayers()) do
                if p.Character and p.Character:FindFirstChild("wesp") then
                    p.Character.wesp:Destroy()
                end
            end
        end
    end
end)

-- Tracers
task.spawn(function()
    while task.wait(0.02) do
        if cfg.tracers then
            clr()
            for _, p in ipairs(plr:GetPlayers()) do
                if p ~= lp then
                    local hrp = gethrp(p)
                    if hrp then
                        local ps, os = cam:WorldToViewportPoint(hrp.Position)
                        if os then
                            local ln = Drawing.new("Line")
                            ln.Color = Color3.fromRGB(255, 255, 255)
                            ln.Thickness = 0.7
                            ln.From = Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y)
                            ln.To = Vector2.new(ps.X, ps.Y)
                            ln.Visible = true
                            table.insert(draws, ln)
                        end
                    end
                end
            end
        end
    end
end)

-- Fly (no lag - uses BodyVelocity)
task.spawn(function()
    while task.wait() do
        if cfg.fly and lp.Character then
            local hrp = lp.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local bg = hrp:FindFirstChild("bgFly") or Instance.new("BodyGyro", hrp)
                local bv = hrp:FindFirstChild("bvFly") or Instance.new("BodyVelocity", hrp)
                bg.Name = "bgFly"
                bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
                bg.CFrame = cam.CFrame
                bv.Name = "bvFly"
                bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                local vel = Vector3.zero
                if uis:IsKeyDown(Enum.KeyCode.W) then vel += cam.CFrame.LookVector * 50 end
                if uis:IsKeyDown(Enum.KeyCode.S) then vel -= cam.CFrame.LookVector * 50 end
                if uis:IsKeyDown(Enum.KeyCode.A) then vel -= cam.CFrame.RightVector * 50 end
                if uis:IsKeyDown(Enum.KeyCode.D) then vel += cam.CFrame.RightVector * 50 end
                if uis:IsKeyDown(Enum.KeyCode.Space) then vel += Vector3.new(0, 50, 0) end
                if uis:IsKeyDown(Enum.KeyCode.LeftShift) then vel -= Vector3.new(0, 50, 0) end
                bv.Velocity = vel
            end
        end
    end
end)

-- Speed Hack
run.Stepped:Connect(function()
    if cfg.speed and lp.Character then
        local hum = lp.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = 32 end
    end
end)
