-- Plalette Hub - One Tap Script | plalettescripts
local Players=game:GetService("Players")
local RunService=game:GetService("RunService")
local UserInputService=game:GetService("UserInputService")
local Workspace=game:GetService("Workspace")
local CoreGui=game:GetService("CoreGui")
local Lighting=game:GetService("Lighting")
local TweenService=game:GetService("TweenService")
local LocalPlayer=Players.LocalPlayer
local Camera=Workspace.CurrentCamera
local Mouse=LocalPlayer:GetMouse()

-- Settings
local AimbotOn=false
local AimbotFOV=120
local SilentOn=false
local ESPOn=false
local TracersOn=false
local RadarOn=false
local SpeedOn=false
local SpeedVal=28
local FlyOn=false
local FlyVal=30
local JumpOn=false
local JumpVal=60
local BrightOn=false

local ESPD={}
local FOVC=nil

-- Colors (Lila)
local C1=Color3.fromRGB(140,80,255)
local C2=Color3.fromRGB(180,130,255)
local C3=Color3.fromRGB(14,12,24)
local C4=Color3.fromRGB(22,18,36)
local C5=Color3.fromRGB(230,220,255)
local C6=Color3.fromRGB(160,140,180)

local function ClearESP()
for _,d in pairs(ESPD)do pcall(function()d:Remove()end)end
ESPD={}if FOVC then pcall(function()FOVC:Remove()end)FOVC=nil end end

local function GetTarget()
local cl=99999 local t=nil local cx=Camera.ViewportSize.X/2 local cy=Camera.ViewportSize.Y/2
for _,p in ipairs(Players:GetPlayers())do if p~=LocalPlayer and p.Character then
local h=p.Character:FindFirstChild("Head")if h then
local pos,on=Camera:WorldToViewportPoint(h.Position)if on then
local dx=pos.X-cx local dy=pos.Y-cy local d=math.sqrt(dx*dx+dy*dy)
if d<AimbotFOV and d<cl then cl=d t=p end end end end end end
return t end

local function StopAll()
AimbotOn=false SilentOn=false ESPOn=false TracersOn=false RadarOn=false
SpeedOn=false FlyOn=false JumpOn=false BrightOn=false ClearESP()
if LocalPlayer.Character then
local h=LocalPlayer.Character:FindFirstChildOfClass("Humanoid")if h then h.WalkSpeed=16 end
local r=LocalPlayer.Character:FindFirstChild("HumanoidRootPart")if r then
for _,c in ipairs(r:GetChildren())do if c:IsA("BodyGyro")or c:IsA("BodyVelocity")then c:Destroy()end end end end
Lighting.Brightness=1 end

-- GUI
local GUI=Instance.new("ScreenGui")GUI.Name="PlaletteHub_OneTap"GUI.ResetOnSpawn=false GUI.Parent=CoreGui
local M=Instance.new("Frame")M.Size=UDim2.new(0,560,0,390)M.Position=UDim2.new(0.5,-280,0.5,-195)M.BackgroundColor3=C3 M.BackgroundTransparency=0.03 M.BorderSizePixel=0 M.Active=true M.Draggable=true M.Parent=GUI
Instance.new("UICorner",M).CornerRadius=UDim.new(0,10)

local GL=Instance.new("Frame")GL.Size=UDim2.new(1,2,1,2)GL.Position=UDim2.new(0,-1,0,-1)GL.BackgroundColor3=C2 GL.BackgroundTransparency=0.5 GL.BorderSizePixel=0 GL.Parent=M
Instance.new("UICorner",GL).CornerRadius=UDim.new(0,10)

task.spawn(function()local a=0 while GUI and GUI.Parent do a=(a+0.02)%(math.pi*2)pcall(function()GL.BackgroundTransparency=0.45-math.sin(a)*0.2 end)task.wait(0.05)end end)

local MN=Instance.new("Frame")MN.Size=UDim2.new(0,180,0,30)MN.Position=UDim2.new(0.5,-90,0.02,0)MN.BackgroundColor3=C3 MN.BackgroundTransparency=0.03 MN.BorderSizePixel=0 MN.Visible=false MN.Active=true MN.Draggable=true MN.Parent=GUI
Instance.new("UICorner",MN).CornerRadius=UDim.new(0,8)
local MT=Instance.new("TextLabel")MT.Size=UDim2.new(1,0,1,0)MT.BackgroundTransparency=1 MT.TextColor3=C2 MT.Text="One Tap | Plalette Hub"MT.Font=Enum.Font.SourceSansBold MT.TextSize=11 MT.Parent=MN

UserInputService.InputBegan:Connect(function(i,p)if p then return end if i.KeyCode==Enum.KeyCode.LeftControl or i.KeyCode==Enum.KeyCode.RightControl then M.Visible=not M.Visible MN.Visible=not MN.Visible end end)

local H=Instance.new("Frame")H.Size=UDim2.new(1,0,0,44)H.BackgroundColor3=Color3.fromRGB(18,15,28)H.BorderSizePixel=0 H.Parent=M
Instance.new("UICorner",H).CornerRadius=UDim.new(0,10)
local HT=Instance.new("TextLabel")HT.Size=UDim2.new(0.5,0,0.55,0)HT.Position=UDim2.new(0,16,0,2)HT.BackgroundTransparency=1 HT.TextColor3=C2 HT.Text="One Tap"HT.Font=Enum.Font.SourceSansBold HT.TextSize=16 HT.TextXAlignment=Enum.TextXAlignment.Left HT.Parent=H
local HS=Instance.new("TextLabel")HS.Size=UDim2.new(0.5,0,0.35,0)HS.Position=UDim2.new(0,16,0,26)HS.BackgroundTransparency=1 HS.TextColor3=C6 HS.Text="Plalette Hub · Lila Edition"HS.Font=Enum.Font.SourceSans HS.TextSize=10 HS.TextXAlignment=Enum.TextXAlignment.Left HS.Parent=H
local CB=Instance.new("TextButton")CB.Size=UDim2.new(0,28,0,26)CB.Position=UDim2.new(1,-36,0,9)CB.BackgroundColor3=Color3.fromRGB(220,50,70)CB.TextColor3=Color3.fromRGB(255,255,255)CB.Text="X"CB.Font=Enum.Font.SourceSansBold CB.TextSize=14 CB.Parent=H
Instance.new("UICorner",CB).CornerRadius=UDim.new(0,5)CB.MouseButton1Click:Connect(function()StopAll()GUI:Destroy()end)

local SB=Instance.new("Frame")SB.Size=UDim2.new(0,155,1,-44)SB.Position=UDim2.new(0,0,0,44)SB.BackgroundColor3=C4 SB.BorderSizePixel=0 SB.Parent=M
local SBL=Instance.new("UIListLayout")SBL.Padding=UDim.new(0,2)SBL.FillDirection=Enum.FillDirection.Vertical SBL.HorizontalAlignment=Enum.HorizontalAlignment.Center SBL.SortOrder=Enum.SortOrder.LayoutOrder SBL.Parent=SB

local CT=Instance.new("Frame")CT.Size=UDim2.new(1,-155,1,-70)CT.Position=UDim2.new(0,155,0,44)CT.BackgroundColor3=Color3.fromRGB(16,14,24)CT.BorderSizePixel=0 CT.Parent=M

local FT=Instance.new("Frame")FT.Size=UDim2.new(1,-155,0,26)FT.Position=UDim2.new(0,155,1,-26)FT.BackgroundColor3=C4 FT.BorderSizePixel=0 FT.Parent=M
local FA=Instance.new("ImageLabel")FA.Size=UDim2.new(0,32,0,32)FA.Position=UDim2.new(0,8,0.5,-16)FA.BackgroundColor3=Color3.fromRGB(30,25,45)FA.BorderSizePixel=0 FA.Parent=FT
Instance.new("UICorner",FA).CornerRadius=UDim.new(0,16)
task.spawn(function()FA.Image=Players:GetUserThumbnailAsync(LocalPlayer.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size48x48)end)
local FL=Instance.new("TextLabel")FL.Size=UDim2.new(1,0,1,0)FL.BackgroundTransparency=1 FL.TextColor3=C6 FL.Text="Welcome, "..LocalPlayer.Name.."  |  Plalette Hub"FL.Font=Enum.Font.SourceSans FL.TextSize=12 FL.TextXAlignment=Enum.TextXAlignment.Center FL.Parent=FT

-- Tabs
local tabs={}
local function MakeTab(n,ic)
local b=Instance.new("TextButton")b.Size=UDim2.new(1,-10,0,34)b.BackgroundColor3=Color3.fromRGB(26,22,38)b.TextColor3=C6 b.Text="  "..ic.."  "..n b.Font=Enum.Font.SourceSans b.TextSize=12 b.TextXAlignment=Enum.TextXAlignment.Left b.Parent=SB
Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
local p=Instance.new("ScrollingFrame")p.Size=UDim2.new(1,-16,1,-16)p.Position=UDim2.new(0,8,0,8)p.BackgroundTransparency=1 p.BorderSizePixel=0 p.ScrollBarThickness=3 p.ScrollBarImageColor3=C1 p.CanvasSize=UDim2.new(0,0,0,0)p.Visible=false p.Parent=CT
local pl=Instance.new("UIListLayout")pl.Padding=UDim.new(0,5)pl.FillDirection=Enum.FillDirection.Vertical pl.SortOrder=Enum.SortOrder.LayoutOrder pl.Parent=p
b.MouseButton1Click:Connect(function()for _,x in ipairs(SB:GetChildren())do if x:IsA("TextButton")then x.BackgroundColor3=Color3.fromRGB(26,22,38)x.TextColor3=C6 end end for _,x in pairs(tabs)do x.Visible=false end b.BackgroundColor3=C1 b.TextColor3=Color3.fromRGB(255,255,255)p.Visible=true end)
table.insert(tabs,p)if#tabs==1 then b.BackgroundColor3=C1 b.TextColor3=Color3.fromRGB(255,255,255)p.Visible=true end
return p end

local function Sec(p,t)local f=Instance.new("Frame")f.Size=UDim2.new(1,0,0,20)f.BackgroundTransparency=1 f.Parent=p
local l=Instance.new("TextLabel")l.Size=UDim2.new(1,0,1,0)l.BackgroundTransparency=1 l.TextColor3=C6 l.Text=t l.Font=Enum.Font.SourceSansBold l.TextSize=11 l.TextXAlignment=Enum.TextXAlignment.Left l.Parent=f
p.CanvasSize=UDim2.new(0,0,0,p.CanvasSize.Y.Offset+24)end

local function Tog(p,n,vn)
local f=Instance.new("Frame")f.Size=UDim2.new(1,0,0,34)f.BackgroundColor3=Color3.fromRGB(26,24,38)f.Parent=p
Instance.new("UICorner",f).CornerRadius=UDim.new(0,6)
local l=Instance.new("TextLabel")l.Size=UDim2.new(0.6,0,1,0)l.Position=UDim2.new(0,12,0,0)l.BackgroundTransparency=1 l.TextColor3=C5 l.Text=n..": OFF"l.Font=Enum.Font.SourceSans l.TextSize=13 l.TextXAlignment=Enum.TextXAlignment.Left l.Parent=f
local tr=Instance.new("Frame")tr.Size=UDim2.new(0,42,0,24)tr.Position=UDim2.new(1,-54,0,5)tr.BackgroundColor3=Color3.fromRGB(50,45,60)tr.BorderSizePixel=0 tr.Parent=f
Instance.new("UICorner",tr).CornerRadius=UDim.new(0,12)
local th=Instance.new("Frame")th.Size=UDim2.new(0,20,0,20)th.Position=UDim2.new(0,2,0,2)th.BackgroundColor3=Color3.fromRGB(180,170,200)th.BorderSizePixel=0 th.Parent=tr
Instance.new("UICorner",th).CornerRadius=UDim.new(0,10)
local tb=Instance.new("TextButton")tb.Size=UDim2.new(1,0,1,0)tb.BackgroundTransparency=1 tb.Text=""tb.Parent=tr
local on=false
tb.MouseButton1Click:Connect(function()
on=not on
if vn=="Aimbot"then AimbotOn=on elseif vn=="Silent"then SilentOn=on elseif vn=="ESP"then ESPOn=on elseif vn=="Tracers"then TracersOn=on elseif vn=="Radar"then RadarOn=on elseif vn=="Speed"then SpeedOn=on elseif vn=="Fly"then FlyOn=on elseif vn=="Jump"then JumpOn=on elseif vn=="Bright"then BrightOn=on end
l.Text=n..": "..(on and"ON"or"OFF")
if on then tr.BackgroundColor3=C1 th.Position=UDim2.new(1,-22,0,2)th.BackgroundColor3=Color3.fromRGB(255,255,255)else tr.BackgroundColor3=Color3.fromRGB(50,45,60)th.Position=UDim2.new(0,2,0,2)th.BackgroundColor3=Color3.fromRGB(180,170,200)end end)
p.CanvasSize=UDim2.new(0,0,0,p.CanvasSize.Y.Offset+38)end

local function Sli(p,n,vn,min,max,def)
local f=Instance.new("Frame")f.Size=UDim2.new(1,0,0,48)f.BackgroundColor3=Color3.fromRGB(26,24,38)f.Parent=p
Instance.new("UICorner",f).CornerRadius=UDim.new(0,6)
local l=Instance.new("TextLabel")l.Size=UDim2.new(0.4,0,0,20)l.Position=UDim2.new(0,12,0,4)l.BackgroundTransparency=1 l.TextColor3=C5 l.Text=n l.Font=Enum.Font.SourceSans l.TextSize=13 l.TextXAlignment=Enum.TextXAlignment.Left l.Parent=f
local vl=Instance.new("TextLabel")vl.Size=UDim2.new(0,45,0,20)vl.Position=UDim2.new(1,-57,0,4)vl.BackgroundTransparency=1 vl.TextColor3=C2 vl.Text=tostring(def)vl.Font=Enum.Font.SourceSansBold vl.TextSize=13 vl.TextXAlignment=Enum.TextXAlignment.Right vl.Parent=f
local inp=Instance.new("TextBox")inp.Size=UDim2.new(0.3,0,0,22)inp.Position=UDim2.new(0.35,0,0,24)inp.BackgroundColor3=Color3.fromRGB(40,36,50)inp.TextColor3=Color3.fromRGB(255,255,255)inp.Text=tostring(def)inp.Font=Enum.Font.SourceSans inp.TextSize=12 inp.Parent=f
Instance.new("UICorner",inp).CornerRadius=UDim.new(0,4)
inp.FocusLost:Connect(function()local v=tonumber(inp.Text)if v and v>=min and v<=max then
if vn=="AimR"then AimbotFOV=v elseif vn=="SpdV"then SpeedVal=v elseif vn=="JumpV"then JumpVal=v elseif vn=="FlyV"then FlyVal=v end
vl.Text=tostring(v)else inp.Text=tostring(vn=="AimR"and AimbotFOV or vn=="SpdV"and SpeedVal or vn=="JumpV"and JumpVal or vn=="FlyV"and FlyVal or def)end end)
p.CanvasSize=UDim2.new(0,0,0,p.CanvasSize.Y.Offset+52)end

local home=MakeTab("Home","HS")
local combat=MakeTab("Combat","CO")
local visual=MakeTab("Visuals","VI")
local char=MakeTab("Char","CH")

-- HOME
local wf=Instance.new("Frame")wf.Size=UDim2.new(1,0,0,80)wf.BackgroundColor3=Color3.fromRGB(26,24,38)wf.Parent=home
Instance.new("UICorner",wf).CornerRadius=UDim.new(0,8)
local wt=Instance.new("TextLabel")wt.Size=UDim2.new(1,-20,0,30)wt.Position=UDim2.new(0,10,0,12)wt.BackgroundTransparency=1 wt.TextColor3=C5 wt.Text="Welcome, "..LocalPlayer.Name wt.Font=Enum.Font.SourceSansBold wt.TextSize=18 wt.TextXAlignment=Enum.TextXAlignment.Left wt.Parent=wf
local wi=Instance.new("TextLabel")wi.Size=UDim2.new(1,-20,0,30)wi.Position=UDim2.new(0,10,0,45)wi.BackgroundTransparency=1 wi.TextColor3=C6 wi.Text="Plalette Hub · One Tap\nCTRL = Hide | X = Stop"wi.Font=Enum.Font.SourceSans wi.TextSize=13 wi.TextXAlignment=Enum.TextXAlignment.Left wi.Parent=wf
home.CanvasSize=UDim2.new(0,0,0,100)

-- COMBAT
Sec(combat,"Aimbot")Tog(combat,"FOV Aimbot","Aimbot")Sli(combat,"FOV Radius","AimR",30,300,120)Tog(combat,"Silent Aim","Silent")

-- VISUALS
Sec(visual,"ESP")Tog(visual,"Player ESP","ESP")Tog(visual,"Tracers","Tracers")Tog(visual,"Radar","Radar")

-- CHARACTER
Sec(char,"Movement")Tog(char,"Speed Hack","Speed")Sli(char,"Walk Speed","SpdV",16,35,28)Tog(char,"Infinite Jump","Jump")Sli(char,"Jump Power","JumpV",50,200,60)Tog(char,"Fly","Fly")Sli(char,"Fly Speed","FlyV",15,50,30)
Sec(char,"World")Tog(char,"Fullbright","Bright")

-- FEATURES
task.spawn(function()while task.wait(0.03)do if AimbotOn then if not FOVC then FOVC=Drawing.new("Circle")end FOVC.Visible=true FOVC.Radius=AimbotFOV FOVC.Thickness=1.5 FOVC.Color=C1 FOVC.Filled=false FOVC.Position=Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y/2)else if FOVC then FOVC.Visible=false end end end end)

local oldNC=hookmetamethod(game,"__namecall",function(s,...)local m=getnamecallmethod()local a={...}if m=="FireServer"and AimbotOn and SilentOn then local t=GetTarget()if t and t.Character then local h=t.Character:FindFirstChild("Head")if h and a[1]then a[1]=h.Position end end end return oldNC(s,unpack(a))end)

task.spawn(function()while task.wait(0.06)do ClearESP()
if ESPOn then for _,p in ipairs(Players:GetPlayers())do if p~=LocalPlayer and p.Character then local h=p.Character:FindFirstChild("Head")local r=p.Character:FindFirstChild("HumanoidRootPart")if h and r then local hp,on=Camera:WorldToViewportPoint(h.Position+Vector3.new(0,0.5,0))local fp=Camera:WorldToViewportPoint(r.Position-Vector3.new(0,3,0))if on then local bh=math.abs(hp.Y-fp.Y)local bw=bh/2
local bx=Drawing.new("Square")bx.Color=C1 bx.Thickness=1 bx.Size=Vector2.new(bw,bh)bx.Position=Vector2.new(hp.X-bw/2,hp.Y)bx.Filled=false bx.Visible=true table.insert(ESPD,bx)
local nm=Drawing.new("Text")nm.Text=p.Name nm.Color=Color3.fromRGB(255,255,255)nm.Size=12 nm.Position=Vector2.new(hp.X,hp.Y-16)nm.Center=true nm.Visible=true table.insert(ESPD,nm)end end end end end
if TracersOn then for _,p in ipairs(Players:GetPlayers())do if p~=LocalPlayer and p.Character then local r=p.Character:FindFirstChild("HumanoidRootPart")if r then local pos,on=Camera:WorldToViewportPoint(r.Position)if on then local ln=Drawing.new("Line")ln.Color=C2 ln.Thickness=0.5 ln.From=Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y)ln.To=Vector2.new(pos.X,pos.Y)ln.Visible=true table.insert(ESPD,ln)end end end end end
if RadarOn then local rs=55 local rx=Camera.ViewportSize.X-rs-8 local ry=Camera.ViewportSize.Y-rs-8
local bg=Drawing.new("Square")bg.Color=Color3.fromRGB(0,0,0)bg.Size=Vector2.new(rs,rs)bg.Position=Vector2.new(rx,ry)bg.Filled=true bg.Visible=true table.insert(ESPD,bg)
if LocalPlayer.Character then local mr=LocalPlayer.Character:FindFirstChild("HumanoidRootPart")if mr then for _,pl in ipairs(Players:GetPlayers())do if pl.Character then local pr=pl.Character:FindFirstChild("HumanoidRootPart")if pr then local off=pr.Position-mr.Position local rd=math.clamp(off.Magnitude/3,0,rs/2-2)local a=math.atan2(off.Z,off.X)local dx=rx+rs/2+math.cos(a)*rd local dy=ry+rs/2+math.sin(a)*rd
local dt=Drawing.new("Circle")dt.Color=pl==LocalPlayer and Color3.fromRGB(0,255,0)or C1 dt.Radius=2 dt.Position=Vector2.new(dx,dy)dt.Filled=true dt.Visible=true table.insert(ESPD,dt)end end end end end end end
end end)

RunService.Stepped:Connect(function()if SpeedOn and LocalPlayer.Character then local h=LocalPlayer.Character:FindFirstChildOfClass("Humanoid")if h then h.WalkSpeed=SpeedVal end end if JumpOn and LocalPlayer.Character then local h=LocalPlayer.Character:FindFirstChildOfClass("Humanoid")if h then h.JumpPower=JumpVal end end end)
UserInputService.JumpRequest:Connect(function()if JumpOn and LocalPlayer.Character then local h=LocalPlayer.Character:FindFirstChildOfClass("Humanoid")if h then h:ChangeState(Enum.HumanoidStateType.Jumping)end end end)

task.spawn(function()while task.wait()do if FlyOn and LocalPlayer.Character then local r=LocalPlayer.Character:FindFirstChild("HumanoidRootPart")if r then
local g=r:FindFirstChild("FlyG")if not g then g=Instance.new("BodyGyro")g.Name="FlyG"g.Parent=r end
local v=r:FindFirstChild("FlyV")if not v then v=Instance.new("BodyVelocity")v.Name="FlyV"v.Parent=r end
g.MaxTorque=Vector3.new(9e9,9e9,9e9)g.CFrame=Camera.CFrame v.MaxForce=Vector3.new(9e9,9e9,9e9)
local s=math.min(FlyVal,50)local m=Vector3.zero
if UserInputService:IsKeyDown(Enum.KeyCode.W)then m=m+Camera.CFrame.LookVector end
if UserInputService:IsKeyDown(Enum.KeyCode.S)then m=m-Camera.CFrame.LookVector end
if UserInputService:IsKeyDown(Enum.KeyCode.A)then m=m-Camera.CFrame.RightVector end
if UserInputService:IsKeyDown(Enum.KeyCode.D)then m=m+Camera.CFrame.RightVector end
if UserInputService:IsKeyDown(Enum.KeyCode.Space)then m=m+Vector3.new(0,1,0)end
if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift)then m=m-Vector3.new(0,1,0)end
v.Velocity=m*s end end end end)

task.spawn(function()while task.wait(60)do if BrightOn then Lighting.Brightness=2 Lighting.ClockTime=14 end end end)

print("Plalette Hub · One Tap · Lila Edition")
