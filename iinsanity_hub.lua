-- Insanity H
-- Purple Theme | Made by Insanity

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- CONFIG (edit these)
local VALID_KEY = "INSANITY-2026" -- change this to whatever key you want
local COPY_LINK = "https://rbx.tg/apl27-Xo" -- put your link inside the brackets

-- Colors
local PurpleMain = Color3.fromRGB(90, 0, 160)
local PurpleDark = Color3.fromRGB(45, 0, 85)
local PurpleLight = Color3.fromRGB(140, 40, 220)
local PurpleGlow = Color3.fromRGB(180, 80, 255)
local White = Color3.fromRGB(255, 255, 255)
local DarkBg = Color3.fromRGB(18, 12, 28)

-- Destroy old UI if exists
if PlayerGui:FindFirstChild("InsanityHubKey") then
	PlayerGui.InsanityHubKey:Destroy()
end

-- Main ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "InsanityHubKey"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

-- Background blur frame
local BlurFrame = Instance.new("Frame")
BlurFrame.Name = "Blur"
BlurFrame.Size = UDim2.new(1, 0, 1, 0)
BlurFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
BlurFrame.BackgroundTransparency = 0.45
BlurFrame.BorderSizePixel = 0
BlurFrame.Parent = ScreenGui

-- Main container
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 420, 0, 260)
Main.Position = UDim2.new(0.5, -210, 0.5, -130)
Main.BackgroundColor3 = DarkBg
Main.BorderSizePixel = 0
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = PurpleMain
MainStroke.Thickness = 2
MainStroke.Transparency = 0.2
MainStroke.Parent = Main

-- Top accent bar
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 6)
TopBar.BackgroundColor3 = PurpleMain
TopBar.BorderSizePixel = 0
TopBar.Parent = Main

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 14)
TopBarCorner.Parent = TopBar

-- Title
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -20, 0, 40)
Title.Position = UDim2.new(0, 10, 0, 18)
Title.BackgroundTransparency = 1
Title.Text = "INSANITY HUB"
Title.TextColor3 = PurpleGlow
Title.TextSize = 26
Title.Font = Enum.Font.GothamBlack
Title.Parent = Main

local SubTitle = Instance.new("TextLabel")
SubTitle.Name = "SubTitle"
SubTitle.Size = UDim2.new(1, -20, 0, 20)
SubTitle.Position = UDim2.new(0, 10, 0, 52)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "made by insanity"
SubTitle.TextColor3 = Color3.fromRGB(180, 140, 220)
SubTitle.TextSize = 13
SubTitle.Font = Enum.Font.Gotham
SubTitle.Parent = Main

-- Key Input Box
local KeyBox = Instance.new("TextBox")
KeyBox.Name = "KeyBox"
KeyBox.Size = UDim2.new(1, -40, 0, 42)
KeyBox.Position = UDim2.new(0, 20, 0, 90)
KeyBox.BackgroundColor3 = Color3.fromRGB(28, 18, 42)
KeyBox.BorderSizePixel = 0
KeyBox.Text = ""
KeyBox.PlaceholderText = "Enter Key..."
KeyBox.PlaceholderColor3 = Color3.fromRGB(140, 100, 180)
KeyBox.TextColor3 = White
KeyBox.TextSize = 16
KeyBox.Font = Enum.Font.Gotham
KeyBox.ClearTextOnFocus = false
KeyBox.Parent = Main

local KeyBoxCorner = Instance.new("UICorner")
KeyBoxCorner.CornerRadius = UDim.new(0, 8)
KeyBoxCorner.Parent = KeyBox

local KeyBoxStroke = Instance.new("UIStroke")
KeyBoxStroke.Color = PurpleMain
KeyBoxStroke.Thickness = 1.5
KeyBoxStroke.Transparency = 0.4
KeyBoxStroke.Parent = KeyBox

-- Button Container
local ButtonFrame = Instance.new("Frame")
ButtonFrame.Name = "ButtonFrame"
ButtonFrame.Size = UDim2.new(1, -40, 0, 48)
ButtonFrame.Position = UDim2.new(0, 20, 0, 150)
ButtonFrame.BackgroundTransparency = 1
ButtonFrame.Parent = Main

-- Check Key Button (Left)
local CheckBtn = Instance.new("TextButton")
CheckBtn.Name = "CheckKey"
CheckBtn.Size = UDim2.new(0.48, 0, 1, 0)
CheckBtn.Position = UDim2.new(0, 0, 0, 0)
CheckBtn.BackgroundColor3 = PurpleMain
CheckBtn.BorderSizePixel = 0
CheckBtn.Text = "Check Key"
CheckBtn.TextColor3 = White
CheckBtn.TextSize = 16
CheckBtn.Font = Enum.Font.GothamBold
CheckBtn.AutoButtonColor = false
CheckBtn.Parent = ButtonFrame

local CheckCorner = Instance.new("UICorner")
CheckCorner.CornerRadius = UDim.new(0, 9)
CheckCorner.Parent = CheckBtn

-- Copy Link Button (Right)
local CopyBtn = Instance.new("TextButton")
CopyBtn.Name = "CopyLink"
CopyBtn.Size = UDim2.new(0.48, 0, 1, 0)
CopyBtn.Position = UDim2.new(0.52, 0, 0, 0)
CopyBtn.BackgroundColor3 = PurpleDark
CopyBtn.BorderSizePixel = 0
CopyBtn.Text = "Copy Link"
CopyBtn.TextColor3 = White
CopyBtn.TextSize = 16
CopyBtn.Font = Enum.Font.GothamBold
CopyBtn.AutoButtonColor = false
CopyBtn.Parent = ButtonFrame

local CopyCorner = Instance.new("UICorner")
CopyCorner.CornerRadius = UDim.new(0, 9)
CopyCorner.Parent = CopyBtn

-- Status Label
local Status = Instance.new("TextLabel")
Status.Name = "Status"
Status.Size = UDim2.new(1, -40, 0, 25)
Status.Position = UDim2.new(0, 20, 0, 215)
Status.BackgroundTransparency = 1
Status.Text = ""
Status.TextColor3 = PurpleLight
Status.TextSize = 14
Status.Font = Enum.Font.Gotham
Status.Parent = Main

-- Hover effects
local function AddHover(btn, normal, hover)
	btn.MouseEnter:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.18), {BackgroundColor3 = hover}):Play()
	end)
	btn.MouseLeave:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.18), {BackgroundColor3 = normal}):Play()
	end)
end

AddHover(CheckBtn, PurpleMain, PurpleLight)
AddHover(CopyBtn, PurpleDark, PurpleMain)

-- Button Functions
CheckBtn.MouseButton1Click:Connect(function()
	local input = KeyBox.Text:gsub("%s+", "")
	
	if input == "" then
		Status.Text = "Enter a key first"
		Status.TextColor3 = Color3.fromRGB(255, 100, 100)
		return
	end
	
	if input == VALID_KEY then
		Status.Text = "Key Accepted // Loading Hub..."
		Status.TextColor3 = Color3.fromRGB(100, 255, 140)
		
		-- Fade out and destroy after success
		task.wait(1.2)
		for _, v in pairs(ScreenGui:GetDescendants()) do
			if v:IsA("Frame") or v:IsA("TextLabel") or v:IsA("TextButton") or v:IsA("TextBox") then
				TweenService:Create(v, TweenInfo.new(0.4), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
			end
		end
		task.wait(0.5)
		ScreenGui:Destroy()
		
		-- PUT YOUR MAIN SCRIPT LOAD HERE
		-- loadstring(game:HttpGet("your_script_url"))()
		print("INSANITY HUB LOADED")
	else
		Status.Text = "Invalid Key"
		Status.TextColor3 = Color3.fromRGB(255, 80, 80)
		KeyBox.Text = ""
	end
end)

CopyBtn.MouseButton1Click:Connect(function()
	setclipboard(COPY_LINK)
	Status.Text = "Link Copied to Clipboard"
	Status.TextColor3 = PurpleGlow
	
	task.delay(2, function()
		if Status and Status.Parent then
			Status.Text = ""
		end
	end)
end)

-- Smooth open animation
Main.Size = UDim2.new(0, 0, 0, 0)
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
TweenService:Create(Main, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
	Size = UDim2.new(0, 420, 0, 260),
	Position = UDim2.new(0.5, -210, 0.5, -130)
}):Play()

print("Insanity Hub Key System Loaded")
