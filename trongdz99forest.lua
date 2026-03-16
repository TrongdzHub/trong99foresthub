repeat task.wait() until game:IsLoaded()

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
   Name = "Cubi Forest Hub",
   Icon = "rbxassetid://97554009847628",
   LoadingTitle = "Trong Dz Hub",
   LoadingSubtitle = "Forest Survival",
   ConfigurationSaving = {Enabled = false}
})

local Main = Window:CreateTab("Farm", 4483362458)
local Combat = Window:CreateTab("Combat", 4483362458)
local Player = Window:CreateTab("Player", 4483362458)

------------------------------------------------
-- AUTO FARM TREE
------------------------------------------------

getgenv().AutoFarm = false

Main:CreateToggle({
Name="Auto Farm Tree",
CurrentValue=false,
Callback=function(v)
getgenv().AutoFarm=v
end
})

task.spawn(function()
while task.wait(1) do
if getgenv().AutoFarm then
for _,v in pairs(workspace:GetDescendants()) do
if v.Name:lower():find("tree") and v:IsA("Part") then

local hrp=game.Players.LocalPlayer.Character.HumanoidRootPart
hrp.CFrame=v.CFrame+Vector3.new(0,3,0)

local tool=game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
if tool then
tool:Activate()
end

task.wait(2)

end
end
end
end
end)

------------------------------------------------
-- AUTO COLLECT WOOD
------------------------------------------------

getgenv().Collect=false

Main:CreateToggle({
Name="Auto Collect Wood",
CurrentValue=false,
Callback=function(v)
getgenv().Collect=v
end
})

task.spawn(function()
while task.wait(1) do
if getgenv().Collect then
for _,v in pairs(workspace:GetDescendants()) do
if v.Name:lower():find("wood") and v:IsA("Part") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=v.CFrame
end
end
end
end
end)

------------------------------------------------
-- KILL BEAR
------------------------------------------------

getgenv().KillBear=false

Combat:CreateToggle({
Name="Kill Bear",
CurrentValue=false,
Callback=function(v)
getgenv().KillBear=v
end
})

task.spawn(function()
while task.wait(1) do
if getgenv().KillBear then
for _,v in pairs(workspace:GetDescendants()) do
if v.Name=="Bear" and v:FindFirstChild("HumanoidRootPart") then

game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=
v.HumanoidRootPart.CFrame*CFrame.new(0,0,3)

local tool=game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
if tool then
tool:Activate()
end

end
end
end
end
end)

------------------------------------------------
-- WALK SPEED
------------------------------------------------

Player:CreateSlider({
Name="WalkSpeed",
Range={16,120},
Increment=1,
CurrentValue=16,
Callback=function(v)
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed=v
end
})

------------------------------------------------
-- ESP BEAR
------------------------------------------------

Combat:CreateToggle({
Name="ESP Bear",
CurrentValue=false,
Callback=function(v)

for _,b in pairs(workspace:GetDescendants()) do
if b.Name=="Bear" then
if v then
local h=Instance.new("Highlight")
h.Parent=b
h.FillColor=Color3.fromRGB(255,0,0)
else
if b:FindFirstChild("Highlight") then
b.Highlight:Destroy()
end
end
end
end

end
})

------------------------------------------------
-- TELEPORT CAMP
------------------------------------------------

Main:CreateButton({
Name="Teleport Camp",
Callback=function()

for _,v in pairs(workspace:GetDescendants()) do
if v.Name:lower():find("camp") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=v.CFrame
break
end
end

end
})

------------------------------------------------
-- FLOATING MENU BUTTON
------------------------------------------------

local gui=Instance.new("ScreenGui")
gui.Parent=game.CoreGui

local btn=Instance.new("TextButton")
btn.Parent=gui
btn.Size=UDim2.new(0,60,0,60)
btn.Position=UDim2.new(0,20,0.5,0)
btn.Text="CUBI"
btn.BackgroundColor3=Color3.fromRGB(0,170,255)

local open=true

btn.MouseButton1Click:Connect(function()
open=not open
Rayfield:Toggle()
end)
