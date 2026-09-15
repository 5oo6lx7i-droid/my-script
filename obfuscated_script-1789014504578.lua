local _0x90FC ="https://raw.githubusercontent.com/5oo6lx7i-droid/my-script/main/whitelist.txt"local _0xC6FF = game:GetService("Players")
local _0x17E2 = _0xC6FF.LocalPlayer
local _0x0649 = _0x17E2.Name
local _0xD8D7 = _0x17E2.DisplayName
local _0x8A3B, _0xEF08 = pcall(function()
return game:HttpGet(_0x90FC)
end)
if _0x8A3B and _0xEF08 and #_0xEF08 > 0 then
local _0x0180 = false
for line in _0xEF08:gmatch("[^\r\n]+") do
local _0x240B = line:gsub("%s+",""):gsub("\r","")
if _0x240B ~=""and (_0x240B == _0x0649 or _0x240B == _0xD8D7) then
_0x0180 = true
break
end
end
if not _0x0180 then
_0x17E2:Kick("🚫 You are not whitelisted! Join Discord: https://discord.gg/wuUESnYJ4")
return
end
endlocal _0xCC68 = game:GetService("Players")
local _0xAED1 = game:GetService("ReplicatedStorage")
local _0x8E74 = game:GetService("StarterPack")
local _0x3C84 = game:GetService("RunService")
local _0xCAB3 = game:GetService("UserInputService")
local _0x4FB1 = workspace.CurrentCamera
local _0x900A = _0xCC68.LocalPlayerlocal _0x7840 = true
local _0x091C = 2000
local _0x534E = 1
local _0x9282 = {}
local _0x30F7 = {}
local _0x5EAB = {
["Common"] = Color3.fromRGB(255, 255, 255),
["Uncommon"] = Color3.fromRGB(99, 255, 52),
["Rare"] = Color3.fromRGB(51, 170, 255),
["Epic"] = Color3.fromRGB(237, 44, 255),
["Legendary"] = Color3.fromRGB(255, 150, 0),
["Omega"] = Color3.fromRGB(255, 20, 51),
}
local function _0x28A3(t)
if not t or not t.Name then return nil end
local _0x20FE = t.Name
local _0xB1F9 = _0x20FE:lower()
local _0xEBE9 = _0xB1F9
:gsub("%d+$","")
:gsub("_%d+$","")
:gsub("%s*%d+%s*$","")
:gsub("[%s_]+"," ")
:gsub("([^%w%s])","")
:match("^%s*(.-)%s*$")
if _0xEBE9:find("fishing") or _0xEBE9:find("rod") or _0xEBE9:find("canne") or _0xEBE9:find("pêche") then
if _0xEBE9:find("ultimate") or _0xEBE9:find("ult") then
return"Ultimate Fishing Rod"elseif _0xEBE9:find("advanced") then
return"Advanced Fishing Rod"elseif _0xEBE9:find("pro") then
return"Pro Fishing Rod"else
return"Regular Fishing Rod"end
end
if _0x30F7[_0x20FE] then
return _0x30F7[_0x20FE]
end
local _0x389C = t:FindFirstChild("Handle")
local _0x8ADD = _0xEBE9
for _, folder in ipairs({_0xAED1:FindFirstChild("Items"), _0x8E74}) do
if folder then
for _, item in ipairs(folder:GetDescendants()) do
if item:IsA("Tool") and item:FindFirstChild("Handle") then
local _0x2267 = true
if _0x389C then
for _, c in ipairs(_0x389C:GetChildren()) do
if not item.Handle:FindFirstChild(c.Name) then
_0x2267 = false
break
end
end
else
_0x2267 = false
end
if _0x2267 then
_0x30F7[_0x20FE] = item.Name
return item.Name
end
end
end
end
end
_0x30F7[_0x20FE] = _0x8ADD
return _0x8ADD
end
local function _0x027B(p)
local _0x36DF = _0x9282[p]
if not _0x36DF then return end
local _0xE0B6 = p.Character
if not _0xE0B6 or not _0xE0B6:FindFirstChild("HumanoidRootPart") then
_0x36DF.Enabled = false
return
end
local _0x310B = _0x900A.Character
if _0x310B and _0x310B:FindFirstChild("HumanoidRootPart") then
local _0xA443 = (_0x310B.HumanoidRootPart.Position - _0xE0B6.HumanoidRootPart.Position).Magnitude
if _0xA443 > _0x091C then
_0x36DF.Enabled = false
return
end
end
local _0x244B = _0x36DF:FindFirstChild("EspContainer")
if not _0x244B then return end
_0x244B:ClearAllChildren()
local _0x980C = Instance.new("UIListLayout", _0x244B)
_0x980C.HorizontalAlignment = Enum.HorizontalAlignment.Center
_0x980C.VerticalAlignment = Enum.VerticalAlignment.Bottom
_0x980C.Padding = UDim.new(0, 2)
local _0x0896 = {}
if p:FindFirstChild("Backpack") then
for _, t in ipairs(p.Backpack:GetChildren()) do
if t:IsA("Tool") and t.Name:lower() ~="fists"then table.insert(_0x0896, t) end
end
end
if _0xE0B6 then
for _, t in ipairs(_0xE0B6:GetChildren()) do
if t:IsA("Tool") and t.Name:lower() ~="fists"then table.insert(_0x0896, t) end
end
end
_0x36DF.Enabled = _0x7840 and (#_0x0896 > 0)
for _, tool in ipairs(_0x0896) do
local _0x240B = _0x28A3(tool)
if _0x240B then
local _0x3010 = Instance.new("TextLabel", _0x244B)
_0x3010.Size = UDim2.new(0, 180, 0, 14)
_0x3010.BackgroundTransparency = 1
_0x3010.Text = _0x240B
_0x3010.Font = Enum.Font.SourceSansBold
_0x3010.TextSize = 11
_0x3010.TextStrokeTransparency = 0.4
local _0x54F7 = tool:GetAttribute("RarityName") or tool:GetAttribute("Rarity")
_0x3010.TextColor3 = _0x5EAB[_0x54F7] or Color3.new(1, 1, 1)
end
end
end
local function _0x1607(p)
if p == _0x900A then return end
local function _0xAA39(_0xE0B6)
local _0xC260 = _0xE0B6:WaitForChild("HumanoidRootPart", 15)
if not _0xC260 then return end
if _0x9282[p] then _0x9282[p]:Destroy() end
local _0x36DF = Instance.new("BillboardGui", _0xC260)
_0x36DF.Name ="FixedUnderfootESP"_0x36DF.Size = UDim2.new(0, 200, 0, 150)
_0x36DF.StudsOffset = Vector3.new(0, -3.5, 0)
_0x36DF.AlwaysOnTop = true
_0x36DF.MaxDistance = _0x091C
local _0x0501 = Instance.new("Frame", _0x36DF)
_0x0501.Name ="EspContainer"_0x0501.Size = UDim2.new(1, 0, 1, 0)
_0x0501.BackgroundTransparency = 1
_0x9282[p] = _0x36DF
_0x027B(p)
_0xE0B6.ChildAdded:Connect(function(child)
if child:IsA("Tool") then task.wait(0.1); _0x027B(p) end
end)
_0xE0B6.ChildRemoved:Connect(function(child)
if child:IsA("Tool") then task.wait(0.1); _0x027B(p) end
end)
local _0x7394 = p:WaitForChild("Backpack", 5)
if _0x7394 then
_0x7394.ChildAdded:Connect(function() _0x027B(p) end)
_0x7394.ChildRemoved:Connect(function() _0x027B(p) end)
end
task.spawn(function()
while _0xE0B6.Parent and _0x36DF.Parent do
_0x027B(p)
task.wait(_0x534E)
end
end)
end
p.CharacterAdded:Connect(_0xAA39)
if p.Character then _0xAA39(p.Character) end
end
for _, p in ipairs(_0xCC68:GetPlayers()) do _0x1607(p) end
_0xCC68.PlayerAdded:Connect(_0x1607)local _0x4679 = Instance.new("ScreenGui", game.CoreGui)
_0x4679.Name ="AL-ADWANI_HUB"_0x4679.IgnoreGuiInset = true
_0x4679.ResetOnSpawn = false
local _0xA4C1 = Instance.new("Frame", _0x4679)
_0xA4C1.Size = UDim2.new(0.3, 0, 0.3, 0)
_0xA4C1.Position = UDim2.new(0.35, 0, 0.35, 0)
_0xA4C1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
_0xA4C1.BorderSizePixel = 0
Instance.new("UICorner", _0xA4C1).CornerRadius = UDim.new(0, 12)
local _0xFEEB = Instance.new("UIStroke", _0xA4C1)
_0xFEEB.Color = Color3.fromRGB(255, 215, 0)
_0xFEEB.Thickness = 2
local _0x05F5 = Instance.new("TextLabel", _0xA4C1)
_0x05F5.Size = UDim2.new(1, 0, 0.2, 0)
_0x05F5.Position = UDim2.new(0, 0, 0.05, 0)
_0x05F5.BackgroundTransparency = 1
_0x05F5.Text ="Select Language / اختر اللغة"_0x05F5.TextColor3 = Color3.fromRGB(255, 215, 0)
_0x05F5.TextScaled = true
_0x05F5.Font = Enum.Font.GothamBold
local _0x99F5 = Instance.new("TextButton", _0xA4C1)
_0x99F5.Size = UDim2.new(0.8, 0, 0.25, 0)
_0x99F5.Position = UDim2.new(0.1, 0, 0.35, 0)
_0x99F5.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
_0x99F5.Text ="🇺🇸 English"_0x99F5.TextColor3 = Color3.fromRGB(0, 0, 0)
_0x99F5.TextScaled = true
_0x99F5.Font = Enum.Font.GothamBold
Instance.new("UICorner", _0x99F5).CornerRadius = UDim.new(0, 8)
local _0x7A44 = Instance.new("TextButton", _0xA4C1)
_0x7A44.Size = UDim2.new(0.8, 0, 0.25, 0)
_0x7A44.Position = UDim2.new(0.1, 0, 0.68, 0)
_0x7A44.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
_0x7A44.Text ="🇰🇼 العربية"_0x7A44.TextColor3 = Color3.fromRGB(0, 0, 0)
_0x7A44.TextScaled = true
_0x7A44.Font = Enum.Font.GothamBold
Instance.new("UICorner", _0x7A44).CornerRadius = UDim.new(0, 8)local _0x642A = {
en = {
title ="🪽 AL-ADWANI HACK 🪽",
espInv ="ESP Inventory",
esp ="ESP",
aimbot ="Aimbot",
wallcheck ="Wallcheck",
fov ="FOV",
_0xF4F0 ="Target",
fovCircle ="FOV Circle",
copyDiscord ="📋 Copy Discord",
toggleCircle ="⭕ Toggle FOV Circle",
},
ar = {
title ="🪽 AL-ADWANI HACK 🪽",
espInv ="جرد ESP",
esp ="ESP",
aimbot ="إيم بوت",
wallcheck ="Wallcheck",
fov ="FOV",
_0xF4F0 ="الهدف",
fovCircle ="دائرة المدى",
copyDiscord ="📋 نسخ الديسكورد",
toggleCircle ="⭕ دائرة المدى",
},
}local _0x8FA7 = Instance.new("Frame", _0x4679)
_0x8FA7.Size = UDim2.new(0.35, 0, 0.85, 0)
_0x8FA7.Position = UDim2.new(0.32, 0, 0.08, 0)
_0x8FA7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
_0x8FA7.BorderSizePixel = 0
_0x8FA7.Visible = false
Instance.new("UICorner", _0x8FA7).CornerRadius = UDim.new(0,8)
local _0x7321 = Instance.new("UIStroke", _0x8FA7)
_0x7321.Color = Color3.fromRGB(255, 215, 0)
_0x7321.Thickness = 2
local _0x2661 = Instance.new("TextLabel", _0x8FA7)
_0x2661.Size = UDim2.new(0.9,0,0.06,0)
_0x2661.Position = UDim2.new(0.05,0,0.02,0)
_0x2661.BackgroundTransparency = 1
_0x2661.Text ="🪽 AL-ADWANI HACK | Protected: 0 🪽"_0x2661.TextColor3 = Color3.fromRGB(255,215,0)
_0x2661.TextScaled = true
_0x2661.Font = Enum.Font.SourceSansBold
local _0x02AF = Instance.new("Frame", _0x8FA7)
_0x02AF.Size = UDim2.new(1,0,0.06,0)
_0x02AF.BackgroundTransparency = 1
local _0xB3B1 = Instance.new("TextButton", _0x4679)
_0xB3B1.Size = UDim2.new(0,100,0,40)
_0xB3B1.Position = UDim2.new(0.9,0,0.05,0)
_0xB3B1.BackgroundColor3 = Color3.fromRGB(255,215,0)
_0xB3B1.Text ="Open"_0xB3B1.TextColor3 = Color3.fromRGB(0,0,0)
_0xB3B1.TextScaled = true
Instance.new("UICorner", _0xB3B1).CornerRadius = UDim.new(0,8)
_0xB3B1.Visible = true
local _0xC29C = Instance.new("Frame", _0xB3B1)
_0xC29C.Size = UDim2.new(1,0,1,0)
_0xC29C.BackgroundTransparency = 1
local _0x436E = Instance.new("TextButton", _0x8FA7)
_0x436E.Size = UDim2.new(0.8,0,0.08,0)
_0x436E.Position = UDim2.new(0.1,0,0.10,0)
_0x436E.BackgroundColor3 = Color3.fromRGB(0,255,0)
_0x436E.Text ="ESP Inventory: ON"_0x436E.TextScaled = true
Instance.new("UICorner", _0x436E).CornerRadius = UDim.new(0,8)
local _0x7D42 = Instance.new("TextButton", _0x8FA7)
_0x7D42.Size = UDim2.new(0.8,0,0.08,0)
_0x7D42.Position = UDim2.new(0.1,0,0.19,0)
_0x7D42.BackgroundColor3 = Color3.fromRGB(255,0,0)
_0x7D42.Text ="ESP: OFF"_0x7D42.TextScaled = true
Instance.new("UICorner", _0x7D42).CornerRadius = UDim.new(0,8)
local _0x6907 = Instance.new("TextButton", _0x8FA7)
_0x6907.Size = UDim2.new(0.8,0,0.08,0)
_0x6907.Position = UDim2.new(0.1,0,0.28,0)
_0x6907.BackgroundColor3 = Color3.fromRGB(255,0,0)
_0x6907.Text ="Aimbot: OFF"_0x6907.TextScaled = true
Instance.new("UICorner", _0x6907).CornerRadius = UDim.new(0,8)
local _0x2E6D = Instance.new("TextButton", _0x8FA7)
_0x2E6D.Size = UDim2.new(0.8,0,0.08,0)
_0x2E6D.Position = UDim2.new(0.1,0,0.37,0)
_0x2E6D.BackgroundColor3 = Color3.fromRGB(0,255,0)
_0x2E6D.Text ="Wallcheck: ON"_0x2E6D.TextScaled = true
_0x2E6D.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", _0x2E6D).CornerRadius = UDim.new(0,8)
local _0x0B71 = Instance.new("TextBox", _0x8FA7)
_0x0B71.Size = UDim2.new(0.8,0,0.08,0)
_0x0B71.Position = UDim2.new(0.1,0,0.46,0)
_0x0B71.BackgroundColor3 = Color3.fromRGB(50,50,50)
_0x0B71.Text ="FOV: 110"_0x0B71.TextColor3 = Color3.fromRGB(255,215,0)
_0x0B71.TextScaled = true
Instance.new("UICorner", _0x0B71).CornerRadius = UDim.new(0,8)
local _0x3119 = Instance.new("TextButton", _0x8FA7)
_0x3119.Size = UDim2.new(0.8,0,0.08,0)
_0x3119.Position = UDim2.new(0.1,0,0.55,0)
_0x3119.BackgroundColor3 = Color3.fromRGB(100,100,255)
_0x3119.Text ="Target: Head (fixed)"_0x3119.TextScaled = true
_0x3119.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", _0x3119).CornerRadius = UDim.new(0,8)
local _0xDEBC = Instance.new("TextButton", _0x8FA7)
_0xDEBC.Size = UDim2.new(0.8,0,0.08,0)
_0xDEBC.Position = UDim2.new(0.1,0,0.64,0)
_0xDEBC.BackgroundColor3 = Color3.fromRGB(0,255,0)
_0xDEBC.Text ="FOV Circle: ON"_0xDEBC.TextScaled = true
_0xDEBC.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", _0xDEBC).CornerRadius = UDim.new(0,8)
local _0xD021 = Instance.new("TextButton", _0x8FA7)
_0xD021.Size = UDim2.new(0.8,0,0.08,0)
_0xD021.Position = UDim2.new(0.1,0,0.73,0)
_0xD021.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
_0xD021.Text ="📋 Copy Discord"_0xD021.TextScaled = true
_0xD021.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", _0xD021).CornerRadius = UDim.new(0,8)
local _0x0CC3 = Instance.new("TextButton", _0x8FA7)
_0x0CC3.Size = UDim2.new(0.8,0,0.08,0)
_0x0CC3.Position = UDim2.new(0.1,0,0.82,0)
_0x0CC3.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
_0x0CC3.Text ="⭕ Toggle FOV Circle"_0x0CC3.TextScaled = true
_0x0CC3.TextColor3 = Color3.fromRGB(0,0,0)
Instance.new("UICorner", _0x0CC3).CornerRadius = UDim.new(0,8)
local _0xFFEC = Instance.new("ScrollingFrame", _0x8FA7)
_0xFFEC.Size = UDim2.new(0.8,0,0.1,0)
_0xFFEC.Position = UDim2.new(0.1,0,0.91,0)
_0xFFEC.BackgroundColor3 = Color3.fromRGB(240,240,240)
_0xFFEC.ScrollBarThickness = 6
_0xFFEC.AutomaticCanvasSize = Enum.AutomaticSize.Y
Instance.new("UICorner", _0xFFEC).CornerRadius = UDim.new(0,8)
local _0xE92A = Instance.new("UIListLayout", _0xFFEC)
_0xE92A.Padding = UDim.new(0,4)local _0xA4E8 = false
local _0xB29D = false
local _0xCE2A = 110
local _0xFF47 = true
local _0x3203 = true
local _0xFDE3 = false
local _0x5920 = {}
local _0xB783 = {}
local _0xB444 = 0.8
local _0x10F0 = 0.03
local _0x8C32 = false
local _0x68B3 = _0x642A.en
local _0x4FAA = Drawing.new("Circle")
_0x4FAA.Radius = _0xCE2A
_0x4FAA.Thickness = 2
_0x4FAA.Color = Color3.fromRGB(255,0,0)
_0x4FAA.Transparency = 0.6
_0x4FAA.Filled = false
_0x4FAA.Visible = false
local _0x8E95 = {
{_0x240B ="Head (fixed)", _0xC4A1 ="Head", color = Color3.fromRGB(100,100,255)},
{_0x240B ="Torso (fixed)", _0xC4A1 ="HumanoidRootPart", color = Color3.fromRGB(255,150,50)},
{_0x240B ="Right Arm (fixed)", _0xC4A1 ="RightUpperArm", color = Color3.fromRGB(50,205,50)},
{_0x240B ="Left Arm (fixed)", _0xC4A1 ="LeftUpperArm", color = Color3.fromRGB(50,255,150)},
{_0x240B ="Auto Switch (Head <> Torso)", parts = {"Head","HumanoidRootPart"}, color = Color3.fromRGB(180,100,255)},
{_0x240B ="Auto Switch (Right <> Left Arm)", parts = {"RightUpperArm","LeftUpperArm"}, color = Color3.fromRGB(255, 255, 0)}
}
local _0xE11E = 1
local _0xF83F = 1
local _0xD30F = 0
local _0xDA55 = 0.7local function _0x27A4(_0xE0B6)
local _0x389C = _0xE0B6 and _0xE0B6:FindFirstChildOfClass("Humanoid")
return _0x389C and _0x389C.Health > 0
end
local function _0x8A73(_0xC4A1)
if not _0xC4A1 then return false end
local _0xB22F = _0x4FB1.CFrame.Position
local _0xFFC3 = (_0xC4A1.Position - _0xB22F)
local _0x6CB0 = RaycastParams.new()
_0x6CB0.FilterType = Enum.RaycastFilterType.Blacklist
_0x6CB0.FilterDescendantsInstances = {_0x900A.Character or workspace, _0xC4A1.Parent}
local _0xFAFE = workspace:Raycast(_0xB22F, _0xFFC3, _0x6CB0)
return not _0xFAFE
end
local function _0xD4E4(_0xE0B6)
if _0xE0B6 then
local _0xF4A0 = _0xE0B6:FindFirstChild("Head")
if _0xF4A0 then
local _0xD233 = _0xF4A0:FindFirstChild("AL-ADWANI_NameHP")
if _0xD233 then _0xD233:Destroy() end
end
local _0x389C = _0xE0B6:FindFirstChild("AL-ADWANI_Highlight")
if _0x389C then _0x389C:Destroy() end
end
end
local function _0x26AB(_0xE0B6)
local _0x7864 = _0xCC68:GetPlayerFromCharacter(_0xE0B6)
if not _0x7864 or _0x7864 == _0x900A then return end
_0xD4E4(_0xE0B6)
local _0xF4A0 = _0xE0B6:FindFirstChild("Head")
local _0x9F24 = _0xE0B6:FindFirstChildOfClass("Humanoid")
if not _0xF4A0 or not _0x9F24 or not _0x27A4(_0xE0B6) then return end
local _0xC368 = Instance.new("BillboardGui", _0xF4A0)
_0xC368.Name ="AL-ADWANI_NameHP"_0xC368.Adornee = _0xF4A0
_0xC368.Size = UDim2.new(0,160,0,35)
_0xC368.StudsOffset = Vector3.new(0,2.8,0)
_0xC368.AlwaysOnTop = true
local _0x240B = Instance.new("TextLabel", _0xC368)
_0x240B.Size = UDim2.new(1,0,0,16)
_0x240B.BackgroundTransparency = 1
_0x240B.Text = _0x7864.DisplayName ~= _0x7864.Name and (_0x7864.DisplayName .." (@".. _0x7864.Name ..")") or _0x7864.Name
_0x240B.TextColor3 = Color3.new(1,1,1)
_0x240B.TextStrokeTransparency = 0
_0x240B.Font = Enum.Font.SourceSansBold
_0x240B.TextSize = 14
local _0x7417 = Instance.new("Frame", _0xC368)
_0x7417.Size = UDim2.new(1,-6,0,5)
_0x7417.Position = UDim2.new(0,3,0,16)
_0x7417.BackgroundColor3 = Color3.new(0,0,0)
Instance.new("UICorner", _0x7417).CornerRadius = UDim.new(0,3)
local _0xF8BE = Instance.new("Frame", _0x7417)
_0xF8BE.Size = UDim2.new(1,0,1,0)
_0xF8BE.BackgroundColor3 = Color3.fromRGB(0,255,0)
Instance.new("UICorner", _0xF8BE).CornerRadius = UDim.new(0,3)
local _0x2AAF = Instance.new("TextLabel", _0x7417)
_0x2AAF.Size = UDim2.new(1,0,1,0)
_0x2AAF.BackgroundTransparency = 1
_0x2AAF.TextColor3 = Color3.new(1,1,1)
_0x2AAF.TextStrokeTransparency = 0
_0x2AAF.TextSize = 8
local function _0x65A7()
if _0x9F24.Parent and _0x27A4(_0xE0B6) then
local _0xA035 = math.clamp(_0x9F24.Health / _0x9F24.MaxHealth, 0, 1)
_0xF8BE.Size = UDim2.new(_0xA035, 0, 1, 0)
_0x2AAF.Text = math.floor(_0x9F24.Health) .."/".. _0x9F24.MaxHealth
else
_0xD4E4(_0xE0B6)
end
end
_0x9F24.HealthChanged:Connect(_0x65A7)
_0x9F24.Died:Connect(function() _0xD4E4(_0xE0B6) end)
_0x65A7()
local _0xBB63 = Instance.new("Highlight", _0xE0B6)
_0xBB63.Name ="AL-ADWANI_Highlight"_0xBB63.OutlineColor = Color3.fromRGB(255,255,0)
_0xBB63.OutlineTransparency = 0
_0xBB63.FillTransparency = 1
end
local function _0x4E79(_0xE0B6)
local _0x7864 = _0xCC68:GetPlayerFromCharacter(_0xE0B6)
if not _0x7864 or _0x7864 == _0x900A then return end
task.delay(0.6, function()
_0xD4E4(_0xE0B6)
if _0xA4E8 then _0x26AB(_0xE0B6) end
end)
end
for _, p in _0xCC68:GetPlayers() do
if p ~= _0x900A then
p.CharacterAdded:Connect(_0x4E79)
if p.Character then _0x4E79(p.Character) end
end
end
_0xCC68.PlayerAdded:Connect(function(p)
if p ~= _0x900A then
p.CharacterAdded:Connect(_0x4E79)
if p.Character then _0x4E79(p.Character) end
end
end)
_0x3C84.Heartbeat:Connect(function()
if _0xA4E8 then
for _, p in _0xCC68:GetPlayers() do
if p ~= _0x900A and p.Character then
local _0xF4A0 = p.Character:FindFirstChild("Head")
if _0xF4A0 and not _0xF4A0:FindFirstChild("AL-ADWANI_NameHP") then
_0x26AB(p.Character)
end
end
end
end
end)
local function _0x5BA9()
for _, _0xD233 in _0xB783 do _0xD233:Destroy() end
_0xB783 = {}
for _, p in _0xCC68:GetPlayers() do
if p ~= _0x900A then
local _0xF722 = Instance.new("TextButton", _0xFFEC)
_0xF722.Size = UDim2.new(1,-10,0,22)
local _0x3D0F = _0x5920[p] or false
_0xF722.BackgroundColor3 = _0x3D0F and Color3.fromRGB(255,215,0) or Color3.fromRGB(60,60,60)
_0xF722.Text = p.DisplayName .." (@".. p.Name ..")".. (_0x3D0F and" ✔"or"")
_0xF722.TextColor3 = Color3.new(1,1,1)
_0xF722.TextScaled = true
Instance.new("UICorner", _0xF722).CornerRadius = UDim.new(0,6)
table.insert(_0xB783, _0xF722)
_0xF722.MouseButton1Click:Connect(function()
_0x5920[p] = not _0x5920[p]
_0x5BA9()
end)
end
end
local _0x77D1 = 0
for _ in pairs(_0x5920) do _0x77D1 = _0x77D1 + 1 end
_0x2661.Text ="🪽 AL-ADWANI HACK | Protected: ".. _0x77D1 .." 🪽"end
_0xCC68.PlayerAdded:Connect(_0x5BA9)
_0xCC68.PlayerRemoving:Connect(_0x5BA9)
_0x5BA9()
local function _0xC528(_0xE0B6)
local _0x2464 = _0x8E95[_0xE11E]
local _0x7A26
if _0x2464.parts then
_0x7A26 = _0x2464.parts[_0xF83F]
else
_0x7A26 = _0x2464.part
end
local _0xC4A1 = _0xE0B6:FindFirstChild(_0x7A26)
if not _0xC4A1 then
if _0x7A26 =="RightUpperArm"then _0xC4A1 = _0xE0B6:FindFirstChild("Right Arm") end
if _0x7A26 =="LeftUpperArm"then _0xC4A1 = _0xE0B6:FindFirstChild("Left Arm") end
end
return _0xC4A1 or _0xE0B6:FindFirstChild("Head") or _0xE0B6:FindFirstChild("HumanoidRootPart")
end
local function _0x656F(_0xE0B6)
local _0xC4A1 = _0xC528(_0xE0B6)
if not _0xC4A1 then return nil end
local _0xC260 = _0xE0B6:FindFirstChild("HumanoidRootPart")
if not _0xC260 then return _0xC4A1.Position end
local _0xF924 = _0xC260.Velocity
return _0xC4A1.Position + (_0xF924 * _0x10F0)
end
local function _0xA4BD()
local _0xCF23, _0x3ABB = nil, math.huge
local _0x040E = _0x4FB1.ViewportSize / 2
for _, p in _0xCC68:GetPlayers() do
if p ~= _0x900A and not _0x5920[p] and p.Character and _0x27A4(p.Character) then
local _0xC4A1 = _0xC528(p.Character)
if _0xC4A1 then
local _0xA5FF = _0x656F(p.Character) or _0xC4A1.Position
local _0x22D0, _0x35DF = _0x4FB1:WorldToViewportPoint(_0xA5FF)
if _0x35DF then
local _0xA443 = (Vector2.new(_0x22D0.X, _0x22D0.Y) - _0x040E).Magnitude
if _0xA443 < _0x3ABB and _0xA443 <= _0xCE2A then
if not _0xFF47 or _0x8A73(_0xC4A1) then
_0x3ABB = _0xA443
_0xCF23 = p
end
end
end
end
end
end
return _0xCF23
end
_0x3C84.RenderStepped:Connect(function()
_0x4FAA.Position = _0x4FB1.ViewportSize / 2
_0x4FAA.Radius = _0xCE2A
_0x4FAA.Visible = _0xB29D and _0x3203 and not _0xFDE3
if _0xB29D then
local _0xF4F0 = _0xA4BD()
if _0xF4F0 and _0xF4F0.Character then
local _0xA5FF = _0x656F(_0xF4F0.Character)
if _0xA5FF then
local _0x5557 = CFrame.new(_0x4FB1.CFrame.Position, _0xA5FF)
_0x4FB1.CFrame = _0x4FB1.CFrame:Lerp(_0x5557, _0xB444)
end
end
end
end)
_0x3C84.Heartbeat:Connect(function(dt)
if not _0xB29D then return end
local _0x2464 = _0x8E95[_0xE11E]
if not _0x2464.parts then return end
_0xD30F = _0xD30F + dt
if _0xD30F >= _0xDA55 then
_0xD30F = 0
_0xF83F = _0xF83F % #_0x2464.parts + 1
end
end)_0x7D42.MouseButton1Click:Connect(function()
_0xA4E8 = not _0xA4E8
_0x7D42.Text = _0x68B3.esp ..": ".. (_0xA4E8 and"ON"or"OFF")
_0x7D42.BackgroundColor3 = _0xA4E8 and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,0,0)
for _, p in _0xCC68:GetPlayers() do
if p ~= _0x900A and p.Character then
if _0xA4E8 then
_0x26AB(p.Character)
else
_0xD4E4(p.Character)
end
end
end
end)
_0x6907.MouseButton1Click:Connect(function()
_0xB29D = not _0xB29D
_0x6907.Text = _0x68B3.aimbot ..": ".. (_0xB29D and"ON"or"OFF")
_0x6907.BackgroundColor3 = _0xB29D and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,0,0)
end)
_0x3119.MouseButton1Click:Connect(function()
_0xE11E = _0xE11E % #_0x8E95 + 1
local _0x2464 = _0x8E95[_0xE11E]
_0x3119.Text = _0x68B3.target ..": ".. _0x2464.name
_0x3119.BackgroundColor3 = _0x2464.color
end)
_0x2E6D.MouseButton1Click:Connect(function()
_0xFF47 = not _0xFF47
_0x2E6D.Text = _0x68B3.wallcheck ..": ".. (_0xFF47 and"ON"or"OFF")
_0x2E6D.BackgroundColor3 = _0xFF47 and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,100,100)
end)
_0x0B71.FocusLost:Connect(function(enterPressed)
if enterPressed then
local _0x5C06 = tonumber(_0x0B71.Text:match("%d+"))
if _0x5C06 and _0x5C06 >= 20 and _0x5C06 <= 600 then
_0xCE2A = _0x5C06
_0x4FAA.Radius = _0x5C06
_0x0B71.Text = _0x68B3.fov ..": ".. _0x5C06
else
_0x0B71.Text = _0x68B3.fov ..": ".. _0xCE2A
end
end
end)
_0xDEBC.MouseButton1Click:Connect(function()
_0x3203 = not _0x3203
_0xDEBC.Text = _0x68B3.fovCircle ..": ".. (_0x3203 and"ON"or"OFF")
_0xDEBC.BackgroundColor3 = _0x3203 and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,0,0)
end)
_0x436E.MouseButton1Click:Connect(function()
_0x7840 = not _0x7840
_0x436E.Text = _0x68B3.espInv ..": ".. (_0x7840 and"ON"or"OFF")
_0x436E.BackgroundColor3 = _0x7840 and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,0,0)
for _, p in ipairs(_0xCC68:GetPlayers()) do
_0x027B(p)
end
end)_0xD021.MouseButton1Click:Connect(function()
pcall(function()
setclipboard("https://discord.gg/wuUESnYJ4")
end)
_0xD021.Text ="✅ Copied!"task.delay(2, function()
_0xD021.Text = _0x68B3.copyDiscord
end)
end)
_0x0CC3.MouseButton1Click:Connect(function()
_0xFDE3 = not _0xFDE3
if _0xFDE3 then
_0x0CC3.Text ="⭕ FOV Circle: OFF"_0x0CC3.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
else
_0x0CC3.Text ="⭕ FOV Circle: ON"_0x0CC3.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
end
end)_0x99F5.MouseButton1Click:Connect(function()
_0x68B3 = _0x642A.en
_0xA4C1.Visible = false
_0x8FA7.Visible = true
_0x2661.Text = _0x68B3.title
_0x436E.Text = _0x68B3.espInv ..": ON"_0x7D42.Text = _0x68B3.esp ..": OFF"_0x6907.Text = _0x68B3.aimbot ..": OFF"_0x2E6D.Text = _0x68B3.wallcheck ..": ON"_0x0B71.Text = _0x68B3.fov ..": 110"_0x3119.Text = _0x68B3.target ..": Head (fixed)"_0xDEBC.Text = _0x68B3.fovCircle ..": ON"_0xD021.Text = _0x68B3.copyDiscord
_0x0CC3.Text = _0x68B3.toggleCircle
end)
_0x7A44.MouseButton1Click:Connect(function()
_0x68B3 = _0x642A.ar
_0xA4C1.Visible = false
_0x8FA7.Visible = true
_0x2661.Text = _0x68B3.title
_0x436E.Text = _0x68B3.espInv ..": ON"_0x7D42.Text = _0x68B3.esp ..": OFF"_0x6907.Text = _0x68B3.aimbot ..": OFF"_0x2E6D.Text = _0x68B3.wallcheck ..": ON"_0x0B71.Text = _0x68B3.fov ..": 110"_0x3119.Text = _0x68B3.target
_0xDEBC.Text = _0x68B3.fovCircle ..": ON"_0xD021.Text = _0x68B3.copyDiscord
_0x0CC3.Text = _0x68B3.toggleCircle
end)local function _0x1D7D(frame, dragArea)
local _0x29FB, _0xEB87, _0x8A89
dragArea.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 then
_0x29FB = true
_0xEB87 = frame.Position
_0x8A89 = input.Position
end
end)
dragArea.InputChanged:Connect(function(input)
if _0x29FB and input.UserInputType == Enum.UserInputType.MouseMovement then
local _0x681D = input.Position - _0x8A89
frame.Position = UDim2.new(
_0xEB87.X.Scale, _0xEB87.X.Offset + _0x681D.X,
_0xEB87.Y.Scale, _0xEB87.Y.Offset + _0x681D.Y
)
end
end)
_0xCAB3.InputEnded:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 then
_0x29FB = false
end
end)
end
_0x1D7D(_0x8FA7, _0x02AF)
_0x1D7D(_0xB3B1, _0xC29C)
_0xB3B1.MouseButton1Click:Connect(function()
_0x8C32 = not _0x8C32
_0x8FA7.Visible = _0x8C32
_0xB3B1.Text = _0x8C32 and"Close"or"Open"if _0x8C32 then _0x5BA9() end
end)
_0xCAB3.InputBegan:Connect(function(input, gameProcessed)
if gameProcessed then return end
if input.KeyCode == Enum.KeyCode.G then
_0x8C32 = not _0x8C32
_0x8FA7.Visible = _0x8C32
_0xB3B1.Visible = not _0x8C32
if _0x8C32 then _0x5BA9() end
end
if input.KeyCode == Enum.KeyCode.K then
_0xFDE3 = not _0xFDE3
if _0xDEBC then
if _0xFDE3 then
_0xDEBC.BackgroundColor3 = Color3.fromRGB(150,150,150)
_0xDEBC.Text = _0x68B3.fovCircle ..": FORCED OFF (K)"else
_0xDEBC.BackgroundColor3 = _0x3203 and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,0,0)
_0xDEBC.Text = _0x68B3.fovCircle ..": ".. (_0x3203 and"ON"or"OFF")
end
end
end
end)
print("AL-ADWANI Script Loaded Successfully - No Protection!")repeat task.wait() until game:IsLoaded()
local _0xCC68 = game:GetService("Players")
local _0x4FB1 = workspace.CurrentCamera
local _0x900A = _0xCC68.LocalPlayer
local _0xD2A4 = false
local function _0x27A4(_0xE0B6)
local _0x3068 = _0xE0B6 and _0xE0B6:FindFirstChildOfClass("Humanoid")
return _0x3068 and _0x3068.Health > 0
end
local function _0x63D7()
for _, p in ipairs(_0xCC68:GetPlayers()) do
if p ~= _0x900A and p.Character and _0x27A4(p.Character) then
return p
end
end
return nil
end
local function _0xC033()
local _0xF4F0 = _0x63D7()
if not _0xF4F0 then
print("[L3K] No players found")
return
end
if _0xF4F0.Character and _0xF4F0.Character:FindFirstChild("Humanoid") then
_0x4FB1.CameraSubject = _0xF4F0.Character.Humanoid
end
task.spawn(function()
task.wait(0.001)
if _0x900A.Character and _0x900A.Character:FindFirstChild("Humanoid") then
_0x4FB1.CameraSubject = _0x900A.Character.Humanoid
end
end)
if _0x6CD3 then
local _0x2D70 = _0x6CD3.BackgroundColor3
_0x6CD3.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
task.spawn(function()
task.wait(0.05)
_0x6CD3.BackgroundColor3 = _0x2D70
end)
end
print("[L3K] Ultra-fast spectate: ".. _0xF4F0.Name)
endlocal _0x1834 = Instance.new("ScreenGui", game:GetService("CoreGui"))
_0x1834.Name ="AL-ADWANI_Spectate"local _0x6CD3 = Instance.new("TextButton", _0x1834)
_0x6CD3.Size = UDim2.new(0, 100, 0, 45)
_0x6CD3.Position = UDim2.new(0, 20, 0.5, -22)
_0x6CD3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
_0x6CD3.Text ="⚡ SPECTATE"_0x6CD3.TextColor3 = Color3.new(0, 0, 0)
_0x6CD3.Font = Enum.Font.GothamBold
_0x6CD3.TextSize = 12
Instance.new("UICorner", _0x6CD3).CornerRadius = UDim.new(0, 10)
local _0x29FB = false
local _0x557F = nil
local _0x6397 = nil
_0x6CD3.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 then
_0x29FB = true
_0x557F = _0x6CD3.Position
_0x6397 = input.Position
end
end)
game:GetService("UserInputService").InputEnded:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 then
_0x29FB = false
end
end)
game:GetService("UserInputService").InputChanged:Connect(function(input)
if _0x29FB and input.UserInputType == Enum.UserInputType.MouseMovement then
local _0x681D = input.Position - _0x6397
_0x6CD3.Position = UDim2.new(
_0x557F.X.Scale, _0x557F.X.Offset + _0x681D.X,
_0x557F.Y.Scale, _0x557F.Y.Offset + _0x681D.Y
)
end
end)
_0x6CD3.MouseButton1Click:Connect(function()
_0xC033()
end)
pcall(function()
local _0xBDC7 = Instance.new("TextLabel", _0x1834)
_0xBDC7.Size = UDim2.new(0, 220, 0, 35)
_0xBDC7.Position = UDim2.new(0.5, -110, 0.85, 0)
_0xBDC7.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
_0xBDC7.Text ="⚡ Fastest spectate - Click and watch"_0xBDC7.TextColor3 = Color3.fromRGB(255, 215, 0)
_0xBDC7.Font = Enum.Font.GothamBold
_0xBDC7.TextSize = 11
Instance.new("UICorner", _0xBDC7).CornerRadius = UDim.new(0, 8)
task.delay(2.5, function()
_0xBDC7:Remove()
end)
end)
print("[WELCOME] ========================================")
print("[AL-ADWANI] ✅ Fastest version - Instant spectate")
print("[AL-ADWANI] 🎮 Click = spectate player then release instantly")
print("[AL-ADWANI] ⚡ Only 0.001 seconds!")
print("[AL-ADWANI] ========================================")
