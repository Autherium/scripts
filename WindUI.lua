local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

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

local Confirmed = false

WindUI:Popup({
    Title = "Autherium | ",
    Icon = "info",
    Content = "Big Thank to " .. gradient("WindUI", Color3.fromHex("#00FF87"), Color3.fromHex("#60EFFF")) .. " Lib",
    Buttons = {
        {
            Title = "Cancel",
            -- Icon = "x",
            Callback = function() end,
            Variant = "Secondary", -- Primary, Secondary, Tertiary
        },
        {
            Title = "Continue",
            Icon = "arrow-right",
            Callback = function() Confirmed = true end,
            Variant = "Primary", -- Primary, Secondary, Tertiary
        }
    }
})


repeat wait() until Confirmed

-- Global Variables

local MarketplaceService = game:GetService("MarketplaceService")
local success, info = pcall(function()
    return MarketplaceService:GetProductInfo(game.PlaceId)
end)
local gameName = success and info.Name or "Unknown Game"

-- Title Games

local Window = WindUI:CreateWindow({
    Title = gameName,
    Icon = "door-open",
    Author = "Autherium",
    Folder = "Auth",
    Size = UDim2.fromOffset(580, 460),
    Transparent = true,
    Theme = "Dark",
    User = {
        Enabled = true, -- <- or false
        Callback = function() print("clicked") end, -- <- optional
        Anonymous = false -- <- or true
    },
    SideBarWidth = 200,
    --Background = "rbxassetid://13511292247", -- rbxassetid only
    HasOutline = true,
    -- remove it below if you don't want to use the key system in your script.
    KeySystem = { -- <- keysystem enabled
        Key = { "UDG", "Autherium", "CahyaXyZp" },
        Note = "Key System: \n\nThe Key is 'UDG' or 'Autherium",
        -- Thumbnail = {
        --     Image = "rbxassetid://18220445082", -- rbxassetid only
        --     Title = "Thumbnail"
        -- },
        URL = "https://discord.gg/SbDtadDG5Y", -- remove this if the key is not obtained from the link.
        SaveKey = true, -- optional
    },
})


--Window:SetBackgroundImage("rbxassetid://13511292247")


Window:EditOpenButton({
    Title = "Autherium",
    Icon = "monitor",
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 2,
    Color = ColorSequence.new( -- gradient
        Color3.fromHex("FF0F7B"), 
        Color3.fromHex("F89B29")
    ),
    --Enabled = false,
    Draggable = false,
})

-- Create Tabs

local Tabs = {
    MainTab = Window:Tab({ Title = "Main Tab", Icon = "house" }),
    OtherTab = Window:Tab({ Title = "Shop Tab", Icon = "shopping-cart" }),
    UtilityTab = Window:Tab({ Title = "Utility Tab", Icon = "hammer" }),
    divider1 = Window:Divider(),
    --
    ConfigTab = Window:Tab({ 
        Title = "Configuration Tab", 
        Icon = "settings", 
        ShowTabTitle = true
    }),

    CreateThemeTab = Window:Tab({
        Title = "Theme Tab",
        Icon = "palette" }),
    be = Window:Divider(),
}

Window:SelectTab(1)

-- Main Tab Features
    -- Variables
        -- Button, Toggle, Paragraph, Code, Input, Colorpicker, Slider, Keybind, Dropdown

Tabs.MainTab:Toggle({
    Title = "Example Toggle",
    Desc = "Lorem ipsum dolor sit amet",
    Value = false,
    Callback = function()
        -- Function Here
    end
})

 Tabs.MainTab:Button({
     Title = "Button With Notify",
     Desc = "Lorem ipsum dolor sit amet",
     Callback = function()
         WindUI:Notify({
            Title = "Example Notify",
            Content = "Example Content",
            Icon = "droplet-off",
            Duration = 5,
         })
         -- Function Here
     end
 })
 
 Tabs.MainTab:Toggle({
    Title = "Toggle With Notify Background Image",
    Desc = "Lorem ipsum dolor sit amet",
    Value = false,
    Callback = function()
        WindUI:Notify({
            Title = "Notification Example 3",
            Content = "with BackgroundImage",
            Icon = "image",
            Duration = 5,
            Background = "rbxassetid://13511292247"
        })
        -- Function Here
    end
})

Tabs.MainTab:Toggle({
    Title = "Example Toggle",
    Desc = "Lorem ipsum dolor sit amet",
    Value = false,
    Callback = function()
        -- Function Here
    end
})

Tabs.MainTab:Slider({
    Title = "Example Slider",
    Value = {
        Min = 1,
        Max = 100,
        Default = 75,
    },
    Callback = function()
        -- Function Here
    end
})

Tabs.MainTab:Toggle({
    Title = "Example Toggle",
    Desc = "Lorem ipsum dolor sit amet",
    Value = false,
    Callback = function()
        -- Function Here
    end
})

-- Other Tab Features
Tabs.OtherTab:Button({
    Title = "Example Button",
    Desc = "Lorem ipsum dolor sit amet",
    Callback = function()
        -- Function Here
    end
})

Tabs.OtherTab:Button({
    Title = "Example Button",
    Desc = "Lorem ipsum dolor sit amet",
    Callback = function()
        -- Function Here
    end
})

-- Configuration (Optional)
local HttpService = game:GetService("HttpService")

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

Tabs.ConfigTab:Section({ Title = "Configuration" })

local themeValues = {}
for name, _ in pairs(WindUI:GetThemes()) do
    table.insert(themeValues, name)
end

local themeDropdown = Tabs.CreateThemeTab:Dropdown({
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

local ToggleTransparency = Tabs.ConfigTab:Toggle({
    Title = "Toggle Window Transparency",
    Callback = function(e)
        Window:ToggleTransparency(e)
    end,
    Value = WindUI:GetTransparency()
})

Tabs.ConfigTab:Section({ Title = "Save" })

local fileNameInput = ""
Tabs.ConfigTab:Input({
    Title = "Write File Name",
    PlaceholderText = "Enter file name",
    Callback = function(text)
        fileNameInput = text
    end
})

Tabs.ConfigTab:Button({
    Title = "Save File",
    Callback = function()
        if fileNameInput ~= "" then
            SaveFile(fileNameInput, { Transparent = WindUI:GetTransparency(), Theme = WindUI:GetCurrentTheme() })
        end
    end
})

Tabs.ConfigTab:Section({ Title = "Load" })

local filesDropdown
local files = ListFiles()

filesDropdown = Tabs.ConfigTab:Dropdown({
    Title = "Select File",
    Multi = false,
    AllowNone = true,
    Values = files,
    Callback = function(selectedFile)
        fileNameInput = selectedFile
    end
})

Tabs.ConfigTab:Button({
    Title = "Load File",
    Callback = function()
        if fileNameInput ~= "" then
            local data = LoadFile(fileNameInput)
            if data then
                WindUI:Notify({
                    Title = "File Loaded",
                    Content = "Loaded data: " .. HttpService:JSONEncode(data),
                    Duration = 5,
                })
                if data.Transparent then 
                    Window:ToggleTransparency(data.Transparent)
                    ToggleTransparency:SetValue(data.Transparent)
                end
                if data.Theme then WindUI:SetTheme(data.Theme) end
            end
        end
    end
})

Tabs.ConfigTab:Button({
    Title = "Overwrite File",
    Callback = function()
        if fileNameInput ~= "" then
            SaveFile(fileNameInput, { Transparent = WindUI:GetTransparency(), Theme = WindUI:GetCurrentTheme() })
        end
    end
})

Tabs.ConfigTab:Button({
    Title = "Refresh List",
    Callback = function()
        filesDropdown:Refresh(ListFiles())
    end
})

local currentThemeName = WindUI:GetCurrentTheme()
local themes = WindUI:GetThemes()

local ThemeAccent = themes[currentThemeName].Accent
local ThemeOutline = themes[currentThemeName].Outline
local ThemeText = themes[currentThemeName].Text
local ThemePlaceholderText = themes[currentThemeName].Placeholder

function updateTheme()
    WindUI:AddTheme({
        Name = currentThemeName,
        Accent = ThemeAccent,
        Outline = ThemeOutline,
        Text = ThemeText,
        Placeholder = ThemePlaceholderText
    })
    WindUI:SetTheme(currentThemeName)
end

local CreateInput = Tabs.CreateThemeTab:Input({
    Title = "Theme Name",
    Value = currentThemeName,
    Callback = function(name)
        currentThemeName = name
    end
})

Tabs.CreateThemeTab:Colorpicker({
    Title = "Background Color",
    Default = Color3.fromHex(ThemeAccent),
    Callback = function(color)
        ThemeAccent = color:ToHex()
    end
})

Tabs.CreateThemeTab:Colorpicker({
    Title = "Outline Color",
    Default = Color3.fromHex(ThemeOutline),
    Callback = function(color)
        ThemeOutline = color:ToHex()
    end
})

Tabs.CreateThemeTab:Colorpicker({
    Title = "Text Color",
    Default = Color3.fromHex(ThemeText),
    Callback = function(color)
        ThemeText = color:ToHex()
    end
})

Tabs.CreateThemeTab:Colorpicker({
    Title = "Placeholder Text Color",
    Default = Color3.fromHex(ThemePlaceholderText),
    Callback = function(color)
        ThemePlaceholderText = color:ToHex()
    end
})

Tabs.CreateThemeTab:Button({
    Title = "Update Theme",
    Callback = function()
        updateTheme()
    end
})

local InviteCode = "SbDtadDG5Y"
local DiscordAPI = "https://discord.com/api/v10/invites/"..InviteCode.."?with_counts=true&with_expiration=true"

local Response = game:GetService("HttpService"):JSONDecode(WindUI.Creator.Request({
    Url = DiscordAPI,
    Method = "GET",
    Headers = {
        ["User-Agent"] = "RobloxBot/1.0",
        ["Accept"] = "application/json"
    }
}).Body)

if Response and Response.guild then
    local DiscordInfo = Tabs.UtilityTab:Paragraph({
        Title = Response.guild.name,
        Desc = 
            ' <font color="#52525b">•</font> Member Count : ' .. tostring(Response.approximate_member_count) .. 
            '\n <font color="#16a34a">•</font> Online Count : ' .. tostring(Response.approximate_presence_count)
        ,
        Image = "https://cdn.discordapp.com/icons/" .. Response.guild.id .. "/" .. Response.guild.icon .. ".png?size=1024",
        ImageSize = 42,
    })

    Tabs.UtilityTab:Button({
        Title = "Refresh",
        Image = "refresh-ccw",
        Callback = function()
            local UpdatedResponse = game:GetService("HttpService"):JSONDecode(WindUI.Creator.Request({
                Url = DiscordAPI,
                Method = "GET",
            }).Body)
            
            if UpdatedResponse and UpdatedResponse and UpdatedResponse.guild then
                DiscordInfo:SetDesc(
                    ' <font color="#52525b">•</font> Member Count : ' .. tostring(UpdatedResponse.approximate_member_count) .. 
                    '\n <font color="#16a34a">•</font> Online Count : ' .. tostring(UpdatedResponse.approximate_presence_count)
                )
            end
        end
    })
else
    Tabs.UtilityTab:Paragraph({
        Title = "Error when receiving information about the Discord server",
        Desc = game:GetService("HttpService"):JSONEncode(Response),
        Image = "triangle-alert",
        ImageSize = 26,
        Color = "Red",
    })
end



local function parseJSON(luau_table, indent, level, visited)
    indent = indent or 2
    level = level or 0
    visited = visited or {}
    
    local currentIndent = string.rep(" ", level * indent)
    local nextIndent = string.rep(" ", (level + 1) * indent)
    
    if luau_table == nil then
        return "null"
    end
    
    local dataType = type(luau_table)
    
    if dataType == "table" then
        if visited[luau_table] then
            return "\"[Circular Reference]\""
        end
        
        visited[luau_table] = true
        
        local isArray = true
        local maxIndex = 0
        
        for k, _ in pairs(luau_table) do
            if type(k) == "number" and k > maxIndex then
                maxIndex = k
            end
            if type(k) ~= "number" or k <= 0 or math.floor(k) ~= k then
                isArray = false
                break
            end
        end
        
        local count = 0
        for _ in pairs(luau_table) do
            count = count + 1
        end
        if count ~= maxIndex and isArray then
            isArray = false
        end
        
        if count == 0 then
            return "{}"
        end
        
        if isArray then
            if count == 0 then
                return "[]"
            end
            
            local result = "[\n"
            
            for i = 1, maxIndex do
                result = result .. nextIndent .. parseJSON(luau_table[i], indent, level + 1, visited)
                if i < maxIndex then
                    result = result .. ","
                end
                result = result .. "\n"
            end
            
            result = result .. currentIndent .. "]"
            return result
        else
            local result = "{\n"
            local first = true
            
            local keys = {}
            for k in pairs(luau_table) do
                table.insert(keys, k)
            end
            table.sort(keys, function(a, b)
                if type(a) == type(b) then
                    return tostring(a) < tostring(b)
                else
                    return type(a) < type(b)
                end
            end)
            
            for _, k in ipairs(keys) do
                local v = luau_table[k]
                if not first then
                    result = result .. ",\n"
                else
                    first = false
                end
                
                if type(k) == "string" then
                    result = result .. nextIndent .. "\"" .. k .. "\": "
                else
                    result = result .. nextIndent .. "\"" .. tostring(k) .. "\": "
                end
                
                result = result .. parseJSON(v, indent, level + 1, visited)
            end
            
            result = result .. "\n" .. currentIndent .. "}"
            return result
        end
    elseif dataType == "string" then
        local escaped = luau_table:gsub("\\", "\\\\")
        escaped = escaped:gsub("\"", "\\\"")
        escaped = escaped:gsub("\n", "\\n")
        escaped = escaped:gsub("\r", "\\r")
        escaped = escaped:gsub("\t", "\\t")
        
        return "\"" .. escaped .. "\""
    elseif dataType == "number" then
        return tostring(luau_table)
    elseif dataType == "boolean" then
        return luau_table and "true" or "false"
    elseif dataType == "function" then
        return "\"function\""
    else
        return "\"" .. dataType .. "\""
    end
end

local function tableToClipboard(luau_table, indent)
    indent = indent or 4
    local jsonString = parseJSON(luau_table, indent)
    setclipboard(jsonString)
    return jsonString
end


Tabs.ConfigTab:Section({
    Title = "Get Autherium JSON"
})

Tabs.ConfigTab:Button({
    Title = "Get Autherium JSON",
    Callback = function()
        tableToClipboard(WindUI)
    end
})