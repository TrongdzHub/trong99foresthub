repeat task.wait() until game:IsLoaded()

-- LOAD RAYFIELD
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
   Name = "Cubi Forest Hub",
   Icon = "rbxassetid://97554009847628", -- logo Cubi
   LoadingTitle = "Cubi Hub",
   LoadingSubtitle = "99 Nights Forest",
   ConfigurationSaving = {
      Enabled = false
   }
})

local Main = Window:CreateTab("Main", 4483362458)
local Combat = Window:CreateTab("Combat", 4483362458)

------------------------------------------------
-- AUTO FARM TREE
------------------------------------------------

getgenv().AutoFarmTree = false

Main:CreateToggle({
   Name = "Auto Farm Tree",
   CurrentValue = false,
   Callback = function(v)
      getgenv().AutoFarmTree = v
   end
})

task.spawn(function()
while task.wait(1) do
if getgenv().AutoFarmTree then

for _,v in pairs(workspace:GetDescendants()) do
if v.Name:lower():find("tree") and v:IsA("Part") then

local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
hrp.CFrame = v.CFrame + Vector3.new(0,3,0)

local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
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
-- AUTO COLLECT
------------------------------------------------

getgenv().AutoCollect = false

Main:CreateToggle({
   Name = "Auto Collect Wood",
   CurrentValue = false,
   Callback = function(v)
      getgenv().AutoCollect = v
   end
})

task.spawn(function()
while task.wait(1) do
if getgenv().AutoCollect then

for _,v in pairs(workspace:GetDescendants()) do
if v.Name:lower():find("wood") and v:IsA("Part") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
end
end

end
end
end)

------------------------------------------------
-- KILL BEAR
------------------------------------------------

getgenv().KillBear = false

Combat:CreateToggle({
   Name = "Kill Bear",
   CurrentValue = false,
   Callback = function(v)
      getgenv().KillBear = v
   end
})

task.spawn(function()
while task.wait(1) do
if getgenv().KillBear then

for _,v in pairs(workspace:GetDescendants()) do
if v.Name == "Bear" and v:FindFirstChild("HumanoidRootPart") then

game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
v.HumanoidRootPart.CFrame * CFrame.new(0,0,3)

local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
if tool then
tool:Activate()
end

end
end

end
end
end)

------------------------------------------------
-- FLOATING BUTTON (MOBILE MENU)
------------------------------------------------

local ScreenGui = Instance.new("ScreenGui")
local Button = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui

Button.Parent = ScreenGui
Button.Size = UDim2.new(0,60,0,60)
Button.Position = UDim2.new(0,20,0.5,0)
Button.Text = "MENU"
Button.BackgroundColor3 = Color3.fromRGB(0,170,255)

local open = true

Button.MouseButton1Click:Connect(function()
open = not open
Rayfield:Toggle()
end)
