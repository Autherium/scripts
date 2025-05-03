local lib = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = lib:CreateWindow({
   Name = "Untitled Drill Game | Autherium",
   Icon = 0,
   LoadingTitle = "Autherium is Loading",
   LoadingSubtitle = "by Autherium",
   Theme = "Default",

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false,

   ConfigurationSaving = {
      Enabled = false,
      FolderName = "Autherium",
      FileName = "Autherium SC"
   },

   Discord = {
      Enabled = true,
      Invite = "SbDtadDG5Y",
      RememberJoins = true
   },

   KeySystem = true,
   KeySettings = {
      Title = "Key System",
      Subtitle = "by Autherium",
      Note = "Key: UDG, CahyaXyZp",
      FileName = "AuthKey",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"UDG", "CahyaXyZp"}
   }
})

getgenv().settings = {rebith = false, drill = false, sell = false, collect = false, storage = false}
local plr = game:GetService("Players").LocalPlayer
local sellPart = workspace:FindFirstChild("Scripted"):FindFirstChild("Sell")
local drillsUi = plr.PlayerGui:FindFirstChild("Menu"):FindFirstChild("CanvasGroup").Buy
local handdrillsUi = plr.PlayerGui:FindFirstChild("Menu"):FindFirstChild("CanvasGroup").HandDrills
local plot = nil

if plr then
    for _, p in ipairs(workspace.Plots:GetChildren()) do
        if p:FindFirstChild("Owner") and p.Owner.Value == plr then
            plot = p
            break
        end
    end
end

local Tab = Window:CreateTab("Main", "compass")
local Section = Tab:CreateSection("Main Features")

-- Auto Drill Toggle
local DrillToggle = Tab:CreateToggle({
   Name = "Auto Drill(Hold Drill)",
   CurrentValue = false,
   Flag = "AutoDrill",
   Callback = function(bool)
        settings.drill = bool
        if settings.drill then
            task.spawn(
                function()
                    while settings.drill do
                        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild(
                            "Services"
                        ):WaitForChild("OreService"):WaitForChild("RE"):WaitForChild("RequestRandomOre"):FireServer()
                        task.wait(0.01)
                    end
                end
            )
        end
   end,
})

-- Fungsi Sell
local lastPos = nil
local function sell()
    lastPos = plr.Character:FindFirstChild("HumanoidRootPart").CFrame

    plr.Character:FindFirstChild("HumanoidRootPart").CFrame = sellPart.CFrame
    task.wait(0.2)

    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Knit = require(ReplicatedStorage.Packages:WaitForChild("Knit"))
    local OreService = Knit.GetService("OreService")

    OreService.SellAll:Fire()
    task.wait(0.2)

    if lastPos then
        plr.Character:FindFirstChild("HumanoidRootPart").CFrame = lastPos
    end
end

-- Sell All Button
local SellButton = Tab:CreateButton({
   Name = "Sell All",
   Callback = function()
        sell()
   end,
})

-- Auto Sell Toggle
local SellToggle = Tab:CreateToggle({
   Name = "Auto Sell All",
   CurrentValue = false,
   Flag = "AutoSell",
   Callback = function(bool)
        settings.sell = bool
        if settings.sell then
            task.spawn(
                function()
                    while settings.sell do
                        sell()
                        task.wait(10)
                    end
                end
            )
        end
   end,
})

-- Auto Rebirth Toggle
local RebirthToggle = Tab:CreateToggle({
   Name = "Auto Rebirth",
   CurrentValue = false,
   Flag = "AutoRebirth",
   Callback = function(bool)
        settings.rebith = bool
        if settings.rebith then
            task.spawn(
                function()
                    while settings.rebith do
                        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("RebirthService"):WaitForChild("RE"):WaitForChild("RebirthRequest"):FireServer()
                        task.wait(1)
                    end
                end
            )
        end
   end,
})

-- Auto Collect Drills Toggle
local CollectDrillsToggle = Tab:CreateToggle({
   Name = "Auto Collect Drills",
   CurrentValue = false,
   Flag = "AutoCollectDrills",
   Callback = function(bool)
        settings.collect = bool
        if settings.collect then
            task.spawn(
                function()
                    while settings.collect do
                        if plot and plot:FindFirstChild("Drills") then
                            for _, drill in pairs(plot.Drills:GetChildren()) do
                                if not settings.collect then
                                    break
                                end
                                game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild(
                                    "Services"
                                ):WaitForChild("PlotService"):WaitForChild("RE"):WaitForChild("CollectDrill"):FireServer(
                                    drill
                                )
                            end
                        end
                        task.wait(1)
                    end
                end
            )
        end
   end,
})

-- Auto Collect Storage Toggle
local CollectStorageToggle = Tab:CreateToggle({
   Name = "Auto Collect Storage",
   CurrentValue = false,
   Flag = "AutoCollectStorage",
   Callback = function(bool)
        settings.storage = bool
        if settings.storage then
            task.spawn(
                function()
                    while settings.storage do
                        if plot and plot:FindFirstChild("Storage") then
                            for _, storage in pairs(plot.Storage:GetChildren()) do
                                if not settings.storage then
                                    break
                                end
                                game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild(
                                    "Services"
                                ):WaitForChild("PlotService"):WaitForChild("RE"):WaitForChild("CollectDrill"):FireServer(
                                    storage
                                )
                            end
                        end
                        task.wait(1)
                    end
                end
            )
        end
   end,
})

local Section = Tab:CreateSection("Utility Features")
-- Shop UI Toggles
local DrillsShopToggle = Tab:CreateToggle({
   Name = "Drills Shop UI",
   CurrentValue = false,
   Flag = "DrillsShopUI",
   Callback = function(bool)
        drillsUi.Visible = bool
   end,
})

local HanddrillsShopToggle = Tab:CreateToggle({
   Name = "Handdrills Shop UI",
   CurrentValue = false,
   Flag = "HanddrillsShopUI",
   Callback = function(bool)
        handdrillsUi.Visible = bool
   end,
})

-- Anti AFK Button
local AntiAFKButton = Tab:CreateButton({
   Name = "Anti AFK",
   Callback = function()
        local bb = game:GetService("VirtualUser")
        plr.Idled:Connect(
            function()
                bb:CaptureController()
                bb:ClickButton2(Vector2.new())
            end
        )
   end,
})

-- Label
local Section2 = Tab:CreateSection("Credits")
local Label = Tab:CreateLabel("RayField Library UI, Random Guy")
