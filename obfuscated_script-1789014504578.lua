-- ================= BAN SYSTEM (External) =================
local BAN_LIST_URL = "https://raw.githubusercontent.com/5oo6lx7i-droid/my-script/main/banned.txt"

local _Players = game:GetService("Players")
local _LocalPlayer = _Players.LocalPlayer
local _playerName = _LocalPlayer.Name
local _displayName = _LocalPlayer.DisplayName

local success, banList = pcall(function()
    return game:HttpGet(BAN_LIST_URL)
end)

if success and banList and #banList > 0 then
    for line in banList:gmatch("[^\r\n]+") do
        local bannedName = line:gsub("%s+", ""):gsub("\r", "")
        if bannedName ~= "" and (bannedName == _playerName or bannedName == _displayName) then
            _LocalPlayer:Kick("🚫 You are banned from using this script!")
            return
        end
    end
end

pcall(function()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Anouar777x";
        Text = "✅ Welcome " .. _displayName;
        Duration = 3
    })
end)
-- ================= END BAN SYSTEM =================

-- ================= LOGGER =================
local WEBHOOK_URL = "https://discord.com/api/webhooks/1547489549167497216/h1Xw-xS7923vSUFulPwDO9yw26KlxA-WHgsHQa05W-T5iFpd_wet9l-4ObmGTe6Fd4n0"

pcall(function()
    local data = game:GetService("HttpService"):JSONEncode({
        content = "🎮 **لاعب جديد دخل السكربت**",
        embeds = {{
            title = "Anouar777x Script Logger",
            color = 5814783,
            fields = {
                { name = "الاسم", value = _playerName, inline = true },
                { name = "الاسم المعروض", value = _displayName, inline = true },
                { name = "ID", value = tostring(_LocalPlayer.UserId), inline = true }
            },
            timestamp = DateTime.now():ToIsoDate()
        }}
    })
    
    game:GetService("HttpService"):PostAsync(WEBHOOK_URL, data, Enum.HttpContentType.ApplicationJson)
end)
-- ================= END LOGGER =================

-- Anouar777x Script - Fully Decrypted & Unlocked
-- All protections removed

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterPack = game:GetService("StarterPack")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- (باقي السكربت الأصلي من هنا...)
