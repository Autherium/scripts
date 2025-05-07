local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

-- Helper function for gradient text
function gradient(text, startColor, endColor)
    local result = ""
    local length = #text

    for i = 1, length do
        local t = (i - 1) / math.max(length - 1, 1)
        local r = math.floor((startColor.R + (endColor.R - startColor.R) * t) * 255)
        local g = math.floor((startColor.G + (endColor.G - startColor.G) * t) * 255)
        local b = math.floor((startColor.B + (endColor.B - startColor.B) * t) * 255)

        local char = text:sub(i, i)
        result = result .. "<font color=\"rgb(" .. r ..", " .. g .. ", " .. b .. ")\">" .. char .. "</font>"
    end

    return result
end

-- Initialize UI confirmation
local Confirmed = false

WindUI:Popup({
    Title = "Autherium | Untitled Drill Game",
    Icon = "info",
    Content = "Free Keyless Script | " .. gradient("Autherium", Color3.fromHex("#00FF87"), Color3.fromHex("#60EFFF")) .. " Lib",
    Buttons = {
        {
            Title = "Cancel",
            Callback = function() end,
            Variant = "Secondary",
        },
        {
            Title = "Continue",
            Icon = "arrow-right",
            Callback = function() Confirmed = true end,
            Variant = "Primary",
        }
    }
})

repeat wait() until Confirmed

-- Main window setup
local Window = WindUI:CreateWindow({
    Title = "Untitled Drill Game",
    Icon = "pickaxe",
    Author = "Autherium",
    Folder = "Auth",
    Size = UDim2.fromOffset(580, 460),
    Transparent = true,
    Theme = "Dark",
    User = {
        Enabled = true,
        Callback = function() print("clicked") end,
        Anonymous = true
    },
    SideBarWidth = 200,
    HasOutline = true,
    KeySystem = {
        Key = { "UDG", "Autherium", "CahyaXyZp" },
        Note = "Key System: \n\nThe Key is 'UDG' or 'Autherium'",
        URL = "https://discord.gg/SbDtadDG5Y",
        SaveKey = true,
    },
})

-- Edit Open Button
Window:EditOpenButton({
    Title = "Autherium",
    Icon = "pickaxe",
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 2,
    Color = ColorSequence.new(
        Color3.fromHex("FF0F7B"), 
        Color3.fromHex("F89B29")
    ),
    Draggable = true,
})

-- Get player and game services
local plr = game:GetService("Players").LocalPlayer
local HttpService = game:GetService("HttpService")
local sellPart = workspace:FindFirstChild("Scripted") and workspace:FindFirstChild("Scripted"):FindFirstChild("Sell")
local drillsUi = plr.PlayerGui:FindFirstChild("Menu") and plr.PlayerGui:FindFirstChild("Menu"):FindFirstChild("CanvasGroup").Buy
local handdrillsUi = plr.PlayerGui:FindFirstChild("Menu") and plr.PlayerGui:FindFirstChild("Menu"):FindFirstChild("CanvasGroup").HandDrills
local plot = nil

-- Find player's plot
if plr then
    for _, p in ipairs(workspace.Plots:GetChildren()) do
        if p:FindFirstChild("Owner") and p.Owner.Value == plr then
            plot = p
            break
        end
    end
end

-- Initialize settings
getgenv().settings = {rebirth = false, drill = false, sell = false, collect = false, storage = false}

-- Create tabs
local Tabs = {
    MainTab = Window:Tab({ Title = "Main", Icon = "tool", Desc = "Main game automation features" }),
    UtilityTab = Window:Tab({ Title = "Utility", Icon = "settings", Desc = "Utility features" }),
    ShopTab = Window:Tab({ Title = "Shop", Icon = "shopping-cart", Desc = "Shop UI toggles" }),
    divider1 = Window:Divider(),
    ThemeTab = Window:Tab({ Title = "Theme", Icon = "palette", Desc = "UI theme settings" }),
    ConfigTab = Window:Tab({ Title = "Config", Icon = "save", Desc = "Save and load configurations" }),
}

Window:SelectTab(1)

-- Main Tab Features
Tabs.MainTab:Paragraph({
    Title = "Untitled Drill Game Automation",
    Desc = "Main features to automate gameplay",
    Image = "pickaxe",
    ImageSize = 34,
})

-- Auto Drill Toggle
Tabs.MainTab:Toggle({
    Title = "Auto Drill (Hold Drill)",
    Value = false,
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
    end
})

-- Sell function
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
Tabs.MainTab:Button({
    Title = "Sell All",
    Callback = function()
        sell()
    end,
})

-- Auto Sell Toggle
Tabs.MainTab:Toggle({
    Title = "Auto Sell All",
    Value = false,
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
    end
})

-- Auto Rebirth Toggle
Tabs.MainTab:Toggle({
    Title = "Auto Rebirth",
    Value = false,
    Callback = function(bool)
        settings.rebirth = bool
        if settings.rebirth then
            task.spawn(
                function()
                    while settings.rebirth do
                        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("RebirthService"):WaitForChild("RE"):WaitForChild("RebirthRequest"):FireServer()
                        task.wait(1)
                    end
                end
            )
        end
    end
})

-- Auto Collect Drills Toggle
Tabs.MainTab:Toggle({
    Title = "Auto Collect Drills",
    Value = false,
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
    end
})

-- Auto Collect Storage Toggle
Tabs.MainTab:Toggle({
    Title = "Auto Collect Storage",
    Value = false,
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
    end
})

-- Shop Tab
Tabs.ShopTab:Paragraph({
    Title = "Shop UI Controls",
    Desc = "Toggle visibility of shop interfaces",
    Image = "shopping-bag",
    ImageSize = 34,
})

-- Shop UI Toggles
Tabs.ShopTab:Toggle({
    Title = "Drills Shop UI",
    Value = false,
    Callback = function(bool)
        drillsUi.Visible = bool
    end,
})

Tabs.ShopTab:Toggle({
    Title = "Handdrills Shop UI",
    Value = false,
    Callback = function(bool)
        handdrillsUi.Visible = bool
    end,
})

-- Utility Tab with Anti-AFK
Tabs.UtilityTab:Paragraph({
    Title = "Utility Features",
    Desc = "Additional helpful features",
    Image = "settings",
    ImageSize = 34,
})

-- Anti AFK Button
Tabs.UtilityTab:Button({
    Title = "Enable Anti AFK",
    Callback = function()
        local bb = game:GetService("VirtualUser")
        plr.Idled:Connect(
            function()
                bb:CaptureController()
                bb:ClickButton2(Vector2.new())
            end
        )
        WindUI:Notify({
            Title = "Anti-AFK Enabled",
            Content = "Successfully activated anti-AFK protection",
            Icon = "shield-check",
            Duration = 5,
        })
    end,
})

-- Theme Tab
local themeValues = {}
for name, _ in pairs(WindUI:GetThemes()) do
    table.insert(themeValues, name)
end

Tabs.ThemeTab:Paragraph({
    Title = "Theme Settings",
    Desc = "Customize your UI appearance",
    Image = "palette",
    ImageSize = 34,
})

local themeDropdown = Tabs.ThemeTab:Dropdown({
    Title = "Select Theme",
    Multi = false,
    AllowNone = false,
    Value = nil,
    Values = themeValues,
    Callback = function(theme)
        WindUI:SetTheme(theme)
    end
})
themeDropdown:Select(WindUI:GetCurrentTheme())

local ToggleTransparency = Tabs.ThemeTab:Toggle({
    Title = "Toggle Window Transparency",
    Callback = function(e)
        Window:ToggleTransparency(e)
    end,
    Value = WindUI:GetTransparency()
})

-- Config Tab
Tabs.ConfigTab:Paragraph({
    Title = "Configuration",
    Desc = "Save and load your settings",
    Image = "save",
    ImageSize = 34,
})

local folderPath = "Auth"
makefolder(folderPath)

local function SaveFile(fileName, data)
    local filePath = folderPath .. "/" .. fileName .. ".json"
    local jsonData = HttpService:JSONEncode(data)
    writefile(filePath, jsonData)
end

local function LoadFile(fileName)
    local filePath = folderPath .. "/" .. fileName .. ".json"
    if isfile(filePath) then
        local jsonData = readfile(filePath)
        return HttpService:JSONDecode(jsonData)
    end
end

local function ListFiles()
    local files = {}
    for _, file in ipairs(listfiles(folderPath)) do
        local fileName = file:match("([^/]+)%.json$")
        if fileName then
            table.insert(files, fileName)
        end
    end
    return files
end

local fileNameInput = ""
Tabs.ConfigTab:Input({
    Title = "Configuration Name",
    PlaceholderText = "Enter config name",
    Callback = function(text)
        fileNameInput = text
    end
})

Tabs.ConfigTab:Button({
    Title = "Save Configuration",
    Callback = function()
        if fileNameInput ~= "" then
            local configData = {
                Transparent = WindUI:GetTransparency(),
                Theme = WindUI:GetCurrentTheme(),
                Settings = {
                    drill = settings.drill,
                    sell = settings.sell,
                    rebirth = settings.rebirth,
                    collect = settings.collect,
                    storage = settings.storage
                }
            }
            SaveFile(fileNameInput, configData)
            WindUI:Notify({
                Title = "Configuration Saved",
                Content = "Successfully saved as: " .. fileNameInput,
                Icon = "save",
                Duration = 5,
            })
        else
            WindUI:Notify({
                Title = "Error",
                Content = "Please enter a configuration name",
                Icon = "alert-triangle",
                Duration = 5,
            })
        end
    end
})

local filesDropdown
local files = ListFiles()

filesDropdown = Tabs.ConfigTab:Dropdown({
    Title = "Select Configuration",
    Multi = false,
    AllowNone = true,
    Values = files,
    Callback = function(selectedFile)
        fileNameInput = selectedFile
    end
})

Tabs.ConfigTab:Button({
    Title = "Load Configuration",
    Callback = function()
        if fileNameInput ~= "" then
            local data = LoadFile(fileNameInput)
            if data then
                WindUI:Notify({
                    Title = "Configuration Loaded",
                    Content = "Successfully loaded: " .. fileNameInput,
                    Icon = "check-circle",
                    Duration = 5,
                })
                
                -- Apply theme settings
                if data.Transparent ~= nil then 
                    Window:ToggleTransparency(data.Transparent)
                    ToggleTransparency:SetValue(data.Transparent)
                end
                if data.Theme then WindUI:SetTheme(data.Theme) end
                
                -- Apply feature settings if they exist in the saved config
                if data.Settings then
                    -- Implementation would need to turn on toggles based on saved settings
                end
            end
        else
            WindUI:Notify({
                Title = "Error",
                Content = "Please select a configuration",
                Icon = "alert-triangle",
                Duration = 5,
            })
        end
    end
})

Tabs.ConfigTab:Button({
    Title = "Refresh List",
    Callback = function()
        filesDropdown:Refresh(ListFiles())
    end
})

-- Discord info (optional)
local InviteCode = "SbDtadDG5Y"
local DiscordAPI = "https://discord.com/api/v10/invites/"..InviteCode.."?with_counts=true&with_expiration=true"

local success, Response = pcall(function()
    return HttpService:JSONDecode(WindUI.Creator.Request({
        Url = DiscordAPI,
        Method = "GET",
        Headers = {
            ["User-Agent"] = "RobloxBot/1.0",
            ["Accept"] = "application/json"
        }
    }).Body)
end)

if success and Response and Response.guild then
    local DiscordInfo = Tabs.UtilityTab:Paragraph({
        Title = "Discord: " .. Response.guild.name,
        Desc = 
            ' <font color="#52525b">•</font> Member Count : ' .. tostring(Response.approximate_member_count) .. 
            '\n <font color="#16a34a">•</font> Online Count : ' .. tostring(Response.approximate_presence_count),
        Image = "https://cdn.discordapp.com/icons/" .. Response.guild.id .. "/" .. Response.guild.icon .. ".png?size=1024",
        ImageSize = 42,
    })

    Tabs.UtilityTab:Button({
        Title = "Join Discord",
        Callback = function()
            setclipboard("https://discord.gg/" .. InviteCode)
            WindUI:Notify({
                Title = "Discord Invite",
                Content = "Invite link copied to clipboard!",
                Icon = "clipboard-check",
                Duration = 5,
            })
        end
    })
end

-- Credits
Tabs.UtilityTab:Paragraph({
    Title = "Credits",
    Desc = "Script by Autherium\nUI by WindUI",
    Image = "info",
    ImageSize = 34,
})
