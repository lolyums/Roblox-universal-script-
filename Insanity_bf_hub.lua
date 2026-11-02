-- // Insanity Hub | Key System
-- // Made by Insanity
-- // Paste your key link below

local KEY_LINK = "https://rbx.tg/lc53lau-" -- << paste your link here

local VALID_KEYS = {
    "INSANITY-XXXX-XXXX-DEMO", -- add your real keys here
}

-- // Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- // Util
local function isValidKey(input)
    local lower = input:lower()
    for _, k in ipairs(VALID_KEYS) do
        if k:lower() == lower then return true end
    end
    return false
end

local function copyToClipboard(text)
    setclipboard(text) -- works on most exploit executors
end

-- // Build GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "InsanityHub_Key"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

-- Background blur/darken
local Overlay = Instance.new("Frame")
Overlay.Size = UDim2.fromScale(1, 1)
Overlay.BackgroundColor3 = Color3.fromRGB(5, 2, 8)
Overlay.BackgroundTransparency = 0.35
Overlay.BorderSizePixel = 0
Overlay.ZIndex = 1
Overlay.Parent = ScreenGui

-- Main card
local Card = Instance.new("Frame")
Card.Size = UDim2.new(0, 440, 0, 280)
Card.Position = UDim2.fromScale(0.5, 0.5)
Card.AnchorPoint = Vector2.new(0.5, 0.5)
Card.BackgroundColor3 = Color3.fromRGB(18, 13, 16)
Card.BorderSizePixel = 0
Card.ZIndex = 2
Card.Parent = ScreenGui

local CardCorner = Instance.new("UICorner")
CardCorner.CornerRadius = UDim.new(0, 14)
CardCorner.Parent = Card

local CardStroke = Instance.new("UIStroke")
CardStroke.Color = Color3.fromRGB(122, 45, 74)
CardStroke.Thickness = 1.2
CardStroke.Transparency = 0.2
CardStroke.Parent = Card

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 80)
Header.BackgroundColor3 = Color3.fromRGB(25, 10, 20)
Header.BorderSizePixel = 0
Header.ZIndex = 3
Header.Parent = Card

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 14)
HeaderCorner.Parent = Header

-- cover bottom corners of header
local HeaderFill = Instance.new("Frame")
HeaderFill.Size = UDim2.new(1, 0, 0, 14)
HeaderFill.Position = UDim2.new(0, 0, 1, -14)
HeaderFill.BackgroundColor3 = Color3.fromRGB(25, 10, 20)
HeaderFill.BorderSizePixel = 0
HeaderFill.ZIndex = 3
HeaderFill.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 36)
Title.Position = UDim2.new(0, 0, 0, 14)
Title.BackgroundTransparency = 1
Title.Text = "💀  INSANITY HUB  💀"
Title.TextColor3 = Color3.fromRGB(255, 140, 58)
Title.TextSize = 22
Title.Font = Enum.Font.GothamBold
Title.ZIndex = 4
Title.Parent = Header

local Sub = Instance.new("TextLabel")
Sub.Size = UDim2.new(1, 0, 0, 20)
Sub.Position = UDim2.new(0, 0, 0, 52)
Sub.BackgroundTransparency = 1
Sub.Text = "KEY VERIFICATION  ·  MADE BY INSANITY"
Sub.TextColor3 = Color3.fromRGB(138, 96, 112)
Sub.TextSize = 11
Sub.Font = Enum.Font.GothamSemibold
Sub.ZIndex = 4
Sub.Parent = Header

-- Input label
local InputLabel = Instance.new("TextLabel")
InputLabel.Size = UDim2.new(1, -48, 0, 18)
InputLabel.Position = UDim2.new(0, 24, 0, 96)
InputLabel.BackgroundTransparency = 1
InputLabel.Text = "— ENTER YOUR KEY"
InputLabel.TextColor3 = Color3.fromRGB(138, 96, 112)
InputLabel.TextSize = 11
InputLabel.Font = Enum.Font.GothamBold
InputLabel.TextXAlignment = Enum.TextXAlignment.Left
InputLabel.ZIndex = 3
InputLabel.Parent = Card

-- Key input box
local InputBox = Instance.new("TextBox")
InputBox.Size = UDim2.new(1, -48, 0, 40)
InputBox.Position = UDim2.new(0, 24, 0, 118)
InputBox.BackgroundColor3 = Color3.fromRGB(26, 16, 24)
InputBox.BorderSizePixel = 0
InputBox.PlaceholderText = "XXXX-XXXX-XXXX-XXXX"
InputBox.PlaceholderColor3 = Color3.fromRGB(90, 60, 75)
InputBox.Text = ""
InputBox.TextColor3 = Color3.fromRGB(232, 201, 212)
InputBox.TextSize = 14
InputBox.Font = Enum.Font.GothamBold
InputBox.ClearTextOnFocus = false
InputBox.ZIndex = 3
InputBox.Parent = Card

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 8)
InputCorner.Parent = InputBox

local InputStroke = Instance.new("UIStroke")
InputStroke.Color = Color3.fromRGB(61, 31, 46)
InputStroke.Thickness = 1
InputStroke.Parent = InputBox

-- Status label
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -48, 0, 20)
StatusLabel.Position = UDim2.new(0, 24, 0, 164)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = ""
StatusLabel.TextColor3 = Color3.fromRGB(96, 192, 112)
StatusLabel.TextSize = 13
StatusLabel.Font = Enum.Font.GothamSemibold
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.ZIndex = 3
StatusLabel.Parent = Card

-- Buttons row
local BtnCheck = Instance.new("TextButton")
BtnCheck.Size = UDim2.new(0.5, -30, 0, 40)
BtnCheck.Position = UDim2.new(0, 24, 0, 218)
BtnCheck.BackgroundColor3 = Color3.fromRGB(140, 72, 30)
BtnCheck.BorderSizePixel = 0
BtnCheck.Text = "🔍  CHECK KEY"
BtnCheck.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnCheck.TextSize = 13
BtnCheck.Font = Enum.Font.GothamBold
BtnCheck.ZIndex = 3
BtnCheck.Parent = Card

local BtnCheckCorner = Instance.new("UICorner")
BtnCheckCorner.CornerRadius = UDim.new(0, 8)
BtnCheckCorner.Parent = BtnCheck

local BtnCopy = Instance.new("TextButton")
BtnCopy.Size = UDim2.new(0.5, -30, 0, 40)
BtnCopy.Position = UDim2.new(0.5, 6, 0, 218)
BtnCopy.BackgroundColor3 = Color3.fromRGB(60, 28, 80)
BtnCopy.BorderSizePixel = 0
BtnCopy.Text = "🔗  COPY LINK"
BtnCopy.TextColor3 = Color3.fromRGB(176, 96, 208)
BtnCopy.TextSize = 13
BtnCopy.Font = Enum.Font.GothamBold
BtnCopy.ZIndex = 3
BtnCopy.Parent = Card

local BtnCopyCorner = Instance.new("UICorner")
BtnCopyCorner.CornerRadius = UDim.new(0, 8)
BtnCopyCorner.Parent = BtnCopy

-- // Button logic
local function setStatus(msg, color)
    StatusLabel.Text = msg
    StatusLabel.TextColor3 = color
end

BtnCheck.MouseButton1Click:Connect(function()
    local key = InputBox.Text:gsub("%s+", "")
    if key == "" then
        setStatus("⚠  Enter a key first.", Color3.fromRGB(240, 160, 60))
        return
    end

    BtnCheck.Text = "⏳  Checking..."
    BtnCheck.Active = false

    task.wait(0.7)

    if isValidKey(key) then
        setStatus("✅  Key verified! Welcome to Insanity Hub.", Color3.fromRGB(96, 192, 112))
        -- load your main script here:
        -- loadstring(game:HttpGet("YOUR_MAIN_SCRIPT_URL"))()
    else
        setStatus("❌  Invalid key. Get one via Copy Link.", Color3.fromRGB(240, 90, 100))
    end

    BtnCheck.Text = "🔍  CHECK KEY"
    BtnCheck.Active = true
end)

BtnCopy.MouseButton1Click:Connect(function()
    copyToClipboard(KEY_LINK)
    local orig = BtnCopy.Text
    BtnCopy.Text = "✔  COPIED!"
    BtnCopy.TextColor3 = Color3.fromRGB(96, 192, 112)
    setStatus("🔗  Link copied to clipboard.", Color3.fromRGB(176, 96, 208))
    task.wait(2)
    BtnCopy.Text = orig
    BtnCopy.TextColor3 = Color3.fromRGB(176, 96, 208)
end)
