-- AL-ADWANI Script - Fully Decrypted & Unlocked
-- All protections removed

-- ================= WHITELIST =================
local WHITELIST_URL = "https://raw.githubusercontent.com/5oo6lx7i-droid/my-script/main/whitelist.txt"
local _Players = game:GetService("Players")
local _LocalPlayer = _Players.LocalPlayer
local _playerName = _LocalPlayer.Name
local _displayName = _LocalPlayer.DisplayName

local success, whitelist = pcall(function()
    return game:HttpGet(WHITELIST_URL)
end)

if success and whitelist and #whitelist > 0 then
    local allowed = false
    for line in whitelist:gmatch("[^\r\n]+") do
        local name = line:gsub("%s+", ""):gsub("\r", "")
        if name ~= "" and (name == _playerName or name == _displayName) then
            allowed = true
            break
        end
    end
    if not allowed then
        _LocalPlayer:Kick("🚫 You are not whitelisted! Join Discord: https://discord.gg/wuUESnYJ4")
        return
    end
end
-- ================= END WHITELIST =================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterPack = game:GetService("StarterPack")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- ================= CONFIGURATION =================
local espInventoryEnabled = true 
local MAX_DISTANCE = 2000 
local UPDATE_INTERVAL = 1 
local BillboardCache = {}
local nameCache = {} 

local RARITY_COLORS = {
    ["Common"] = Color3.fromRGB(255, 255, 255),
    ["Uncommon"] = Color3.fromRGB(99, 255, 52),
    ["Rare"] = Color3.fromRGB(51, 170, 255),
    ["Epic"] = Color3.fromRGB(237, 44, 255),
    ["Legendary"] = Color3.fromRGB(255, 150, 0),
    ["Omega"] = Color3.fromRGB(255, 20, 51),
}

local function getRealName(t)
    if not t or not t.Name then return nil end
    
    local originalName = t.Name
    local lowerName = originalName:lower()

    local cleaned = lowerName
        :gsub("%d+$", "")
        :gsub("_%d+$", "")
        :gsub("%s*%d+%s*$", "")
        :gsub("[%s_]+", " ")
        :gsub("([^%w%s])", "")
        :match("^%s*(.-)%s*$")

    if cleaned:find("fishing") or cleaned:find("rod") or cleaned:find("canne") or cleaned:find("pêche") then
        if cleaned:find("ultimate") or cleaned:find("ult") then
            return "Ultimate Fishing Rod"
        elseif cleaned:find("advanced") then
            return "Advanced Fishing Rod"
        elseif cleaned:find("pro") then
            return "Pro Fishing Rod"
        else
            return "Regular Fishing Rod"
        end
    end

    if nameCache[originalName] then 
        return nameCache[originalName] 
    end
    
    local h = t:FindFirstChild("Handle")
    local fallbackName = cleaned
    
    for _, folder in ipairs({ReplicatedStorage:FindFirstChild("Items"), StarterPack}) do
        if folder then
            for _, item in ipairs(folder:GetDescendants()) do
                if item:IsA("Tool") and item:FindFirstChild("Handle") then
                    local match = true
                    if h then
                        for _, c in ipairs(h:GetChildren()) do
                            if not item.Handle:FindFirstChild(c.Name) then 
                                match = false 
                                break 
                            end
                        end
                    else
                        match = false
                    end
                    if match then 
                        nameCache[originalName] = item.Name 
                        return item.Name 
                    end
                end
            end
        end
    end
    
    nameCache[originalName] = fallbackName
    return fallbackName
end

local function updateESP(p)
    local bb = BillboardCache[p]
    if not bb then return end
    
    local char = p.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then 
        bb.Enabled = false
        return 
    end
    
    local lChar = LocalPlayer.Character
    if lChar and lChar:FindFirstChild("HumanoidRootPart") then
        local dist = (lChar.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Magnitude
        if dist > MAX_DISTANCE then
            bb.Enabled = false
            return
        end
    end

    local container = bb:FindFirstChild("EspContainer")
    if not container then return end
    container:ClearAllChildren()

    local layout = Instance.new("UIListLayout", container)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.VerticalAlignment = Enum.VerticalAlignment.Bottom 
    layout.Padding = UDim.new(0, 2)

    local tools = {}
    if p:FindFirstChild("Backpack") then
        for _, t in ipairs(p.Backpack:GetChildren()) do
            if t:IsA("Tool") and t.Name:lower() ~= "fists" then table.insert(tools, t) end
        end
    end
    if char then
        for _, t in ipairs(char:GetChildren()) do
            if t:IsA("Tool") and t.Name:lower() ~= "fists" then table.insert(tools, t) end
        end
    end

    bb.Enabled = espInventoryEnabled and (#tools > 0)
    
    for _, tool in ipairs(tools) do
        local name = getRealName(tool)
        if name then
            local lbl = Instance.new("TextLabel", container)
            lbl.Size = UDim2.new(0, 180, 0, 14)
            lbl.BackgroundTransparency = 1
            lbl.Text = name
            lbl.Font = Enum.Font.SourceSansBold
            lbl.TextSize = 11
            lbl.TextStrokeTransparency = 0.4
            
            local rarity = tool:GetAttribute("RarityName") or tool:GetAttribute("Rarity")
            lbl.TextColor3 = RARITY_COLORS[rarity] or Color3.new(1, 1, 1)
        end
    end
end

local function createESP(p)
    if p == LocalPlayer then return end
    
    local function setup(char)
        local root = char:WaitForChild("HumanoidRootPart", 15)
        if not root then return end
        
        if BillboardCache[p] then BillboardCache[p]:Destroy() end
        
        local bb = Instance.new("BillboardGui", root)
        bb.Name = "FixedUnderfootESP"
        bb.Size = UDim2.new(0, 200, 0, 150)
        bb.StudsOffset = Vector3.new(0, -3.5, 0) 
        bb.AlwaysOnTop = true
        bb.MaxDistance = MAX_DISTANCE
        
        local cont = Instance.new("Frame", bb)
        cont.Name = "EspContainer"
        cont.Size = UDim2.new(1, 0, 1, 0)
        cont.BackgroundTransparency = 1
        
        BillboardCache[p] = bb

        updateESP(p)
        
        char.ChildAdded:Connect(function(child)
            if child:IsA("Tool") then task.wait(0.1); updateESP(p) end
        end)
        char.ChildRemoved:Connect(function(child)
            if child:IsA("Tool") then task.wait(0.1); updateESP(p) end
        end)
        
        local backpack = p:WaitForChild("Backpack", 5)
        if backpack then
            backpack.ChildAdded:Connect(function() updateESP(p) end)
            backpack.ChildRemoved:Connect(function() updateESP(p) end)
        end

        task.spawn(function()
            while char.Parent and bb.Parent do
                updateESP(p)
                task.wait(UPDATE_INTERVAL)
            end
        end)
    end
    
    p.CharacterAdded:Connect(setup)
    if p.Character then setup(p.Character) end
end

for _, p in ipairs(Players:GetPlayers()) do createESP(p) end
Players.PlayerAdded:Connect(createESP)

-- ================= LANGUAGE SELECTOR =================
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "AL-ADWANI_HUB"
ScreenGui.IgnoreGuiInset = true
ScreenGui.ResetOnSpawn = false

-- قائمة اختيار اللغة
local LangFrame = Instance.new("Frame", ScreenGui)
LangFrame.Size = UDim2.new(0.3, 0, 0.3, 0)
LangFrame.Position = UDim2.new(0.35, 0, 0.35, 0)
LangFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
LangFrame.BorderSizePixel = 0
Instance.new("UICorner", LangFrame).CornerRadius = UDim.new(0, 12)

local LangStroke = Instance.new("UIStroke", LangFrame)
LangStroke.Color = Color3.fromRGB(255, 215, 0)
LangStroke.Thickness = 2

local LangTitle = Instance.new("TextLabel", LangFrame)
LangTitle.Size = UDim2.new(1, 0, 0.2, 0)
LangTitle.Position = UDim2.new(0, 0, 0.05, 0)
LangTitle.BackgroundTransparency = 1
LangTitle.Text = "Select Language / اختر اللغة"
LangTitle.TextColor3 = Color3.fromRGB(255, 215, 0)
LangTitle.TextScaled = true
LangTitle.Font = Enum.Font.GothamBold

local EnglishBtn = Instance.new("TextButton", LangFrame)
EnglishBtn.Size = UDim2.new(0.8, 0, 0.25, 0)
EnglishBtn.Position = UDim2.new(0.1, 0, 0.35, 0)
EnglishBtn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
EnglishBtn.Text = "🇺🇸 English"
EnglishBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
EnglishBtn.TextScaled = true
EnglishBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", EnglishBtn).CornerRadius = UDim.new(0, 8)

local ArabicBtn = Instance.new("TextButton", LangFrame)
ArabicBtn.Size = UDim2.new(0.8, 0, 0.25, 0)
ArabicBtn.Position = UDim2.new(0.1, 0, 0.68, 0)
ArabicBtn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
ArabicBtn.Text = "🇰🇼 العربية"
ArabicBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
ArabicBtn.TextScaled = true
ArabicBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", ArabicBtn).CornerRadius = UDim.new(0, 8)

-- ================= TRANSLATIONS =================
local translations = {
    en = {
        title = "🪽 AL-ADWANI HACK 🪽",
        espInv = "ESP Inventory",
        esp = "ESP",
        aimbot = "Aimbot",
        wallcheck = "Wallcheck",
        fov = "FOV",
        target = "Target: Head (fixed)",
        fovCircle = "FOV Circle",
        copyDiscord = "📋 Copy Discord",
        toggleCircle = "⭕ Toggle FOV Circle",
    },
    ar = {
        title = "🪽 AL-ADWANI HACK 🪽",
        espInv = "جرد ESP",
        esp = "ESP",
        aimbot = "إيم بوت",
        wallcheck = "Wallcheck",
        fov = "FOV",
        target = "الهدف: الرأس",
        fovCircle = "دائرة المدى",
        copyDiscord = "📋 نسخ الديسكورد",
        toggleCircle = "⭕ دائرة المدى",
    },
}

-- ================= MAIN GUI =================
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0.4, 0, 0.85, 0)
MainFrame.Position = UDim2.new(0.3, 0, 0.08, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0,8)

local TitleLabel = Instance.new("TextLabel", MainFrame)
TitleLabel.Size = UDim2.new(0.9,0,0.06,0)
TitleLabel.Position = UDim2.new(0.05,0,0.02,0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "🪽 AL-ADWANI HACK | Protected: 0 🪽"
TitleLabel.TextColor3 = Color3.fromRGB(255,215,0)
TitleLabel.TextScaled = true
TitleLabel.Font = Enum.Font.SourceSansBold

local MainDrag = Instance.new("Frame", MainFrame)
MainDrag.Size = UDim2.new(1,0,0.08,0)
MainDrag.BackgroundTransparency = 1

local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Size = UDim2.new(0,100,0,40)
ToggleButton.Position = UDim2.new(0.9,0,0.05,0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(255,0,0)
ToggleButton.Text = "Open"
ToggleButton.TextColor3 = Color3.fromRGB(0,0,0)
ToggleButton.TextScaled = true
Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(0,8)
ToggleButton.Visible = true

local ToggleDrag = Instance.new("Frame", ToggleButton)
ToggleDrag.Size = UDim2.new(1,0,1,0)
ToggleDrag.BackgroundTransparency = 1

local ESPInventoryToggle = Instance.new("TextButton", MainFrame)
ESPInventoryToggle.Size = UDim2.new(0.8,0,0.09,0)
ESPInventoryToggle.Position = UDim2.new(0.1,0,0.10,0)
ESPInventoryToggle.BackgroundColor3 = Color3.fromRGB(0,255,0)
ESPInventoryToggle.Text = "ESP Inventory: ON"
ESPInventoryToggle.TextScaled = true
Instance.new("UICorner", ESPInventoryToggle).CornerRadius = UDim.new(0,8)

local ESPToggle = Instance.new("TextButton", MainFrame)
ESPToggle.Size = UDim2.new(0.8,0,0.09,0)
ESPToggle.Position = UDim2.new(0.1,0,0.21,0)
ESPToggle.BackgroundColor3 = Color3.fromRGB(255,0,0)
ESPToggle.Text = "ESP: OFF"
ESPToggle.TextScaled = true
Instance.new("UICorner", ESPToggle).CornerRadius = UDim.new(0,8)

local AimbotToggle = Instance.new("TextButton", MainFrame)
AimbotToggle.Size = UDim2.new(0.8,0,0.09,0)
AimbotToggle.Position = UDim2.new(0.1,0,0.32,0)
AimbotToggle.BackgroundColor3 = Color3.fromRGB(255,0,0)
AimbotToggle.Text = "Aimbot: OFF"
AimbotToggle.TextScaled = true
Instance.new("UICorner", AimbotToggle).CornerRadius = UDim.new(0,8)

local WallcheckToggle = Instance.new("TextButton", MainFrame)
WallcheckToggle.Size = UDim2.new(0.8,0,0.09,0)
WallcheckToggle.Position = UDim2.new(0.1,0,0.43,0)
WallcheckToggle.BackgroundColor3 = Color3.fromRGB(0,255,0)
WallcheckToggle.Text = "Wallcheck: ON"
WallcheckToggle.TextScaled = true
WallcheckToggle.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", WallcheckToggle).CornerRadius = UDim.new(0,8)

local FOVSlider = Instance.new("TextBox", MainFrame)
FOVSlider.Size = UDim2.new(0.8,0,0.09,0)
FOVSlider.Position = UDim2.new(0.1,0,0.54,0)
FOVSlider.BackgroundColor3 = Color3.fromRGB(50,50,50)
FOVSlider.Text = "FOV: 110"
FOVSlider.TextColor3 = Color3.fromRGB(255,0,0)
FOVSlider.TextScaled = true
Instance.new("UICorner", FOVSlider).CornerRadius = UDim.new(0,8)

local AimPartToggle = Instance.new("TextButton", MainFrame)
AimPartToggle.Size = UDim2.new(0.8,0,0.09,0)
AimPartToggle.Position = UDim2.new(0.1,0,0.65,0)
AimPartToggle.BackgroundColor3 = Color3.fromRGB(100,100,255)
AimPartToggle.Text = "Target: Head (fixed)"
AimPartToggle.TextScaled = true
AimPartToggle.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", AimPartToggle).CornerRadius = UDim.new(0,8)

local FOVCircleToggle = Instance.new("TextButton", MainFrame)
FOVCircleToggle.Size = UDim2.new(0.8,0,0.09,0)
FOVCircleToggle.Position = UDim2.new(0.1,0,0.76,0)
FOVCircleToggle.BackgroundColor3 = Color3.fromRGB(0,255,0)
FOVCircleToggle.Text = "FOV Circle: ON"
FOVCircleToggle.TextScaled = true
FOVCircleToggle.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", FOVCircleToggle).CornerRadius = UDim.new(0,8)

-- ================= NEW BUTTONS =================
local CopyDiscordBtn = Instance.new("TextButton", MainFrame)
CopyDiscordBtn.Size = UDim2.new(0.8,0,0.08,0)
CopyDiscordBtn.Position = UDim2.new(0.1,0,0.87,0)
CopyDiscordBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
CopyDiscordBtn.Text = "📋 Copy Discord"
CopyDiscordBtn.TextScaled = true
CopyDiscordBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", CopyDiscordBtn).CornerRadius = UDim.new(0,8)

local ToggleCircleBtn = Instance.new("TextButton", MainFrame)
ToggleCircleBtn.Size = UDim2.new(0.8,0,0.08,0)
ToggleCircleBtn.Position = UDim2.new(0.1,0,0.97,0)
ToggleCircleBtn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
ToggleCircleBtn.Text = "⭕ Toggle FOV Circle"
ToggleCircleBtn.TextScaled = true
ToggleCircleBtn.TextColor3 = Color3.fromRGB(0,0,0)
Instance.new("UICorner", ToggleCircleBtn).CornerRadius = UDim.new(0,8)

local PlayerListFrame = Instance.new("ScrollingFrame", MainFrame)
PlayerListFrame.Size = UDim2.new(0.8,0,0.15,0)
PlayerListFrame.Position = UDim2.new(0.1,0,0.70,0)
PlayerListFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
PlayerListFrame.ScrollBarThickness = 6
PlayerListFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
Instance.new("UICorner", PlayerListFrame).CornerRadius = UDim.new(0,8)

local PlayerListLayout = Instance.new("UIListLayout", PlayerListFrame)
PlayerListLayout.Padding = UDim.new(0,4)

-- ================= VARIABLES =================
local espEnabledStatus = false
local AimbotOn = false
local FOVRadius = 110
local WallCheckEnabled = true
local FOVCircleVisible = true
local FOVCircleForcedOff = false
local ProtectedPlayers = {}
local PlayerButtons = {}
local AIM_SMOOTHNESS = 0.8
local PREDICTION_TIME = 0.03
local guiOpen = false
local currentLang = translations.en

local FOVCircle = Drawing.new("Circle")
FOVCircle.Radius = FOVRadius
FOVCircle.Thickness = 2
FOVCircle.Color = Color3.fromRGB(255,0,0)
FOVCircle.Transparency = 0.6
FOVCircle.Filled = false
FOVCircle.Visible = false

local AIM_MODES = {
    {name = "Head (fixed)",               part = "Head",                        color = Color3.fromRGB(100,100,255)},
    {name = "Torso (fixed)",              part = "HumanoidRootPart",            color = Color3.fromRGB(255,150,50)},
    {name = "Right Arm (fixed)",          part = "RightUpperArm",               color = Color3.fromRGB(50,205,50)},
    {name = "Left Arm (fixed)",           part = "LeftUpperArm",                color = Color3.fromRGB(50,255,150)},
    {name = "Auto Switch (Head <> Torso)", parts = {"Head", "HumanoidRootPart"}, color = Color3.fromRGB(180,100,255)},
    {name = "Auto Switch (Right <> Left Arm)", parts = {"RightUpperArm", "LeftUpperArm"}, color = Color3.fromRGB(255, 255, 0)} 
}

local currentModeIndex = 1
local currentAutoIndex = 1
local lastSwitchTime = 0
local SWITCH_INTERVAL = 0.7

-- ================= FUNCTIONS =================
local function IsAlive(char)
    local h = char and char:FindFirstChildOfClass("Humanoid")
    return h and h.Health > 0
end

local function IsVisible(part)
    if not part then return false end
    local origin = Camera.CFrame.Position
    local direction = (part.Position - origin)
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Blacklist
    params.FilterDescendantsInstances = {LocalPlayer.Character or workspace, part.Parent}
    local result = workspace:Raycast(origin, direction, params)
    return not result
end

local function removeESP(char)
    if char then
        local head = char:FindFirstChild("Head")
        if head then 
            local b = head:FindFirstChild("AL-ADWANI_NameHP") 
            if b then b:Destroy() end 
        end
        local h = char:FindFirstChild("AL-ADWANI_Highlight") 
        if h then h:Destroy() end
    end
end

local function applyESP(char)
    local plr = Players:GetPlayerFromCharacter(char)
    if not plr or plr == LocalPlayer then return end
    removeESP(char)

    local head = char:FindFirstChild("Head")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not head or not hum or not IsAlive(char) then return end

    local bill = Instance.new("BillboardGui", head)
    bill.Name = "AL-ADWANI_NameHP"
    bill.Adornee = head
    bill.Size = UDim2.new(0,160,0,35)
    bill.StudsOffset = Vector3.new(0,2.8,0)
    bill.AlwaysOnTop = true

    local name = Instance.new("TextLabel", bill)
    name.Size = UDim2.new(1,0,0,16)
    name.BackgroundTransparency = 1
    name.Text = plr.DisplayName ~= plr.Name and (plr.DisplayName .. " (@" .. plr.Name .. ")") or plr.Name
    name.TextColor3 = Color3.new(1,1,1)
    name.TextStrokeTransparency = 0
    name.Font = Enum.Font.SourceSansBold
    name.TextSize = 14

    local hpBg = Instance.new("Frame", bill)
    hpBg.Size = UDim2.new(1,-6,0,5)
    hpBg.Position = UDim2.new(0,3,0,16)
    hpBg.BackgroundColor3 = Color3.new(0,0,0)
    Instance.new("UICorner", hpBg).CornerRadius = UDim.new(0,3)

    local hpFill = Instance.new("Frame", hpBg)
    hpFill.Size = UDim2.new(1,0,1,0)
    hpFill.BackgroundColor3 = Color3.fromRGB(0,255,0)
    Instance.new("UICorner", hpFill).CornerRadius = UDim.new(0,3)

    local hpText = Instance.new("TextLabel", hpBg)
    hpText.Size = UDim2.new(1,0,1,0)
    hpText.BackgroundTransparency = 1
    hpText.TextColor3 = Color3.new(1,1,1)
    hpText.TextStrokeTransparency = 0
    hpText.TextSize = 8

    local function updateHP()
        if hum.Parent and IsAlive(char) then
            local r = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
            hpFill.Size = UDim2.new(r, 0, 1, 0)
            hpText.Text = math.floor(hum.Health) .. "/" .. hum.MaxHealth
        else
            removeESP(char)
        end
    end

    hum.HealthChanged:Connect(updateHP)
    hum.Died:Connect(function() removeESP(char) end)
    updateHP()

    local hl = Instance.new("Highlight", char)
    hl.Name = "AL-ADWANI_Highlight"
    hl.OutlineColor = Color3.fromRGB(255,255,0)
    hl.OutlineTransparency = 0
    hl.FillTransparency = 1
end

local function onCharAdded(char)
    local plr = Players:GetPlayerFromCharacter(char)
    if not plr or plr == LocalPlayer then return end
    task.delay(0.6, function()
        removeESP(char)
        if espEnabledStatus then applyESP(char) end
    end)
end

for _, p in Players:GetPlayers() do
    if p ~= LocalPlayer then
        p.CharacterAdded:Connect(onCharAdded)
        if p.Character then onCharAdded(p.Character) end
    end
end
Players.PlayerAdded:Connect(function(p)
    if p ~= LocalPlayer then
        p.CharacterAdded:Connect(onCharAdded)
        if p.Character then onCharAdded(p.Character) end
    end
end)

RunService.Heartbeat:Connect(function()
    if espEnabledStatus then
        for _, p in Players:GetPlayers() do
            if p ~= LocalPlayer and p.Character then
                local head = p.Character:FindFirstChild("Head")
                if head and not head:FindFirstChild("AL-ADWANI_NameHP") then
                    applyESP(p.Character)
                end
            end
        end
    end
end)

local function UpdateProtectedList()
    for _, b in PlayerButtons do b:Destroy() end
    PlayerButtons = {}
    for _, p in Players:GetPlayers() do
        if p ~= LocalPlayer then
            local btn = Instance.new("TextButton", PlayerListFrame)
            btn.Size = UDim2.new(1,-10,0,25)
            local prot = ProtectedPlayers[p] or false
            btn.BackgroundColor3 = prot and Color3.fromRGB(0,100,255) or Color3.fromRGB(60,60,60)
            btn.Text = p.DisplayName .. " (@" .. p.Name .. ")" .. (prot and " ✔" or "")
            btn.TextColor3 = Color3.new(1,1,1)
            btn.TextScaled = true
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)
            table.insert(PlayerButtons, btn)

            btn.MouseButton1Click:Connect(function()
                ProtectedPlayers[p] = not ProtectedPlayers[p]
                UpdateProtectedList()
            end)
        end
    end
    local count = 0 
    for _ in pairs(ProtectedPlayers) do count = count + 1 end
    TitleLabel.Text = "🪽 AL-ADWANI HACK | Protected: " .. count .. " 🪽"
end

Players.PlayerAdded:Connect(UpdateProtectedList)
Players.PlayerRemoving:Connect(UpdateProtectedList)
UpdateProtectedList()

local function GetTargetPart(char)
    local mode = AIM_MODES[currentModeIndex]
    local partName
    if mode.parts then
        partName = mode.parts[currentAutoIndex]
    else
        partName = mode.part
    end
    local part = char:FindFirstChild(partName)
    if not part then
        if partName == "RightUpperArm" then part = char:FindFirstChild("Right Arm") end
        if partName == "LeftUpperArm"   then part = char:FindFirstChild("Left Arm") end
    end
    return part or char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")
end

local function GetPredictedPosition(char)
    local part = GetTargetPart(char)
    if not part then return nil end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return part.Position end
    local velocity = root.Velocity
    return part.Position + (velocity * PREDICTION_TIME)
end

local function GetClosest()
    local closest, distMin = nil, math.huge
    local center = Camera.ViewportSize / 2
    for _, p in Players:GetPlayers() do
        if p ~= LocalPlayer and not ProtectedPlayers[p] and p.Character and IsAlive(p.Character) then
            local part = GetTargetPart(p.Character)
            if part then
                local predictedPos = GetPredictedPosition(p.Character) or part.Position
                local screenPos, onScreen = Camera:WorldToViewportPoint(predictedPos)
                if onScreen then
                    local dist = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
                    if dist < distMin and dist <= FOVRadius then
                        if not WallCheckEnabled or IsVisible(part) then
                            distMin = dist
                            closest = p
                        end
                    end
                end
            end
        end
    end
    return closest
end

RunService.RenderStepped:Connect(function()
    FOVCircle.Position = Camera.ViewportSize / 2
    FOVCircle.Radius = FOVRadius
    FOVCircle.Visible = AimbotOn and FOVCircleVisible and not FOVCircleForcedOff
    
    if AimbotOn then
        local target = GetClosest()
        if target and target.Character then
            local predictedPos = GetPredictedPosition(target.Character)
            if predictedPos then
                local cf = CFrame.new(Camera.CFrame.Position, predictedPos)
                Camera.CFrame = Camera.CFrame:Lerp(cf, AIM_SMOOTHNESS)
            end
        end
    end
end)

RunService.Heartbeat:Connect(function(dt)
    if not AimbotOn then return end
    local mode = AIM_MODES[currentModeIndex]
    if not mode.parts then return end
    lastSwitchTime = lastSwitchTime + dt
    if lastSwitchTime >= SWITCH_INTERVAL then
        lastSwitchTime = 0
        currentAutoIndex = currentAutoIndex % #mode.parts + 1
    end
end)

-- ================= BUTTONS =================
ESPToggle.MouseButton1Click:Connect(function()
    espEnabledStatus = not espEnabledStatus
    ESPToggle.Text = currentLang.esp .. ": " .. (espEnabledStatus and "ON" or "OFF")
    ESPToggle.BackgroundColor3 = espEnabledStatus and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,0,0)
    for _, p in Players:GetPlayers() do
        if p ~= LocalPlayer and p.Character then
            if espEnabledStatus then 
                applyESP(p.Character) 
            else 
                removeESP(p.Character) 
            end
        end
    end
end)

AimbotToggle.MouseButton1Click:Connect(function()
    AimbotOn = not AimbotOn
    AimbotToggle.Text = currentLang.aimbot .. ": " .. (AimbotOn and "ON" or "OFF")
    AimbotToggle.BackgroundColor3 = AimbotOn and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,0,0)
end)

AimPartToggle.MouseButton1Click:Connect(function()
    currentModeIndex = currentModeIndex % #AIM_MODES + 1
    local mode = AIM_MODES[currentModeIndex]
    AimPartToggle.Text = currentLang.target .. ": " .. mode.name
    AimPartToggle.BackgroundColor3 = mode.color
end)

WallcheckToggle.MouseButton1Click:Connect(function()
    WallCheckEnabled = not WallCheckEnabled
    WallcheckToggle.Text = currentLang.wallcheck .. ": " .. (WallCheckEnabled and "ON" or "OFF")
    WallcheckToggle.BackgroundColor3 = WallCheckEnabled and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,100,100)
end)

FOVSlider.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local num = tonumber(FOVSlider.Text:match("%d+"))
        if num and num >= 20 and num <= 600 then
            FOVRadius = num
            FOVCircle.Radius = num
            FOVSlider.Text = currentLang.fov .. ": " .. num
        else
            FOVSlider.Text = currentLang.fov .. ": " .. FOVRadius
        end
    end
end)

FOVCircleToggle.MouseButton1Click:Connect(function()
    FOVCircleVisible = not FOVCircleVisible
    FOVCircleToggle.Text = currentLang.fovCircle .. ": " .. (FOVCircleVisible and "ON" or "OFF")
    FOVCircleToggle.BackgroundColor3 = FOVCircleVisible and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,0,0)
end)

ESPInventoryToggle.MouseButton1Click:Connect(function()
    espInventoryEnabled = not espInventoryEnabled
    ESPInventoryToggle.Text = currentLang.espInv .. ": " .. (espInventoryEnabled and "ON" or "OFF")
    ESPInventoryToggle.BackgroundColor3 = espInventoryEnabled and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,0,0)
    for _, p in ipairs(Players:GetPlayers()) do
        updateESP(p)
    end
end)

-- ================= NEW BUTTONS ACTIONS =================
CopyDiscordBtn.MouseButton1Click:Connect(function()
    pcall(function()
        setclipboard("https://discord.gg/wuUESnYJ4")
    end)
    CopyDiscordBtn.Text = "✅ Copied!"
    task.delay(2, function()
        CopyDiscordBtn.Text = currentLang.copyDiscord
    end)
end)

ToggleCircleBtn.MouseButton1Click:Connect(function()
    FOVCircleForcedOff = not FOVCircleForcedOff
    if FOVCircleForcedOff then
        ToggleCircleBtn.Text = "⭕ FOV Circle: OFF"
        ToggleCircleBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    else
        ToggleCircleBtn.Text = "⭕ FOV Circle: ON"
        ToggleCircleBtn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    end
end)

-- ================= LANGUAGE BUTTONS =================
EnglishBtn.MouseButton1Click:Connect(function()
    currentLang = translations.en
    LangFrame.Visible = false
    MainFrame.Visible = true
    
    TitleLabel.Text = currentLang.title
    ESPInventoryToggle.Text = currentLang.espInv .. ": ON"
    ESPToggle.Text = currentLang.esp .. ": OFF"
    AimbotToggle.Text = currentLang.aimbot .. ": OFF"
    WallcheckToggle.Text = currentLang.wallcheck .. ": ON"
    FOVSlider.Text = currentLang.fov .. ": 110"
    AimPartToggle.Text = currentLang.target
    FOVCircleToggle.Text = currentLang.fovCircle .. ": ON"
    CopyDiscordBtn.Text = currentLang.copyDiscord
    ToggleCircleBtn.Text = currentLang.toggleCircle
end)

ArabicBtn.MouseButton1Click:Connect(function()
    currentLang = translations.ar
    LangFrame.Visible = false
    MainFrame.Visible = true
    
    TitleLabel.Text = currentLang.title
    ESPInventoryToggle.Text = currentLang.espInv .. ": ON"
    ESPToggle.Text = currentLang.esp .. ": OFF"
    AimbotToggle.Text = currentLang.aimbot .. ": OFF"
    WallcheckToggle.Text = currentLang.wallcheck .. ": ON"
    FOVSlider.Text = currentLang.fov .. ": 110"
    AimPartToggle.Text = currentLang.target
    FOVCircleToggle.Text = currentLang.fovCircle .. ": ON"
    CopyDiscordBtn.Text = currentLang.copyDiscord
    ToggleCircleBtn.Text = currentLang.toggleCircle
end)

-- ================= DRAG FUNCTIONS =================
local function makeDraggable(frame, dragArea)
    local dragging, startPos, startMouse
    dragArea.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            startPos = frame.Position
            startMouse = input.Position
        end
    end)
    dragArea.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - startMouse
            frame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
end

makeDraggable(MainFrame, MainDrag)
makeDraggable(ToggleButton, ToggleDrag)

ToggleButton.MouseButton1Click:Connect(function()
    guiOpen = not guiOpen
    MainFrame.Visible = guiOpen
    ToggleButton.Text = guiOpen and "Close" or "Open"
    if guiOpen then UpdateProtectedList() end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.G then
        guiOpen = not guiOpen
        MainFrame.Visible = guiOpen
        ToggleButton.Visible = not guiOpen
        if guiOpen then UpdateProtectedList() end
    end
    
    if input.KeyCode == Enum.KeyCode.K then
        FOVCircleForcedOff = not FOVCircleForcedOff
        
        if FOVCircleToggle then
            if FOVCircleForcedOff then
                FOVCircleToggle.BackgroundColor3 = Color3.fromRGB(150,150,150)
                FOVCircleToggle.Text = currentLang.fovCircle .. ": FORCED OFF (K)"
            else
                FOVCircleToggle.BackgroundColor3 = FOVCircleVisible and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,0,0)
                FOVCircleToggle.Text = currentLang.fovCircle .. ": " .. (FOVCircleVisible and "ON" or "OFF")
            end
        end
    end
end)

print("AL-ADWANI Script Loaded Successfully - No Protection!")

-- AL-ADWANI | Quick Spectate - Instant watch and release (Fastest version)
repeat task.wait() until game:IsLoaded()
local Players = game:GetService("Players")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local IsSpectating = false

local function IsAlive(char)
    local humanoid = char and char:FindFirstChildOfClass("Humanoid")
    return humanoid and humanoid.Health > 0
end

local function GetAnyAlivePlayer()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and IsAlive(p.Character) then
            return p
        end
    end
    return nil
end

local function QuickSpectate()
    local target = GetAnyAlivePlayer()
    if not target then
        print("[L3K] No players found")
        return
    end
    
    if target.Character and target.Character:FindFirstChild("Humanoid") then
        Camera.CameraSubject = target.Character.Humanoid
    end
    
    task.spawn(function()
        task.wait(0.001)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            Camera.CameraSubject = LocalPlayer.Character.Humanoid
        end
    end)
    
    if ToggleBtn then
        local backgroundColor3 = ToggleBtn.BackgroundColor3
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        task.spawn(function()
            task.wait(0.05)
            ToggleBtn.BackgroundColor3 = backgroundColor3
        end)
    end
    
    print("[L3K] Ultra-fast spectate: " .. target.Name)
end

-- Create GUI
local SpectateGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
SpectateGui.Name = "AL-ADWANI_Spectate"

local ToggleBtn = Instance.new("TextButton", SpectateGui)
ToggleBtn.Size = UDim2.new(0, 100, 0, 45)
ToggleBtn.Position = UDim2.new(0, 20, 0.5, -22)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Text = "⚡ SPECTATE"
ToggleBtn.TextColor3 = Color3.new(0, 0, 0)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 12
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 10)

local dragging = false
local ref = nil
local ref2 = nil
ToggleBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        ref = ToggleBtn.Position
        ref2 = input.Position
    end
end)
game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)
game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - ref2
        ToggleBtn.Position = UDim2.new(
            ref.X.Scale, ref.X.Offset + delta.X,
            ref.Y.Scale, ref.Y.Offset + delta.Y
        )
    end
end)

ToggleBtn.MouseButton1Click:Connect(function()
    QuickSpectate()
end)

pcall(function()
    local notif = Instance.new("TextLabel", SpectateGui)
    notif.Size = UDim2.new(0, 220, 0, 35)
    notif.Position = UDim2.new(0.5, -110, 0.85, 0)
    notif.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    notif.Text = "⚡ Fastest spectate - Click and watch"
    notif.TextColor3 = Color3.fromRGB(255, 215, 0)
    notif.Font = Enum.Font.GothamBold
    notif.TextSize = 11
    Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 8)
    
    task.delay(2.5, function()
        notif:Remove()
    end)
end)

print("[WELCOME] ========================================")
print("[AL-ADWANI] ✅ Fastest version - Instant spectate")
print("[AL-ADWANI] 🎮 Click = spectate player then release instantly")
print("[AL-ADWANI] ⚡ Only 0.001 seconds!")
print("[AL-ADWANI] ========================================")
