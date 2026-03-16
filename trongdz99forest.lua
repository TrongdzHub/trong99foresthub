-- Chờ game load hoàn toàn để tránh lỗi script chạy trước game
if not game:IsLoaded() then game.Loaded:Wait() end

-- Sử dụng bản Orion được tối ưu cho Mobile/Delta
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({
    Name = "🔥 CUBI HUB V5 | PREMIUM", 
    HidePremium = false, 
    SaveConfig = true, 
    ConfigFolder = "CubiForestV5",
    IntroText = "Đang khởi tạo Cubi Hub...",
    Icon = "rbxassetid://97554009847628" -- Logo của bạn
})

-- Biến toàn cục (Global Variables)
getgenv().AutoFarm = false
getgenv().AutoCollect = false
getgenv().AutoUpgrade = false

-- [TAB: FARM]
local FarmTab = Window:MakeTab({
    Name = "Auto Farm",
    Icon = "rbxassetid://4483345998"
})

FarmTab:AddToggle({
    Name = "Auto Chặt Gỗ (Smart)",
    Default = false,
    Callback = function(Value)
        getgenv().AutoFarm = Value
        task.spawn(function()
            while getgenv().AutoFarm do
                pcall(function()
                    for _, v in pairs(workspace:GetChildren()) do
                        if not getgenv().AutoFarm then break end
                        
                        -- Tìm vật thể có tên chứa chữ "Tree"
                        if v.Name:lower():find("tree") then
                            local part = v:FindFirstChildWhichIsA("BasePart") or v:FindFirstChild("Wood")
                            if part then
                                local player = game.Players.LocalPlayer
                                local character = player.Character
                                
                                -- Di chuyển tới cây (đứng cao hơn 1 chút để không kẹt)
                                character.HumanoidRootPart.CFrame = part.CFrame * CFrame.new(0, 5, 0)
                                
                                -- Tự động trang bị Rìu từ Backpack hoặc Character
                                local tool = player.Backpack:FindFirstChildOfClass("Tool") or character:FindFirstChildOfClass("Tool")
                                if tool then
                                    character.Humanoid:EquipTool(tool)
                                    tool:Activate()
                                end
                                task.wait(0.5) -- Tốc độ chặt (chỉnh thấp hơn nếu muốn nhanh)
                            end
                        end
                    end
                end)
                task.wait(0.1)
            end
        end)
    end    
})

-- [TAB: ITEMS]
local ItemTab = Window:MakeTab({
    Name = "Vật Phẩm",
    Icon = "rbxassetid://4483345998"
})

ItemTab:AddToggle({
    Name = "Hút Gỗ/Vật Phẩm về mình",
    Default = false,
    Callback = function(Value)
        getgenv().AutoCollect = Value
        task.spawn(function()
            while getgenv().AutoCollect do
                pcall(function()
                    local myHrp = game.Players.LocalPlayer.Character.HumanoidRootPart
                    for _, v in pairs(workspace:GetChildren()) do
                        -- Hút các vật phẩm có tên Log, Wood, Food...
                        if v:IsA("BasePart") and (v.Name:find("Log") or v.Name:find("Wood") or v.Name:find("Food")) then
                            v.CFrame = myHrp.CFrame
                        end
                    end
                end)
                task.wait(0.5)
            end
        end)
    end    
})

ItemTab:AddButton({
    Name = "Gom tất cả về Lửa Trại",
    Callback = function()
        pcall(function()
            local camp = workspace:FindFirstChild("Campfire") or workspace:FindFirstChild("Fire")
            if camp then
                for _, v in pairs(workspace:GetChildren()) do
                    if v:IsA("BasePart") and (v.Name:find("Log") or v.Name:find("Wood")) then
                        v.CFrame = camp.CFrame * CFrame.new(0, 2, 0)
                    end
                end
            end
        end)
    end
})

-- [TAB: PLAYER]
local PlayerTab = Window:MakeTab({
    Name = "Người Chơi",
    Icon = "rbxassetid://4483345998"
})

PlayerTab:AddSlider({
    Name = "Tốc Độ (WalkSpeed)",
    Min = 16,
    Max = 200,
    Default = 16,
    Callback = function(v)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
    end    
})

-- Thông báo khi load xong
OrionLib:MakeNotification({
    Name = "Cubi Hub V5",
    Content = "Script đã sẵn sàng! Chúc bạn farm vui vẻ.",
    Image = "rbxassetid://97554009847628",
    Time = 5
})

OrionLib:Init()
