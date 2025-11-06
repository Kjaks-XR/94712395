-- Player List UI Script for Roblox
-- Place this in StarterGui as a LocalScript

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")


local fonts = {}; do
	function Register_Font(Name, Weight, Style, Asset)
		if not isfile(Asset.Id) then
			writefile(Asset.Id, Asset.Font)
		end

		if isfile(Name .. ".font") then
			delfile(Name .. ".font")
		end

		local Data = {
			name = Name,
			faces = {
				{
					name = "Regular",
					weight = Weight,
					style = Style,
					assetId = getcustomasset(Asset.Id),
				},
			},
		}

		writefile(Name .. ".font", game:GetService("HttpService"):JSONEncode(Data))

		return getcustomasset(Name .. ".font");
	end

	local ProggyTiny = Register_Font("ProggyTiny", 200, "Normal", {
		Id = "ProggyTiny.ttf",
		Font = game:HttpGet("https://github.com/i77lhm/storage/raw/refs/heads/main/fonts/tahoma_bold.ttf"),
	})

	local ProggyClean = Register_Font("ProggyClean", 200, "normal", {
		Id = "ProggyClean.ttf",
		Font = game:HttpGet("https://github.com/97y1oHW/4991/raw/refs/heads/main/v3/Minecraftia-Regular.ttf")
	})

	fonts = {
		["TahomaBold"] = Font.new(ProggyTiny, Enum.FontWeight.Regular, Enum.FontStyle.Normal);
		["ProggyClean"] = Font.new(ProggyClean, Enum.FontWeight.Regular, Enum.FontStyle.Normal);
	}
end

local fonttobe = fonts["ProggyClean"]


-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PlayerListGui"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- Main Frame (smaller size)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 600, 0, 450)
mainFrame.Position = UDim2.new(0.5, -300, 0.5, -225)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui





-- Add UIStroke to main frame
local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(60, 60, 60)
mainStroke.Thickness = 1
mainStroke.Parent = mainFrame

-- Add UICorner for rounded edges
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 8)
--mainCorner.Parent = mainFrame

-- Make draggable
local dragging = false
local dragInput, mousePos, framePos

mainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		mousePos = input.Position
		framePos = mainFrame.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

mainFrame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input
			.Position - mousePos
		local goal = UDim2.new(
			framePos.X.Scale,
			framePos.X.Offset + delta.X,
			framePos.Y.Scale,
			framePos.Y.Offset + delta.Y
		)
		game:GetService("TweenService"):Create(mainFrame, TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = goal}):Play()
	end
end)

-- Header
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 35)
header.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
header.BorderSizePixel = 0
header.ClipsDescendants = true
header.Parent = mainFrame

-- Round top corners only
local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 8)
headerCorner.Parent = header

-- Fix for bottom corners (add cover frame)
local headerCover = Instance.new("Frame")
headerCover.Size = UDim2.new(1, 0, 0, 8)
headerCover.Position = UDim2.new(0, 0, 1, -8)
headerCover.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
headerCover.BorderSizePixel = 0
headerCover.Parent = header

local headerText = Instance.new("TextLabel")
headerText.Size = UDim2.new(1, -15, 1, 0)
headerText.Position = UDim2.new(0, 15, 0, 0)
headerText.BackgroundTransparency = 1
headerText.Text = "Players"
headerText.TextColor3 = Color3.fromRGB(255, 255, 255)
headerText.TextSize = 18
headerText.FontFace = fonttobe
headerText.TextXAlignment = Enum.TextXAlignment.Left
headerText.TextYAlignment = Enum.TextYAlignment.Center
headerText.Parent = header

-- Blue line under header
local blueLine = Instance.new("Frame")
blueLine.Size = UDim2.new(1, -20, 0, 2)
blueLine.Position = UDim2.new(0, 10, 1, 0)
blueLine.BackgroundColor3 = Color3.fromRGB(74, 158, 255)
blueLine.BorderSizePixel = 0
blueLine.Parent = header

-- Player List Title Frame
local titleFrame = Instance.new("Frame")
titleFrame.Name = "TitleFrame"
titleFrame.Size = UDim2.new(0.95, 0, 0, 50)
titleFrame.Position = UDim2.new(0.025, 0, 0, 50)
titleFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
titleFrame.BorderSizePixel = 0
titleFrame.Parent = mainFrame

local TweenService = game:GetService("TweenService")
local miniBtn = Instance.new("TextButton")
miniBtn.Size = UDim2.new(0,30,0,30)
miniBtn.Position = UDim2.new(1,-30,0,2)
miniBtn.BackgroundTransparency = 1
miniBtn.Text = "−"
miniBtn.TextColor3 = Color3.fromRGB(200,200,200)
miniBtn.Font = Enum.Font.RobotoMono
miniBtn.TextSize = 24
miniBtn.Parent = header

mainFrame.ClipsDescendants = true

local minimized = false
miniBtn.MouseButton1Click:Connect(function()
	minimized = not minimized
	local tween = TweenService:Create(mainFrame, TweenInfo.new(0.25), {
		Size = minimized and UDim2.new(0,200,0,35) or UDim2.new(0,600,0,450)
	})
	tween:Play()
	for _,v in pairs(mainFrame:GetChildren()) do
		if v ~= header then
			v.Visible = not minimized
		end
	end
end)



local titleStroke = Instance.new("UIStroke")
titleStroke.Color = Color3.fromRGB(60, 60, 60)
titleStroke.Thickness = 1
titleStroke.Parent = titleFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 4)
titleCorner.Parent = titleFrame

local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(1, 0, 1, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "Playerlist"
titleText.TextColor3 = Color3.fromRGB(180, 180, 180)
titleText.TextSize = 16
titleText.FontFace = fonttobe
titleText.Parent = titleFrame

-- Scrolling Frame for Players
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Name = "PlayerScroll"
scrollFrame.Size = UDim2.new(0.95, 0, 0, 210)
scrollFrame.Position = UDim2.new(0.025, 0, 0, 110)
scrollFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 4
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(70, 70, 70)
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.Parent = mainFrame

local bar = Instance.new("Frame")
bar.Size = UDim2.new(0,4,0,0)
bar.BackgroundColor3 = Color3.fromRGB(74,158,255)
bar.Parent = scrollFrame

local scrollStroke = Instance.new("UIStroke")
scrollStroke.Color = Color3.fromRGB(60, 60, 60)
scrollStroke.Thickness = 1
scrollStroke.Parent = scrollFrame

local scrollCorner = Instance.new("UICorner")
scrollCorner.CornerRadius = UDim.new(0, 4)
scrollCorner.Parent = scrollFrame

local listLayout = Instance.new("UIListLayout")
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Padding = UDim.new(0, 1)
listLayout.Parent = scrollFrame

-- === REPLACE THE OLD infoFrame SECTION WITH THIS NEW ONE ===

-- NEW: Outer container for double border
local infoContainer = Instance.new("Frame")
infoContainer.Name = "InfoContainer"
infoContainer.Size = UDim2.new(0.95, 0, 0, 90)
infoContainer.Position = UDim2.new(0.025, 0, 0, 330)
infoContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
infoContainer.BorderSizePixel = 0
infoContainer.Parent = mainFrame

-- Outer stroke (first border)
local outerStroke = Instance.new("UIStroke")
outerStroke.Color = Color3.fromRGB(40, 40, 40)  -- darker outer line
outerStroke.Thickness = 2
outerStroke.Parent = infoContainer

-- Outer corner
local glow = Instance.new("ImageLabel", infoContainer)
glow.Name = "GlowEffect"
glow.Image = "rbxassetid://18245826428" -- Glow texture ID
glow.ScaleType = Enum.ScaleType.Stretch
glow.SliceCenter = Rect.new(21, 21, 79, 79)
glow.ImageColor3 = Color3.fromRGB(100, 100, 255) -- Mavi renk
glow.ImageTransparency = 0.54
glow.BackgroundTransparency = 1
glow.Size = UDim2.new(1, 40, 1, 40)
glow.Position = UDim2.new(0, -20, 0, -20)
glow.ZIndex = -1


-- === NOW YOUR ORIGINAL infoFrame becomes the INNER frame ===
local infoFrame = Instance.new("Frame")
infoFrame.Name = "InfoFrame"
infoFrame.Size = UDim2.new(1, -8, 1, -8)        -- slightly smaller
infoFrame.Position = UDim2.new(0, 4, 0, 4)        -- offset inside
infoFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
infoFrame.BorderSizePixel = 0
infoFrame.Parent = infoContainer                 -- parent is now the container!

-- Inner stroke (second border)
local infoStroke = Instance.new("UIStroke")
infoStroke.Color = Color3.fromRGB(60, 60, 60)    -- lighter inner line
infoStroke.Thickness = 1
infoStroke.Parent = infoFrame

local infoCorner = Instance.new("UICorner")
--infoCorner.CornerRadius = UDim.new(0, 4)
--infoCorner.Parent = infoFrame

-- === REST OF YOUR INFO ELEMENTS (avatar, labels, etc.) ===
-- Just keep everything exactly as before, but parent to infoFrame

local infoAvatar = Instance.new("ImageLabel")
infoAvatar.Size = UDim2.new(0, 60, 0, 60)
infoAvatar.Position = UDim2.new(0, 15, 0, 15)
infoAvatar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
infoAvatar.BorderSizePixel = 0
infoAvatar.Image = ""
infoAvatar.Parent = infoFrame

local avatarStroke = Instance.new("UIStroke")
avatarStroke.Color = Color3.fromRGB(45, 45, 45)
avatarStroke.Thickness = 1
avatarStroke.Parent = infoAvatar

local avatarCorner = Instance.new("UICorner")
avatarCorner.CornerRadius = UDim.new(0, 6)
avatarCorner.Parent = infoAvatar

local infoName = Instance.new("TextLabel")
infoName.Size = UDim2.new(0, 400, 0, 25)
infoName.Position = UDim2.new(0, 90, 0, 20)
infoName.BackgroundTransparency = 1
infoName.Text = "Name: xz None"
infoName.TextColor3 = Color3.fromRGB(180, 180, 180)
infoName.TextSize = 14
infoName.FontFace = fonttobe
infoName.TextXAlignment = Enum.TextXAlignment.Left
infoName.Parent = infoFrame

local infoDisplay = Instance.new("TextLabel")
infoDisplay.Size = UDim2.new(0, 400, 0, 25)
infoDisplay.Position = UDim2.new(0, 90, 0, 45)
infoDisplay.BackgroundTransparency = 1
infoDisplay.Text = "DisplayName: spawn"
infoDisplay.TextColor3 = Color3.fromRGB(180, 180, 180)
infoDisplay.TextSize = 14
infoDisplay.FontFace = fonttobe
infoDisplay.TextXAlignment = Enum.TextXAlignment.Left
infoDisplay.Parent = infoFrame

local countLabel = Instance.new("TextLabel")
countLabel.Size = UDim2.new(0,100,1,0)
countLabel.Position = UDim2.new(1,-115,0,0)
countLabel.BackgroundTransparency = 1
countLabel.Text = #Players:GetPlayers().." players"
countLabel.TextColor3 = Color3.fromRGB(120,180,255)
countLabel.FontFace = fonttobe
countLabel.TextSize = 14
countLabel.Parent = header

Players.PlayerAdded:Connect(function() countLabel.Text = #Players:GetPlayers().." players" end)
Players.PlayerRemoving:Connect(function() countLabel.Text = #Players:GetPlayers().." players" end)














-- Variable to track selected player entry
local selectedEntry = nil

-- Function to create player entry
local function createPlayerEntry(plr)
	local entry = Instance.new("Frame")
	entry.Name = plr.Name
	entry.Size = UDim2.new(1, -5, 0, 25)
	entry.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	entry.BorderSizePixel = 0
	entry.Parent = scrollFrame

	local nameLabel = Instance.new("TextLabel")
	nameLabel.Size = UDim2.new(0.7, 0, 1, 0)
	nameLabel.Position = UDim2.new(0, 10, 0, 0)
	nameLabel.BackgroundTransparency = 1
	nameLabel.Text = plr.Name
	nameLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
	nameLabel.TextSize = 14
	nameLabel.FontFace = fonttobe
	nameLabel.TextXAlignment = Enum.TextXAlignment.Left
	nameLabel.Parent = entry

	local statusLabel = Instance.new("TextLabel")
	statusLabel.Size = UDim2.new(0.3, -10, 1, 0)
	statusLabel.Position = UDim2.new(0.7, 0, 0, 0)
	statusLabel.BackgroundTransparency = 1
	statusLabel.Text = "None"
	statusLabel.TextColor3 = Color3.fromRGB(130, 130, 130)
	statusLabel.TextSize = 14
	statusLabel.FontFace = fonttobe
	statusLabel.TextXAlignment = Enum.TextXAlignment.Right
	statusLabel.Parent = entry





	-- Click to select
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(1, 0, 1, 0)
	button.BackgroundTransparency = 1
	button.Text = ""
	button.Parent = entry

	button.MouseButton1Click:Connect(function()
		if selectedEntry and selectedEntry ~= entry then
			local prevLabel = selectedEntry:FindFirstChild("TextLabel")
			if prevLabel then
				game:GetService("TweenService"):Create(prevLabel, TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
					TextColor3 = Color3.fromRGB(130, 130, 130)
				}):Play();
			end;
		end;

		selectedEntry = entry;
		game:GetService("TweenService"):Create(nameLabel, TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
			TextColor3 = Color3.fromRGB(90, 170, 255)
		}):Play();

		local shine = Instance.new("ImageLabel");
		shine.Size = UDim2.new(1, 0, 1, 0);
		shine.Position = UDim2.new(0, 0, 0, 0);
		shine.BackgroundTransparency = 1;
		shine.Image = "rbxassetid://11968229606"; -- hafif parıltı efekti
		shine.ImageTransparency = 0.8;
		shine.ZIndex = 10;
		shine.Parent = entry;

		game:GetService("TweenService"):Create(shine, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			ImageTransparency = 0.3
		}):Play();
		task.delay(0.25, function()
			game:GetService("TweenService"):Create(shine, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				ImageTransparency = 1
			}):Play();
			game.Debris:AddItem(shine, 0.45);
		end);

		game:GetService("TweenService"):Create(entry, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
			BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		}):Play();
		task.delay(0.25, function()
			game:GetService("TweenService"):Create(entry, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
				BackgroundColor3 = Color3.fromRGB(35, 35, 35)
			}):Play();
		end);

		local fadeOut = game:GetService("TweenService"):Create(infoName, TweenInfo.new(0.12), {TextTransparency = 1});
		local fadeOut2 = game:GetService("TweenService"):Create(infoDisplay, TweenInfo.new(0.12), {TextTransparency = 1});
		local fadeOutAvatar = game:GetService("TweenService"):Create(infoAvatar, TweenInfo.new(0.12), {ImageTransparency = 1});

		fadeOut:Play(); fadeOut2:Play(); fadeOutAvatar:Play();

		fadeOut.Completed:Connect(function()
			infoName.Text = "Name: " .. plr.Name .. " None";
			infoDisplay.Text = "DisplayName: " .. plr.DisplayName;

			local content = Players:GetUserThumbnailAsync(plr.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150);
			infoAvatar.Image = content;

			game:GetService("TweenService"):Create(infoName, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play();
			game:GetService("TweenService"):Create(infoDisplay, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play();
			game:GetService("TweenService"):Create(infoAvatar, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {ImageTransparency = 0}):Play();
		end);
	end);

	button.MouseEnter:Connect(function()
		if selectedEntry ~= entry then
			game:GetService("TweenService"):Create(entry, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
				BackgroundColor3 = Color3.fromRGB(45, 45, 45)
			}):Play();
		end;
	end);

	button.MouseLeave:Connect(function()
		if selectedEntry ~= entry then
			game:GetService("TweenService"):Create(entry, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
				BackgroundColor3 = Color3.fromRGB(35, 35, 35)
			}):Play();
		end;
	end);











	return entry
end

-- Update canvas size

local function updateCanvasSize()
	local contentSize = listLayout.AbsoluteContentSize
	scrollFrame.CanvasSize = UDim2.new(0, 0, 0, contentSize.Y + 5)
end

-- Add all current players
for _, plr in ipairs(Players:GetPlayers()) do
	createPlayerEntry(plr)
end


updateCanvasSize()

local search = Instance.new("TextBox")
search.Size = UDim2.new(0.9,0,0,28)
search.Position = UDim2.new(0.05,0,0,70)
search.PlaceholderText = "Search player..."
search.Text = ""
search.BackgroundColor3 = Color3.fromRGB(35,35,35)
search.TextColor3 = Color3.fromRGB(220,220,220)
search.FontFace = fonttobe
search.Parent = mainFrame
local sCorner = Instance.new("UICorner",search); sCorner.CornerRadius = UDim.new(0,1)
local sStroke = Instance.new("UIStroke",search); sStroke.Color = Color3.fromRGB(12, 12, 12)


search:GetPropertyChangedSignal("Text"):Connect(function()
	local txt = search.Text:lower()
	for _,entry in pairs(scrollFrame:GetChildren()) do
		if entry:IsA("Frame") then
			entry.Visible = entry.Name:lower():find(txt) ~= nil
		end
	end
	updateCanvasSize()
end)







scrollFrame:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
	local ratio = scrollFrame.CanvasPosition.Y / (scrollFrame.AbsoluteCanvasSize.Y - scrollFrame.AbsoluteSize.Y)
	bar.Size = UDim2.new(0,4,0,math.max(20, scrollFrame.AbsoluteSize.Y * (scrollFrame.AbsoluteSize.Y / scrollFrame.AbsoluteCanvasSize.Y)))
	bar.Position = UDim2.new(1,-6,0,ratio * (scrollFrame.AbsoluteSize.Y - bar.AbsoluteSize.Y))
	game:GetService("TweenService"):Create(bar, TweenInfo.new(0.15), {BackgroundTransparency = 0}):Play()
	task.delay(1,function() game:GetService("TweenService"):Create(bar,TweenInfo.new(0.3),{BackgroundTransparency=0.6}):Play() end)
end)






-- Set initial info to first player and select it
if #Players:GetPlayers() > 0 then
	local firstPlayer = Players:GetPlayers()[1]
	local firstEntry = scrollFrame:FindFirstChild(firstPlayer.Name)
	if firstEntry then
		selectedEntry = firstEntry
		local nameLabel = firstEntry:FindFirstChild("TextLabel")
		if nameLabel then
			nameLabel.TextColor3 = Color3.fromRGB(74, 158, 255)
		end
	end
	infoName.Text = "Name: " .. firstPlayer.Name .. " None"
	infoDisplay.Text = "DisplayName: " .. firstPlayer.DisplayName
	local userId = firstPlayer.UserId
	local thumbType = Enum.ThumbnailType.HeadShot
	local thumbSize = Enum.ThumbnailSize.Size150x150
	local content = Players:GetUserThumbnailAsync(userId, thumbType, thumbSize)
	infoAvatar.Image = content
end

-- Listen for new players
Players.PlayerAdded:Connect(function(plr)
	createPlayerEntry(plr)
	updateCanvasSize()
end)

-- Listen for players leaving
Players.PlayerRemoving:Connect(function(plr)
	local entry = scrollFrame:FindFirstChild(plr.Name)
	if entry then
		entry:Destroy()
		updateCanvasSize()
	end
end)



-- Update canvas size when layout changes
listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvasSize)





workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(resize)


print("Player List UI loaded successfully")

