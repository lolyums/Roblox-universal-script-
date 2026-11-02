-- // Insanity Hub | Key System
-- // executor: getgenv / syn / fluxus / krnl compatible

-- ══════════════════════════════════════════
--   CONFIG — change these two values only
-- ══════════════════════════════════════════
local KEY_LINK    = "YOUR_KEY_LINK_HERE"   -- link opened by Copy button
local VALID_KEYS  = {                       -- add valid keys here
    -- "insanity-xxxx-xxxx-xxxx",
}
-- ══════════════════════════════════════════

if getgenv().InsanityLoaded then return end
getgenv().InsanityLoaded = true

-- services
local Players       = game:GetService("Players")
local TweenService  = game:GetService("TweenService")
local RunService    = game:GetService("RunService")
local UIS           = game:GetService("UserInputService")

local lp = Players.LocalPlayer
local pg = lp:WaitForChild("PlayerGui")

-- ── helpers ──────────────────────────────
local function tween(obj, props, t, style, dir)
    style = style or Enum.EasingStyle.Quart
    dir   = dir   or Enum.EasingDirection.Out
    TweenService:Create(obj, TweenInfo.new(t, style, dir), props):Play()
end

local function has_key(input)
    input = input:gsub("%s+", "")
    for _, v in ipairs(VALID_KEYS) do
        if v == input then return true end
    end
    return false
end

local function copy_to_clipboard(text)
    if setclipboard then
        setclipboard(text)
        return true
    elseif toclipboard then
        toclipboard(text)
        return true
    end
    return false
end

-- ── GUI build ────────────────────────────
local sg = Instance.new("ScreenGui")
sg.Name            = "InsanityHub"
sg.ResetOnSpawn    = false
sg.ZIndexBehavior  = Enum.ZIndexBehavior.Sibling
sg.IgnoreGuiInset  = true
sg.DisplayOrder    = 999

if syn and syn.protect_gui then
    syn.protect_gui(sg)
    sg.Parent = game.CoreGui
elseif gethui then
    sg.Parent = gethui()
else
    sg.Parent = pg
end

-- backdrop blur
local blur = Instance.new("BlurEffect")
blur.Size   = 12
blur.Parent = game:GetService("Lighting")

-- dim overlay
local overlay = Instance.new("Frame")
overlay.Size            = UDim2.fromScale(1, 1)
overlay.BackgroundColor3 = Color3.fromRGB(5, 0, 15)
overlay.BackgroundTransparency = 0.35
overlay.BorderSizePixel = 0
overlay.ZIndex          = 1
overlay.Parent          = sg

-- ── MODAL FRAME ──────────────────────────
local modal = Instance.new("Frame")
modal.Name                   = "Modal"
modal.Size                   = UDim2.new(0, 500, 0, 0)   -- height auto
modal.Position               = UDim2.fromScale(0.5, 0.5)
modal.AnchorPoint            = Vector2.new(0.5, 0.5)
modal.BackgroundColor3       = Color3.fromRGB(13, 0, 24)
modal.BorderSizePixel        = 0
modal.AutomaticSize          = Enum.AutomaticSize.Y
modal.ZIndex                 = 2
modal.Parent                 = sg

local mCorner = Instance.new("UICorner")
mCorner.CornerRadius = UDim.new(0, 14)
mCorner.Parent       = modal

-- outer purple stroke
local mStroke = Instance.new("UIStroke")
mStroke.Color       = Color3.fromRGB(124, 58, 237)
mStroke.Thickness   = 2
mStroke.Transparency = 0
mStroke.Parent      = modal

-- inner glow (ImageLabel hack)
local glow = Instance.new("ImageLabel")
glow.Size                   = UDim2.new(1, 60, 1, 60)
glow.Position               = UDim2.new(0, -30, 0, -30)
glow.BackgroundTransparency = 1
glow.Image                  = "rbxassetid://5028857084"   -- radial gradient asset
glow.ImageColor3            = Color3.fromRGB(90, 0, 160)
glow.ImageTransparency      = 0.6
glow.ZIndex                 = 1
glow.Parent                 = modal

-- layout
local mLayout = Instance.new("UIPadding")
mLayout.PaddingLeft   = UDim.new(0, 24)
mLayout.PaddingRight  = UDim.new(0, 24)
mLayout.PaddingTop    = UDim.new(0, 22)
mLayout.PaddingBottom = UDim.new(0, 22)
mLayout.Parent        = modal

local mList = Instance.new("UIListLayout")
mList.FillDirection = Enum.FillDirection.Vertical
mList.Padding       = UDim.new(0, 12)
mList.SortOrder     = Enum.SortOrder.LayoutOrder
mList.Parent        = modal

-- ── HEADER ROW ───────────────────────────
local header = Instance.new("Frame")
header.Size                   = UDim2.new(1, 0, 0, 58)
header.BackgroundTransparency = 1
header.LayoutOrder             = 1
header.ZIndex                  = 3
header.Parent                  = modal

local hList = Instance.new("UIListLayout")
hList.FillDirection  = Enum.FillDirection.Horizontal
hList.VerticalAlignment = Enum.VerticalAlignment.Center
hList.Padding        = UDim.new(0, 12)
hList.SortOrder      = Enum.SortOrder.LayoutOrder
hList.Parent         = header

-- evil face icon (ImageLabel — using a Roblox decal-style asset)
-- using a built-in placeholder; swap rbxassetid to your own uploaded icon
local icon = Instance.new("ImageLabel")
icon.Size                   = UDim2.new(0, 52, 0, 52)
icon.BackgroundTransparency = 1
icon.Image                  = "rbxassetid://6031068420"  -- skull/evil placeholder
icon.ImageColor3            = Color3.fromRGB(180, 78, 245)
icon.LayoutOrder             = 1
icon.ZIndex                  = 3
icon.Parent                  = header

-- title text
local titleLbl = Instance.new("TextLabel")
titleLbl.Size                   = UDim2.new(1, -70, 1, 0)
titleLbl.BackgroundTransparency = 1
titleLbl.Text                   = "Insanity"
titleLbl.Font                   = Enum.Font.GothamBold
titleLbl.TextSize               = 32
titleLbl.TextColor3             = Color3.fromRGB(180, 78, 245)
titleLbl.TextXAlignment         = Enum.TextXAlignment.Left
titleLbl.LayoutOrder            = 2
titleLbl.ZIndex                 = 3
titleLbl.Parent                 = header

-- subtitle "made by insanity"
local subLbl = Instance.new("TextLabel")
subLbl.Size                   = UDim2.new(1, 0, 0, 16)
subLbl.BackgroundTransparency = 1
subLbl.Text                   = "made by insanity"
subLbl.Font                   = Enum.Font.Gotham
subLbl.TextSize               = 12
subLbl.TextColor3             = Color3.fromRGB(139, 123, 168)
subLbl.TextXAlignment         = Enum.TextXAlignment.Left
subLbl.LayoutOrder            = 3
subLbl.ZIndex                 = 3
subLbl.Parent                 = modal

-- ── DIVIDER ──────────────────────────────
local div = Instance.new("Frame")
div.Size                 = UDim2.new(1, 0, 0, 1)
div.BackgroundColor3     = Color3.fromRGB(60, 20, 100)
div.BorderSizePixel      = 0
div.LayoutOrder          = 4
div.ZIndex               = 3
div.Parent               = modal

-- ── KEY SECTION LABEL ────────────────────
local keyHeaderRow = Instance.new("Frame")
keyHeaderRow.Size                   = UDim2.new(1, 0, 0, 26)
keyHeaderRow.BackgroundTransparency = 1
keyHeaderRow.LayoutOrder             = 5
keyHeaderRow.ZIndex                  = 3
keyHeaderRow.Parent                  = modal

local khList = Instance.new("UIListLayout")
khList.FillDirection     = Enum.FillDirection.Horizontal
khList.VerticalAlignment = Enum.VerticalAlignment.Center
khList.Padding           = UDim.new(0, 8)
khList.Parent            = keyHeaderRow

local keyIconLbl = Instance.new("TextLabel")
keyIconLbl.Size                   = UDim2.new(0, 22, 1, 0)
keyIconLbl.BackgroundTransparency = 1
keyIconLbl.Text                   = "🔑"
keyIconLbl.Font                   = Enum.Font.GothamBold
keyIconLbl.TextSize               = 18
keyIconLbl.TextColor3             = Color3.fromRGB(168, 85, 247)
keyIconLbl.ZIndex                 = 3
keyIconLbl.Parent                 = keyHeaderRow

local keySectionTitle = Instance.new("TextLabel")
keySectionTitle.Size                   = UDim2.new(1, -30, 1, 0)
keySectionTitle.BackgroundTransparency = 1
keySectionTitle.Text                   = "Key System"
keySectionTitle.Font                   = Enum.Font.GothamBold
keySectionTitle.TextSize               = 17
keySectionTitle.TextColor3             = Color3.fromRGB(226, 217, 243)
keySectionTitle.TextXAlignment         = Enum.TextXAlignment.Left
keySectionTitle.ZIndex                 = 3
keySectionTitle.Parent                 = keyHeaderRow

local keySub = Instance.new("TextLabel")
keySub.Size                   = UDim2.new(1, 0, 0, 18)
keySub.BackgroundTransparency = 1
keySub.Text                   = "Enter the API key below to continue."
keySub.Font                   = Enum.Font.Gotham
keySub.TextSize               = 13
keySub.TextColor3             = Color3.fromRGB(139, 123, 168)
keySub.TextXAlignment         = Enum.TextXAlignment.Left
keySub.LayoutOrder            = 6
keySub.ZIndex                 = 3
keySub.Parent                 = modal

-- ── KEY INPUT ────────────────────────────
local inputFrame = Instance.new("Frame")
inputFrame.Size                 = UDim2.new(1, 0, 0, 44)
inputFrame.BackgroundColor3     = Color3.fromRGB(18, 0, 31)
inputFrame.BorderSizePixel      = 0
inputFrame.LayoutOrder          = 7
inputFrame.ZIndex               = 3
inputFrame.Parent               = modal

Instance.new("UICorner", inputFrame).CornerRadius = UDim.new(0, 9)

local inputStroke = Instance.new("UIStroke")
inputStroke.Color       = Color3.fromRGB(124, 58, 237)
inputStroke.Thickness   = 1.5
inputStroke.Transparency = 0.45
inputStroke.Parent      = inputFrame

local keyBox = Instance.new("TextBox")
keyBox.Size                   = UDim2.new(1, 0, 1, 0)
keyBox.BackgroundTransparency = 1
keyBox.Text                   = ""
keyBox.PlaceholderText        = "Paste your key here..."
keyBox.PlaceholderColor3      = Color3.fromRGB(139, 123, 168)
keyBox.Font                   = Enum.Font.Gotham
keyBox.TextSize               = 14
keyBox.TextColor3             = Color3.fromRGB(226, 217, 243)
keyBox.TextXAlignment         = Enum.TextXAlignment.Center
keyBox.ClearTextOnFocus       = false
keyBox.ZIndex                 = 4
keyBox.Parent                 = inputFrame

-- focus glow
keyBox.Focused:Connect(function()
    tween(inputStroke, {Transparency = 0, Color = Color3.fromRGB(157, 92, 245)}, 0.2)
end)
keyBox.FocusLost:Connect(function()
    tween(inputStroke, {Transparency = 0.45, Color = Color3.fromRGB(124, 58, 237)}, 0.2)
end)

-- ── BUTTON ROW ───────────────────────────
local btnRow = Instance.new("Frame")
btnRow.Size                   = UDim2.new(1, 0, 0, 46)
btnRow.BackgroundTransparency = 1
btnRow.LayoutOrder            = 8
btnRow.ZIndex                 = 3
btnRow.Parent                 = modal

local bList = Instance.new("UIListLayout")
bList.FillDirection = Enum.FillDirection.Horizontal
bList.Padding       = UDim.new(0, 12)
bList.SortOrder     = Enum.SortOrder.LayoutOrder
bList.Parent        = btnRow

-- Copy button (purple)
local btnCopy = Instance.new("TextButton")
btnCopy.Size                 = UDim2.new(0.5, -6, 1, 0)
btnCopy.BackgroundColor3     = Color3.fromRGB(124, 58, 237)
btnCopy.BorderSizePixel      = 0
btnCopy.Text                 = "📋  Copy"
btnCopy.Font                 = Enum.Font.GothamBold
btnCopy.TextSize             = 14
btnCopy.TextColor3           = Color3.fromRGB(255, 255, 255)
btnCopy.AutoButtonColor      = false
btnCopy.LayoutOrder          = 1
btnCopy.ZIndex               = 4
btnCopy.Parent               = btnRow
Instance.new("UICorner", btnCopy).CornerRadius = UDim.new(0, 9)

-- Check button (dark)
local btnCheck = Instance.new("TextButton")
btnCheck.Size                 = UDim2.new(0.5, -6, 1, 0)
btnCheck.BackgroundColor3     = Color3.fromRGB(30, 30, 46)
btnCheck.BorderSizePixel      = 0
btnCheck.Text                 = "✔  Check"
btnCheck.Font                 = Enum.Font.GothamBold
btnCheck.TextSize             = 14
btnCheck.TextColor3           = Color3.fromRGB(226, 217, 243)
btnCheck.AutoButtonColor      = false
btnCheck.LayoutOrder          = 2
btnCheck.ZIndex               = 4
btnCheck.Parent               = btnRow
Instance.new("UICorner", btnCheck).CornerRadius = UDim.new(0, 9)

local checkStroke = Instance.new("UIStroke")
checkStroke.Color       = Color3.fromRGB(61, 61, 92)
checkStroke.Thickness   = 1.5
checkStroke.Parent      = btnCheck

-- ── STATUS LABEL ─────────────────────────
local statusLbl = Instance.new("TextLabel")
statusLbl.Size                   = UDim2.new(1, 0, 0, 18)
statusLbl.BackgroundTransparency = 1
statusLbl.Text                   = ""
statusLbl.Font                   = Enum.Font.Gotham
statusLbl.TextSize               = 12
statusLbl.TextColor3             = Color3.fromRGB(139, 123, 168)
statusLbl.TextXAlignment         = Enum.TextXAlignment.Center
statusLbl.LayoutOrder            = 9
statusLbl.ZIndex                 = 3
statusLbl.Parent                 = modal

-- ── BUTTON LOGIC ─────────────────────────
local function setStatus(msg, color)
    statusLbl.Text       = msg
    statusLbl.TextColor3 = color or Color3.fromRGB(139, 123, 168)
end

local function pulse(btn, col)
    local orig = btn.BackgroundColor3
    tween(btn, {BackgroundColor3 = col}, 0.08)
    task.delay(0.12, function()
        tween(btn, {BackgroundColor3 = orig}, 0.15)
    end)
end

btnCopy.MouseButton1Click:Connect(function()
    pulse(btnCopy, Color3.fromRGB(167, 100, 255))
    if KEY_LINK == "YOUR_KEY_LINK_HERE" then
        setStatus("⚠ No link configured.", Color3.fromRGB(255, 180, 60))
        return
    end
    local ok = copy_to_clipboard(KEY_LINK)
    if ok then
        setStatus("✔ Link copied to clipboard!", Color3.fromRGB(130, 255, 160))
    else
        -- fallback: paste into box
        keyBox.Text = KEY_LINK
        setStatus("Copied into field — grab it from there.", Color3.fromRGB(200, 200, 255))
    end
end)

btnCheck.MouseButton1Click:Connect(function()
    pulse(btnCheck, Color3.fromRGB(70, 70, 110))
    local input = keyBox.Text:gsub("%s+", "")
    if input == "" then
        setStatus("⚠ Paste a key first.", Color3.fromRGB(255, 180, 60))
        return
    end
    if has_key(input) then
        setStatus("✔ Valid key — loading...", Color3.fromRGB(130, 255, 160))
        task.delay(0.8, function()
            -- close UI
            tween(modal,   {BackgroundTransparency = 1}, 0.3)
            tween(overlay, {BackgroundTransparency = 1}, 0.3)
            task.delay(0.35, function()
                blur:Destroy()
                sg:Destroy()
                -- ── load your main script here ──
                -- loadstring(game:HttpGet("YOUR_MAIN_SCRIPT_URL"))()
            end)
        end)
    else
        setStatus("✘ Invalid key.", Color3.fromRGB(255, 90, 90))
        tween(inputStroke, {Color = Color3.fromRGB(220, 60, 60)}, 0.15)
        task.delay(1.2, function()
            tween(inputStroke, {Color = Color3.fromRGB(124, 58, 237)}, 0.3)
        end)
    end
end)

-- ── DRAGGABLE ────────────────────────────
do
    local dragging, dragStart, startPos = false, nil, nil
    modal.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1
        or inp.UserInputType == Enum.UserInputType.Touch then
            dragging  = true
            dragStart = inp.Position
            startPos  = modal.Position
        end
    end)
    UIS.InputChanged:Connect(function(inp)
        if not dragging then return end
        if inp.UserInputType == Enum.UserInputType.MouseMovement
        or inp.UserInputType == Enum.UserInputType.Touch then
            local delta = inp.Position - dragStart
            modal.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
    UIS.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1
        or inp.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

-- ── OPEN ANIMATION ───────────────────────
modal.Size         = UDim2.new(0, 500, 0, 0)
modal.BackgroundTransparency = 1
overlay.BackgroundTransparency = 1

tween(overlay, {BackgroundTransparency = 0.35}, 0.25)
tween(modal,   {BackgroundTransparency = 0, Size = UDim2.new(0, 500, 0, 260)}, 0.35,
      Enum.EasingStyle.Back, Enum.EasingDirection.Out)
