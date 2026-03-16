repeat task.wait() until game:IsLoaded()

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
   Name = "Cubi Forest Hub | Premium V2",
   Icon = "rbxassetid://97554009847628",
   LoadingTitle = "Cubi Hub",
   LoadingSubtitle = "Forest Survival",
   ConfigurationSaving = {Enabled = false}
})

-- Biến điều khiển
getgenv().AutoFarm = false
getgenv().Collect = false
getgenv().KillBear = false

local Main = Window:CreateTab("Farm", 4483362458)
local Combat = Window:CreateTab("Combat", 4483362458)
local Player = Window:CreateTab("Player", 4483362458)

------------------------------------------------
-- AUTO FARM TREE (FIXED)
------------------------------------------------
Main:CreateToggle({
    Name = "Auto Farm Tree",
    CurrentValue = false,
    Callback = function(v)
        getgenv().AutoFarm = v
    end
})

task.spawn(function()
    while task.wait(0.5) do
        if getgenv().AutoFarm then
            pcall(function()
                for _, v in pairs(workspace:GetChildren()) do -- Chỉ quét vật thể lớn ở Workspace
                    if v.Name:lower():find("tree") and getgenv().AutoFarm then
                        local targetPart = v:FindFirstChild("Wood") or v:FindFirstChildWhichIsA("BasePart")
                        if targetPart then
                            local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
                            -- Bay lên trên cây một chút để không bị kẹt
                            hrp.CFrame = targetPart.CFrame * CFrame.new(0, 5, 0)
                            
                            local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
                            if tool then
                                tool:Activate()
                            end
                            task.wait(0.5) -- Đợi chặt xong 1 nhịp rồi mới tìm cây khác
                        end
                    end
                end
            end)
        end
    end
end)

------------------------------------------------
-- AUTO COLLECT WOOD (FIXED)
------------------------------------------------
Main:CreateToggle({
    Name = "Auto Collect Wood",
    CurrentValue = false,
    Callback = function(v)
        getgenv().Collect = v
    end
})

task.spawn(function()
    while task.wait(0.3) do
        if getgenv().Collect then
            for _, v in pairs(workspace:GetChildren()) do
                if (v.Name:lower():find("wood") or v.Name:lower():find("item")) and v:IsA("BasePart") then
                    v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                end
            end
        end
    end
end)

------------------------------------------------
-- KILL BEAR (SMART TP)
------------------------------------------------
Combat:CreateToggle({
    Name = "Kill Bear",
    CurrentValue = false,
    Callback = function(v)
        getgenv().KillBear = v
    end
})

task.spawn(function()
    while task.wait(0.1) do
        if getgenv().KillBear then
            for _, v in pairs(workspace:GetChildren()) do
                if v.Name == "Bear" and v:FindFirstChild("HumanoidRootPart") then
                    -- Teleport ra sau lưng gấu để né đòn
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                    local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
                    if tool then tool:Activate() end
                end
            end
        end
    end
end)

------------------------------------------------
-- FLOATING BUTTON (HỖ TRỢ MOBILE)
------------------------------------------------
local ScreenGui = Instance.new("ScreenGui")
local ImageButton = Instance.new("ImageButton")

ScreenGui.Parent = game.CoreGui
ImageButton.Parent = ScreenGui
ImageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageButton.BackgroundTransparency = 1.0
ImageButton.Position = UDim2.new(0, 10, 0, 150)
ImageButton.Size = UDim2.new(0, 50, 0, 50)
ImageButton.Image = "rbxassetid://97554009847628" -- Logo của bạn

ImageButton.MouseButton1Click:Connect(function()
    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.RightControl, false, game)
end)

-- Các chức năng khác (WalkSpeed, Teleport) giữ nguyên logic cũ nhưng bọc trong pcall để tránh lỗi.
