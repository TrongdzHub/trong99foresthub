repeat task.wait() until game:IsLoaded()

-- LOAD UI
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
   Name = "Cubi Forest Hub",
   LoadingTitle = "Cubi Hub",
   LoadingSubtitle = "99 Nights In Forest",
   ToggleUIKeybind = "RightControl",
   ConfigurationSaving = {
      Enabled = false
   }
})

local Main = Window:CreateTab("Farm", 4483362458)
local Esp = Window:CreateTab("ESP", 4483362458)

------------------------------------------------
-- AUTO CHOP
------------------------------------------------

getgenv().AutoChop = false

Main:CreateToggle({
   Name = "Auto Chop",
   CurrentValue = false,
   Callback = function(v)
      getgenv().AutoChop = v
   end
})

task.spawn(function()
while task.wait(0.3) do
if getgenv().AutoChop then
local char = game.Players.LocalPlayer.Character
if char then
local tool = char:FindFirstChildOfClass("Tool")
if tool then
tool:Activate()
end
end
end
end
end)

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

for i,v in pairs(workspace:GetDescendants()) do
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
-- AUTO COLLECT WOOD
------------------------------------------------

getgenv().AutoWood = false

Main:CreateToggle({
   Name = "Auto Collect Wood",
   CurrentValue = false,
   Callback = function(v)
      getgenv().AutoWood = v
   end
})

task.spawn(function()
while task.wait(1) do
if getgenv().AutoWood then

for i,v in pairs(workspace:GetDescendants()) do
if v.Name:lower():find("wood") and v:IsA("Part") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
end
end

end
end
end)

------------------------------------------------
-- ESP BEAR
------------------------------------------------

getgenv().BearESP = false

Esp:CreateToggle({
   Name = "ESP Bear",
   CurrentValue = false,
   Callback = function(v)
      getgenv().BearESP = v
   end
})

task.spawn(function()
while task.wait(2) do
if getgenv().BearESP then

for i,v in pairs(workspace:GetDescendants()) do
if v.Name == "Bear" then
if not v:FindFirstChild("Highlight") then

local h = Instance.new("Highlight")
h.Parent = v
h.FillColor = Color3.fromRGB(255,0,0)

end
end
end

end
end
end)

------------------------------------------------
-- ESP TREE
------------------------------------------------

getgenv().TreeESP = false

Esp:CreateToggle({
   Name = "ESP Tree",
   CurrentValue = false,
   Callback = function(v)
      getgenv().TreeESP = v
   end
})

task.spawn(function()
while task.wait(2) do
if getgenv().TreeESP then

for i,v in pairs(workspace:GetDescendants()) do
if v.Name:lower():find("tree") then
if not v:FindFirstChild("Highlight") then

local h = Instance.new("Highlight")
h.Parent = v
h.FillColor = Color3.fromRGB(0,255,0)

end
end
end

end
end
end)
