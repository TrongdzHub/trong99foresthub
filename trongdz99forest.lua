repeat task.wait() until game:IsLoaded()

local player = game.Players.LocalPlayer
if not player.Character then
	player.CharacterAdded:Wait()
end

-- LOAD RAYFIELD
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
	Name = "🌲 99 Nights Forest Hub",
	LoadingTitle = "Forest Hub",
	LoadingSubtitle = "by Cubi",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "ForestHub",
		FileName = "Config"
	}
})

-- VARIABLES
getgenv().AutoFarm = false
getgenv().AutoUpgrade = false
getgenv().AutoCollect = false

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- GET ROOT
local function getRoot()
	if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		return player.Character.HumanoidRootPart
	end
	return nil
end

-- FIND TREE
local function getClosestTree()

	local root = getRoot()
	if not root then return nil end

	local closest = nil
	local dist = math.huge

	for _,v in pairs(workspace:GetChildren()) do

		if v.Name:find("Tree") or v.Name:find("Wood") then

			local part = v:FindFirstChildWhichIsA("BasePart")

			if part then

				local d = (root.Position - part.Position).Magnitude

				if d < dist then
					dist = d
					closest = part
				end

			end

		end

	end

	return closest
end

-- TAB MAIN
local MainTab = Window:CreateTab("Main", 4483345998)

-- AUTO CHOP
MainTab:CreateToggle({
	Name = "Auto Chop Tree",
	CurrentValue = false,
	Flag = "AutoFarm",
	Callback = function(Value)

		getgenv().AutoFarm = Value

		while getgenv().AutoFarm do

			local tree = getClosestTree()
			local root = getRoot()

			if tree and root then

				root.CFrame = tree.CFrame * CFrame.new(0,0,3)

				pcall(function()
					ReplicatedStorage.Events.Interact:FireServer(tree)
				end)

			end

			task.wait(0.4)

		end
	end
})

-- AUTO UPGRADE
MainTab:CreateToggle({
	Name = "Auto Upgrade",
	CurrentValue = false,
	Flag = "AutoUpgrade",
	Callback = function(Value)

		getgenv().AutoUpgrade = Value

		while getgenv().AutoUpgrade do

			local upgrades = {"Fireplace","Chest","Axe","Sword"}

			for _,v in pairs(upgrades) do

				pcall(function()
					ReplicatedStorage.Events.Upgrade:FireServer(v)
				end)

			end

			task.wait(1.5)

		end
	end
})

-- AUTO COLLECT
MainTab:CreateToggle({
	Name = "Auto Collect Items",
	CurrentValue = false,
	Flag = "AutoCollect",
	Callback = function(Value)

		getgenv().AutoCollect = Value

		while getgenv().AutoCollect do

			pcall(function()

				local campfire = workspace:FindFirstChild("Campfire") or workspace:FindFirstChild("Fire")

				if campfire and workspace:FindFirstChild("DroppedItems") then

					local firePart = campfire:FindFirstChildWhichIsA("BasePart")

					if firePart then

						for _,item in pairs(workspace.DroppedItems:GetChildren()) do

							if item:IsA("BasePart") then
								item.CFrame = firePart.CFrame * CFrame.new(0,2,0)
							elseif item:IsA("Model") and item.PrimaryPart then
								item:SetPrimaryPartCFrame(firePart.CFrame * CFrame.new(0,2,0))
							end

						end

					end

				end

			end)

			task.wait(0.6)

		end
	end
})

-- TAB SETTINGS
local SettingsTab = Window:CreateTab("Settings", 4483345998)

SettingsTab:CreateButton({
	Name = "Destroy Script",
	Callback = function()
		Rayfield:Destroy()
	end
})
