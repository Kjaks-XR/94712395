if not LPH_OBFUSCATED then
LPH_JIT = function(...) return ... end;
LPH_JIT_MAX = function(...) return ... end;
LPH_JIT_ULTRA = function(...) return ... end;
LPH_NO_VIRTUALIZE = function(...) return ... end;
LPH_ENCSTR = function(...) return ... end;
LPH_STRENC = function(...) return ... end;
LRM_INIT_SCRIPT = function(callback)
    if type(callback) == "function" then
        callback()
    end
end
LPH_HOOK_FIX = function(...) return ... end;
LPH_CRASH = function() return print(debug.traceback()) end;
end;

if LPH_OBFUSCATED then

warn("Library Optimization ON")
else
print("nun opt")

end





local InputService = game:GetService('UserInputService');
local TextService = game:GetService('TextService');
local CoreGui = game:GetService('CoreGui');
local Teams = game:GetService('Teams');
local Players = game:GetService('Players');
local RunService = game:GetService('RunService')
local TweenService = game:GetService('TweenService');
local RenderStepped = RunService.RenderStepped;
local LocalPlayer = Players.LocalPlayer;
local Mouse = LocalPlayer:GetMouse();
local version = "0.5XX - OPT"
warn("Current Version Of Lib: "..version)
local ProtectGui = protectgui or (syn and syn.protect_gui) or (function() end);






local fonts = {}
do
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
        Font = game:HttpGet("https://github.com/Kjaks-XR/94712395/raw/refs/heads/main/Minecraftia-Regular.ttf")
    })

    local PIXY = Register_Font("PIXY", 200, "normal", {
        Id = "PIXY.ttf",
        Font = game:HttpGet("https://github.com/Kjaks-XR/94712395/raw/refs/heads/main/PIXY.ttf")
    })

    fonts = {
        ["TahomaBold"] = Font.new(ProggyTiny, Enum.FontWeight.Regular, Enum.FontStyle.Normal);
        ["ProggyClean"] = Font.new(ProggyClean, Enum.FontWeight.Regular, Enum.FontStyle.Normal);
        ["PIXY"] = Font.new(PIXY, Enum.FontWeight.Regular, Enum.FontStyle.Normal);
    }
    
    -- Validate fonts loaded correctly
    if not fonts["ProggyClean"] or typeof(fonts["ProggyClean"]) ~= "Font" then
        warn("⚠️ Font loading failed Using Enum.Font as fallback")
        fonts["ProggyClean"] = Enum.Font.Code
    end
end





local function intro()

wait(2)
local TweenService = game:GetService("TweenService")
local CoreGuiService = game:GetService("CoreGui")

local TweenTable = {
	Default = TweenInfo.new(0.17, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false, 0),
	Smooth = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0),
	Bounce = TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0),
	Fast = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, false, 0),
	Premium = TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut, 0, false, 0),
	Elegant = TweenInfo.new(1.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0)
}

local CreateTween = function(name, speed, style, direction, loop, reverse, delay)
	speed = speed or 0.17
	style = style or Enum.EasingStyle.Sine
	direction = direction or Enum.EasingDirection.InOut
	loop = loop or 0
	reverse = reverse or false
	delay = delay or 0

	TweenTable[name] = TweenInfo.new(speed, style, direction, loop, reverse, delay)
end

CreateTween("xsxRotation", 0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

local introduction = Instance.new("ScreenGui")
local edge = Instance.new("Frame")
local edgeCorner = Instance.new("UICorner")
local background = Instance.new("Frame")
local backgroundGradient = Instance.new("UIGradient")
local backgroundCorner = Instance.new("UICorner")
local barFolder = Instance.new("Folder")
local bar = Instance.new("Frame")
local barCorner = Instance.new("UICorner")
local barLayout = Instance.new("UIListLayout")
local xsxLogo = Instance.new("ImageLabel")
local xsx = Instance.new("TextLabel")
local text = Instance.new("TextLabel")
local pageLayout = Instance.new("UIListLayout")
local n3TextLabel = Instance.new("TextLabel")
local specialEditionBadge = Instance.new("TextLabel")

local soundintro = Instance.new("Sound")
soundintro.SoundId = "rbxassetid://9788118106"
soundintro.Volume = 1
soundintro:Play()

introduction.Name = "introduction"
introduction.Parent = CoreGuiService
introduction.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

edge.Name = "edge"
edge.Parent = introduction
edge.AnchorPoint = Vector2.new(0.5, 0.5)
edge.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
edge.BackgroundTransparency = 1
edge.BorderSizePixel = 0
edge.Position = UDim2.new(0.5, 0, 0.5, 0)
edge.Size = UDim2.new(0, 320, 0, 340)

edgeCorner.CornerRadius = UDim.new(0, 8)
edgeCorner.Name = "edgeCorner"
edgeCorner.Parent = edge

-- Clean single glow layer for premium feel
local glowInner = Instance.new("ImageLabel", edge)
glowInner.Name = "GlowInner"
glowInner.Image = "rbxassetid://18245826428"
glowInner.ScaleType = Enum.ScaleType.Slice
glowInner.SliceCenter = Rect.new(10, 10, 60, 60)
glowInner.ImageColor3 = Color3.fromRGB(180, 140, 255)
glowInner.ImageTransparency = 0.5
glowInner.BackgroundTransparency = 1
glowInner.Size = UDim2.new(1, 40, 1, 40)
glowInner.Position = UDim2.new(0, -20, 0, -20)
glowInner.ZIndex = -0.5

-- Refined particle effect - fewer but more elegant
local particlesFrame = Instance.new("Frame", background)
particlesFrame.Name = "ParticlesFrame"
particlesFrame.BackgroundTransparency = 1
particlesFrame.Size = UDim2.new(1, 0, 1, 0)
particlesFrame.ClipsDescendants = true
particlesFrame.ZIndex = 10

local function createParticle()
	local particle = Instance.new("Frame", particlesFrame)
	particle.BackgroundColor3 = Color3.fromRGB(180, 140, 255)
	particle.BackgroundTransparency = 0.7
	particle.BorderSizePixel = 0
	particle.Size = UDim2.new(0, math.random(1, 2), 0, math.random(1, 2))
	particle.Position = UDim2.new(math.random(), 0, 1.2, 0)
	
	local corner = Instance.new("UICorner", particle)
	corner.CornerRadius = UDim.new(1, 0)
	
	local duration = math.random(5, 8)
	local targetY = -0.2
	local targetX = particle.Position.X.Scale + (math.random(-20, 20) / 100)
	
	TweenService:Create(particle, TweenInfo.new(duration, Enum.EasingStyle.Linear), {
		Position = UDim2.new(targetX, 0, targetY, 0),
		BackgroundTransparency = 1
	}):Play()
	
	game:GetService("Debris"):AddItem(particle, duration)
end

task.spawn(function()
	for i = 1, 20 do
		createParticle()
		wait(0.15)
	end
end)

-- Smooth subtle pulse
local function SmoothPulse()
	local infoPulse = TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
	TweenService:Create(glowInner, infoPulse, { ImageTransparency = 0.3 }):Play()
end

task.spawn(SmoothPulse)

background.Name = "background"
background.Parent = edge
background.AnchorPoint = Vector2.new(0.5, 0.5)
background.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
background.BackgroundTransparency = 1
background.BorderSizePixel = 0
background.ClipsDescendants = true
background.Position = UDim2.new(0.5, 0, 0.5, 0)
background.Size = UDim2.new(0, 316, 0, 336)

-- Ultra-premium dark gradient
backgroundGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(12, 10, 20)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(28, 20, 45)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 14, 30))
}
backgroundGradient.Rotation = 135
backgroundGradient.Name = "backgroundGradient"
backgroundGradient.Parent = background

-- Smooth rotating gradient
task.spawn(function()
	while background.Parent do
		for i = 135, 495, 0.5 do
			if not background.Parent then break end
			backgroundGradient.Rotation = i
			wait(0.15)
		end
	end
end)

backgroundCorner.CornerRadius = UDim.new(0, 8)
backgroundCorner.Name = "backgroundCorner"
backgroundCorner.Parent = background

-- Elegant scanline with minimal opacity
local scanline = Instance.new("Frame", background)
scanline.Name = "Scanline"
scanline.BackgroundColor3 = Color3.fromRGB(180, 140, 255)
scanline.BackgroundTransparency = 0.95
scanline.BorderSizePixel = 0
scanline.Size = UDim2.new(1, 0, 0, 0.5)
scanline.Position = UDim2.new(0, 0, 0, 0)
scanline.ZIndex = 5

task.spawn(function()
	while scanline.Parent do
		TweenService:Create(scanline, TweenInfo.new(3, Enum.EasingStyle.Linear), {
			Position = UDim2.new(0, 0, 1, 0)
		}):Play()
		wait(3)
		scanline.Position = UDim2.new(0, 0, 0, 0)
		wait(0.4)
	end
end)

barFolder.Name = "barFolder"
barFolder.Parent = background

-- Premium progress bar
bar.Name = "bar"
bar.Parent = barFolder
bar.BackgroundColor3 = Color3.fromRGB(180, 140, 255)
bar.BackgroundTransparency = 0
bar.Size = UDim2.new(0, 0, 0, 2)

-- Sophisticated shimmer
local barShimmer = Instance.new("Frame", bar)
barShimmer.Name = "Shimmer"
barShimmer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
barShimmer.BackgroundTransparency = 0.4
barShimmer.BorderSizePixel = 0
barShimmer.Size = UDim2.new(0, 100, 1, 0)
barShimmer.Position = UDim2.new(0, 0, 0, 0)

local shimmerGradient = Instance.new("UIGradient", barShimmer)
shimmerGradient.Transparency = NumberSequence.new{
	NumberSequenceKeypoint.new(0, 1),
	NumberSequenceKeypoint.new(0.5, 0.1),
	NumberSequenceKeypoint.new(1, 1)
}

barCorner.CornerRadius = UDim.new(0, 1)
barCorner.Name = "barCorner"
barCorner.Parent = bar

barLayout.Name = "barLayout"
barLayout.Parent = barFolder
barLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
barLayout.SortOrder = Enum.SortOrder.LayoutOrder

xsxLogo.Name = "xsxLogo"
xsxLogo.Parent = background
xsxLogo.AnchorPoint = Vector2.new(0.5, 0.5)
xsxLogo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
xsxLogo.BackgroundTransparency = 1
xsxLogo.Position = UDim2.new(0.5, 0, 0.5, 0)
xsxLogo.Size = UDim2.new(0, 448, 0, 150)
xsxLogo.Visible = true
xsxLogo.ImageColor3 = Color3.fromRGB(180, 140, 255)
xsxLogo.ImageTransparency = 1

xsx.Name = "xsx"
xsx.Parent = background
xsx.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
xsx.BackgroundTransparency = 1
xsx.Position = UDim2.new(0, 10, 0, 5)
xsx.Size = UDim2.new(0, 120, 0, 21)
xsx.FontFace = fonts["ProggyClean"]
xsx.Text = "XWARE V3.4B"
xsx.TextColor3 = Color3.fromRGB(180, 140, 255)
xsx.TextSize = 11
xsx.TextTransparency = 1
xsx.TextXAlignment = Enum.TextXAlignment.Left

text.Name = "text"
text.Parent = background
text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
text.BackgroundTransparency = 1
text.Position = UDim2.new(1, -40, 0, 5)
text.Size = UDim2.new(0, 30, 0, 21)
text.FontFace = fonts["ProggyClean"]
text.Text = "PRIME"
text.TextColor3 = Color3.fromRGB(255, 190, 70)
text.TextSize = 11
text.TextTransparency = 1
text.RichText = true
text.TextXAlignment = Enum.TextXAlignment.Right

n3TextLabel.Name = "n3TextLabel"
n3TextLabel.Parent = background
n3TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
n3TextLabel.BackgroundTransparency = 1
n3TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
n3TextLabel.Position = UDim2.new(0.50, 0, 0.4, 0)
n3TextLabel.Size = UDim2.new(0, 200, 0, 100)
n3TextLabel.FontFace = fonts["ProggyClean"]
n3TextLabel.Text = "<b><font size=\"70\">X</font><font color=\"rgb(180, 140, 255)\"><font size=\"70\">3</font></font></b>"
n3TextLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
n3TextLabel.TextSize = 70
n3TextLabel.TextTransparency = 1
n3TextLabel.TextScaled = true
n3TextLabel.RichText = true

-- Premium badge with minimal design
specialEditionBadge.Name = "SpecialEditionBadge"
specialEditionBadge.Parent = background
specialEditionBadge.BackgroundColor3 = Color3.fromRGB(25, 18, 40)
specialEditionBadge.BackgroundTransparency = 0.8
specialEditionBadge.Position = UDim2.new(0.5, -80, 0.58, 0)
specialEditionBadge.Size = UDim2.new(0, 160, 0, 22)
specialEditionBadge.FontFace = fonts["ProggyClean"]
specialEditionBadge.Text = "B SERIES"
specialEditionBadge.TextColor3 = Color3.fromRGB(180, 140, 255)
specialEditionBadge.TextSize = 9
specialEditionBadge.TextTransparency = 1


local badgeCorner = Instance.new("UICorner", specialEditionBadge)
badgeCorner.CornerRadius = UDim.new(0, 5)

local badgeStroke = Instance.new("UIStroke", specialEditionBadge)
badgeStroke.Color = Color3.fromRGB(180, 140, 255)
badgeStroke.Thickness = 1
badgeStroke.Transparency = 1

-- Elegant dots instead of emojis
local badgeDotLeft = Instance.new("TextLabel", specialEditionBadge)
badgeDotLeft.BackgroundTransparency = 1
badgeDotLeft.Position = UDim2.new(0, -8, 0.5, -3)
badgeDotLeft.Size = UDim2.new(0, 6, 0, 6)
badgeDotLeft.Text = ""
badgeDotLeft.TextColor3 = Color3.fromRGB(255, 190, 70)
badgeDotLeft.TextSize = 10
badgeDotLeft.TextTransparency = 1
badgeDotLeft.FontFace = fonts["ProggyClean"]

local badgeDotRight = Instance.new("TextLabel", specialEditionBadge)
badgeDotRight.BackgroundTransparency = 1
badgeDotRight.Position = UDim2.new(1, 2, 0.5, -3)
badgeDotRight.Size = UDim2.new(0, 6, 0, 6)
badgeDotRight.Text = ""
badgeDotRight.TextColor3 = Color3.fromRGB(255, 190, 70)
badgeDotRight.TextSize = 10
badgeDotRight.TextTransparency = 1
badgeDotRight.FontFace = fonts["ProggyClean"]

-- Blinking cursor
task.spawn(function()
	local states = {'XWARE V3.4 B', 'XWARE V3.4 B_'}
	local index = 1
	while xsx.Parent do
		wait(0.6)
		if xsx.Parent then
			xsx.Text = states[index]
			index = index % 2 + 1
		end
	end
end)

pageLayout.Name = "pageLayout"
pageLayout.Parent = introduction
pageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
pageLayout.SortOrder = Enum.SortOrder.LayoutOrder
pageLayout.VerticalAlignment = Enum.VerticalAlignment.Center

-- Terminal frame
local terminalTextFrame = Instance.new("Frame")
terminalTextFrame.Name = "terminalTextFrame"
terminalTextFrame.Parent = background
terminalTextFrame.BackgroundTransparency = 1
terminalTextFrame.Position = UDim2.new(0.5, -130, 0.68, 0)
terminalTextFrame.Size = UDim2.new(0, 260, 0, 80)
terminalTextFrame.ClipsDescendants = true

local terminalTextLayout = Instance.new("UIListLayout")
terminalTextLayout.Name = "terminalTextLayout"
terminalTextLayout.Parent = terminalTextFrame
terminalTextLayout.SortOrder = Enum.SortOrder.LayoutOrder
terminalTextLayout.Padding = UDim.new(0, 3)

local function addTerminalLine(textContent, color)
	local newText = Instance.new("TextLabel")
	newText.Parent = terminalTextFrame
	newText.BackgroundTransparency = 1
	newText.FontFace = fonts["ProggyClean"]
	newText.Text = textContent
	newText.TextColor3 = color or Color3.fromRGB(200, 160, 255)
	newText.TextSize = 9
	newText.TextTransparency = 1
	newText.Size = UDim2.new(1, 0, 0, 10)
	newText.TextXAlignment = Enum.TextXAlignment.Left
	
	TweenService:Create(newText, TweenTable["Fast"], {TextTransparency = 0}):Play()

	coroutine.wrap(function()
		wait(3.2)
		TweenService:Create(newText, TweenTable["Fast"], {TextTransparency = 1}):Play()
		wait(0.4)
		newText:Destroy()
	end)()
end

local terminalLines = {
	{text = "[ LDR ] Initializing libraries...", color = Color3.fromRGB(123, 140, 255)};

	{text = "[ SYS ] Mounting metatable (setmetatable)...", color = Color3.fromRGB(255, 190, 100)};
	{text = "[ SYS ] Allocating memory blocks...", color = Color3.fromRGB(255, 190, 100)};
	{text = "[ SYS ] Registering runtime handlers...", color = Color3.fromRGB(255, 190, 100)};

	{text = "[ CFG ] Loading environment variables...", color = Color3.fromRGB(200, 160, 255)};
	{text = "[ CFG ] Applying configuration policies...", color = Color3.fromRGB(200, 160, 255)};
	--{text = "[ CFG ] Syncing persistent states...", color = Color3.fromRGB(200, 160, 255)};

	--{text = "[ NET ] Establishing internal communication channel...", color = Color3.fromRGB(120, 200, 255)};
	--{text = "[ NET ] Resolving gateway routes...", color = Color3.fromRGB(120, 200, 255)};
	{text = "[ NET ] Luarmor Webhook.", color = Color3.fromRGB(120, 200, 255)};

	{text = "[ SEC ] Authenticating runtime context...", color = Color3.fromRGB(255, 140, 140)};
	{text = "[ SEC ] Validating Key", color = Color3.fromRGB(255, 140, 140)};
	--{text = "[ SEC ] Secure session active.", color = Color3.fromRGB(255, 140, 140)};

	{text = "[ FRM ] Framework verified", color = Color3.fromRGB(110, 255, 180)};
	{text = "[ LDR  ] Done.", color = Color3.fromRGB(123, 140, 255)};
};


coroutine.wrap(function()
	for _, line in ipairs(terminalLines) do
		addTerminalLine(line.text, line.color)
		wait(0.45)
	end
end)()

-- Logo rotation
local RotationSpeed = -20
coroutine.wrap(function()
	while xsxLogo.Parent do
		RotationSpeed = RotationSpeed + 0.3
		xsxLogo.Rotation = xsxLogo.Rotation - RotationSpeed * 0.1
		wait()
	end
end)()

-- Entrance animations - refined timing
TweenService:Create(edge, TweenTable["Elegant"], {BackgroundTransparency = 0}):Play()
TweenService:Create(background, TweenTable["Elegant"], {BackgroundTransparency = 0}):Play()
wait(0.5)

-- Bar animation
TweenService:Create(bar, TweenTable["Premium"], {Size = UDim2.new(0, 316, 0, 2)}):Play()
task.spawn(function()
	wait(0.4)
	TweenService:Create(barShimmer, TweenInfo.new(1, Enum.EasingStyle.Linear), {
		Position = UDim2.new(1, 0, 0, 0)
	}):Play()
end)

wait(0.5)
TweenService:Create(xsx, TweenTable["Bounce"], {TextTransparency = 0}):Play()
wait(0.2)
TweenService:Create(text, TweenTable["Bounce"], {TextTransparency = 0}):Play()
wait(0.3)
TweenService:Create(n3TextLabel, TweenTable["Bounce"], {TextTransparency = 0}):Play()
wait(0.25)
TweenService:Create(specialEditionBadge, TweenTable["Bounce"], {TextTransparency = 0}):Play()
TweenService:Create(badgeStroke, TweenTable["Bounce"], {Transparency = 0.3}):Play()
TweenService:Create(badgeDotLeft, TweenTable["Bounce"], {TextTransparency = 0}):Play()
TweenService:Create(badgeDotRight, TweenTable["Bounce"], {TextTransparency = 0}):Play()

-- Badge subtle pulse
task.spawn(function()
	wait(1.5)
	while specialEditionBadge.Parent do
		TweenService:Create(specialEditionBadge, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			TextColor3 = Color3.fromRGB(210, 180, 255)
		}):Play()
		TweenService:Create(badgeDotLeft, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			TextColor3 = Color3.fromRGB(255, 210, 80)
		}):Play()
		TweenService:Create(badgeDotRight, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			TextColor3 = Color3.fromRGB(255, 210, 80)
		}):Play()
		wait(1.5)
		TweenService:Create(specialEditionBadge, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			TextColor3 = Color3.fromRGB(180, 140, 255)
		}):Play()
		TweenService:Create(badgeDotLeft, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			TextColor3 = Color3.fromRGB(255, 190, 70)
		}):Play()
		TweenService:Create(badgeDotRight, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			TextColor3 = Color3.fromRGB(255, 190, 70)
		}):Play()
		wait(1.5)
	end
end)

wait(0.5)
TweenService:Create(xsxLogo, TweenTable["Bounce"], {ImageTransparency = 0}):Play()

-- Hold for impact
wait(5.24)

-- Exit animations
TweenService:Create(xsxLogo, TweenTable["Premium"], {
	ImageTransparency = 1,
	Rotation = xsxLogo.Rotation + 180
}):Play()
wait(0.25)
TweenService:Create(specialEditionBadge, TweenTable["Fast"], {TextTransparency = 1}):Play()
TweenService:Create(badgeStroke, TweenTable["Fast"], {Transparency = 1}):Play()
wait(0.2)
TweenService:Create(n3TextLabel, TweenTable["Fast"], {TextTransparency = 1}):Play()
wait(0.2)
TweenService:Create(text, TweenTable["Fast"], {TextTransparency = 1}):Play()
wait(0.2)
TweenService:Create(xsx, TweenTable["Fast"], {TextTransparency = 1}):Play()
wait(0.25)
TweenService:Create(bar, TweenTable["Premium"], {Size = UDim2.new(0, 0, 0, 2)}):Play()
wait(0.3)
TweenService:Create(background, TweenTable["Premium"], {BackgroundTransparency = 1}):Play()
TweenService:Create(edge, TweenTable["Premium"], {BackgroundTransparency = 1}):Play()
TweenService:Create(glowInner, TweenTable["Premium"], {ImageTransparency = 1}):Play()
wait(0.5)
introduction:Destroy()

end

chancegsdsf = math.random(1,2)
chanchefef2 = math.random(1,3)

if chanchefef2 == chancegsdsf then
	intro()
end














local ScreenGui = Instance.new('ScreenGui');
ProtectGui(ScreenGui);

ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global;
ScreenGui.Parent = CoreGui;

local Toggles = {};
local Options = {};

getgenv().Toggles = Toggles;
getgenv().Options = Options;

local Library = {
    Registry = {};
    RegistryMap = {};

    HudRegistry = {};
    InactiveColor = Color3.fromRGB(60, 60, 60),
    InactiveColorDark =  Color3.fromRGB(60, 60, 60),
    FontColor = Color3.fromRGB(255, 255, 255);
    MainColor = Color3.fromRGB(28, 28, 28);
    BackgroundColor = Color3.fromRGB(42, 42, 42);
    AccentColor = Color3.fromRGB(219, 101, 75);
    OutlineColor = Color3.fromRGB(50, 50, 50);
    RiskColor = Color3.fromRGB(255, 50, 50),
    Black = Color3.new(0, 0, 0);
    Font = fonts["ProggyClean"],  -- Use your custom font

    OpenedFrames = {};
    DependencyBoxes = {};

    Signals = {};
    ScreenGui = ScreenGui;
};


local RainbowStep = 0
local Hue = 0

table.insert(Library.Signals, RenderStepped:Connect(LPH_NO_VIRTUALIZE(function(Delta)
    RainbowStep = RainbowStep + Delta

    if RainbowStep >= (1 / 60) then
        RainbowStep = 0

        Hue = Hue + (1 / 400);

        if Hue > 1 then
            Hue = 0;
        end;

        Library.CurrentRainbowHue = Hue;
        Library.CurrentRainbowColor = Color3.fromHSV(Hue, 0.8, 1);
    end
end)))

local function GetPlayersString()
    local PlayerList = Players:GetPlayers();

    for i = 1, #PlayerList do
        PlayerList[i] = PlayerList[i].Name;
    end;

    table.sort(PlayerList, function(str1, str2) return str1 < str2 end);

    return PlayerList;
end;

local function GetTeamsString()
    local TeamList = Teams:GetTeams();

    for i = 1, #TeamList do
        TeamList[i] = TeamList[i].Name;
    end;

    table.sort(TeamList, function(str1, str2) return str1 < str2 end);
    
    return TeamList;
end;

function Library:SafeCallback(f, ...)
    if (not f) then
        return;
    end;

    if not Library.NotifyOnError then
        return f(...);
    end;

    local success, event = pcall(f, ...);

    if not success then
        local _, i = event:find(":%d+: ");

        if not i then
            return Library:Notify(event);
        end;

        return Library:Notify(event:sub(i + 1), 3);
    end;
end;

function Library:AttemptSave()
    if Library.SaveManager then
        Library.SaveManager:Save();
    end;
end;

function Library:Create(Class, Properties)
    local _Instance = Class;

    if type(Class) == 'string' then
        _Instance = Instance.new(Class);
    end;

    for Property, Value in next, Properties do
        _Instance[Property] = Value;
    end;

    return _Instance;
end;

function Library:ApplyTextStroke(Inst)
    Inst.TextStrokeTransparency = 1;

    Library:Create('UIStroke', {
        Color = Color3.new(0, 0, 0);
        Thickness = 1;
        LineJoinMode = Enum.LineJoinMode.Miter;
        Parent = Inst;
    });
end;

function Library:CreateLabel(Properties, IsHud)
    local _Instance = Library:Create('TextLabel', {
        BackgroundTransparency = 1;
        FontFace = Library.Font;  -- Changed from Font to FontFace
        TextColor3 = Library.FontColor;
        TextSize = 11;
        TextStrokeTransparency = 0;
    });

    Library:ApplyTextStroke(_Instance);

    Library:AddToRegistry(_Instance, {
        TextColor3 = 'FontColor';
    }, IsHud);

    return Library:Create(_Instance, Properties);
end;

function Library:MakeDraggable(Instance, Cutoff)
    Instance.Active = true;
    local dragging = false
    local dragInput, dragStart, startPos
    
    Instance.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
            local ObjPos = Vector2.new(
                Mouse.X - Instance.AbsolutePosition.X,
                Mouse.Y - Instance.AbsolutePosition.Y
            );
            if ObjPos.Y > (Cutoff or 40) then
                return;
            end;
            
            dragging = true
            dragStart = Input.Position
            startPos = Instance.Position
            
            -- Capture the input to prevent other interactions
            Input.Changed:Connect(function()
                if Input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end;
    end)
    
    Instance.InputChanged:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = Input
        end
    end)
    
    InputService.InputChanged:Connect(function(Input)
        if Input == dragInput and dragging then
            local delta = Input.Position - dragStart
            Instance.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end


function Library:AddToolTip(InfoStr, HoverInstance)
    local X, Y = Library:GetTextBounds(InfoStr, Library.Font, 14);
    local Tooltip = Library:Create('Frame', {
        BackgroundColor3 = Library.MainColor,
        BorderColor3 = Library.OutlineColor,

        Size = UDim2.fromOffset(X + 5, Y + 4),
        ZIndex = 100,
        Parent = Library.ScreenGui,

        Visible = false,
    })

    local Label = Library:CreateLabel({
        Position = UDim2.fromOffset(3, 1),
        Size = UDim2.fromOffset(X, Y);
        TextSize = 11;
        Text = InfoStr,
        TextColor3 = Library.FontColor,
        TextXAlignment = Enum.TextXAlignment.Left;
        ZIndex = Tooltip.ZIndex + 1,

        Parent = Tooltip;
    });

    Library:AddToRegistry(Tooltip, {
        BackgroundColor3 = 'MainColor';
        BorderColor3 = 'OutlineColor';
    });

    Library:AddToRegistry(Label, {
        TextColor3 = 'FontColor',
    });

    local IsHovering = false

    HoverInstance.MouseEnter:Connect(function()
        if Library:MouseIsOverOpenedFrame() then
            return
        end

        IsHovering = true

        Tooltip.Position = UDim2.fromOffset(Mouse.X + 15, Mouse.Y + 12)
        Tooltip.Visible = true

        while IsHovering do
            RunService.Heartbeat:Wait()
            Tooltip.Position = UDim2.fromOffset(Mouse.X + 15, Mouse.Y + 12)
        end
    end)

    HoverInstance.MouseLeave:Connect(function()
        IsHovering = false
        Tooltip.Visible = false
    end)
end

function Library:OnHighlight(HighlightInstance, Instance, Properties, PropertiesDefault)
    HighlightInstance.MouseEnter:Connect(function()
        local Reg = Library.RegistryMap[Instance];

        for Property, ColorIdx in next, Properties do
            Instance[Property] = Library[ColorIdx] or ColorIdx;

            if Reg and Reg.Properties[Property] then
                Reg.Properties[Property] = ColorIdx;
            end;
        end;
    end)

    HighlightInstance.MouseLeave:Connect(function()
        local Reg = Library.RegistryMap[Instance];

        for Property, ColorIdx in next, PropertiesDefault do
            Instance[Property] = Library[ColorIdx] or ColorIdx;

            if Reg and Reg.Properties[Property] then
                Reg.Properties[Property] = ColorIdx;
            end;
        end;
    end)
end;

function Library:MouseIsOverOpenedFrame()
    for Frame, _ in next, Library.OpenedFrames do
        local AbsPos, AbsSize = Frame.AbsolutePosition, Frame.AbsoluteSize;

        if Mouse.X >= AbsPos.X and Mouse.X <= AbsPos.X + AbsSize.X
            and Mouse.Y >= AbsPos.Y and Mouse.Y <= AbsPos.Y + AbsSize.Y then

            return true;
        end;
    end;
end;

function Library:IsMouseOverFrame(Frame)
    local AbsPos, AbsSize = Frame.AbsolutePosition, Frame.AbsoluteSize;

    if Mouse.X >= AbsPos.X and Mouse.X <= AbsPos.X + AbsSize.X
        and Mouse.Y >= AbsPos.Y and Mouse.Y <= AbsPos.Y + AbsSize.Y then

        return true;
    end;
end;

function Library:UpdateDependencyBoxes()
    for _, Depbox in next, Library.DependencyBoxes do
        Depbox:Update();
    end;
end;

function Library:MapValue(Value, MinA, MaxA, MinB, MaxB)
    return (1 - ((Value - MinA) / (MaxA - MinA))) * MinB + ((Value - MinA) / (MaxA - MinA)) * MaxB;
end;


function Library:GetTextBounds(Text, Font, Size, Resolution)
  --print(Text,Font,Size,Resolution)
    local maxRetries = 5
    local retryCount = 0
    
    while retryCount < maxRetries do
        local success, result = pcall(function()
            -- Validate font
            if not Font then
                error("Invalid font provided")
            end
            
            local Params = Instance.new("GetTextBoundsParams")
            Params.Text = Text
            
            -- Use FontFace for custom fonts, Font for Enum.Font
            if typeof(Font) == "FontFace" then
                Params.FontFace = Font  -- ✅ Use FontFace for custom fonts
            else
                Params.Font = Font  -- For standard Enum.Font values
            end
            
            Params.Size = Size
            Params.Width = (Resolution or Vector2.new(1920, 1080)).X
            
            return TextService:GetTextBoundsAsync(Params)
        end)
        
        if success then
            return result.X, result.Y
        end
        
        retryCount = retryCount + 1
        wait(0.1)
    end
    
    warn("GetTextBounds failed after retries with font:", Font)
    return 0, 0
end



function Library:GetDarkerColor(Color)
    local H, S, V = Color3.toHSV(Color);
    return Color3.fromHSV(H, S, V / 1.5);
end;
Library.AccentColorDark = Library:GetDarkerColor(Library.AccentColor);

function Library:AddToRegistry(Instance, Properties, IsHud)
    local Idx = #Library.Registry + 1;
    local Data = {
        Instance = Instance;
        Properties = Properties;
        Idx = Idx;
    };

    table.insert(Library.Registry, Data);
    Library.RegistryMap[Instance] = Data;

    if IsHud then
        table.insert(Library.HudRegistry, Data);
    end;
end;

function Library:RemoveFromRegistry(Instance)
    local Data = Library.RegistryMap[Instance];

    if Data then
        for Idx = #Library.Registry, 1, -1 do
            if Library.Registry[Idx] == Data then
                table.remove(Library.Registry, Idx);
            end;
        end;

        for Idx = #Library.HudRegistry, 1, -1 do
            if Library.HudRegistry[Idx] == Data then
                table.remove(Library.HudRegistry, Idx);
            end;
        end;

        Library.RegistryMap[Instance] = nil;
    end;
end;







function Library:UpdateColorsUsingRegistry()
    -- Only update if UI is visible
    if not ScreenGui.Parent then return end
    
    for Idx, Object in next, Library.Registry do
        -- Check if instance still exists
        if not Object.Instance or not Object.Instance.Parent then continue end
        
        -- Skip invisible objects for performance (but still update them occasionally)
        local shouldUpdate = Object.Instance.Visible or (Idx % 10 == 0)
        if not shouldUpdate then continue end
        
        for Property, ColorIdx in next, Object.Properties do
            if type(ColorIdx) == 'string' then
                -- Safely update the property
                local newColor = Library[ColorIdx]
                if newColor then
                    Object.Instance[Property] = newColor
                end
            elseif type(ColorIdx) == 'function' then
                -- Safely call the function
                local success, newColor = pcall(ColorIdx)
                if success and newColor then
                    Object.Instance[Property] = newColor
                end
            end
        end
    end
end










function Library:GiveSignal(Signal)
    -- Only used for signals not attached to library instances, as those should be cleaned up on object destruction by Roblox
    table.insert(Library.Signals, Signal)
end

function Library:Unload()
    -- Unload all of the signals
    for Idx = #Library.Signals, 1, -1 do
        local Connection = table.remove(Library.Signals, Idx)
        Connection:Disconnect()
    end

     -- Call our unload callback, maybe to undo some hooks etc
    if Library.OnUnload then
        Library.OnUnload()
    end

    ScreenGui:Destroy()
end

function Library:OnUnload(Callback)
    Library.OnUnload = Callback
end

Library:GiveSignal(ScreenGui.DescendantRemoving:Connect(function(Instance)
    if Library.RegistryMap[Instance] then
        Library:RemoveFromRegistry(Instance);
    end;
end))

local BaseAddons = {};

do
    local Funcs = {};

    function Funcs:AddColorPicker(Idx, Info)
    local ToggleLabel = self.TextLabel;
    -- local Container = self.Container;
    
    assert(Info.Default, 'AddColorPicker: Missing default value.');
    
    local ColorPicker = {
        Value = Info.Default;
        Transparency = Info.Transparency or 0;
        Type = 'ColorPicker';
        Title = type(Info.Title) == 'string' and Info.Title or 'Color picker',
        Callback = Info.Callback or function(Color) end;
    };
    
    function ColorPicker:SetHSVFromRGB(Color)
        local H, S, V = Color3.toHSV(Color);
        ColorPicker.Hue = H;
        ColorPicker.Sat = S;
        ColorPicker.Vib = V;
    end;
    
    ColorPicker:SetHSVFromRGB(ColorPicker.Value);
    
    local DisplayFrame = Library:Create('Frame', {
        BackgroundColor3 = ColorPicker.Value;
        BorderColor3 = Library:GetDarkerColor(ColorPicker.Value);
        BorderMode = Enum.BorderMode.Inset;
        Size = UDim2.new(0, 28, 0, 14);
        ZIndex = 6;
        Parent = ToggleLabel;
    });
    
    -- Add gradient with 90 degree rotation and subtle black tint
    local Gradient = Library:Create('UIGradient', {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, ColorPicker.Value),
            ColorSequenceKeypoint.new(1, Color3.new(
                ColorPicker.Value.R * 0.7,
                ColorPicker.Value.G * 0.7,
                ColorPicker.Value.B * 0.7
            ))
        });
        Rotation = 90;
        Parent = DisplayFrame;
    });






local TweenService = game:GetService("TweenService");

local glow = Instance.new("ImageLabel", DisplayFrame);
glow.Name = "GlowEffect";
glow.Image = "rbxassetid://18245826428";
glow.ScaleType = Enum.ScaleType.Slice;
glow.SliceCenter = Rect.new(10, 10, 60, 60);
glow.ImageColor3 = Color3.fromRGB(80, 60, 150);
glow.ImageTransparency = 0.3;
glow.BackgroundTransparency = 1;
glow.Size = UDim2.new(1, 40, 1, 40);
glow.Position = UDim2.new(0, -20, 0, -20);
glow.ZIndex = -1;

local function Pulse()
	local info = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true);
	local props = { ImageTransparency = 0.6 };
	local tween = TweenService:Create(glow, info, props);
	tween:Play();
end;

task.spawn(Pulse)







		

        -- Transparency image taken from https://github.com/matas3535/SplixPrivateDrawingLibrary/blob/main/Library.lua cus i'm lazy
        local CheckerFrame = Library:Create('ImageLabel', {
            BorderSizePixel = 0;
            Size = UDim2.new(0, 27, 0, 13);
            ZIndex = 5;
            Image = 'http://www.roblox.com/asset/?id=12977615774';
            Visible = not not Info.Transparency;
            Parent = DisplayFrame;
        });

        -- 1/16/23
        -- Rewrote this to be placed inside the Library ScreenGui
        -- There was some issue which caused RelativeOffset to be way off
        -- Thus the color picker would never show

        local PickerFrameOuter = Library:Create('Frame', {
            Name = 'Color';
            BackgroundColor3 = Color3.new(1, 1, 1);
            BorderColor3 = Color3.new(0, 0, 0);
            Position = UDim2.fromOffset(DisplayFrame.AbsolutePosition.X, DisplayFrame.AbsolutePosition.Y + 18),
            Size = UDim2.fromOffset(230, Info.Transparency and 271 or 253);
            Visible = false;
            ZIndex = 15;
            Parent = ScreenGui,
        });

        DisplayFrame:GetPropertyChangedSignal('AbsolutePosition'):Connect(function()
            PickerFrameOuter.Position = UDim2.fromOffset(DisplayFrame.AbsolutePosition.X, DisplayFrame.AbsolutePosition.Y + 18);
        end)

        local PickerFrameInner = Library:Create('Frame', {
            BackgroundColor3 = Library.BackgroundColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 16;
            Parent = PickerFrameOuter;
        });

        local Highlight = Library:Create('Frame', {
            BackgroundColor3 = Library.AccentColor;
            BorderSizePixel = 0;
            Size = UDim2.new(1, 0, 0, 2);
            ZIndex = 17;
            Parent = PickerFrameInner;
        });

        local SatVibMapOuter = Library:Create('Frame', {
            BorderColor3 = Color3.new(0, 0, 0);
            Position = UDim2.new(0, 4, 0, 25);
            Size = UDim2.new(0, 200, 0, 200);
            ZIndex = 17;
            Parent = PickerFrameInner;
        });

        local SatVibMapInner = Library:Create('Frame', {
            BackgroundColor3 = Library.BackgroundColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 18;
            Parent = SatVibMapOuter;
        });

        local SatVibMap = Library:Create('ImageLabel', {
            BorderSizePixel = 0;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 18;
            Image = 'rbxassetid://4155801252';
            Parent = SatVibMapInner;
        });

        local CursorOuter = Library:Create('ImageLabel', {
            AnchorPoint = Vector2.new(0.5, 0.5);
            Size = UDim2.new(0, 6, 0, 6);
            BackgroundTransparency = 1;
            Image = 'http://www.roblox.com/asset/?id=9619665977';
            ImageColor3 = Color3.new(0, 0, 0);
            ZIndex = 19;
            Parent = SatVibMap;
        });

        local CursorInner = Library:Create('ImageLabel', {
            Size = UDim2.new(0, CursorOuter.Size.X.Offset - 2, 0, CursorOuter.Size.Y.Offset - 2);
            Position = UDim2.new(0, 1, 0, 1);
            BackgroundTransparency = 1;
            Image = 'http://www.roblox.com/asset/?id=9619665977';
            ZIndex = 20;
            Parent = CursorOuter;
        })

        local HueSelectorOuter = Library:Create('Frame', {
            BorderColor3 = Color3.new(0, 0, 0);
            Position = UDim2.new(0, 208, 0, 25);
            Size = UDim2.new(0, 15, 0, 200);
            ZIndex = 17;
            Parent = PickerFrameInner;
        });

        local HueSelectorInner = Library:Create('Frame', {
            BackgroundColor3 = Color3.new(1, 1, 1);
            BorderSizePixel = 0;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 18;
            Parent = HueSelectorOuter;
        });

        local HueCursor = Library:Create('Frame', { 
            BackgroundColor3 = Color3.new(1, 1, 1);
            AnchorPoint = Vector2.new(0, 0.5);
            BorderColor3 = Color3.new(0, 0, 0);
            Size = UDim2.new(1, 0, 0, 1);
            ZIndex = 18;
            Parent = HueSelectorInner;
        });

        local HueBoxOuter = Library:Create('Frame', {
            BorderColor3 = Color3.new(0, 0, 0);
            Position = UDim2.fromOffset(4, 228),
            Size = UDim2.new(0.5, -6, 0, 20),
            ZIndex = 18,
            Parent = PickerFrameInner;
        });

        local HueBoxInner = Library:Create('Frame', {
            BackgroundColor3 = Library.MainColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 18,
            Parent = HueBoxOuter;
        });

        Library:Create('UIGradient', {
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(212, 212, 212))
            });
            Rotation = 90;
            Parent = HueBoxInner;
        });

        local HueBox = Library:Create('TextBox', {
            BackgroundTransparency = 1;
            Position = UDim2.new(0, 5, 0, 0);
            Size = UDim2.new(1, -5, 1, 0);
            FontFace = Library.Font;
            PlaceholderColor3 = Color3.fromRGB(190, 190, 190);
            PlaceholderText = 'Hex color',
            Text = '#FFFFFF',
            TextColor3 = Library.FontColor;
            TextSize = 11;
            TextStrokeTransparency = 0;
            TextXAlignment = Enum.TextXAlignment.Left;
            ZIndex = 20,
            Parent = HueBoxInner;
        });

        Library:ApplyTextStroke(HueBox);

        local RgbBoxBase = Library:Create(HueBoxOuter:Clone(), {
            Position = UDim2.new(0.5, 2, 0, 228),
            Size = UDim2.new(0.5, -6, 0, 20),
            Parent = PickerFrameInner
        });

        local RgbBox = Library:Create(RgbBoxBase.Frame:FindFirstChild('TextBox'), {
            Text = '255, 255, 255',
            PlaceholderText = 'RGB color',
            TextColor3 = Library.FontColor
        });

        local TransparencyBoxOuter, TransparencyBoxInner, TransparencyCursor;
        
        if Info.Transparency then 
            TransparencyBoxOuter = Library:Create('Frame', {
                BorderColor3 = Color3.new(0, 0, 0);
                Position = UDim2.fromOffset(4, 251);
                Size = UDim2.new(1, -8, 0, 15);
                ZIndex = 19;
                Parent = PickerFrameInner;
            });

            TransparencyBoxInner = Library:Create('Frame', {
                BackgroundColor3 = ColorPicker.Value;
                BorderColor3 = Library.OutlineColor;
                BorderMode = Enum.BorderMode.Inset;
                Size = UDim2.new(1, 0, 1, 0);
                ZIndex = 19;
                Parent = TransparencyBoxOuter;
            });

            Library:AddToRegistry(TransparencyBoxInner, { BorderColor3 = 'OutlineColor' });

            Library:Create('ImageLabel', {
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 1, 0);
                Image = 'http://www.roblox.com/asset/?id=12978095818';
                ZIndex = 20;
                Parent = TransparencyBoxInner;
            });

            TransparencyCursor = Library:Create('Frame', { 
                BackgroundColor3 = Color3.new(1, 1, 1);
                AnchorPoint = Vector2.new(0.5, 0);
                BorderColor3 = Color3.new(0, 0, 0);
                Size = UDim2.new(0, 1, 1, 0);
                ZIndex = 21;
                Parent = TransparencyBoxInner;
            });
        end;

        local DisplayLabel = Library:CreateLabel({
            Size = UDim2.new(1, 0, 0, 14);
            Position = UDim2.fromOffset(5, 5);
            TextXAlignment = Enum.TextXAlignment.Left;
            TextSize = 11;
            Text = ColorPicker.Title,--Info.Default;
            TextWrapped = false;
            ZIndex = 16;
            Parent = PickerFrameInner;
        });


        local ContextMenu = {}
        do
            ContextMenu.Options = {}
            ContextMenu.Container = Library:Create('Frame', {
                BorderColor3 = Color3.new(),
                ZIndex = 14,

                Visible = false,
                Parent = ScreenGui
            })

            ContextMenu.Inner = Library:Create('Frame', {
                BackgroundColor3 = Library.BackgroundColor;
                BorderColor3 = Library.OutlineColor;
                BorderMode = Enum.BorderMode.Inset;
                Size = UDim2.fromScale(1, 1);
                ZIndex = 15;
                Parent = ContextMenu.Container;
            });

            Library:Create('UIListLayout', {
                Name = 'Layout',
                FillDirection = Enum.FillDirection.Vertical;
                SortOrder = Enum.SortOrder.LayoutOrder;
                Parent = ContextMenu.Inner;
            });

            Library:Create('UIPadding', {
                Name = 'Padding',
                PaddingLeft = UDim.new(0, 4),
                Parent = ContextMenu.Inner,
            });

            local function updateMenuPosition()
                ContextMenu.Container.Position = UDim2.fromOffset(
                    (DisplayFrame.AbsolutePosition.X + DisplayFrame.AbsoluteSize.X) + 4,
                    DisplayFrame.AbsolutePosition.Y + 1
                )
            end

            local function updateMenuSize()
                local menuWidth = 60
                for i, label in next, ContextMenu.Inner:GetChildren() do
                    if label:IsA('TextLabel') then
                        menuWidth = math.max(menuWidth, label.TextBounds.X)
                    end
                end

                ContextMenu.Container.Size = UDim2.fromOffset(
                    menuWidth + 8,
                    ContextMenu.Inner.Layout.AbsoluteContentSize.Y + 4
                )
            end

            DisplayFrame:GetPropertyChangedSignal('AbsolutePosition'):Connect(updateMenuPosition)
            ContextMenu.Inner.Layout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(updateMenuSize)

            task.spawn(updateMenuPosition)
            task.spawn(updateMenuSize)

            Library:AddToRegistry(ContextMenu.Inner, {
                BackgroundColor3 = 'BackgroundColor';
                BorderColor3 = 'OutlineColor';
            });

            function ContextMenu:Show()
                self.Container.Visible = true
            end

            function ContextMenu:Hide()
                self.Container.Visible = false
            end

            function ContextMenu:AddOption(Str, Callback)
                if type(Callback) ~= 'function' then
                    Callback = function() end
                end

                local Button = Library:CreateLabel({
                    Active = false;
                    Size = UDim2.new(1, 0, 0, 15);
                    TextSize = 12;
                    Text = Str;
                    ZIndex = 16;
                    Parent = self.Inner;
                    TextXAlignment = Enum.TextXAlignment.Left,
                });

                Library:OnHighlight(Button, Button, 
                    { TextColor3 = 'AccentColor' },
                    { TextColor3 = 'FontColor' }
                );

                Button.InputBegan:Connect(function(Input)
                    if Input.UserInputType ~= Enum.UserInputType.MouseButton1 then
                        return
                    end

                    Callback()
                end)
            end

            ContextMenu:AddOption('Copy color', function()
                Library.ColorClipboard = ColorPicker.Value
                Library:Notify('Copied color!', 2)
            end)

            ContextMenu:AddOption('Paste color', function()
                if not Library.ColorClipboard then
                    return Library:Notify('You have not copied a color!', 2)
                end
                ColorPicker:SetValueRGB(Library.ColorClipboard)
            end)


            ContextMenu:AddOption('Copy HEX', function()
                pcall(setclipboard, ColorPicker.Value:ToHex())
                Library:Notify('Copied hex code to clipboard!', 2)
            end)

            ContextMenu:AddOption('Copy RGB', function()
                pcall(setclipboard, table.concat({ math.floor(ColorPicker.Value.R * 255), math.floor(ColorPicker.Value.G * 255), math.floor(ColorPicker.Value.B * 255) }, ', '))
                Library:Notify('Copied RGB values to clipboard!', 2)
            end)

        end

        Library:AddToRegistry(PickerFrameInner, { BackgroundColor3 = 'BackgroundColor'; BorderColor3 = 'OutlineColor'; });
        Library:AddToRegistry(Highlight, { BackgroundColor3 = 'AccentColor'; });
        Library:AddToRegistry(SatVibMapInner, { BackgroundColor3 = 'BackgroundColor'; BorderColor3 = 'OutlineColor'; });

        Library:AddToRegistry(HueBoxInner, { BackgroundColor3 = 'MainColor'; BorderColor3 = 'OutlineColor'; });
        Library:AddToRegistry(RgbBoxBase.Frame, { BackgroundColor3 = 'MainColor'; BorderColor3 = 'OutlineColor'; });
        Library:AddToRegistry(RgbBox, { TextColor3 = 'FontColor', });
        Library:AddToRegistry(HueBox, { TextColor3 = 'FontColor', });

        local SequenceTable = {};

        for Hue = 0, 1, 0.1 do
            table.insert(SequenceTable, ColorSequenceKeypoint.new(Hue, Color3.fromHSV(Hue, 1, 1)));
        end;

        local HueSelectorGradient = Library:Create('UIGradient', {
            Color = ColorSequence.new(SequenceTable);
            Rotation = 90;
            Parent = HueSelectorInner;
        });

        HueBox.FocusLost:Connect(function(enter)
            if enter then
                local success, result = pcall(Color3.fromHex, HueBox.Text)
                if success and typeof(result) == 'Color3' then
                    ColorPicker.Hue, ColorPicker.Sat, ColorPicker.Vib = Color3.toHSV(result)
                end
            end

            ColorPicker:Display()
        end)

        RgbBox.FocusLost:Connect(function(enter)
            if enter then
                local r, g, b = RgbBox.Text:match('(%d+),%s*(%d+),%s*(%d+)')
                if r and g and b then
                    ColorPicker.Hue, ColorPicker.Sat, ColorPicker.Vib = Color3.toHSV(Color3.fromRGB(r, g, b))
                end
            end

            ColorPicker:Display()
        end)

        function ColorPicker:Display()
            ColorPicker.Value = Color3.fromHSV(ColorPicker.Hue, ColorPicker.Sat, ColorPicker.Vib);
            SatVibMap.BackgroundColor3 = Color3.fromHSV(ColorPicker.Hue, 1, 1);

            Library:Create(DisplayFrame, {
                BackgroundColor3 = ColorPicker.Value;
                BackgroundTransparency = ColorPicker.Transparency;
                BorderColor3 = Library:GetDarkerColor(ColorPicker.Value);
            });

            if TransparencyBoxInner then
                TransparencyBoxInner.BackgroundColor3 = ColorPicker.Value;
                TransparencyCursor.Position = UDim2.new(1 - ColorPicker.Transparency, 0, 0, 0);
            end;

            CursorOuter.Position = UDim2.new(ColorPicker.Sat, 0, 1 - ColorPicker.Vib, 0);
            HueCursor.Position = UDim2.new(0, 0, ColorPicker.Hue, 0);

            HueBox.Text = '#' .. ColorPicker.Value:ToHex()
            RgbBox.Text = table.concat({ math.floor(ColorPicker.Value.R * 255), math.floor(ColorPicker.Value.G * 255), math.floor(ColorPicker.Value.B * 255) }, ', ')

            Library:SafeCallback(ColorPicker.Callback, ColorPicker.Value);
            Library:SafeCallback(ColorPicker.Changed, ColorPicker.Value);
        end;

        function ColorPicker:OnChanged(Func)
            ColorPicker.Changed = Func;
            Func(ColorPicker.Value)
        end;

        function ColorPicker:Show()
            for Frame, Val in next, Library.OpenedFrames do
                if Frame.Name == 'Color' then
                    Frame.Visible = false;
                    Library.OpenedFrames[Frame] = nil;
                end;
            end;

            PickerFrameOuter.Visible = true;
            Library.OpenedFrames[PickerFrameOuter] = true;
        end;

        function ColorPicker:Hide()
            PickerFrameOuter.Visible = false;
            Library.OpenedFrames[PickerFrameOuter] = nil;
        end;

        function ColorPicker:SetValue(HSV, Transparency)
            local Color = Color3.fromHSV(HSV[1], HSV[2], HSV[3]);

            ColorPicker.Transparency = Transparency or 0;
            ColorPicker:SetHSVFromRGB(Color);
            ColorPicker:Display();
        end;

        function ColorPicker:SetValueRGB(Color, Transparency)
            ColorPicker.Transparency = Transparency or 0;
            ColorPicker:SetHSVFromRGB(Color);
            ColorPicker:Display();
        end;

        SatVibMap.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                while InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                    local MinX = SatVibMap.AbsolutePosition.X;
                    local MaxX = MinX + SatVibMap.AbsoluteSize.X;
                    local MouseX = math.clamp(Mouse.X, MinX, MaxX);

                    local MinY = SatVibMap.AbsolutePosition.Y;
                    local MaxY = MinY + SatVibMap.AbsoluteSize.Y;
                    local MouseY = math.clamp(Mouse.Y, MinY, MaxY);

                    ColorPicker.Sat = (MouseX - MinX) / (MaxX - MinX);
                    ColorPicker.Vib = 1 - ((MouseY - MinY) / (MaxY - MinY));
                    ColorPicker:Display();

                    RenderStepped:Wait();
                end;

                Library:AttemptSave();
            end;
        end);

        HueSelectorInner.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                while InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                    local MinY = HueSelectorInner.AbsolutePosition.Y;
                    local MaxY = MinY + HueSelectorInner.AbsoluteSize.Y;
                    local MouseY = math.clamp(Mouse.Y, MinY, MaxY);

                    ColorPicker.Hue = ((MouseY - MinY) / (MaxY - MinY));
                    ColorPicker:Display();

                    RenderStepped:Wait();
                end;

                Library:AttemptSave();
            end;
        end);

        DisplayFrame.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 and not Library:MouseIsOverOpenedFrame() then
                if PickerFrameOuter.Visible then
                    ColorPicker:Hide()
                else
                    ContextMenu:Hide()
                    ColorPicker:Show()
                end;
            elseif Input.UserInputType == Enum.UserInputType.MouseButton2 and not Library:MouseIsOverOpenedFrame() then
                ContextMenu:Show()
                ColorPicker:Hide()
            end
        end);

        if TransparencyBoxInner then
            TransparencyBoxInner.InputBegan:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    while InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                        local MinX = TransparencyBoxInner.AbsolutePosition.X;
                        local MaxX = MinX + TransparencyBoxInner.AbsoluteSize.X;
                        local MouseX = math.clamp(Mouse.X, MinX, MaxX);

                        ColorPicker.Transparency = 1 - ((MouseX - MinX) / (MaxX - MinX));

                        ColorPicker:Display();

                        RenderStepped:Wait();
                    end;

                    Library:AttemptSave();
                end;
            end);
        end;

        Library:GiveSignal(InputService.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                local AbsPos, AbsSize = PickerFrameOuter.AbsolutePosition, PickerFrameOuter.AbsoluteSize;

                if Mouse.X < AbsPos.X or Mouse.X > AbsPos.X + AbsSize.X
                    or Mouse.Y < (AbsPos.Y - 20 - 1) or Mouse.Y > AbsPos.Y + AbsSize.Y then

                    ColorPicker:Hide();
                end;

                if not Library:IsMouseOverFrame(ContextMenu.Container) then
                    ContextMenu:Hide()
                end
            end;

            if Input.UserInputType == Enum.UserInputType.MouseButton2 and ContextMenu.Container.Visible then
                if not Library:IsMouseOverFrame(ContextMenu.Container) and not Library:IsMouseOverFrame(DisplayFrame) then
                    ContextMenu:Hide()
                end
            end
        end))

        ColorPicker:Display();
        ColorPicker.DisplayFrame = DisplayFrame

        Options[Idx] = ColorPicker;

        return self;
    end;

    function Funcs:AddKeyPicker(Idx, Info)
        local ParentObj = self;
        local ToggleLabel = self.TextLabel;
        local Container = self.Container;

        assert(Info.Default, 'AddKeyPicker: Missing default value.');

        local KeyPicker = {
            Value = Info.Default;
            Toggled = false;
            Mode = Info.Mode or 'Toggle'; -- Always, Toggle, Hold
            Type = 'KeyPicker';
            Callback = Info.Callback or function(Value) end;
            ChangedCallback = Info.ChangedCallback or function(New) end;

            SyncToggleState = Info.SyncToggleState or false;
        };

        if KeyPicker.SyncToggleState then
            Info.Modes = { 'Toggle' }
            Info.Mode = 'Toggle'
        end

        local PickOuter = Library:Create('Frame', {
            BackgroundColor3 = Color3.new(0, 0, 0);
            BorderColor3 = Color3.new(0, 0, 0);
            Size = UDim2.new(0, 28, 0, 15);
            ZIndex = 6;
            Parent = ToggleLabel;
        });

        local PickInner = Library:Create('Frame', {
            BackgroundColor3 = Library.BackgroundColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 7;
            Parent = PickOuter;
        });

        Library:AddToRegistry(PickInner, {
            BackgroundColor3 = 'BackgroundColor';
            BorderColor3 = 'OutlineColor';
        });

        local DisplayLabel = Library:CreateLabel({
            Size = UDim2.new(1, 0, 1, 0);
            TextSize = 12;
            Text = Info.Default;
            TextWrapped = true;
            ZIndex = 8;
            Parent = PickInner;
        });

local ModeSelectOuter = Library:Create('Frame', {
    BorderColor3 = Color3.new(0,0,0);
    Size = UDim2.new(0,60,0,47);
    Visible = false;
    ZIndex = 14;
    Parent = PickOuter; -- artık ToggleLabel’in parent’ı
    Position = UDim2.new(1,4,0,0); -- ToggleLabel’in sağında
});


local function UpdatePos()
    local absPos = ToggleLabel.AbsolutePosition
    local newX = math.min(absPos.X + ToggleLabel.AbsoluteSize.X + 4, workspace.CurrentCamera.ViewportSize.X - ModeSelectOuter.Size.X.Offset)
    local newY = math.min(absPos.Y, workspace.CurrentCamera.ViewportSize.Y - ModeSelectOuter.Size.Y.Offset)
    ModeSelectOuter.Position = UDim2.fromOffset(newX, newY)
end

ToggleLabel:GetPropertyChangedSignal('AbsolutePosition'):Connect(UpdatePos)
ToggleLabel:GetPropertyChangedSignal('AbsoluteSize'):Connect(UpdatePos)
UpdatePos()


        ToggleLabel:GetPropertyChangedSignal('AbsolutePosition'):Connect(function()
            ModeSelectOuter.Position = UDim2.fromOffset(ToggleLabel.AbsolutePosition.X + ToggleLabel.AbsoluteSize.X + 4, ToggleLabel.AbsolutePosition.Y + 1);
        end);

        local ModeSelectInner = Library:Create('Frame', {
            BackgroundColor3 = Library.BackgroundColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 15;
            Parent = ModeSelectOuter;
        });

        Library:AddToRegistry(ModeSelectInner, {
            BackgroundColor3 = 'BackgroundColor';
            BorderColor3 = 'OutlineColor';
        });

        Library:Create('UIListLayout', {
            FillDirection = Enum.FillDirection.Vertical;
            SortOrder = Enum.SortOrder.LayoutOrder;
            Parent = ModeSelectInner;
        });

        local ContainerLabel = Library:CreateLabel({
            TextXAlignment = Enum.TextXAlignment.Left;
            Size = UDim2.new(1, 0, 0, 18);
            TextSize = 11;
            Visible = false;
            ZIndex = 110;
            Parent = Library.KeybindContainer;
        },  true);

        local Modes = Info.Modes or { 'Always', 'Toggle', 'Hold' };
        local ModeButtons = {};

        for Idx, Mode in next, Modes do
            local ModeButton = {};

            local Label = Library:CreateLabel({
                Active = false;
                Size = UDim2.new(1, 0, 0, 15);
                TextSize = 11;
                Text = Mode;
                ZIndex = 16;
                Parent = ModeSelectInner;
            });

            function ModeButton:Select()
                for _, Button in next, ModeButtons do
                    Button:Deselect();
                end;

                KeyPicker.Mode = Mode;

                Label.TextColor3 = Library.AccentColor;
                Library.RegistryMap[Label].Properties.TextColor3 = 'AccentColor';

                ModeSelectOuter.Visible = false;
            end;

            function ModeButton:Deselect()
                KeyPicker.Mode = nil;

                Label.TextColor3 = Library.FontColor;
                Library.RegistryMap[Label].Properties.TextColor3 = 'FontColor';
            end;

            Label.InputBegan:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    ModeButton:Select();
                    Library:AttemptSave();
                end;
            end);

            if Mode == KeyPicker.Mode then
                ModeButton:Select();
            end;

            ModeButtons[Mode] = ModeButton;
        end;

        function KeyPicker:Update()
            if Info.NoUI then
                return;
            end;

            local State = KeyPicker:GetState();

            ContainerLabel.Text = string.format('[%s] %s (%s)', KeyPicker.Value, Info.Text, KeyPicker.Mode);

            ContainerLabel.Visible = true;
            ContainerLabel.TextColor3 = State and Library.AccentColor or Library.FontColor;

            Library.RegistryMap[ContainerLabel].Properties.TextColor3 = State and 'AccentColor' or 'FontColor';

            local YSize = 0
            local XSize = 0

            for _, Label in next, Library.KeybindContainer:GetChildren() do
                if Label:IsA('TextLabel') and Label.Visible then
                    YSize = YSize + 18;
                    if (Label.TextBounds.X > XSize) then
                        XSize = Label.TextBounds.X
                    end
                end;
            end;

            Library.KeybindFrame.Size = UDim2.new(0, math.max(XSize + 10, 210), 0, YSize + 23)
        end;

        function KeyPicker:GetState()
            if KeyPicker.Mode == 'Always' then
                return true;
            elseif KeyPicker.Mode == 'Hold' then
                if KeyPicker.Value == 'None' then
                    return false;
                end

                local Key = KeyPicker.Value;

                if Key == 'MB1' or Key == 'MB2' then
                    return Key == 'MB1' and InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
                        or Key == 'MB2' and InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2);
                else
                    return InputService:IsKeyDown(Enum.KeyCode[KeyPicker.Value]);
                end;
            else
                return KeyPicker.Toggled;
            end;
        end;

        function KeyPicker:SetValue(Data)
            local Key, Mode = Data[1], Data[2];
            DisplayLabel.Text = Key;
            KeyPicker.Value = Key;
            ModeButtons[Mode]:Select();
            KeyPicker:Update();
        end;

        function KeyPicker:OnClick(Callback)
            KeyPicker.Clicked = Callback
        end

        function KeyPicker:OnChanged(Callback)
            KeyPicker.Changed = Callback
            Callback(KeyPicker.Value)
        end

        if ParentObj.Addons then
            table.insert(ParentObj.Addons, KeyPicker)
        end

        function KeyPicker:DoClick()
            if ParentObj.Type == 'Toggle' and KeyPicker.SyncToggleState then
                ParentObj:SetValue(not ParentObj.Value)
            end

            Library:SafeCallback(KeyPicker.Callback, KeyPicker.Toggled)
            Library:SafeCallback(KeyPicker.Clicked, KeyPicker.Toggled)
        end

        local Picking = false;

        PickOuter.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 and not Library:MouseIsOverOpenedFrame() then
                Picking = true;

                DisplayLabel.Text = '';

                local Break;
                local Text = '';

                task.spawn(function()
                    while (not Break) do
                        if Text == '...' then
                            Text = '';
                        end;

                        Text = Text .. '.';
                        DisplayLabel.Text = Text;

                        wait(0.4);
                    end;
                end);

                wait(0.2);

                local Event;
                Event = InputService.InputBegan:Connect(function(Input)
                    local Key;

                    if Input.UserInputType == Enum.UserInputType.Keyboard then
                        Key = Input.KeyCode.Name;
                    elseif Input.UserInputType == Enum.UserInputType.MouseButton1 then
                        Key = 'MB1';
                    elseif Input.UserInputType == Enum.UserInputType.MouseButton2 then
                        Key = 'MB2';
                    end;

                    Break = true;
                    Picking = false;

                    DisplayLabel.Text = Key;
                    KeyPicker.Value = Key;

                    Library:SafeCallback(KeyPicker.ChangedCallback, Input.KeyCode or Input.UserInputType)
                    Library:SafeCallback(KeyPicker.Changed, Input.KeyCode or Input.UserInputType)

                    Library:AttemptSave();

                    Event:Disconnect();
                end);
            elseif Input.UserInputType == Enum.UserInputType.MouseButton2 and not Library:MouseIsOverOpenedFrame() then
                ModeSelectOuter.Visible = true;
            end;
        end);

        Library:GiveSignal(InputService.InputBegan:Connect(function(Input)
            if (not Picking) then
                if KeyPicker.Mode == 'Toggle' then
                    local Key = KeyPicker.Value;

                    if Key == 'MB1' or Key == 'MB2' then
                        if Key == 'MB1' and Input.UserInputType == Enum.UserInputType.MouseButton1
                        or Key == 'MB2' and Input.UserInputType == Enum.UserInputType.MouseButton2 then
                            KeyPicker.Toggled = not KeyPicker.Toggled
                            KeyPicker:DoClick()
                        end;
                    elseif Input.UserInputType == Enum.UserInputType.Keyboard then
                        if Input.KeyCode.Name == Key then
                            KeyPicker.Toggled = not KeyPicker.Toggled;
                            KeyPicker:DoClick()
                        end;
                    end;
                end;

                KeyPicker:Update();
            end;

            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                local AbsPos, AbsSize = ModeSelectOuter.AbsolutePosition, ModeSelectOuter.AbsoluteSize;

                if Mouse.X < AbsPos.X or Mouse.X > AbsPos.X + AbsSize.X
                    or Mouse.Y < (AbsPos.Y - 20 - 1) or Mouse.Y > AbsPos.Y + AbsSize.Y then

                    ModeSelectOuter.Visible = false;
                end;
            end;
        end))

        Library:GiveSignal(InputService.InputEnded:Connect(function(Input)
            if (not Picking) then
                KeyPicker:Update();
            end;
        end))

        KeyPicker:Update();

        Options[Idx] = KeyPicker;

        return self;
    end;

    BaseAddons.__index = Funcs;
    BaseAddons.__namecall = function(Table, Key, ...)
        return Funcs[Key](...);
    end;
end;

local BaseGroupbox = {};

do
    local Funcs = {};

    function Funcs:AddBlank(Size)
        local Groupbox = self;
        local Container = Groupbox.Container;

        Library:Create('Frame', {
            BackgroundTransparency = 1;
            Size = UDim2.new(1, 0, 0, Size);
            ZIndex = 1;
            Parent = Container;
        });
    end;

    function Funcs:AddLabel(Text, DoesWrap)
        local Label = {};

        local Groupbox = self;
        local Container = Groupbox.Container;

        local TextLabel = Library:CreateLabel({
            Size = UDim2.new(1, -4, 0, 15);
            TextSize = 14;
            Text = Text;
            TextWrapped = DoesWrap or false,
            TextXAlignment = Enum.TextXAlignment.Left;
            ZIndex = 5;
            Parent = Container;
        });

        if DoesWrap then
            local Y = select(2, Library:GetTextBounds(Text, Library.Font, 14, Vector2.new(TextLabel.AbsoluteSize.X, math.huge)))
            TextLabel.Size = UDim2.new(1, -4, 0, Y)
        else
            Library:Create('UIListLayout', {
                Padding = UDim.new(0, 4);
                FillDirection = Enum.FillDirection.Horizontal;
                HorizontalAlignment = Enum.HorizontalAlignment.Right;
                SortOrder = Enum.SortOrder.LayoutOrder;
                Parent = TextLabel;
            });
        end

        Label.TextLabel = TextLabel;
        Label.Container = Container;

        function Label:SetText(Text)
            TextLabel.Text = Text

            if DoesWrap then
                local Y = select(2, Library:GetTextBounds(Text, Library.Font, 14, Vector2.new(TextLabel.AbsoluteSize.X, math.huge)))
                TextLabel.Size = UDim2.new(1, -4, 0, Y)
            end

            Groupbox:Resize();
        end

        if (not DoesWrap) then
            setmetatable(Label, BaseAddons);
        end

        Groupbox:AddBlank(5);
        Groupbox:Resize();

        return Label;
    end;


function Funcs:AddVariableLabel(Text, Variable, UpdateInterval)
    local VarLabel = {}
    
    local Groupbox = self
    local Container = Groupbox.Container
    
    UpdateInterval = UpdateInterval or 0.1 -- Default update every 0.1 seconds
    
    local TextLabel = Library:CreateLabel({
        Size = UDim2.new(1, -4, 0, 15),
        TextSize = 11,
        Text = Text,
        TextWrapped = false,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 5,
        Parent = Container,
    })
    
    Library:Create('UIListLayout', {
        Padding = UDim.new(0, 4),
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = TextLabel,
    })
    
    VarLabel.TextLabel = TextLabel
    VarLabel.Container = Container
    VarLabel.Variable = Variable
    VarLabel.BaseText = Text
    VarLabel.Updating = true
    
    -- Function to update the label
    function VarLabel:Update()
        if type(VarLabel.Variable) == "function" then
            -- If variable is a function, call it to get the value
            local success, result = pcall(VarLabel.Variable)
            if success then
                TextLabel.Text = VarLabel.BaseText .. tostring(result)
            else
                TextLabel.Text = VarLabel.BaseText .. "Error"
            end
        else
            -- If it's a direct value
            TextLabel.Text = VarLabel.BaseText .. tostring(VarLabel.Variable)
        end
        
        Groupbox:Resize()
    end
    
    -- Set new variable/function to track
    function VarLabel:SetVariable(NewVariable)
        VarLabel.Variable = NewVariable
        VarLabel:Update()
    end
    
    -- Change the base text
    function VarLabel:SetText(NewText)
        VarLabel.BaseText = NewText
        VarLabel:Update()
    end
    
    -- Stop updating
    function VarLabel:Stop()
        VarLabel.Updating = false
    end
    
    -- Resume updating
    function VarLabel:Resume()
        VarLabel.Updating = true
    end
    
    -- Start the update loop
    task.spawn(function()
        while VarLabel.TextLabel and VarLabel.TextLabel.Parent and VarLabel.Updating do
            VarLabel:Update()
            task.wait(UpdateInterval)
        end
    end)
    
    -- Initial update
    VarLabel:Update()
    
    setmetatable(VarLabel, BaseAddons)
    
    Groupbox:AddBlank(5)
    Groupbox:Resize()
    
    return VarLabel
end

	

  local TweenService = game:GetService('TweenService')

function Funcs:AddButton(...)
    -- TODO: Eventually redo this
    local Button = {};
    local function ProcessButtonParams(Class, Obj, ...)
        local Props = select(1, ...)
        if type(Props) == 'table' then
            Obj.Text = Props.Text
            Obj.Func = Props.Func
            Obj.DoubleClick = Props.DoubleClick
            Obj.Tooltip = Props.Tooltip
        else
            Obj.Text = select(1, ...)
            Obj.Func = select(2, ...)
        end

        assert(type(Obj.Func) == 'function', 'AddButton: Func callback is missing.');
    end

    ProcessButtonParams('Button', Button, ...)

    local Groupbox = self;
    local Container = Groupbox.Container;

    local function CreateBaseButton(Button)
        local Outer = Library:Create('Frame', {
            BackgroundColor3 = Color3.new(0, 0, 0);
            BorderColor3 = Color3.new(0, 0, 0);
            Size = UDim2.new(1, -4, 0, 20);
            ZIndex = 5;
        });

        local Inner = Library:Create('Frame', {
            BackgroundColor3 = Library.MainColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 6;
            Parent = Outer;
        });


local Label = Library:CreateLabel({
    Size = UDim2.new(1, 0, 1, 0);
    TextSize = 11;
    Text = Button.Text;
    TextColor3 = Color3.fromRGB(105, 105, 105); -- START GREY, NOT WHITE
    ZIndex = 6;
    Parent = Inner;
});


        Library:Create('UIGradient', {
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(212, 212, 212))
            });
            Rotation = 90;
            Parent = Inner;
        });

        Library:AddToRegistry(Outer, {
            BorderColor3 = 'Black';
        });

        Library:AddToRegistry(Inner, {
            BackgroundColor3 = 'MainColor';
            BorderColor3 = 'OutlineColor';
        });

        Library:OnHighlight(Outer, Outer,
            { BorderColor3 = 'AccentColor' },
            { BorderColor3 = 'Black' }
        );

        return Outer, Inner, Label
    end

    local function AnimateButtonPress(Label, pressed)
        local TweenService = game:GetService("TweenService")
        local tweenInfo = TweenInfo.new(
            0.2, -- Duration
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0, -- Repeat count
            false, -- Reverses
            0 -- Delay
        )
        
        local targetColor
        if pressed then
            targetColor = Color3.fromRGB(255, 255, 255) -- White when pressed
        else
            targetColor = Color3.fromRGB(150, 150, 150) -- Gray when not pressed
        end
        
        local colorTween = TweenService:Create(Label, tweenInfo, {
            TextColor3 = targetColor
        })
        
        colorTween:Play()
        return colorTween
    end

    local function InitEvents(Button)
        local function WaitForEvent(event, timeout, validator)
            local bindable = Instance.new('BindableEvent')
            local connection = event:Once(function(...)
                if type(validator) == 'function' and validator(...) then
                    bindable:Fire(true)
                else
                    bindable:Fire(false)
                end
            end)
            task.delay(timeout, function()
                connection:disconnect()
                bindable:Fire(false)
            end)
            return bindable.Event:Wait()
        end

        local function ValidateClick(Input)
            if Library:MouseIsOverOpenedFrame() then
                return false
            end

            if Input.UserInputType ~= Enum.UserInputType.MouseButton1 then
                return false
            end

            return true
        end

        -- Mouse button down event
        Button.Outer.InputBegan:Connect(function(Input)
            if not ValidateClick(Input) then return end
            if Button.Locked then return end

            -- Animate to pressed state (gray to white)
            AnimateButtonPress(Button.Label, true)

            if Button.DoubleClick then
                Library:RemoveFromRegistry(Button.Label)
                Library:AddToRegistry(Button.Label, { TextColor3 = 'AccentColor' })

                Button.Label.TextColor3 = Library.AccentColor
                Button.Label.Text = 'Are you sure?'
                Button.Locked = true

                local clicked = WaitForEvent(Button.Outer.InputBegan, 0.5, ValidateClick)

                Library:RemoveFromRegistry(Button.Label)
                Library:AddToRegistry(Button.Label, { TextColor3 = 'FontColor' })

                Button.Label.TextColor3 = Library.FontColor
                Button.Label.Text = Button.Text
                task.defer(rawset, Button, 'Locked', false)

                if clicked then
                    Library:SafeCallback(Button.Func)
                end

                return
            end

            Library:SafeCallback(Button.Func);
        end)

        -- Mouse button up event
        Button.Outer.InputEnded:Connect(function(Input)
            if Input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
            if Button.Locked then return end

            -- Animate back to normal state (white to gray)
            AnimateButtonPress(Button.Label, false)
        end)

        -- Handle mouse leave (in case mouse leaves while pressed)
        Button.Outer.MouseLeave:Connect(function()
            if Button.Locked then return end
            -- Animate back to normal state if mouse leaves
            AnimateButtonPress(Button.Label, false)
        end)
    end

    Button.Outer, Button.Inner, Button.Label = CreateBaseButton(Button)
    Button.Outer.Parent = Container

    InitEvents(Button)

    function Button:AddTooltip(tooltip)
        if type(tooltip) == 'string' then
            Library:AddToolTip(tooltip, self.Outer)
        end
        return self
    end

    function Button:AddButton(...)
        local SubButton = {}

        ProcessButtonParams('SubButton', SubButton, ...)

        self.Outer.Size = UDim2.new(0.5, -2, 0, 20)

        SubButton.Outer, SubButton.Inner, SubButton.Label = CreateBaseButton(SubButton)

        SubButton.Outer.Position = UDim2.new(1, 3, 0, 0)
        SubButton.Outer.Size = UDim2.fromOffset(self.Outer.AbsoluteSize.X - 2, self.Outer.AbsoluteSize.Y)
        SubButton.Outer.Parent = self.Outer

        function SubButton:AddTooltip(tooltip)
            if type(tooltip) == 'string' then
                Library:AddToolTip(tooltip, self.Outer)
            end
            return SubButton
        end

        if type(SubButton.Tooltip) == 'string' then
            SubButton:AddTooltip(SubButton.Tooltip)
        end

        InitEvents(SubButton)
        return SubButton
    end

    if type(Button.Tooltip) == 'string' then
        Button:AddTooltip(Button.Tooltip)
    end

    Groupbox:AddBlank(5);
    Groupbox:Resize();

    return Button;
end;


	

    function Funcs:AddDivider()
        local Groupbox = self;
        local Container = self.Container

        local Divider = {
            Type = 'Divider',
        }

        Groupbox:AddBlank(2);
        local DividerOuter = Library:Create('Frame', {
            BackgroundColor3 = Color3.new(0, 0, 0);
            BorderColor3 = Color3.new(0, 0, 0);
            Size = UDim2.new(1, -4, 0, 5);
            ZIndex = 5;
            Parent = Container;
        });

        local DividerInner = Library:Create('Frame', {
            BackgroundColor3 = Library.MainColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 6;
            Parent = DividerOuter;
        });

        Library:AddToRegistry(DividerOuter, {
            BorderColor3 = 'Black';
        });

        Library:AddToRegistry(DividerInner, {
            BackgroundColor3 = 'MainColor';
            BorderColor3 = 'OutlineColor';
        });

        Groupbox:AddBlank(9);
        Groupbox:Resize();
    end

    function Funcs:AddInput(Idx, Info)
        assert(Info.Text, 'AddInput: Missing `Text` string.')

        local Textbox = {
            Value = Info.Default or '';
            Numeric = Info.Numeric or false;
            Finished = Info.Finished or false;
            Type = 'Input';
            Callback = Info.Callback or function(Value) end;
        };

        local Groupbox = self;
        local Container = Groupbox.Container;

        local InputLabel = Library:CreateLabel({
            Size = UDim2.new(1, 0, 0, 15);
            TextSize = 14;
            Text = Info.Text;
            TextXAlignment = Enum.TextXAlignment.Left;
            ZIndex = 5;
            Parent = Container;
        });

        Groupbox:AddBlank(1);

        local TextBoxOuter = Library:Create('Frame', {
            BackgroundColor3 = Color3.new(0, 0, 0);
            BorderColor3 = Color3.new(0, 0, 0);
            Size = UDim2.new(1, -4, 0, 20);
            ZIndex = 5;
            Parent = Container;
        });

        local TextBoxInner = Library:Create('Frame', {
            BackgroundColor3 = Library.MainColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 6;
            Parent = TextBoxOuter;
        });

        Library:AddToRegistry(TextBoxInner, {
            BackgroundColor3 = 'MainColor';
            BorderColor3 = 'OutlineColor';
        });

        Library:OnHighlight(TextBoxOuter, TextBoxOuter,
            { BorderColor3 = 'AccentColor' },
            { BorderColor3 = 'Black' }
        );

        if type(Info.Tooltip) == 'string' then
            Library:AddToolTip(Info.Tooltip, TextBoxOuter)
        end

        Library:Create('UIGradient', {
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(212, 212, 212))
            });
            Rotation = 90;
            Parent = TextBoxInner;
        });

        local Container = Library:Create('Frame', {
            BackgroundTransparency = 1;
            ClipsDescendants = true;

            Position = UDim2.new(0, 5, 0, 0);
            Size = UDim2.new(1, -5, 1, 0);

            ZIndex = 7;
            Parent = TextBoxInner;
        })

        local Box = Library:Create('TextBox', {
            BackgroundTransparency = 1;

            Position = UDim2.fromOffset(0, 0),
            Size = UDim2.fromScale(5, 1),

            FontFace = Library.Font;
            PlaceholderColor3 = Color3.fromRGB(190, 190, 190);
            PlaceholderText = Info.Placeholder or '';

            Text = Info.Default or '';
            TextColor3 = Library.FontColor;
            TextSize = 14;
            TextStrokeTransparency = 0;
            TextXAlignment = Enum.TextXAlignment.Left;

            ZIndex = 7;
            Parent = Container;
        });

        Library:ApplyTextStroke(Box);

        function Textbox:SetValue(Text)
            if Info.MaxLength and #Text > Info.MaxLength then
                Text = Text:sub(1, Info.MaxLength);
            end;

            if Textbox.Numeric then
                if (not tonumber(Text)) and Text:len() > 0 then
                    Text = Textbox.Value
                end
            end

            Textbox.Value = Text;
            Box.Text = Text;

            Library:SafeCallback(Textbox.Callback, Textbox.Value);
            Library:SafeCallback(Textbox.Changed, Textbox.Value);
        end;

        if Textbox.Finished then
            Box.FocusLost:Connect(function(enter)
                if not enter then return end

                Textbox:SetValue(Box.Text);
                Library:AttemptSave();
            end)
        else
            Box:GetPropertyChangedSignal('Text'):Connect(function()
                Textbox:SetValue(Box.Text);
                Library:AttemptSave();
            end);
        end

        -- https://devforum.roblox.com/t/how-to-make-textboxes-follow-current-cursor-position/1368429/6
        -- thank you nicemike40 :)

        local function Update()
            local PADDING = 2
            local reveal = Container.AbsoluteSize.X

            if not Box:IsFocused() or Box.TextBounds.X <= reveal - 2 * PADDING then
                -- we aren't focused, or we fit so be normal
                Box.Position = UDim2.new(0, PADDING, 0, 0)
            else
                -- we are focused and don't fit, so adjust position
                local cursor = Box.CursorPosition
                if cursor ~= -1 then
                    -- calculate pixel width of text from start to cursor
                    local subtext = string.sub(Box.Text, 1, cursor-1)
                    local width = TextService:GetTextSize(subtext, Box.TextSize, Box.Font, Vector2.new(math.huge, math.huge)).X

                    -- check if we're inside the box with the cursor
                    local currentCursorPos = Box.Position.X.Offset + width

                    -- adjust if necessary
                    if currentCursorPos < PADDING then
                        Box.Position = UDim2.fromOffset(PADDING-width, 0)
                    elseif currentCursorPos > reveal - PADDING - 1 then
                        Box.Position = UDim2.fromOffset(reveal-width-PADDING-1, 0)
                    end
                end
            end
        end

        task.spawn(Update)

        Box:GetPropertyChangedSignal('Text'):Connect(Update)
        Box:GetPropertyChangedSignal('CursorPosition'):Connect(Update)
        Box.FocusLost:Connect(Update)
        Box.Focused:Connect(Update)

        Library:AddToRegistry(Box, {
            TextColor3 = 'FontColor';
        });

        function Textbox:OnChanged(Func)
            Textbox.Changed = Func;
            Func(Textbox.Value);
        end;

        Groupbox:AddBlank(5);
        Groupbox:Resize();

        Options[Idx] = Textbox;

        return Textbox;
    end;




function Funcs:AddToggle(Idx, Info)
    assert(Info.Text, 'AddInput: Missing `Text` string.')


    local Toggle = {
        Value = Info.Default or false;
        Type = 'Toggle';
        IsHovered = false;
        Callback = Info.Callback or function(Value) end;
        Addons = {};
        Risky = Info.Risky;
    }

    local Groupbox = self
    local Container = Groupbox.Container

local ToggleOuter = Library:Create('Frame', {
    BackgroundColor3 = Color3.fromRGB(0, 0, 0);
    BorderColor3 = Color3.fromRGB(0, 0, 0);
    Size = UDim2.new(0, 13, 0, 13);
    ZIndex = 5;
    Parent = Container;
})




		
    Library:AddToRegistry(ToggleOuter, {
        BorderColor3 = 'Black';
    })

    local ToggleInner = Library:Create('Frame', {
        BackgroundColor3 = Toggle.Value and Library.AccentColor or Color3.new(0, 0, 0),
        BorderColor3 = Toggle.Value and Library.AccentColorDark or Library.InactiveColorDark;
        BorderMode = Enum.BorderMode.Inset;
        Size = UDim2.new(1, 0, 1, 0);
        ZIndex = 6;
        Parent = ToggleOuter;
    })


local Stroke = Instance.new('UIStroke')
Stroke.Thickness = 0.6
Stroke.Color = Color3.fromRGB(60, 60, 60)
Stroke.Transparency = 0
Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
Stroke.Parent = ToggleInner


    local ToggleLabel = Library:CreateLabel({
        Size = UDim2.new(0, 216, 1, 0);
        Position = UDim2.new(1, 6, 0, 0);
        TextSize = 12;
        Text = Info.Text;
        TextXAlignment = Enum.TextXAlignment.Left;
        ZIndex = 6;
        Parent = ToggleOuter;
    })
    
    -- Set initial color based on toggle state BEFORE adding UIListLayout
    if not Toggle.Value then
        ToggleLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    end

    Library:Create('UIListLayout', {
        Padding = UDim.new(0, 4);
        FillDirection = Enum.FillDirection.Horizontal;
        HorizontalAlignment = Enum.HorizontalAlignment.Right;
        SortOrder = Enum.SortOrder.LayoutOrder;
        Parent = ToggleLabel;
    })

    local ToggleRegion = Library:Create('Frame', {
        BackgroundTransparency = 1;
        Size = UDim2.new(0, 170, 1, 0);
        ZIndex = 8;
        Parent = ToggleOuter;
    })

		if type(Info.Tooltip) == 'string' then
    Library:AddToolTip(Info.Tooltip, ToggleRegion)
end
		

    ToggleRegion.MouseEnter:Connect(function()
        Toggle.IsHovered = true;
        if not Toggle.Value then
            TweenService:Create(ToggleOuter, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
                BorderColor3 = Library.AccentColor
            }):Play();
        end
    end)

    ToggleRegion.MouseLeave:Connect(function()
        Toggle.IsHovered = false;
        if not Toggle.Value then
            TweenService:Create(ToggleOuter, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
                BorderColor3 = Color3.new(0, 0, 0)
            }):Play();
        end
    end)

    function Toggle:UpdateColors()
        Toggle:Display()
    end

    function Toggle:Display()
        local bgColor = Toggle.Value and Library.AccentColor or Color3.fromRGB(25, 25, 25)
        local borderColor = Toggle.Value and Library.AccentColorDark or Color3.fromRGB(40, 40, 40)
        local outerColor = Toggle.Value and Library.AccentColor or (Toggle.IsHovered and Library.AccentColor or Color3.fromRGB(30, 30, 30))
        local textColor = Toggle.Value and Library.FontColor or Color3.fromRGB(150, 150, 150)

        TweenService:Create(ToggleInner, TweenInfo.new(0.6, Enum.EasingStyle.Quad), {
            BackgroundColor3 = bgColor,
            BorderColor3 = borderColor
        }):Play()

        TweenService:Create(ToggleOuter, TweenInfo.new(0.6, Enum.EasingStyle.Quad), {
            BorderColor3 = outerColor
        }):Play()

			TweenService:Create(Stroke, TweenInfo.new(0.6, Enum.EasingStyle.Quad), {
    Color = Toggle.Value and Library.AccentColor or Color3.fromRGB(60, 60, 60)
}):Play()


        if not Toggle.Risky then
            TweenService:Create(ToggleLabel, TweenInfo.new(0.6, Enum.EasingStyle.Quad), {
                TextColor3 = textColor
            }):Play()
        end
    end

    function Toggle:OnChanged(Func)
        Toggle.Changed = Func;
        Func(Toggle.Value)
getgenv().logMessage(1, tostring(Toggle).." Changed to "..tostring(Toggle.Value))

    end

    function Toggle:SetValue(Bool)
        Bool = (not not Bool);
        Toggle.Value = Bool;
        Toggle:Display()

        for _, Addon in next, Toggle.Addons do
            if Addon.Type == 'KeyPicker' and Addon.SyncToggleState then
                Addon.Toggled = Bool
                Addon:Update()
            end
        end

        Library:SafeCallback(Toggle.Callback, Toggle.Value)
        Library:SafeCallback(Toggle.Changed, Toggle.Value)
        Library:UpdateDependencyBoxes()
    end

    ToggleRegion.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 and not Library:MouseIsOverOpenedFrame() then
            Toggle:SetValue(not Toggle.Value)
            Library:AttemptSave()
        end
    end)

    if Toggle.Risky then
        Library:RemoveFromRegistry(ToggleLabel)
        ToggleLabel.TextColor3 = Library.RiskColor
        Library:AddToRegistry(ToggleLabel, { TextColor3 = 'RiskColor' })
    else
        -- For non-risky toggles, set the correct initial color
        Library:RemoveFromRegistry(ToggleLabel)
        if Toggle.Value then
            ToggleLabel.TextColor3 = Library.FontColor
            Library:AddToRegistry(ToggleLabel, { TextColor3 = 'FontColor' })
        else
            ToggleLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
            Library:AddToRegistry(ToggleLabel, { TextColor3 = function() 
                return Toggle.Value and Library.FontColor or Color3.fromRGB(150, 150, 150)
            end })
        end
    end

    -- Set all initial visual states without animation
    local bgColor = Toggle.Value and Library.AccentColor or Color3.fromRGB(25, 25, 25)
    local borderColor = Toggle.Value and Library.AccentColorDark or Color3.fromRGB(40, 40, 40)
    local outerColor = Toggle.Value and Library.AccentColor or Color3.fromRGB(30, 30, 30)
    
    ToggleInner.BackgroundColor3 = bgColor
    ToggleInner.BorderColor3 = borderColor
    ToggleOuter.BorderColor3 = outerColor

    Groupbox:AddBlank(Info.BlankSize or 5 + 2)
    Groupbox:Resize()

    Toggle.TextLabel = ToggleLabel
    Toggle.Container = Container
    setmetatable(Toggle, BaseAddons)

    Toggles[Idx] = Toggle
    Library:UpdateDependencyBoxes()

    return Toggle
end

	
task.spawn(function()
	local lastColor = Library.AccentColorDark;
	while true do
		task.wait(0.31);
		local current = Library.AccentColorDark;
		if current ~= lastColor then
			lastColor = current;
			for _, t in next, Toggles do
				local d = t.Display;
				if d then d(t); end;
			end;
		end;
	end;
end);


function Funcs:AddSlider(Idx, Info)
        assert(Info.Default, 'AddSlider: Missing default value.');
        assert(Info.Text, 'AddSlider: Missing slider text.');
        assert(Info.Min, 'AddSlider: Missing minimum value.');
        assert(Info.Max, 'AddSlider: Missing maximum value.');
        assert(Info.Rounding, 'AddSlider: Missing rounding value.');

        local Slider = {
            Value = Info.Default;
            Min = Info.Min;
            Max = Info.Max;
            Rounding = Info.Rounding;
            MaxSize = 232;
            Type = 'Slider';
            Callback = Info.Callback or function(Value) end;
            IsTouched = false; -- Dokunma durumu
        };

        local Groupbox = self;
        local Container = Groupbox.Container;

local TitleLabel
if not Info.Compact then
    TitleLabel = Library:CreateLabel({
        Size = UDim2.new(1, 0, 0, 10);
        TextSize = 12;
        Text = Info.Text;
        TextXAlignment = Enum.TextXAlignment.Left;
        TextYAlignment = Enum.TextYAlignment.Bottom;
        ZIndex = 5;
        Parent = Container;
    });

    -- START WITH GREY COLOR
    TitleLabel.TextColor3 = Color3.fromRGB(105, 105, 105);
    Slider.IsTouched = false -- Start as not touched

    Groupbox:AddBlank(3);
end

        local SliderOuter = Library:Create('Frame', {
            BackgroundColor3 = Color3.new(0, 0, 0);
            BorderColor3 = Color3.new(0, 0, 0);
            Size = UDim2.new(1, -4, 0, 13);
            ZIndex = 5;
            Parent = Container;
        });

        Library:AddToRegistry(SliderOuter, {
            BorderColor3 = 'Black';
        });

        local SliderInner = Library:Create('Frame', {
            BackgroundColor3 = Library.MainColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 6;
            Parent = SliderOuter;
        });

        Library:AddToRegistry(SliderInner, {
            BackgroundColor3 = 'MainColor';
            BorderColor3 = 'OutlineColor';
        });

        local Fill = Library:Create('Frame', {
            BackgroundColor3 = Library.AccentColor;
            BorderColor3 = Library.AccentColorDark;
            Size = UDim2.new(0, 0, 1, 0);
            ZIndex = 7;
            Parent = SliderInner;
        });

        Library:AddToRegistry(Fill, {
            BackgroundColor3 = 'AccentColor';
            BorderColor3 = 'AccentColorDark';
        });

        local HideBorderRight = Library:Create('Frame', {
            BackgroundColor3 = Library.AccentColor;
            BorderSizePixel = 0;
            Position = UDim2.new(1, 0, 0, 0);
            Size = UDim2.new(0, 1, 1, 0);
            ZIndex = 8;
            Parent = Fill;
        });

        Library:AddToRegistry(HideBorderRight, {
            BackgroundColor3 = 'AccentColor';
        });

local DisplayLabel = Library:CreateLabel({
    Size = UDim2.new(1, 0, 1, 0);
    TextSize = 12;
    -- Don't set Text = 'Infinite', let Display() set it
    ZIndex = 9;
    Parent = SliderInner;
});


        Library:OnHighlight(SliderOuter, SliderOuter,
            { BorderColor3 = 'AccentColor' },
            { BorderColor3 = 'Black' }
        );

        if type(Info.Tooltip) == 'string' then
            Library:AddToolTip(Info.Tooltip, SliderOuter)
        end

        function Slider:UpdateColors()
            Fill.BackgroundColor3 = Library.AccentColor;
            Fill.BorderColor3 = Library.AccentColorDark;
        end;

        -- Smooth tween fonksiyonu
-- Add to slider creation:
local ActiveTweens = {}

function Slider:TweenFill(targetSize)
    -- Cancel previous tween
    if ActiveTweens[Fill] then
        ActiveTweens[Fill]:Cancel()
    end
    
    local tween = TweenService:Create(Fill, TweenInfo.new(0.75, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = targetSize})
    ActiveTweens[Fill] = tween
    tween:Play()
    
    tween.Completed:Connect(function()
        ActiveTweens[Fill] = nil
    end)
end

        -- Text renk değiştirme fonksiyonu (Title için)
        function Slider:UpdateTextColor(touched)
            if TitleLabel then
                local TweenService = game:GetService("TweenService")
                local tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                local targetColor = touched and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(128, 128, 128)
                local colorTween = TweenService:Create(TitleLabel, tweenInfo, {TextColor3 = targetColor})
                colorTween:Play()
            end
        end

function Slider:Display()
    local Suffix = Info.Suffix or '';
    
    -- Format the value properly to avoid showing 0 for small decimals
    local displayValue = Slider.Value
    if Slider.Rounding > 0 then
        displayValue = string.format('%.' .. Slider.Rounding .. 'f', Slider.Value)
    end
    
    if Info.Compact then
        DisplayLabel.Text = Info.Text .. ': ' .. displayValue .. Suffix;
    elseif Info.HideMax then
        DisplayLabel.Text = string.format('%s', displayValue .. Suffix);
    else
        DisplayLabel.Text = string.format('%s/%s', displayValue .. Suffix, Slider.Max .. Suffix);
    end

    local X = math.ceil(Library:MapValue(Slider.Value, Slider.Min, Slider.Max, 0, Slider.MaxSize));
    Slider:TweenFill(UDim2.new(0, X, 1, 0));
    HideBorderRight.Visible = not (X == Slider.MaxSize or X == 0);
end;


        function Slider:OnChanged(Func)
            Slider.Changed = Func;
            Func(Slider.Value);
        end;

        local function Round(Value)
            if Slider.Rounding == 0 then
                return math.floor(Value);
            end;

            return tonumber(string.format('%.' .. Slider.Rounding .. 'f', Value))
        end;

        function Slider:GetValueFromXOffset(X)
            return Round(Library:MapValue(X, 0, Slider.MaxSize, Slider.Min, Slider.Max));
        end;

        function Slider:SetValue(Str)
            local Num = tonumber(Str);

            if (not Num) then
                return;
            end;

            Num = math.clamp(Num, Slider.Min, Slider.Max);

            Slider.Value = Num;
            Slider:Display();

            -- Değer değiştiğinde dokunulmuş olarak işaretle
            if not Slider.IsTouched then
                Slider.IsTouched = true;
                Slider:UpdateTextColor(true);
            end

            Library:SafeCallback(Slider.Callback, Slider.Value);
            Library:SafeCallback(Slider.Changed, Slider.Value);
        end;

        SliderInner.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 and not Library:MouseIsOverOpenedFrame() then
					Slider:UpdateTextColor(false)
                local mPos = Mouse.X;
                local gPos = Fill.Size.X.Offset;
                local Diff = mPos - (Fill.AbsolutePosition.X + gPos);

                -- Slider'a dokunulduğunda text rengini beyaz yap
                if not Slider.IsTouched then
                    Slider.IsTouched = true;
                end
                Slider:UpdateTextColor(true);

                while InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                    local nMPos = Mouse.X;
                    local nX = math.clamp(gPos + (nMPos - mPos) + Diff, 0, Slider.MaxSize);

                    local nValue = Slider:GetValueFromXOffset(nX);
                    local OldValue = Slider.Value;
                    Slider.Value = nValue;

                    -- Smooth tween ile hareket ettir
                    Slider:TweenFill(UDim2.new(0, nX, 1, 0));
                    
                    local Suffix = Info.Suffix or '';
                    if Info.Compact then
                        DisplayLabel.Text = Info.Text .. ': ' .. Slider.Value .. Suffix
                    elseif Info.HideMax then
                        DisplayLabel.Text = string.format('%s', Slider.Value .. Suffix)
                    else
                        DisplayLabel.Text = string.format('%s/%s', Slider.Value .. Suffix, Slider.Max .. Suffix);
                    end

                    HideBorderRight.Visible = not (nX == Slider.MaxSize or nX == 0);

                    if nValue ~= OldValue then
                        Library:SafeCallback(Slider.Callback, Slider.Value);
                        Library:SafeCallback(Slider.Changed, Slider.Value);
                    end;

                    RenderStepped:Wait();
                end;

                -- Mouse bırakıldığında text rengini geri gri yap
                wait(0.1) -- Kısa bir bekleme
                Slider:UpdateTextColor(false);

                Library:AttemptSave();
            end;
        end);

        Slider:Display();
        Groupbox:AddBlank(Info.BlankSize or 6);
        Groupbox:Resize();

        Options[Idx] = Slider;

        return Slider;
    end;





function Funcs:AddDropdown(Idx, Info)
    if Info.SpecialType == 'Player' then
        Info.Values = GetPlayersString();
        Info.AllowNull = true;
    elseif Info.SpecialType == 'Team' then
        Info.Values = GetTeamsString();
        Info.AllowNull = true;
    end;

    assert(Info.Values, 'AddDropdown: Missing dropdown value list.');
    assert(Info.AllowNull or Info.Default, 'AddDropdown: Missing default value. Pass AllowNull as true if this was intentional.')

    if (not Info.Text) then
        Info.Compact = true;
    end;

    local Dropdown = {
        Values = Info.Values;
        Value = Info.Multi and {};
        Multi = Info.Multi;
        Type = 'Dropdown';
        SpecialType = Info.SpecialType; -- can be either 'Player' or 'Team'
        Callback = Info.Callback or function(Value) end;
        IsAnimating = false; -- Add animation state tracking
    };

    local Groupbox = self;
    local Container = Groupbox.Container;

    local RelativeOffset = 0;

    -- Tween settings for smooth animations
    local TweenService = game:GetService("TweenService");
    local TweenInfo_Fast = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    local TweenInfo_Smooth = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);

    if not Info.Compact then
        local DropdownLabel = Library:CreateLabel({
            Size = UDim2.new(1, 0, 0, 10);
            TextSize = 14;
            Text = Info.Text;
            TextXAlignment = Enum.TextXAlignment.Left;
            TextYAlignment = Enum.TextYAlignment.Bottom;
            ZIndex = 5;
            Parent = Container;
        });

        Groupbox:AddBlank(3);
    end

    for _, Element in next, Container:GetChildren() do
        if not Element:IsA('UIListLayout') then
            RelativeOffset = RelativeOffset + Element.Size.Y.Offset;
        end;
    end;

    local DropdownOuter = Library:Create('Frame', {
        BackgroundColor3 = Color3.new(0, 0, 0);
        BorderColor3 = Color3.new(0, 0, 0);
        Size = UDim2.new(1, -4, 0, 20);
        ZIndex = 5;
        Parent = Container;
    });

    Library:AddToRegistry(DropdownOuter, {
        BorderColor3 = 'Black';
    });

    local DropdownInner = Library:Create('Frame', {
        BackgroundColor3 = Library.MainColor;
        BorderColor3 = Library.OutlineColor;
        BorderMode = Enum.BorderMode.Inset;
        Size = UDim2.new(1, 0, 1, 0);
        ZIndex = 6;
        Parent = DropdownOuter;
    });

    Library:AddToRegistry(DropdownInner, {
        BackgroundColor3 = 'MainColor';
        BorderColor3 = 'OutlineColor';
    });

    Library:Create('UIGradient', {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(212, 212, 212))
        });
        Rotation = 90;
        Parent = DropdownInner;
    });

    local DropdownArrow = Library:Create('ImageLabel', {
        AnchorPoint = Vector2.new(0, 0.5);
        BackgroundTransparency = 1;
        Position = UDim2.new(1, -16, 0.5, 0);
        Size = UDim2.new(0, 12, 0, 12);
        Image = 'http://www.roblox.com/asset/?id=6282522798';
        ZIndex = 8;
        Parent = DropdownInner;
    });

    local ItemList = Library:CreateLabel({
        Position = UDim2.new(0, 5, 0, 0);
        Size = UDim2.new(1, -5, 1, 0);
        TextSize = 12;
        Text = '--';
        TextXAlignment = Enum.TextXAlignment.Left;
        TextWrapped = true;
        ZIndex = 7;
        Parent = DropdownInner;
    });

    Library:OnHighlight(DropdownOuter, DropdownOuter,
        { BorderColor3 = 'AccentColor' },
        { BorderColor3 = 'Black' }
    );

    if type(Info.Tooltip) == 'string' then
        Library:AddToolTip(Info.Tooltip, DropdownOuter)
    end

    local MAX_DROPDOWN_ITEMS = 8;

    local ListOuter = Library:Create('Frame', {
        BackgroundColor3 = Color3.new(0, 0, 0);
        BorderColor3 = Color3.new(0, 0, 0);
        ZIndex = 20;
        Visible = false;
        Parent = ScreenGui;
        -- Start with zero size for animation
        Size = UDim2.fromOffset(0, 0);
    });

    local function RecalculateListPosition()
        ListOuter.Position = UDim2.fromOffset(DropdownOuter.AbsolutePosition.X, DropdownOuter.AbsolutePosition.Y + DropdownOuter.Size.Y.Offset + 1);
    end;

    local function RecalculateListSize(YSize)
        -- Store the target size for animations
        Dropdown.TargetSize = UDim2.fromOffset(DropdownOuter.AbsoluteSize.X, YSize or (MAX_DROPDOWN_ITEMS * 20 + 2));
    end;

    RecalculateListPosition();
    RecalculateListSize();

    DropdownOuter:GetPropertyChangedSignal('AbsolutePosition'):Connect(RecalculateListPosition);

    local ListInner = Library:Create('Frame', {
        BackgroundColor3 = Library.MainColor;
        BorderColor3 = Library.OutlineColor;
        BorderMode = Enum.BorderMode.Inset;
        BorderSizePixel = 0;
        Size = UDim2.new(1, 0, 1, 0);
        ZIndex = 21;
        Parent = ListOuter;
    });

    Library:AddToRegistry(ListInner, {
        BackgroundColor3 = 'MainColor';
        BorderColor3 = 'OutlineColor';
    });

    local Scrolling = Library:Create('ScrollingFrame', {
        BackgroundTransparency = 1;
        BorderSizePixel = 0;
        CanvasSize = UDim2.new(0, 0, 0, 0);
        Size = UDim2.new(1, 0, 1, 0);
        ZIndex = 21;
        Parent = ListInner;

        TopImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png',
        BottomImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png',

        ScrollBarThickness = 3,
        ScrollBarImageColor3 = Library.AccentColor,
    });

    Library:AddToRegistry(Scrolling, {
        ScrollBarImageColor3 = 'AccentColor'
    })

    Library:Create('UIListLayout', {
        Padding = UDim.new(0, 0);
        FillDirection = Enum.FillDirection.Vertical;
        SortOrder = Enum.SortOrder.LayoutOrder;
        Parent = Scrolling;
    });

    function Dropdown:Display()
        local Values = Dropdown.Values;
        local Str = '';

        if Info.Multi then
            for Idx, Value in next, Values do
                if Dropdown.Value[Value] then
                    Str = Str .. Value .. ', ';
                end;
            end;

            Str = Str:sub(1, #Str - 2);
        else
            Str = Dropdown.Value or '';
        end;

        ItemList.Text = (Str == '' and '--' or Str);
    end;

    function Dropdown:GetActiveValues()
        if Info.Multi then
            local T = {};

            for Value, Bool in next, Dropdown.Value do
                table.insert(T, Value);
            end;

            return T;
        else
            return Dropdown.Value and 1 or 0;
        end;
    end;

    function Dropdown:BuildDropdownList()
        local Values = Dropdown.Values;
        local Buttons = {};

        for _, Element in next, Scrolling:GetChildren() do
            if not Element:IsA('UIListLayout') then
                Element:Destroy();
            end;
        end;

        local Count = 0;

        for Idx, Value in next, Values do
            local Table = {};

            Count = Count + 1;

            local Button = Library:Create('Frame', {
                BackgroundColor3 = Library.MainColor;
                BorderColor3 = Library.OutlineColor;
                BorderMode = Enum.BorderMode.Middle;
                Size = UDim2.new(1, -1, 0, 20);
                ZIndex = 23;
                Active = true,
                Parent = Scrolling;
            });

            Library:AddToRegistry(Button, {
                BackgroundColor3 = 'MainColor';
                BorderColor3 = 'OutlineColor';
            });

            local ButtonLabel = Library:CreateLabel({
                Active = false;
                Size = UDim2.new(1, -6, 1, 0);
                Position = UDim2.new(0, 6, 0, 0);
                TextSize = 12;
                Text = Value;
                TextXAlignment = Enum.TextXAlignment.Left;
                ZIndex = 25;
                Parent = Button;
            });

            Library:OnHighlight(Button, Button,
                { BorderColor3 = 'AccentColor', ZIndex = 24 },
                { BorderColor3 = 'OutlineColor', ZIndex = 23 }
            );

            local Selected;

            if Info.Multi then
                Selected = Dropdown.Value[Value];
            else
                Selected = Dropdown.Value == Value;
            end;

            function Table:UpdateButton()
                if Info.Multi then
                    Selected = Dropdown.Value[Value];
                else
                    Selected = Dropdown.Value == Value;
                end;

                -- Smooth color transition for selection
                local targetColor = Selected and Library.AccentColor or Library.FontColor;
                local colorTween = TweenService:Create(ButtonLabel, TweenInfo_Fast, {
                    TextColor3 = targetColor
                });
                colorTween:Play();

                Library.RegistryMap[ButtonLabel].Properties.TextColor3 = Selected and 'AccentColor' or 'FontColor';
            end;

            -- Add smooth hover effect
            local function CreateHoverEffect()
                local originalSize = Button.Size;
                
                Button.MouseEnter:Connect(function()
                    if not Dropdown.IsAnimating then
                        local hoverTween = TweenService:Create(Button, TweenInfo_Fast, {
                            Size = UDim2.new(originalSize.X.Scale, originalSize.X.Offset + 2, originalSize.Y.Scale, originalSize.Y.Offset)
                        });
                        hoverTween:Play();
                    end
                end);

                Button.MouseLeave:Connect(function()
                    if not Dropdown.IsAnimating then
                        local unhoverTween = TweenService:Create(Button, TweenInfo_Fast, {
                            Size = originalSize
                        });
                        unhoverTween:Play();
                    end
                end);
            end;

            CreateHoverEffect();

            ButtonLabel.InputBegan:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    -- Add click animation
                    local clickTween = TweenService:Create(Button, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {
                        Size = UDim2.new(Button.Size.X.Scale, Button.Size.X.Offset - 4, Button.Size.Y.Scale, Button.Size.Y.Offset)
                    });
                    
                    clickTween:Play();
                    clickTween.Completed:Connect(function()
                        local returnTween = TweenService:Create(Button, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {
                            Size = UDim2.new(1, -1, 0, 20)
                        });
                        returnTween:Play();
                    end);

                    local Try = not Selected;

                    if Dropdown:GetActiveValues() == 1 and (not Try) and (not Info.AllowNull) then
                    else
                        if Info.Multi then
                            Selected = Try;

                            if Selected then
                                Dropdown.Value[Value] = true;
                            else
                                Dropdown.Value[Value] = nil;
                            end;
                        else
                            Selected = Try;

                            if Selected then
                                Dropdown.Value = Value;
                            else
                                Dropdown.Value = nil;
                            end;

                            for _, OtherButton in next, Buttons do
                                OtherButton:UpdateButton();
                            end;
                        end;

                        Table:UpdateButton();
                        Dropdown:Display();

                        Library:SafeCallback(Dropdown.Callback, Dropdown.Value);
                        Library:SafeCallback(Dropdown.Changed, Dropdown.Value);

                        Library:AttemptSave();
                    end;
                end;
            end);

            Table:UpdateButton();
            Dropdown:Display();

            Buttons[Button] = Table;
        end;

        Scrolling.CanvasSize = UDim2.fromOffset(0, (Count * 20) + 1);

        local Y = math.clamp(Count * 20, 0, MAX_DROPDOWN_ITEMS * 20) + 1;
        RecalculateListSize(Y);
    end;

    function Dropdown:SetValues(NewValues)
        if NewValues then
            Dropdown.Values = NewValues;
        end;

        Dropdown:BuildDropdownList();
    end;

    function Dropdown:OpenDropdown()
        if Dropdown.IsAnimating then return end;
        
        Dropdown.IsAnimating = true;
        ListOuter.Visible = true;
        Library.OpenedFrames[ListOuter] = true;
        
        -- Animate dropdown opening
        ListOuter.Size = UDim2.fromOffset(Dropdown.TargetSize.X.Offset, 0);
        
        local openTween = TweenService:Create(ListOuter, TweenInfo_Smooth, {
            Size = Dropdown.TargetSize
        });
        
        local arrowTween = TweenService:Create(DropdownArrow, TweenInfo_Smooth, {
            Rotation = 180
        });
        
        openTween:Play();
        arrowTween:Play();
        
        openTween.Completed:Connect(function()
            Dropdown.IsAnimating = false;
        end);
    end;

    function Dropdown:CloseDropdown()
        if Dropdown.IsAnimating then return end;
        
        Dropdown.IsAnimating = true;
        
        local closeTween = TweenService:Create(ListOuter, TweenInfo_Smooth, {
            Size = UDim2.fromOffset(Dropdown.TargetSize.X.Offset, 0)
        });
        
        local arrowTween = TweenService:Create(DropdownArrow, TweenInfo_Smooth, {
            Rotation = 0
        });
        
        closeTween:Play();
        arrowTween:Play();
        
        closeTween.Completed:Connect(function()
            ListOuter.Visible = false;
            Library.OpenedFrames[ListOuter] = nil;
            Dropdown.IsAnimating = false;
        end);
    end;

    function Dropdown:OnChanged(Func)
        Dropdown.Changed = Func;
        Func(Dropdown.Value);
    end;

    function Dropdown:SetValue(Val)
        if Dropdown.Multi then
            local nTable = {};

            for Value, Bool in next, Val do
                if table.find(Dropdown.Values, Value) then
                    nTable[Value] = true
                end;
            end;

            Dropdown.Value = nTable;
        else
            if (not Val) then
                Dropdown.Value = nil;
            elseif table.find(Dropdown.Values, Val) then
                Dropdown.Value = Val;
            end;
        end;

        Dropdown:BuildDropdownList();

        Library:SafeCallback(Dropdown.Callback, Dropdown.Value);
        Library:SafeCallback(Dropdown.Changed, Dropdown.Value);
    end;

    DropdownOuter.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 and not Library:MouseIsOverOpenedFrame() then
            if ListOuter.Visible then
                Dropdown:CloseDropdown();
            else
                Dropdown:OpenDropdown();
            end;
        end;
    end);

    InputService.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
            local AbsPos, AbsSize = ListOuter.AbsolutePosition, ListOuter.AbsoluteSize;

            if Mouse.X < AbsPos.X or Mouse.X > AbsPos.X + AbsSize.X
                or Mouse.Y < (AbsPos.Y - 20 - 1) or Mouse.Y > AbsPos.Y + AbsSize.Y then

                Dropdown:CloseDropdown();
            end;
        end;
    end);

    Dropdown:BuildDropdownList();
    Dropdown:Display();

    local Defaults = {}

    if type(Info.Default) == 'string' then
        local Idx = table.find(Dropdown.Values, Info.Default)
        if Idx then
            table.insert(Defaults, Idx)
        end
    elseif type(Info.Default) == 'table' then
        for _, Value in next, Info.Default do
            local Idx = table.find(Dropdown.Values, Value)
            if Idx then
                table.insert(Defaults, Idx)
            end
        end
    elseif type(Info.Default) == 'number' and Dropdown.Values[Info.Default] ~= nil then
        table.insert(Defaults, Info.Default)
    end

    if next(Defaults) then
        for i = 1, #Defaults do
            local Index = Defaults[i]
            if Info.Multi then
                Dropdown.Value[Dropdown.Values[Index]] = true
            else
                Dropdown.Value = Dropdown.Values[Index];
            end

            if (not Info.Multi) then break end
        end

        Dropdown:BuildDropdownList();
        Dropdown:Display();
    end

    Groupbox:AddBlank(Info.BlankSize or 5);
    Groupbox:Resize();

    Options[Idx] = Dropdown;

    return Dropdown;
end;
	


    function Funcs:AddDependencyBox()
        local Depbox = {
            Dependencies = {};
        };
        
        local Groupbox = self;
        local Container = Groupbox.Container;

        local Holder = Library:Create('Frame', {
            BackgroundTransparency = 1;
            Size = UDim2.new(1, 0, 0, 0);
            Visible = false;
            Parent = Container;
        });

        local Frame = Library:Create('Frame', {
            BackgroundTransparency = 1;
            Size = UDim2.new(1, 0, 1, 0);
            Visible = true;
            Parent = Holder;
        });

        local Layout = Library:Create('UIListLayout', {
            FillDirection = Enum.FillDirection.Vertical;
            SortOrder = Enum.SortOrder.LayoutOrder;
            Parent = Frame;
        });

        function Depbox:Resize()
            Holder.Size = UDim2.new(1, 0, 0, Layout.AbsoluteContentSize.Y);
            Groupbox:Resize();
        end;

        Layout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
            Depbox:Resize();
        end);

        Holder:GetPropertyChangedSignal('Visible'):Connect(function()
            Depbox:Resize();
        end);

        function Depbox:Update()
            for _, Dependency in next, Depbox.Dependencies do
                local Elem = Dependency[1];
                local Value = Dependency[2];

                if Elem.Type == 'Toggle' and Elem.Value ~= Value then
                    Holder.Visible = false;
                    Depbox:Resize();
                    return;
                end;
            end;

            Holder.Visible = true;
            Depbox:Resize();
        end;

        function Depbox:SetupDependencies(Dependencies)
            for _, Dependency in next, Dependencies do
                assert(type(Dependency) == 'table', 'SetupDependencies: Dependency is not of type `table`.');
                assert(Dependency[1], 'SetupDependencies: Dependency is missing element argument.');
                assert(Dependency[2] ~= nil, 'SetupDependencies: Dependency is missing value argument.');
            end;

            Depbox.Dependencies = Dependencies;
            Depbox:Update();
        end;

        Depbox.Container = Frame;

        setmetatable(Depbox, BaseGroupbox);

        table.insert(Library.DependencyBoxes, Depbox);

        return Depbox;
    end;

    BaseGroupbox.__index = Funcs;
    BaseGroupbox.__namecall = function(Table, Key, ...)
        return Funcs[Key](...);
    end;


-- < Create other UI elements >
do
    Library.NotificationArea = Library:Create('Frame', {
        BackgroundTransparency = 1;
        Position = UDim2.new(0, 0, 0, 40);
        Size = UDim2.new(0, 300, 0, 200);
        ZIndex = 100;
        Parent = ScreenGui;
    });

    Library:Create('UIListLayout', {
        Padding = UDim.new(0, 4);
        FillDirection = Enum.FillDirection.Vertical;
        SortOrder = Enum.SortOrder.LayoutOrder;
        Parent = Library.NotificationArea;
    });

    local WatermarkOuter = Library:Create('Frame', {
        BorderColor3 = Color3.new(0, 0, 0);
        Position = UDim2.new(0, 100, 0, -25);
        Size = UDim2.new(0, 213, 0, 20);
        ZIndex = 200;
        Visible = false;
        Parent = ScreenGui;
    });

    local WatermarkInner = Library:Create('Frame', {
        BackgroundColor3 = Library.MainColor;
        BorderColor3 = Library.AccentColor;
        BorderMode = Enum.BorderMode.Inset;
        Size = UDim2.new(1, 0, 1, 0);
        ZIndex = 201;
        Parent = WatermarkOuter;
    });







local glow = Instance.new("ImageLabel", WatermarkOuter)
glow.Name = "GlowEffect"
glow.Image = "rbxassetid://18245826428" -- Glow texture ID
glow.ScaleType = Enum.ScaleType.Slice
glow.SliceCenter = Rect.new(21, 21, 79, 79)
glow.ImageColor3 = Library.AccentColor
glow.ImageTransparency = 0.6
glow.BackgroundTransparency = 1
glow.Size = UDim2.new(1, 40, 1, 40)
glow.Position = UDim2.new(0, -20, 0, -20)
glow.ZIndex = -1

-- Create pulsing animation
local TweenService = game:GetService("TweenService")
local startTransparency = 0.8
local minTransparency = 0.5
local pulseDuration = getgenv().glowwatermarkspeed or 4

local pulseInfo = TweenInfo.new(
	pulseDuration / 2,
	Enum.EasingStyle.Sine,
	Enum.EasingDirection.InOut
)

local function createPulseTween()
	local tweenOut = TweenService:Create(glow, pulseInfo, {ImageTransparency = minTransparency})
	local tweenIn = TweenService:Create(glow, pulseInfo, {ImageTransparency = startTransparency})
	
	tweenOut.Completed:Connect(function()
		tweenIn:Play()
	end)
	
	tweenIn.Completed:Connect(function()
		tweenOut:Play()
	end)
	
	tweenOut:Play()
end

-- Start pulsing animation
createPulseTween()

-- Watch for color changes and tween them
local lastColor = Library.AccentColor
local colorChangeConnection

colorChangeConnection = game:GetService("RunService").Heartbeat:Connect(function()
	if Library.AccentColor ~= lastColor then
		lastColor = Library.AccentColor
		
		local colorTweenInfo = TweenInfo.new(
			5,
			Enum.EasingStyle.Quad,
			Enum.EasingDirection.Out
		)
		
		local colorTween = TweenService:Create(glow, colorTweenInfo, {ImageColor3 = Library.AccentColor})
		colorTween:Play()
	end
end)






    Library:AddToRegistry(WatermarkInner, {
        BorderColor3 = 'AccentColor';
    });

    local InnerFrame = Library:Create('Frame', {
        BackgroundColor3 = Color3.new(1, 1, 1);
        BorderSizePixel = 0;
        Position = UDim2.new(0, 1, 0, 1);
        Size = UDim2.new(1, -2, 1, -2);
        ZIndex = 202;
        Parent = WatermarkInner;
    });

    local Gradient = Library:Create('UIGradient', {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Library:GetDarkerColor(Library.MainColor)),
            ColorSequenceKeypoint.new(1, Library.MainColor),
        });
        Rotation = -90;
        Parent = InnerFrame;
    });

    Library:AddToRegistry(Gradient, {
        Color = function()
            return ColorSequence.new({
                ColorSequenceKeypoint.new(0, Library:GetDarkerColor(Library.MainColor)),
                ColorSequenceKeypoint.new(1, Library.MainColor),
            });
        end
    });

    local WatermarkLabel = Library:CreateLabel({
        Position = UDim2.new(0, 5, 0, 0);
        Size = UDim2.new(1, -4, 1, 0);
        TextSize = 13;
        TextXAlignment = Enum.TextXAlignment.Left;
        ZIndex = 203;
        Parent = InnerFrame;
    });

    Library.Watermark = WatermarkOuter;
    Library.WatermarkText = WatermarkLabel;
    Library:MakeDraggable(Library.Watermark);



    local KeybindOuter = Library:Create('Frame', {
        AnchorPoint = Vector2.new(0, 0.5);
        BorderColor3 = Color3.new(0, 0, 0);
        Position = UDim2.new(0, 10, 0.5, 0);
        Size = UDim2.new(0, 210, 0, 20);
        Visible = false;
        ZIndex = 100;
        Parent = ScreenGui;
    });

    local KeybindInner = Library:Create('Frame', {
        BackgroundColor3 = Library.MainColor;
        BorderColor3 = Library.OutlineColor;
        BorderMode = Enum.BorderMode.Inset;
        Size = UDim2.new(1, 0, 1, 0);
        ZIndex = 101;
        Parent = KeybindOuter;
    });

    Library:AddToRegistry(KeybindInner, {
        BackgroundColor3 = 'MainColor';
        BorderColor3 = 'OutlineColor';
    }, true);

    local ColorFrame = Library:Create('Frame', {
        BackgroundColor3 = Library.AccentColor;
        BorderSizePixel = 0;
        Size = UDim2.new(1, 0, 0, 2);
        ZIndex = 102;
        Parent = KeybindInner;
    });

    Library:AddToRegistry(ColorFrame, {
        BackgroundColor3 = 'AccentColor';
    }, true);

    local KeybindLabel = Library:CreateLabel({
        Size = UDim2.new(1, 0, 0, 20);
        Position = UDim2.fromOffset(5, 2),
        TextXAlignment = Enum.TextXAlignment.Left,

        Text = 'Keybinds';
        ZIndex = 104;
        Parent = KeybindInner;
    });

    local KeybindContainer = Library:Create('Frame', {
        BackgroundTransparency = 1;
        Size = UDim2.new(1, 0, 1, -20);
        Position = UDim2.new(0, 0, 0, 20);
        ZIndex = 1;
        Parent = KeybindInner;
    });

    Library:Create('UIListLayout', {
        FillDirection = Enum.FillDirection.Vertical;
        SortOrder = Enum.SortOrder.LayoutOrder;
        Parent = KeybindContainer;
    });

    Library:Create('UIPadding', {
        PaddingLeft = UDim.new(0, 5),
        Parent = KeybindContainer,
    })

    Library.KeybindFrame = KeybindOuter;
    Library.KeybindContainer = KeybindContainer;
    Library:MakeDraggable(KeybindOuter);
end;

function Library:SetWatermarkVisibility(Bool)
    Library.Watermark.Visible = Bool;
end;

function Library:SetWatermark(Text)
    local X, Y = Library:GetTextBounds(Text, Library.Font, 14);
    Library.Watermark.Size = UDim2.new(0, X + 15, 0, (Y * 1.5) + 3);
    Library:SetWatermarkVisibility(true)

    Library.WatermarkText.Text = Text;
end;




function Library:Notify(Text, Time, Button1Text, Button2Text)
    local XSize, YSize = Library:GetTextBounds(Text, Library.Font, 14)
    YSize = YSize + 7
    
    local HasButtons = Button1Text ~= nil or Button2Text ~= nil
    local ButtonHeight = HasButtons and 28 or 0
    local TotalHeight = YSize + ButtonHeight + (HasButtons and 10 or 0)
    
    local NotifyOuter = Library:Create('Frame', {
        BackgroundTransparency = 1;
        BorderColor3 = Color3.new(0, 0, 0);
        Position = UDim2.new(0, 100, 0, 10);
        Size = UDim2.new(0, 0, 0, TotalHeight);
        ClipsDescendants = true;
        ZIndex = 100;
        Parent = Library.NotificationArea;
    })
    
    local NotifyInner = Library:Create('Frame', {
        BackgroundColor3 = Library.MainColor;
        BorderColor3 = Library.OutlineColor;
        BorderMode = Enum.BorderMode.Inset;
        Size = UDim2.new(1, 0, 1, 0);
        ZIndex = 101;
        Parent = NotifyOuter;
    })
    
    Library:AddToRegistry(NotifyInner, {
        BackgroundColor3 = 'MainColor';
        BorderColor3 = 'OutlineColor';
    }, true)
    
    local InnerFrame = Library:Create('Frame', {
        BackgroundColor3 = Color3.new(1, 1, 1);
        BorderSizePixel = 0;
        Position = UDim2.new(0, 1, 0, 1);
        Size = UDim2.new(1, -2, 1, -2);
        ZIndex = 102;
        Parent = NotifyInner;
    })
    
    local Gradient = Library:Create('UIGradient', {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Library:GetDarkerColor(Library.MainColor)),
            ColorSequenceKeypoint.new(1, Library.MainColor),
        });
        Rotation = -90;
        Parent = InnerFrame;
    })
    
    Library:AddToRegistry(Gradient, {
        Color = function()
            return ColorSequence.new({
                ColorSequenceKeypoint.new(0, Library:GetDarkerColor(Library.MainColor)),
                ColorSequenceKeypoint.new(1, Library.MainColor),
            });
        end
    })
    
    local TextContainer = Library:Create('Frame', {
        BackgroundTransparency = 1;
        Position = UDim2.new(0, 4, 0, 0);
        Size = UDim2.new(1, -4, 0, YSize);
        ZIndex = 103;
        Parent = InnerFrame;
    })
    
    local NotifyLabel = Library:CreateLabel({
        Size = UDim2.new(1, 0, 1, 0);
        Text = Text;
        TextXAlignment = Enum.TextXAlignment.Left;
        TextSize = 12;
        ZIndex = 103;
        Parent = TextContainer;
    })
    
    local ButtonContainer
    if HasButtons then
        ButtonContainer = Library:Create('Frame', {
            BackgroundTransparency = 1;
            Position = UDim2.new(0, 4, 0, YSize + 5);
            Size = UDim2.new(1, -8, 0, ButtonHeight);
            ZIndex = 103;
            Parent = InnerFrame;
        })
        
        Library:Create('UIListLayout', {
            Padding = UDim.new(0, 4);
            FillDirection = Enum.FillDirection.Horizontal;
            SortOrder = Enum.SortOrder.LayoutOrder;
            Parent = ButtonContainer;
        })
        
        local ButtonSize = Button1Text and Button2Text and 0.5 or 1
        
        if Button1Text then
            local Button1Outer = Library:Create('Frame', {
                BackgroundColor3 = Color3.new(0, 0, 0);
                BorderColor3 = Color3.new(0, 0, 0);
                Size = UDim2.new(ButtonSize, Button2Text and -2 or 0, 1, 0);
                ZIndex = 104;
                LayoutOrder = 1;
                Parent = ButtonContainer;
            })
            
            local Button1Inner = Library:Create('Frame', {
                BackgroundColor3 = Library.MainColor;
                BorderColor3 = Library.OutlineColor;
                BorderMode = Enum.BorderMode.Inset;
                Size = UDim2.new(1, 0, 1, 0);
                ZIndex = 105;
                Parent = Button1Outer;
            })
            
            Library:AddToRegistry(Button1Inner, {
                BackgroundColor3 = 'MainColor';
                BorderColor3 = 'OutlineColor';
            })
            
            local Button1Label = Library:CreateLabel({
                Size = UDim2.new(1, 0, 1, 0);
                TextSize = 11;
                Text = Button1Text;
                TextColor3 = Color3.fromRGB(150, 150, 150);
                ZIndex = 106;
                Parent = Button1Inner;
            })
            
            Button1Outer.MouseEnter:Connect(function()
                TweenService:Create(Button1Inner, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    BackgroundColor3 = Library:GetDarkerColor(Library.MainColor)
                }):Play()
                
                TweenService:Create(Button1Outer, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    BorderColor3 = Library.AccentColor
                }):Play()
                
                TweenService:Create(Button1Label, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    TextColor3 = Library.FontColor
                }):Play()
            end)
            
            Button1Outer.MouseLeave:Connect(function()
                TweenService:Create(Button1Inner, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    BackgroundColor3 = Library.MainColor
                }):Play()
                
                TweenService:Create(Button1Outer, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    BorderColor3 = Color3.new(0, 0, 0)
                }):Play()
                
                TweenService:Create(Button1Label, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    TextColor3 = Color3.fromRGB(150, 150, 150)
                }):Play()
            end)
            
            Button1Outer.InputBegan:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    TweenService:Create(Button1Label, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
                        TextColor3 = Library.AccentColor
                    }):Play()
                    
                    if Library._NotifyButton1Callback then
                        Library:SafeCallback(Library._NotifyButton1Callback)
                    end
                end
            end)
        end
        
        if Button2Text then
            local Button2Outer = Library:Create('Frame', {
                BackgroundColor3 = Color3.new(0, 0, 0);
                BorderColor3 = Color3.new(0, 0, 0);
                Size = UDim2.new(ButtonSize, 0, 1, 0);
                ZIndex = 104;
                LayoutOrder = 2;
                Parent = ButtonContainer;
            })
            
            local Button2Inner = Library:Create('Frame', {
                BackgroundColor3 = Library.MainColor;
                BorderColor3 = Library.OutlineColor;
                BorderMode = Enum.BorderMode.Inset;
                Size = UDim2.new(1, 0, 1, 0);
                ZIndex = 105;
                Parent = Button2Outer;
            })
            
            Library:AddToRegistry(Button2Inner, {
                BackgroundColor3 = 'MainColor';
                BorderColor3 = 'OutlineColor';
            })
            
            local Button2Label = Library:CreateLabel({
                Size = UDim2.new(1, 0, 1, 0);
                TextSize = 11;
                Text = Button2Text;
                TextColor3 = Color3.fromRGB(150, 150, 150);
                ZIndex = 106;
                Parent = Button2Inner;
            })
            
            Button2Outer.MouseEnter:Connect(function()
                TweenService:Create(Button2Inner, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    BackgroundColor3 = Library:GetDarkerColor(Library.MainColor)
                }):Play()
                
                TweenService:Create(Button2Outer, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    BorderColor3 = Library.AccentColor
                }):Play()
                
                TweenService:Create(Button2Label, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    TextColor3 = Library.FontColor
                }):Play()
            end)
            
            Button2Outer.MouseLeave:Connect(function()
                TweenService:Create(Button2Inner, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    BackgroundColor3 = Library.MainColor
                }):Play()
                
                TweenService:Create(Button2Outer, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    BorderColor3 = Color3.new(0, 0, 0)
                }):Play()
                
                TweenService:Create(Button2Label, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    TextColor3 = Color3.fromRGB(150, 150, 150)
                }):Play()
            end)
            
            Button2Outer.InputBegan:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    TweenService:Create(Button2Label, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
                        TextColor3 = Library.AccentColor
                    }):Play()
                    
                    if Library._NotifyButton2Callback then
                        Library:SafeCallback(Library._NotifyButton2Callback)
                    end
                end
            end)
        end
    end
    
    local LeftColor = Library:Create('Frame', {
        BackgroundColor3 = Library.AccentColor;
        BorderSizePixel = 0;
        Position = UDim2.new(0, -1, 0, -1);
        Size = UDim2.new(0, 3, 1, 2);
        ZIndex = 104;
        Parent = NotifyOuter;
    })
    
    Library:AddToRegistry(LeftColor, {
        BackgroundColor3 = 'AccentColor';
    }, true)
    
    local openTween = TweenService:Create(NotifyOuter, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, XSize + 8 + 4, 0, TotalHeight)
    })
    openTween:Play()
    
    local function CloseNotification()
        local closeTween = TweenService:Create(NotifyOuter, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, TotalHeight)
        })
        closeTween:Play()
        
        closeTween.Completed:Connect(function()
            if NotifyOuter and NotifyOuter.Parent then
                NotifyOuter:Destroy()
            end
        end)
    end
    
    if Time and Time > 0 then
        task.spawn(function()
            wait(Time)
            CloseNotification()
        end)
    end
    
    local NotificationObject = {
        OnButton1 = function(self, callback)
            Library._NotifyButton1Callback = function()
                callback()
                CloseNotification()
            end
            return self
        end,
        OnButton2 = function(self, callback)
            Library._NotifyButton2Callback = function()
                callback()
                CloseNotification()
            end
            return self
        end,
        Close = CloseNotification
    }
    
    return NotificationObject
end








function Library:CreateWindow(...)
    local Arguments = { ... }
    local Config = { AnchorPoint = Vector2.zero }

    if type(...) == 'table' then
        Config = ...;
    else
        Config.Title = Arguments[1]
        Config.AutoShow = Arguments[2] or false;
    end

    if type(Config.Title) ~= 'string' then Config.Title = 'No title' end
    if type(Config.TabPadding) ~= 'number' then Config.TabPadding = 0 end
    if type(Config.MenuFadeTime) ~= 'number' then Config.MenuFadeTime = 0.2 end

    if typeof(Config.Position) ~= 'UDim2' then Config.Position = UDim2.fromOffset(175, 50) end
    if typeof(Config.Size) ~= 'UDim2' then Config.Size = UDim2.fromOffset(520, 610) end

    if Config.Center then
        Config.AnchorPoint = Vector2.new(0.5, 0.5)
        Config.Position = UDim2.fromScale(0.5, 0.5)
    end

    local Window = {
        Tabs = {};
    };

    local Outer = Library:Create('Frame', {
        AnchorPoint = Config.AnchorPoint,
        BackgroundColor3 = Color3.new(0, 0, 0);
        BorderSizePixel = 0;
        Position = Config.Position,
        Size = Config.Size,
        Visible = false;
        ZIndex = 1;
        Parent = ScreenGui;
    });

    Library:MakeDraggable(Outer, 25);

    local Inner = Library:Create('Frame', {
        BackgroundColor3 = Library.MainColor;
        BorderColor3 = Library.AccentColor;
        BorderMode = Enum.BorderMode.Inset;
        Position = UDim2.new(0, 1, 0, 1);
        Size = UDim2.new(1, -2, 1, -2);
        ZIndex = 1;
        Parent = Outer;
    });

    Library:AddToRegistry(Inner, {
        BackgroundColor3 = 'MainColor';
        BorderColor3 = 'AccentColor';
    });

    local WindowLabel = Library:CreateLabel({
        Position = UDim2.new(0, 7, 0, 0);
        Size = UDim2.new(0, 0, 0, 25);
        Text = Config.Title or '';
        TextXAlignment = Enum.TextXAlignment.Left;
        ZIndex = 1;
        Parent = Inner;
    });

    local MainSectionOuter = Library:Create('Frame', {
        BackgroundColor3 = Library.BackgroundColor;
        BorderColor3 = Library.OutlineColor;
        Position = UDim2.new(0, 8, 0, 25);
        Size = UDim2.new(1, -16, 1, -33);
        ZIndex = 1;
        Parent = Inner;
    });

    Library:AddToRegistry(MainSectionOuter, {
        BackgroundColor3 = 'BackgroundColor';
        BorderColor3 = 'OutlineColor';
    });

    local MainSectionInner = Library:Create('Frame', {
        BackgroundColor3 = Library.BackgroundColor;
        BorderColor3 = Color3.new(0, 0, 0);
        BorderMode = Enum.BorderMode.Inset;
        Position = UDim2.new(0, 0, 0, 0);
        Size = UDim2.new(1, 0, 1, 0);
        ZIndex = 1;
        Parent = MainSectionOuter;
    });

    Library:AddToRegistry(MainSectionInner, {
        BackgroundColor3 = 'BackgroundColor';
    });

    local TabArea = Library:Create('Frame', {
        BackgroundTransparency = 1;
        Position = UDim2.new(0, 8, 0, 8);
        Size = UDim2.new(1, -16, 0, 21);
        ZIndex = 1;
        Parent = MainSectionInner;
    });

    local TabListLayout = Library:Create('UIListLayout', {
        Padding = UDim.new(0, Config.TabPadding);
        FillDirection = Enum.FillDirection.Horizontal;
        SortOrder = Enum.SortOrder.LayoutOrder;
        Parent = TabArea;
    });

    local TabContainer = Library:Create('Frame', {
        BackgroundColor3 = Library.MainColor;
        BorderColor3 = Library.OutlineColor;
        Position = UDim2.new(0, 8, 0, 30);
        Size = UDim2.new(1, -16, 1, -38);
        ZIndex = 2;
        Parent = MainSectionInner;
    });
    

    Library:AddToRegistry(TabContainer, {
        BackgroundColor3 = 'MainColor';
        BorderColor3 = 'OutlineColor';
    });

    function Window:SetWindowTitle(Title)
        WindowLabel.Text = Title;
    end;

    function Window:AddTab(Name)
        local Tab = {
            Groupboxes = {};
            Tabboxes = {};
        };

        local TabButtonWidth = Library:GetTextBounds(Name, Library.Font, 16);

        local TabButton = Library:Create('Frame', {
            BackgroundColor3 = Library.BackgroundColor;
            BorderColor3 = Library.OutlineColor;
            Size = UDim2.new(0, TabButtonWidth + 8 + 4, 1, 0);
            ZIndex = 1;
            Parent = TabArea;
        });

        Library:AddToRegistry(TabButton, {
            BackgroundColor3 = 'BackgroundColor';
            BorderColor3 = 'OutlineColor';
        });

        local TabButtonLabel = Library:CreateLabel({
            Position = UDim2.new(0, 0, 0, 0);
            Size = UDim2.new(1, 0, 1, -1);
            Text = Name;
            ZIndex = 1;
            Parent = TabButton;
        });

        local Blocker = Library:Create('Frame', {
            BackgroundColor3 = Library.MainColor;
            BorderSizePixel = 0;
            Position = UDim2.new(0, 0, 1, 0);
            Size = UDim2.new(1, 0, 0, 1);
            BackgroundTransparency = 1;
            ZIndex = 3;
            Parent = TabButton;
        });

        Library:AddToRegistry(Blocker, {
            BackgroundColor3 = 'MainColor';
        });

        local TabFrame = Library:Create('Frame', {
            Name = 'TabFrame',
            BackgroundTransparency = 1;
            Position = UDim2.new(0, 0, 0, 0);
            Size = UDim2.new(1, 0, 1, 0);
            Visible = false;
            ZIndex = 2;
            Parent = TabContainer;
        });

        local LeftSide = Library:Create('ScrollingFrame', {
            BackgroundTransparency = 1;
            BorderSizePixel = 0;
            Position = UDim2.new(0, 8 - 1, 0, 8 - 1);
            Size = UDim2.new(0.5, -12 + 2, 0, 507 + 2);
            CanvasSize = UDim2.new(0, 0, 0, 0);
            BottomImage = '';
            TopImage = '';
            ScrollBarThickness = 0;
            ZIndex = 2;
            Parent = TabFrame;
        });

        local RightSide = Library:Create('ScrollingFrame', {
            BackgroundTransparency = 1;
            BorderSizePixel = 0;
            Position = UDim2.new(0.5, 4 + 1, 0, 8 - 1);
            Size = UDim2.new(0.5, -12 + 2, 0, 507 + 2);
            CanvasSize = UDim2.new(0, 0, 0, 0);
            BottomImage = '';
            TopImage = '';
            ScrollBarThickness = 0;
            ZIndex = 2;
            Parent = TabFrame;
        });

        Library:Create('UIListLayout', {
            Padding = UDim.new(0, 8);
            FillDirection = Enum.FillDirection.Vertical;
            SortOrder = Enum.SortOrder.LayoutOrder;
            HorizontalAlignment = Enum.HorizontalAlignment.Center;
            Parent = LeftSide;
        });

        Library:Create('UIListLayout', {
            Padding = UDim.new(0, 8);
            FillDirection = Enum.FillDirection.Vertical;
            SortOrder = Enum.SortOrder.LayoutOrder;
            HorizontalAlignment = Enum.HorizontalAlignment.Center;
            Parent = RightSide;
        });

        for _, Side in next, { LeftSide, RightSide } do
            Side:WaitForChild('UIListLayout'):GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
                Side.CanvasSize = UDim2.fromOffset(0, Side.UIListLayout.AbsoluteContentSize.Y);
            end);
        end;

        function Tab:ShowTab()
            for _, Tab in next, Window.Tabs do
                Tab:HideTab();
            end;

            Blocker.BackgroundTransparency = 0;
            TabButton.BackgroundColor3 = Library.MainColor;
            Library.RegistryMap[TabButton].Properties.BackgroundColor3 = 'MainColor';
            TabFrame.Visible = true;
        end;

        function Tab:HideTab()
            Blocker.BackgroundTransparency = 1;
            TabButton.BackgroundColor3 = Library.BackgroundColor;
            Library.RegistryMap[TabButton].Properties.BackgroundColor3 = 'BackgroundColor';
            TabFrame.Visible = false;
        end;

        function Tab:SetLayoutOrder(Position)
            TabButton.LayoutOrder = Position;
            TabListLayout:ApplyLayout();
        end;

        function Tab:AddGroupbox(Info)
            local Groupbox = {};

            local BoxOuter = Library:Create('Frame', {
                BackgroundColor3 = Library.BackgroundColor;
                BorderColor3 = Library.OutlineColor;
                BorderMode = Enum.BorderMode.Inset;
                Size = UDim2.new(1, 0, 0, 507 + 2);
                ZIndex = 2;
                Parent = Info.Side == 1 and LeftSide or RightSide;
            });

            Library:AddToRegistry(BoxOuter, {
                BackgroundColor3 = 'BackgroundColor';
                BorderColor3 = 'OutlineColor';
            });

            local BoxInner = Library:Create('Frame', {
                BackgroundColor3 = Library.BackgroundColor;
                BorderColor3 = Color3.new(0, 0, 0);
                -- BorderMode = Enum.BorderMode.Inset;
                Size = UDim2.new(1, -2, 1, -2);
                Position = UDim2.new(0, 1, 0, 1);
                ZIndex = 4;
                Parent = BoxOuter;
            });

            Library:AddToRegistry(BoxInner, {
                BackgroundColor3 = 'BackgroundColor';
            });

            local Highlight = Library:Create('Frame', {
                BackgroundColor3 = Library.AccentColor;
                BorderSizePixel = 0;
                Size = UDim2.new(1, 0, 0, 2);
                ZIndex = 5;
                Parent = BoxInner;
            });

            Library:AddToRegistry(Highlight, {
                BackgroundColor3 = 'AccentColor';
            });

            local GroupboxLabel = Library:CreateLabel({
                Size = UDim2.new(1, 0, 0, 18);
                Position = UDim2.new(0, 4, 0, 2);
                TextSize = 13;
                Text = Info.Name;
                TextXAlignment = Enum.TextXAlignment.Left;
                ZIndex = 5;
                Parent = BoxInner;
            });

            local Container = Library:Create('Frame', {
                BackgroundTransparency = 1;
                Position = UDim2.new(0, 4, 0, 20);
                Size = UDim2.new(1, -4, 1, -20);
                ZIndex = 1;
                Parent = BoxInner;
            });

            Library:Create('UIListLayout', {
                FillDirection = Enum.FillDirection.Vertical;
                SortOrder = Enum.SortOrder.LayoutOrder;
                Parent = Container;
            });

            function Groupbox:Resize()
                local Size = 0;

                for _, Element in next, Groupbox.Container:GetChildren() do
                    if (not Element:IsA('UIListLayout')) and Element.Visible then
                        Size = Size + Element.Size.Y.Offset;
                    end;
                end;

                BoxOuter.Size = UDim2.new(1, 0, 0, 20 + Size + 2 + 2);
            end;

            Groupbox.Container = Container;
            setmetatable(Groupbox, BaseGroupbox);

            Groupbox:AddBlank(3);
            Groupbox:Resize();

            Tab.Groupboxes[Info.Name] = Groupbox;

            return Groupbox;
        end;

        function Tab:AddLeftGroupbox(Name)
            return Tab:AddGroupbox({ Side = 1; Name = Name; });
        end;

        function Tab:AddRightGroupbox(Name)
            return Tab:AddGroupbox({ Side = 2; Name = Name; });
        end;

        function Tab:AddTabbox(Info)
            local Tabbox = {
                Tabs = {};
            };

            local BoxOuter = Library:Create('Frame', {
                BackgroundColor3 = Library.BackgroundColor;
                BorderColor3 = Library.OutlineColor;
                BorderMode = Enum.BorderMode.Inset;
                Size = UDim2.new(1, 0, 0, 0);
                ZIndex = 2;
                Parent = Info.Side == 1 and LeftSide or RightSide;
            });

            Library:AddToRegistry(BoxOuter, {
                BackgroundColor3 = 'BackgroundColor';
                BorderColor3 = 'OutlineColor';
            });

            local BoxInner = Library:Create('Frame', {
                BackgroundColor3 = Library.BackgroundColor;
                BorderColor3 = Color3.new(0, 0, 0);
                -- BorderMode = Enum.BorderMode.Inset;
                Size = UDim2.new(1, -2, 1, -2);
                Position = UDim2.new(0, 1, 0, 1);
                ZIndex = 4;
                Parent = BoxOuter;
            });

            Library:AddToRegistry(BoxInner, {
                BackgroundColor3 = 'BackgroundColor';
            });

            local Highlight = Library:Create('Frame', {
                BackgroundColor3 = Library.AccentColor;
                BorderSizePixel = 0;
                Size = UDim2.new(1, 0, 0, 2);
                ZIndex = 10;
                Parent = BoxInner;
            });

            Library:AddToRegistry(Highlight, {
                BackgroundColor3 = 'AccentColor';
            });

            local TabboxButtons = Library:Create('Frame', {
                BackgroundTransparency = 1;
                Position = UDim2.new(0, 0, 0, 1);
                Size = UDim2.new(1, 0, 0, 18);
                ZIndex = 5;
                Parent = BoxInner;
            });

            Library:Create('UIListLayout', {
                FillDirection = Enum.FillDirection.Horizontal;
                HorizontalAlignment = Enum.HorizontalAlignment.Left;
                SortOrder = Enum.SortOrder.LayoutOrder;
                Parent = TabboxButtons;
            });

            function Tabbox:AddTab(Name)
                local Tab = {};

                local Button = Library:Create('Frame', {
                    BackgroundColor3 = Library.MainColor;
                    BorderColor3 = Color3.new(0, 0, 0);
                    Size = UDim2.new(0.5, 0, 1, 0);
                    ZIndex = 6;
                    Parent = TabboxButtons;
                });

                Library:AddToRegistry(Button, {
                    BackgroundColor3 = 'MainColor';
                });

                local ButtonLabel = Library:CreateLabel({
                    Size = UDim2.new(1, 0, 1, 0);
                    TextSize = 14;
                    Text = Name;
                    TextXAlignment = Enum.TextXAlignment.Center;
                    ZIndex = 7;
                    Parent = Button;
                });

                local Block = Library:Create('Frame', {
                    BackgroundColor3 = Library.BackgroundColor;
                    BorderSizePixel = 0;
                    Position = UDim2.new(0, 0, 1, 0);
                    Size = UDim2.new(1, 0, 0, 1);
                    Visible = false;
                    ZIndex = 9;
                    Parent = Button;
                });

                Library:AddToRegistry(Block, {
                    BackgroundColor3 = 'BackgroundColor';
                });

                local Container = Library:Create('Frame', {
                    BackgroundTransparency = 1;
                    Position = UDim2.new(0, 4, 0, 20);
                    Size = UDim2.new(1, -4, 1, -20);
                    ZIndex = 1;
                    Visible = false;
                    Parent = BoxInner;
                });

                Library:Create('UIListLayout', {
                    FillDirection = Enum.FillDirection.Vertical;
                    SortOrder = Enum.SortOrder.LayoutOrder;
                    Parent = Container;
                });

                function Tab:Show()
                    for _, Tab in next, Tabbox.Tabs do
                        Tab:Hide();
                    end;

                    Container.Visible = true;
                    Block.Visible = true;

                    Button.BackgroundColor3 = Library.BackgroundColor;
                    Library.RegistryMap[Button].Properties.BackgroundColor3 = 'BackgroundColor';

                    Tab:Resize();
                end;

                function Tab:Hide()
                    Container.Visible = false;
                    Block.Visible = false;

                    Button.BackgroundColor3 = Library.MainColor;
                    Library.RegistryMap[Button].Properties.BackgroundColor3 = 'MainColor';
                end;

                function Tab:Resize()
                    local TabCount = 0;

                    for _, Tab in next, Tabbox.Tabs do
                        TabCount = TabCount + 1;
                    end;

                    for _, Button in next, TabboxButtons:GetChildren() do
                        if not Button:IsA('UIListLayout') then
                            Button.Size = UDim2.new(1 / TabCount, 0, 1, 0);
                        end;
                    end;

                    if (not Container.Visible) then
                        return;
                    end;

                    local Size = 0;

                    for _, Element in next, Tab.Container:GetChildren() do
                        if (not Element:IsA('UIListLayout')) and Element.Visible then
                            Size = Size + Element.Size.Y.Offset;
                        end;
                    end;

                    BoxOuter.Size = UDim2.new(1, 0, 0, 20 + Size + 2 + 2);
                end;

                Button.InputBegan:Connect(function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 and not Library:MouseIsOverOpenedFrame() then
                        Tab:Show();
                        Tab:Resize();
                    end;
                end);

                Tab.Container = Container;
                Tabbox.Tabs[Name] = Tab;

                setmetatable(Tab, BaseGroupbox);

                Tab:AddBlank(3);
                Tab:Resize();

                -- Show first tab (number is 2 cus of the UIListLayout that also sits in that instance)
                if #TabboxButtons:GetChildren() == 2 then
                    Tab:Show();
                end;

                return Tab;
            end;

            Tab.Tabboxes[Info.Name or ''] = Tabbox;

            return Tabbox;
        end;

        function Tab:AddLeftTabbox(Name)
            return Tab:AddTabbox({ Name = Name, Side = 1; });
        end;

        function Tab:AddRightTabbox(Name)
            return Tab:AddTabbox({ Name = Name, Side = 2; });
        end;

        TabButton.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                Tab:ShowTab();
            end;
        end);

        -- This was the first tab added, so we show it by default.
        if #TabContainer:GetChildren() == 1 then
            Tab:ShowTab();
        end;

        Window.Tabs[Name] = Tab;
        return Tab;
    end;

    local ModalElement = Library:Create('TextButton', {
        BackgroundTransparency = 1;
        Size = UDim2.new(0, 0, 0, 0);
        Visible = true;
        Text = '';
        Modal = false;
        Parent = ScreenGui;
    });

    local TransparencyCache = {};
    local Toggled = false;
    local Fading = false;

    function Library:Toggle()

getgenv().uiisopen = not Toggled



        if Fading then
            return;
        end;

        local FadeTime = Config.MenuFadeTime;
        Fading = true;
        Toggled = (not Toggled);
        ModalElement.Modal = Toggled;



        if Toggled then
            -- A bit scuffed, but if we're going from not toggled -> toggled we want to show the frame immediately so that the fade is visible.
            Outer.Visible = true;



            task.spawn(function()
                -- TODO: add cursor fade?
                local State = InputService.MouseIconEnabled;

                local Cursor = Drawing.new('Triangle');
                Cursor.Thickness = 1;
                Cursor.Filled = true;
                Cursor.Visible = true;

                local CursorOutline = Drawing.new('Triangle');
                CursorOutline.Thickness = 1;
                CursorOutline.Filled = false;
                CursorOutline.Color = Color3.new(0, 0, 0);
                CursorOutline.Visible = true;

                while Toggled and ScreenGui.Parent do
                    InputService.MouseIconEnabled = false;

                    local mPos = InputService:GetMouseLocation();

                    Cursor.Color = Library.AccentColor;

                    Cursor.PointA = Vector2.new(mPos.X, mPos.Y);
                    Cursor.PointB = Vector2.new(mPos.X + 16, mPos.Y + 6);
                    Cursor.PointC = Vector2.new(mPos.X + 6, mPos.Y + 16);

                    CursorOutline.PointA = Cursor.PointA;
                    CursorOutline.PointB = Cursor.PointB;
                    CursorOutline.PointC = Cursor.PointC;

                    RenderStepped:Wait();
                end;

                InputService.MouseIconEnabled = State;

                Cursor:Remove();
                CursorOutline:Remove();
            end);
        end;

        for _, Desc in next, Outer:GetDescendants() do
            local Properties = {};

            if Desc:IsA('ImageLabel') then
                table.insert(Properties, 'ImageTransparency');
                table.insert(Properties, 'BackgroundTransparency');
            elseif Desc:IsA('TextLabel') or Desc:IsA('TextBox') then
                table.insert(Properties, 'TextTransparency');
            elseif Desc:IsA('Frame') or Desc:IsA('ScrollingFrame') then
                table.insert(Properties, 'BackgroundTransparency');
            elseif Desc:IsA('UIStroke') then
                table.insert(Properties, 'Transparency');
            end;

            local Cache = TransparencyCache[Desc];

            if (not Cache) then
                Cache = {};
                TransparencyCache[Desc] = Cache;
            end;

            for _, Prop in next, Properties do
                if not Cache[Prop] then
                    Cache[Prop] = Desc[Prop];
                end;

                if Cache[Prop] == 1 then
                    continue;
                end;

                TweenService:Create(Desc, TweenInfo.new(FadeTime, Enum.EasingStyle.Linear), { [Prop] = Toggled and Cache[Prop] or 1 }):Play();
            end;
        end;

        task.wait(FadeTime);

        Outer.Visible = Toggled;

        Fading = false;
    end

    Library:GiveSignal(InputService.InputBegan:Connect(function(Input, Processed)
        if type(Library.ToggleKeybind) == 'table' and Library.ToggleKeybind.Type == 'KeyPicker' then
            if Input.UserInputType == Enum.UserInputType.Keyboard and Input.KeyCode.Name == Library.ToggleKeybind.Value then
                task.spawn(Library.Toggle)

            end
        elseif Input.KeyCode == Enum.KeyCode.RightControl or (Input.KeyCode == Enum.KeyCode.RightShift and (not Processed)) then
            task.spawn(Library.Toggle)

        end
    end))

    if Config.AutoShow then task.spawn(Library.Toggle) end

    Window.Holder = Outer;

    return Window;
end;



function Library:AddTitleImage(WindowInner, ImageUrl, Config)
    Config = Config or {}
    
    local ImageSize = Config.Size or UDim2.new(0, 50, 0, 20)
    local ImagePosition = Config.Position or UDim2.new(1, -58, 0, 3)
    
    -- Download and cache the image
    local success, imageData = pcall(function()
        return game:HttpGet(ImageUrl)
    end)
    
    if not success then
        warn("Failed to download image from: " .. ImageUrl)
        return nil
    end
    
    -- Save to file for getcustomasset
    local fileName = "title_image_" .. math.random(1000, 9999) .. ".png"
    pcall(function()
        writefile(fileName, imageData)
    end)
    
    -- Create the image label
    local TitleImage = Library:Create('ImageLabel', {
        BackgroundTransparency = 1;
        BorderSizePixel = 0;
        Position = ImagePosition;
        Size = ImageSize;
        Image = getcustomasset(fileName);
        ZIndex = 2;
        Parent = WindowInner;
    })
    
    return TitleImage
end






if not getgenv().moderatorsdetected then
    getgenv().moderatorsdetected = {}
end

	 UpdateDebounce = false
 UpdateScheduled = false

function Library:CreatePlayerListFrame(MainWindow, WindowName, Config)
		
    Config = Config or {}
    local DynamicSize = Config.DynamicSize or false
    local Width = Config.Width or 250
    local Height = Config.Height or 400
    
    if not getgenv().playerstoflag then
        getgenv().playerstoflag = {}
    end
    
    if not getgenv().statusshowtoggle then
        getgenv().statusshowtoggle = true
    end
    
    local TweenService = game:GetService("TweenService")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local RS = game:GetService("ReplicatedStorage")
    
    local PlayerListFrame = {
        Players = {};
        SelectedPlayer = nil;
        SelectedPlayerName = nil;
        SearchText = '';
        SortMethod = 'name';
        ViewMode = 'list'; -- 'list', 'grid', 'compact'
        OnlineCount = 0;
        ClanCache = {};
        ClanCacheTime = 0;
        PlayerStatusCache = {};
        UpdateThrottleTime = 0.1;
        LastUpdateTime = 0;
        IsUpdating = false;
    }
    
    -- === Player Status Color Coding ===
    local PLAYER_STATUS = {
        ACTIVE = {color = Color3.fromRGB(50, 200, 50), text = "Active"},
        IDLE = {color = Color3.fromRGB(200, 150, 50), text = "Idle"},
        AFK = {color = Color3.fromRGB(200, 50, 50), text = "AFK"},
        LOADING = {color = Color3.fromRGB(100, 150, 255), text = "Spawn"}
    }
    
    local function GetPlayerStatus(player)
        if not player.Character then
            return PLAYER_STATUS.LOADING
        end
        
        local humanoid = player.Character:FindFirstChild("Humanoid")
        if not humanoid or humanoid.Health <= 0 then
            return PLAYER_STATUS.AFK
        end
        
        local cached = PlayerListFrame.PlayerStatusCache[player.UserId]
        if cached and tick() - cached.time < 5 then
            return cached.status
        end
        
        -- Detect idle via humanoid state and root part velocity
        local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
        local isMoving = false
        
        if rootPart then
            isMoving = rootPart.AssemblyLinearVelocity.Magnitude > 0.5
        end
        
        local status = isMoving and PLAYER_STATUS.ACTIVE or PLAYER_STATUS.IDLE
        PlayerListFrame.PlayerStatusCache[player.UserId] = {status = status, time = tick()}
        return status
    end

    local function GetPlayerClan(player)
        local cached = PlayerListFrame.ClanCache[player.UserId]
        if cached and tick() - PlayerListFrame.ClanCacheTime < 5 then
            return cached
        end
        
        local clan = nil
        local rs = RS:FindFirstChild("Players")
        if rs then
            local playerFolder = rs:FindFirstChild(player.Name)
            if playerFolder then
                local status = playerFolder:FindFirstChild("Status")
                if status then
                    local journey = status:FindFirstChild("Journey")
                    if journey then
                        local clanObj = journey:FindFirstChild("Clan")
                        if clanObj then
                            clan = clanObj:GetAttribute("CurrentClan")
                        end
                    end
                end
            end
        end
        
        if clan and clan ~= "" then
            PlayerListFrame.ClanCache[player.UserId] = clan
            return clan
        end
        
        PlayerListFrame.ClanCache[player.UserId] = nil
        return nil
    end

    local function IsPlayerInLocalPlayerClan(player)
        if player == LocalPlayer then return false end
        
        local localClan = GetPlayerClan(LocalPlayer)
        if not localClan then return false end
        
        local playerClan = GetPlayerClan(player)
        if not playerClan then return false end
        
        local function ExtractPlayerNameFromClan(clanName)
            if not clanName then return nil end
            local playerName = clanName:match("^(.-)%'s")
            return playerName
        end
        
        local localPlayerNameFromClan = ExtractPlayerNameFromClan(localClan)
        local otherPlayerNameFromClan = ExtractPlayerNameFromClan(playerClan)
        
        if not localPlayerNameFromClan or not otherPlayerNameFromClan then
            return false
        end
        
        return localPlayerNameFromClan == otherPlayerNameFromClan
    end

    local function IsPlayerFlagged(playerName)
        for i = 1, #getgenv().playerstoflag do
            if getgenv().playerstoflag[i] == playerName then return true end
        end
        return false
    end

local function IsPlayerModerator(playerName)
    for i = 1, #getgenv().moderatorsdetected do
        if getgenv().moderatorsdetected[i] == playerName then return true end
    end
    return false
end

    local function MatchesSearch(playerName)
        if PlayerListFrame.SearchText == '' then return true end
        return string.find(string.lower(playerName), string.lower(PlayerListFrame.SearchText), 1, true) ~= nil
    end

    local function GetPlayerDistance(player)
        local playerChar = player.Character
        local localChar = LocalPlayer.Character
        
        if playerChar and localChar then
            local playerRoot = playerChar:FindFirstChild('HumanoidRootPart')
            local localRoot = localChar:FindFirstChild('HumanoidRootPart')
            if playerRoot and localRoot then
                return (localRoot.Position - playerRoot.Position).Magnitude
            end
        end
        return math.huge
    end

    local SORT_METHODS = {
        name = function(a, b) return a.Name < b.Name end,
        team = function(a, b)
            local ta = a.Team and a.Team.Name or ''
            local tb = b.Team and b.Team.Name or ''
            return ta == tb and a.Name < b.Name or ta < tb
        end,
        distance = function(a, b) return GetPlayerDistance(a) < GetPlayerDistance(b) end,
    }

    local function SortPlayers(playerList)
        table.sort(playerList, SORT_METHODS[PlayerListFrame.SortMethod] or SORT_METHODS.name)
    end

    local function DeselectPlayer()
        if not PlayerListFrame.SelectedPlayer then return end
        
        local btn = PlayerListFrame.SelectedPlayer.Button
        TweenService:Create(btn, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            BackgroundColor3 = Library.MainColor
        }):Play()
        
        for _, child in next, btn:GetDescendants() do
            if child:IsA('TextLabel') and child.Name ~= 'UITextSizeConstraint' then
                TweenService:Create(child, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                    TextColor3 = Library.FontColor
                }):Play()
            end
        end
        
        PlayerListFrame.SelectedPlayer = nil
        PlayerListFrame.SelectedPlayerName = nil
    end

    local function SelectPlayer(Player, PlayerButton)
        DeselectPlayer()
        
        PlayerListFrame.SelectedPlayerName = Player.Name
        PlayerListFrame.SelectedPlayer = {Name = Player.Name, Button = PlayerButton}
        
        TweenService:Create(PlayerButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            BackgroundColor3 = Library.AccentColor
        }):Play()
        
        for _, child in next, PlayerButton:GetDescendants() do
            if child:IsA('TextLabel') and child.Name ~= 'UITextSizeConstraint' then
                TweenService:Create(child, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                    TextColor3 = Color3.fromRGB(255, 255, 255)
                }):Play()
            end
        end
        
        Library:SafeCallback(PlayerListFrame.OnPlayerSelected, Player)
    end

    -- === UI Creation ===
    local Outer = Library:Create('Frame', {
        BackgroundColor3 = Color3.new(0, 0, 0);
        BorderColor3 = Color3.new(0, 0, 0);
        Position = UDim2.fromOffset(0, 0);
        Size = UDim2.fromOffset(Width, Height);
        ZIndex = 1;
        Parent = ScreenGui;
    });

    local glow = Instance.new("ImageLabel", Outer)
    glow.Name = "GlowEffect"
    glow.Image = "rbxassetid://18245826428"
    glow.ScaleType = Enum.ScaleType.Slice
    glow.SliceCenter = Rect.new(21, 21, 79, 79)
    glow.ImageColor3 = Library.AccentColor
    glow.ImageTransparency = 0.6
    glow.BackgroundTransparency = 1
    glow.Size = UDim2.new(1, 40, 1, 40)
    glow.Position = UDim2.new(0, -20, 0, -20)
    glow.ZIndex = -1

    local function AnimateGlow()
        local function pulse()
            local t1 = TweenService:Create(glow, TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {ImageTransparency = 0.3})
            local t2 = TweenService:Create(glow, TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {ImageTransparency = 0.6})
            t1.Completed:Connect(function() t2:Play() end)
            t2.Completed:Connect(function() t1:Play() end)
            t1:Play()
        end
        pulse()
    end

    AnimateGlow()


    -- Color change detection (optimized)
    local lastColor = Library.AccentColor
    local colorChangeConnection
    colorChangeConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if Library.AccentColor ~= lastColor then
            lastColor = Library.AccentColor
            local colorTweenInfo = TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            TweenService:Create(glow, colorTweenInfo, {ImageColor3 = Library.AccentColor}):Play()
        end
    end)


    local Inner = Library:Create('Frame', {
        BackgroundColor3 = Library.MainColor;
        BorderColor3 = Library.AccentColor;
        BorderMode = Enum.BorderMode.Inset;
        Position = UDim2.new(0, 1, 0, 1);
        Size = UDim2.new(1, -2, 1, -2);
        ZIndex = 1;
        Parent = Outer;
    });

    Library:AddToRegistry(Inner, {BackgroundColor3 = 'MainColor', BorderColor3 = 'AccentColor'});

    local TitleLabel = Library:CreateLabel({
        Position = UDim2.new(0, 7, 0, 0);
        Size = UDim2.new(0, 0, 0, 20);
        Text = (WindowName or 'Players Online') .. ' [0]';
        TextXAlignment = Enum.TextXAlignment.Left;
        TextSize = 12;
        ZIndex = 1;
        Parent = Inner;
    });

    -- === Search Box ===
    local SearchBoxOuter = Library:Create('Frame', {
        BackgroundColor3 = Color3.new(0, 0, 0);
        BorderColor3 = Color3.new(0, 0, 0);
        Position = UDim2.new(0, 8, 0, 20);
        Size = UDim2.new(1, -16, 0, 18);
        ZIndex = 5;
        Parent = Inner;
    });

    local SearchBoxInner = Library:Create('Frame', {
        BackgroundColor3 = Library.BackgroundColor;
        BorderColor3 = Library.OutlineColor;
        BorderMode = Enum.BorderMode.Inset;
        Size = UDim2.new(1, 0, 1, 0);
        ZIndex = 6;
        Parent = SearchBoxOuter;
    });

    Library:AddToRegistry(SearchBoxInner, {BackgroundColor3 = 'BackgroundColor', BorderColor3 = 'OutlineColor'});

    local SearchBox = Library:Create('TextBox', {
        BackgroundTransparency = 1;
        Position = UDim2.new(0, 5, 0, 0);
        Size = UDim2.new(1, -5, 1, 0);
        FontFace = Library.Font;
        PlaceholderColor3 = Color3.fromRGB(130, 130, 130);
        PlaceholderText = 'Search...';
        Text = '';
        TextColor3 = Library.FontColor;
        TextSize = 11;
        TextStrokeTransparency = 0;
        TextXAlignment = Enum.TextXAlignment.Left;
        ZIndex = 7;
        Parent = SearchBoxInner;
    });

    Library:ApplyTextStroke(SearchBox);
    Library:AddToRegistry(SearchBox, {TextColor3 = 'FontColor'});

    -- === Controls ===
    local ControlsOuter = Library:Create('Frame', {
        BackgroundColor3 = Library.BackgroundColor;
        BorderColor3 = Library.OutlineColor;
        Position = UDim2.new(0, 8, 0, 39);
        Size = UDim2.new(1, -16, 0, 16);
        ZIndex = 5;
        Parent = Inner;
    });

    Library:AddToRegistry(ControlsOuter, {BackgroundColor3 = 'BackgroundColor', BorderColor3 = 'OutlineColor'});
    Library:Create('UIListLayout', {Padding = UDim.new(0, 2), FillDirection = Enum.FillDirection.Horizontal, SortOrder = Enum.SortOrder.LayoutOrder, Parent = ControlsOuter});

    local SortButton = Library:Create('TextButton', {
        BackgroundColor3 = Library.MainColor;
        BorderColor3 = Library.OutlineColor;
        Size = UDim2.new(0.33, -1, 1, 0);
        Text = 'Sort: Name';
        TextColor3 = Library.FontColor;
        TextSize = 9;
        FontFace = Library.Font;
        ZIndex = 6;
        Parent = ControlsOuter;
    });

    Library:AddToRegistry(SortButton, {BackgroundColor3 = 'MainColor', BorderColor3 = 'OutlineColor', TextColor3 = 'FontColor'});

    local SORT_TEXTS = {name = 'Sort: Name', team = 'Sort: Team', distance = 'Sort: Dist'}
    
    local function UpdateSortButtonText()
        SortButton.Text = SORT_TEXTS[PlayerListFrame.SortMethod] or 'Sort: Name'
    end

    local SortMenu = Library:Create('Frame', {
        BackgroundColor3 = Library.BackgroundColor;
        BorderColor3 = Library.OutlineColor;
        Position = UDim2.new(0, 0, 1, 2);
        Size = UDim2.fromOffset(60, 60);
        Visible = false;
        ZIndex = 10;
        Parent = ControlsOuter;
    });

    Library:AddToRegistry(SortMenu, {BackgroundColor3 = 'BackgroundColor', BorderColor3 = 'OutlineColor'});
    Library:Create('UIListLayout', {FillDirection = Enum.FillDirection.Vertical, SortOrder = Enum.SortOrder.LayoutOrder, Parent = SortMenu});

    for _, sortType in ipairs({'name', 'team', 'distance'}) do
        local SortOption = Library:Create('TextButton', {
            BackgroundColor3 = Library.MainColor;
            BorderColor3 = Color3.new(0, 0, 0);
            Size = UDim2.new(1, -1, 0, 18);
            Text = sortType:sub(1, 1):upper() .. sortType:sub(2);
            TextColor3 = Library.FontColor;
            TextSize = 10;
            FontFace = Library.Font;
            ZIndex = 11;
            Parent = SortMenu;
        });

        Library:AddToRegistry(SortOption, {BackgroundColor3 = 'MainColor', TextColor3 = 'FontColor'});

        SortOption.MouseButton1Click:Connect(function()
            PlayerListFrame.SortMethod = sortType
            UpdateSortButtonText()
            PlayerListFrame:UpdatePlayerList()
            SortMenu.Visible = false
        end)
    end

    SortButton.MouseButton1Click:Connect(function()
        SortMenu.Visible = not SortMenu.Visible
    end)

    -- === View Mode Button ===
    local ViewModeButton = Library:Create('TextButton', {
        BackgroundColor3 = Library.MainColor;
        BorderColor3 = Library.OutlineColor;
        Size = UDim2.new(0.33, -1, 1, 0);
        Text = 'View: List';
        TextColor3 = Library.FontColor;
        TextSize = 9;
        FontFace = Library.Font;
        ZIndex = 6;
        Parent = ControlsOuter;
    });

    Library:AddToRegistry(ViewModeButton, {BackgroundColor3 = 'MainColor', BorderColor3 = 'OutlineColor', TextColor3 = 'FontColor'});

    local VIEW_TEXTS = {list = 'View: List', grid = 'View: Grid', compact = 'View: Compact'}
    
    local function UpdateViewModeButtonText()
        ViewModeButton.Text = VIEW_TEXTS[PlayerListFrame.ViewMode] or 'View: List'
    end

    local ViewModeMenu = Library:Create('Frame', {
        BackgroundColor3 = Library.BackgroundColor;
        BorderColor3 = Library.OutlineColor;
        Position = UDim2.new(0, 0, 1, 2);
        Size = UDim2.fromOffset(70, 60);
        Visible = false;
        ZIndex = 10;
        Parent = ViewModeButton;
    });

    Library:AddToRegistry(ViewModeMenu, {BackgroundColor3 = 'BackgroundColor', BorderColor3 = 'OutlineColor'});
    Library:Create('UIListLayout', {FillDirection = Enum.FillDirection.Vertical, SortOrder = Enum.SortOrder.LayoutOrder, Parent = ViewModeMenu});

    for _, viewType in ipairs({'list', 'grid', 'compact'}) do
        local ViewOption = Library:Create('TextButton', {
            BackgroundColor3 = Library.MainColor;
            BorderColor3 = Color3.new(0, 0, 0);
            Size = UDim2.new(1, -1, 0, 18);
            Text = viewType:sub(1, 1):upper() .. viewType:sub(2);
            TextColor3 = Library.FontColor;
            TextSize = 10;
            FontFace = Library.Font;
            ZIndex = 11;
            Parent = ViewModeMenu;
        });

        Library:AddToRegistry(ViewOption, {BackgroundColor3 = 'MainColor', TextColor3 = 'FontColor'});

        ViewOption.MouseButton1Click:Connect(function()
            PlayerListFrame.ViewMode = viewType
            UpdateViewModeButtonText()
            PlayerListFrame:UpdatePlayerList()
            ViewModeMenu.Visible = false
        end)
    end

    ViewModeButton.MouseButton1Click:Connect(function()
        ViewModeMenu.Visible = not ViewModeMenu.Visible
    end)

    local ClearButton = Library:Create('TextButton', {
        BackgroundColor3 = Library.MainColor;
        BorderColor3 = Library.OutlineColor;
        Size = UDim2.new(0.34, -1, 1, 0);
        Text = 'Clear';
        TextColor3 = Library.FontColor;
        TextSize = 9;
        FontFace = Library.Font;
        ZIndex = 6;
        Parent = ControlsOuter;
    });

    Library:AddToRegistry(ClearButton, {BackgroundColor3 = 'MainColor', BorderColor3 = 'OutlineColor', TextColor3 = 'FontColor'});
    ClearButton.MouseButton1Click:Connect(DeselectPlayer)

    -- === Player List ===
    local ListOuter = Library:Create('Frame', {
        BackgroundColor3 = Library.BackgroundColor;
        BorderColor3 = Library.OutlineColor;
        Position = UDim2.new(0, 8, 0, 56);
        Size = UDim2.new(1, -16, 1, -64);
        ZIndex = 1;
        Parent = Inner;
    });

    Library:AddToRegistry(ListOuter, {BackgroundColor3 = 'BackgroundColor', BorderColor3 = 'OutlineColor'});

    local ListInner = Library:Create('Frame', {
        BackgroundColor3 = Library.BackgroundColor;
        BorderColor3 = Color3.new(0, 0, 0);
        BorderMode = Enum.BorderMode.Inset;
        Size = UDim2.new(1, 0, 1, 0);
        ZIndex = 2;
        Parent = ListOuter;
    });

    Library:AddToRegistry(ListInner, {BackgroundColor3 = 'BackgroundColor'});

    local ScrollingFrame = Library:Create('ScrollingFrame', {
        BackgroundTransparency = 1;
        BorderSizePixel = 0;
        CanvasSize = UDim2.new(0, 0, 0, 0);
        Size = UDim2.new(1, 0, 1, 0);
        ZIndex = 2;
        Parent = ListInner;
        TopImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png';
        BottomImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png';
        ScrollBarThickness = 3;
        ScrollBarImageColor3 = Library.AccentColor;
    });

    Library:AddToRegistry(ScrollingFrame, {ScrollBarImageColor3 = 'AccentColor'});

    local ListLayout = Library:Create('UIListLayout', {
        Padding = UDim.new(0, 1);
        FillDirection = Enum.FillDirection.Vertical;
        SortOrder = Enum.SortOrder.LayoutOrder;
        Parent = ScrollingFrame;
    });

    local PlayerButtons = {}

    local function CreatePlayerButton(Player, isLocal)
        if not MatchesSearch(Player.Name) then return end

        local status = GetPlayerStatus(Player)
        local buttonSize = PlayerListFrame.ViewMode == 'list' and UDim2.new(1, -1, 0, 20) or 
                          PlayerListFrame.ViewMode == 'grid' and UDim2.new(0.5, -2, 0, 50) or
                          UDim2.new(1, -1, 0, 14)

        local PlayerButton = Library:Create('Frame', {
            BackgroundColor3 = Library.MainColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Middle;
            Size = buttonSize;
            ZIndex = 3;
            Active = true;
            Parent = ScrollingFrame;
        });

        Library:AddToRegistry(PlayerButton, {BackgroundColor3 = 'MainColor', BorderColor3 = 'OutlineColor'});

        local displayName = Player.Name
        if isLocal then
            displayName = displayName .. " <font color=\"rgb(255, 255, 255)\"> [</font><font color=\"rgb(" .. math.floor(Library.AccentColor.R * 255) .. ", " .. math.floor(Library.AccentColor.G * 255) .. ", " .. math.floor(Library.AccentColor.B * 255) .. ")\">LOCAL</font><font color=\"rgb(255, 255, 255)\">]</font>"
        elseif IsPlayerFlagged(Player.Name) then
            displayName = displayName .. " <font color=\"rgb(255, 255, 255)\">[</font><font color=\"rgb(255, 100, 100)\">C</font><font color=\"rgb(255, 255, 255)\">]</font>"
        end

if IsPlayerModerator(Player.Name) then
    displayName = displayName .. " <font color=\"rgb(255, 255, 255)\">[</font><font color=\"rgb(100, 150, 255)\">M</font><font color=\"rgb(255, 255, 255)\">]</font>"
end


        if PlayerListFrame.SortMethod == 'distance' then
            local dist = math.floor(GetPlayerDistance(Player))
            displayName = displayName .. " <font color=\"rgb(255, 255, 255)\">(</font>" .. dist .. "<font color=\"rgb(255, 255, 255)\">m)</font>"
        end

        local isInClan = IsPlayerInLocalPlayerClan(Player)
        if isInClan then
            displayName = displayName .. " <font color=\"rgb(255, 255, 255)\">[</font><font color=\"rgb(100, 255, 100)\">T</font><font color=\"rgb(255, 255, 255)\">]</font>"
        elseif Player.Team then
            displayName = displayName .. " <font color=\"rgb(255, 255, 255)\">[</font><font color=\"rgb(255, 255, 255)\">" .. Player.Team.Name:sub(1, 1) .. "</font><font color=\"rgb(255, 255, 255)\">]</font>"
        end

        -- Add status at the end if toggle is enabled
        if getgenv().statusshowtoggle then
            displayName = displayName .. "   <font color=\"rgb(255, 255, 255)\">[</font><font color=\"rgb(" .. math.floor(status.color.R * 255) .. ", " .. math.floor(status.color.G * 255) .. ", " .. math.floor(status.color.B * 255) .. ")\">" .. status.text .. "</font><font color=\"rgb(255, 255, 255)\">]</font>"
        end

        local PlayerLabelContainer = Library:Create('Frame', {
            BackgroundTransparency = 1;
            Size = UDim2.new(1, -6, 1, 0);
            Position = UDim2.new(0, 6, 0, 0);
            ZIndex = 4;
            Parent = PlayerButton;
        });

        Library:CreateLabel({
            Active = false;
            Size = UDim2.new(1, 0, 1, 0);
            TextSize = PlayerListFrame.ViewMode == 'compact' and 9 or 11;
            Text = displayName;
            TextXAlignment = Enum.TextXAlignment.Left;
            RichText = true;
            FontFace = Library.Font;
            ZIndex = 4;
            Parent = PlayerLabelContainer;
        });

        if PlayerListFrame.SelectedPlayerName == Player.Name then
            PlayerButton.BackgroundColor3 = Library.AccentColor;
            PlayerListFrame.SelectedPlayer = {Name = Player.Name, Button = PlayerButton};
        end

        Library:OnHighlight(PlayerButton, PlayerButton,
            {BorderColor3 = 'AccentColor', ZIndex = 4},
            {BorderColor3 = 'OutlineColor', ZIndex = 3}
        );

        PlayerButton.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                SelectPlayer(Player, PlayerButton)
            end
        end);

        table.insert(PlayerButtons, PlayerButton);
        return 1
    end

    function PlayerListFrame:UpdatePlayerList()
        local now = tick()
        if now - self.LastUpdateTime < self.UpdateThrottleTime and not self.IsUpdating then
            return
        end
        
        self.IsUpdating = true
        
        task.spawn(function()
            for i = 1, #PlayerButtons do
                PlayerButtons[i]:Destroy()
            end
            table.clear(PlayerButtons)

            local PlayerList = Players:GetPlayers()
            SortPlayers(PlayerList)

            local OnlineCount = 0

            OnlineCount = OnlineCount + (CreatePlayerButton(LocalPlayer, true) or 0)
            for i = 1, #PlayerList do
                if PlayerList[i] ~= LocalPlayer then
                    OnlineCount = OnlineCount + (CreatePlayerButton(PlayerList[i], false) or 0)
                end
            end

            PlayerListFrame.OnlineCount = OnlineCount
            TitleLabel.Text = (WindowName or 'Players Online') .. ' [' .. OnlineCount .. ']'
            ScrollingFrame.CanvasSize = UDim2.fromOffset(0, ListLayout.AbsoluteContentSize.Y);
            
            if DynamicSize then
                local newHeight = math.max(ListLayout.AbsoluteContentSize.Y + 120, Height);
                Outer.Size = UDim2.fromOffset(Width, newHeight);
            end
            
            self.LastUpdateTime = tick()
            self.IsUpdating = false
        end)
    end

    SearchBox:GetPropertyChangedSignal('Text'):Connect(function()
        PlayerListFrame.SearchText = SearchBox.Text
        PlayerListFrame:UpdatePlayerList()
    end)

    function PlayerListFrame:OnPlayerSelected(Callback)
        PlayerListFrame.OnPlayerSelected = Callback;
    end

    function PlayerListFrame:SetSortMethod(method)
        if SORT_METHODS[method] then
            PlayerListFrame.SortMethod = method
            UpdateSortButtonText()
            PlayerListFrame:UpdatePlayerList()
        end
    end

    function PlayerListFrame:SetViewMode(mode)
        if VIEW_TEXTS[mode] then
            PlayerListFrame.ViewMode = mode
            UpdateViewModeButtonText()
            PlayerListFrame:UpdatePlayerList()
        end
    end

    Library:GiveSignal(Players.PlayerAdded:Connect(function()
        PlayerListFrame.ClanCache = {}
        PlayerListFrame.ClanCacheTime = tick()
        PlayerListFrame:UpdatePlayerList();
    end));

    Library:GiveSignal(Players.PlayerRemoving:Connect(function()
        PlayerListFrame.ClanCache = {}
        PlayerListFrame.ClanCacheTime = tick()
        PlayerListFrame:UpdatePlayerList();
    end));

    task.spawn(function()
        local lastFlagCount = 0
        while Outer.Parent do
            task.wait(0.1)
            local currentFlagCount = #getgenv().playerstoflag
            if currentFlagCount ~= lastFlagCount then
                lastFlagCount = currentFlagCount
                PlayerListFrame:UpdatePlayerList()
            end
        end
    end);

    task.spawn(function()
        local lastToggleState = getgenv().statusshowtoggle
        while Outer.Parent do
            task.wait(0.2)
            if getgenv().statusshowtoggle ~= lastToggleState then
                lastToggleState = getgenv().statusshowtoggle
                PlayerListFrame:UpdatePlayerList()
            end
        end
    end)

    task.defer(function()
        local lastMain, lastAccent = Library.MainColor, Library.AccentColor
        while Outer.Parent do
            task.wait(1)
            if lastMain ~= Library.MainColor or lastAccent ~= Library.AccentColor then
                lastMain, lastAccent = Library.MainColor, Library.AccentColor
                TweenService:Create(Inner, TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    BackgroundColor3 = lastMain,
                    BorderColor3 = lastAccent
                }):Play()
            end
        end
    end)

    PlayerListFrame:UpdatePlayerList();

    if MainWindow and MainWindow.Holder then
        MainWindow.Holder:GetPropertyChangedSignal('Visible'):Connect(function()
            Outer.Visible = MainWindow.Holder.Visible;
        end);
        
        Outer.Visible = MainWindow.Holder.Visible;
    end

    local function UpdatePosition()
        if MainWindow and MainWindow.Holder and MainWindow.Holder.Parent then
            local mainPos = MainWindow.Holder.AbsolutePosition;
            local leftX = mainPos.X - Width - 5;
            leftX = math.max(5, leftX);
            Outer.Position = UDim2.fromOffset(leftX, mainPos.Y);
        end
    end

    if MainWindow and MainWindow.Holder then
        Library:GiveSignal(MainWindow.Holder:GetPropertyChangedSignal('AbsolutePosition'):Connect(UpdatePosition));
        Library:GiveSignal(MainWindow.Holder:GetPropertyChangedSignal('AbsoluteSize'):Connect(UpdatePosition));
        UpdatePosition();
    else
        Outer.Position = UDim2.fromOffset(5, 50);
    end

    PlayerListFrame.Holder = Outer;
    PlayerListFrame._LastAccentColor = Library.AccentColor

    Library:GiveSignal(game:GetService("RunService").Heartbeat:Connect(function()
        if Library.AccentColor ~= PlayerListFrame._LastAccentColor then
            PlayerListFrame._LastAccentColor = Library.AccentColor
            PlayerListFrame:UpdatePlayerList()
        end
    end))

    return PlayerListFrame;
end




































local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

function Library:CreateObjectPreview(ParentWindow, WindowName, Config)
    Config = Config or {}
    
    local PreviewSize = Config.Size or UDim2.fromOffset(220, 300)
    local TargetObject = Config.Object or Workspace:FindFirstChild('Model')
    local ShouldRotate = Config.Rotate ~= false
    local RotateSpeed = Config.RotateSpeed or 2
    
    -- Create outer frame
    local PreviewOuter = Library:Create('Frame', {
        BackgroundColor3 = Color3.new(0, 0, 0),
        BorderColor3 = Color3.new(0, 0, 0),
        Size = PreviewSize,
        Position = UDim2.new(1, 10, 0, 25),
        Parent = ParentWindow.Holder,
        ZIndex = 50,
    })
    




local glow = Instance.new("ImageLabel", PreviewOuter)
glow.Name = "GlowEffect"
glow.Image = "rbxassetid://18245826428" -- Glow texture ID
glow.ScaleType = Enum.ScaleType.Slice
glow.SliceCenter = Rect.new(21, 21, 79, 79)
glow.ImageColor3 = Library.AccentColor
glow.ImageTransparency = 0.6
glow.BackgroundTransparency = 1
glow.Size = UDim2.new(1, 40, 1, 40)
glow.Position = UDim2.new(0, -20, 0, -20)
glow.ZIndex = -1

-- Create pulsing animation
local TweenService = game:GetService("TweenService")
local startTransparency = 0.6
local minTransparency = 0.3
local pulseDuration = getgenv().glowwatermarkspeed or 5

local pulseInfo = TweenInfo.new(
	pulseDuration / 2,
	Enum.EasingStyle.Sine,
	Enum.EasingDirection.InOut
)

local function createPulseTween()
	local tweenOut = TweenService:Create(glow, pulseInfo, {ImageTransparency = minTransparency})
	local tweenIn = TweenService:Create(glow, pulseInfo, {ImageTransparency = startTransparency})
	
	tweenOut.Completed:Connect(function()
		tweenIn:Play()
	end)
	
	tweenIn.Completed:Connect(function()
		tweenOut:Play()
	end)
	
	tweenOut:Play()
end

-- Start pulsing animation
createPulseTween()

-- Watch for color changes and tween them
local lastColor = Library.AccentColor
local colorChangeConnection

colorChangeConnection = game:GetService("RunService").Heartbeat:Connect(function()
	if Library.AccentColor ~= lastColor then
		lastColor = Library.AccentColor
		
		local colorTweenInfo = TweenInfo.new(
			5,
			Enum.EasingStyle.Quad,
			Enum.EasingDirection.Out
		)
		
		local colorTween = TweenService:Create(glow, colorTweenInfo, {ImageColor3 = Library.AccentColor})
		colorTween:Play()
	end
end)






    -- Create inner frame with accent border
    local PreviewInner = Library:Create('Frame', {
        BackgroundColor3 = Library.MainColor,
        BorderColor3 = Library.AccentColor,
        BorderMode = Enum.BorderMode.Inset,
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 1, 0, 1),
        ZIndex = 51,
        Parent = PreviewOuter,
    })
    
    local Highlight = Library:Create('Frame', {
        BackgroundColor3 = Library.AccentColor,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 2),
        ZIndex = 52,
        Parent = PreviewInner,
    })
    
    -- Color sync loop (only runs when colors change)
    task.defer(function()
        local lastMain, lastAccent = Library.MainColor, Library.AccentColor
        while task.wait(1) do
            if lastMain ~= Library.MainColor or lastAccent ~= Library.AccentColor then
                lastMain, lastAccent = Library.MainColor, Library.AccentColor
                TweenService:Create(PreviewInner, TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    BackgroundColor3 = lastMain,
                    BorderColor3 = lastAccent
                }):Play()
                TweenService:Create(Highlight, TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    BackgroundColor3 = lastAccent
                }):Play()
            end
        end
    end)
    
    Library:CreateLabel({
        Size = UDim2.new(1, 0, 0, 18),
        Position = UDim2.new(0, 4, 0, 2),
        Text = WindowName or 'Preview',
        TextSize = 12,
        ZIndex = 52,
        Parent = PreviewInner,
    })
    
    -- Setup viewport
    local ViewportFrame = Instance.new('ViewportFrame')
    ViewportFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    ViewportFrame.BorderSizePixel = 0
    ViewportFrame.Position = UDim2.new(0, 0, 0, 20)
    ViewportFrame.Size = UDim2.new(1, 0, 1, -40)
    ViewportFrame.ZIndex = 52
    ViewportFrame.Parent = PreviewInner
    
    local Camera = Instance.new('Camera')
    Camera.Parent = ViewportFrame
    Camera.FieldOfView = 33
    ViewportFrame.CurrentCamera = Camera
    
    local ClonedModel = Instance.new('Folder')
    ClonedModel.Name = 'PreviewModel'
    ClonedModel.Parent = ViewportFrame
    
    -- Bottom label
    Library:CreateLabel({
        Size = UDim2.new(1, 0, 0, 18),
        Position = UDim2.new(0, 4, 1, -18),
        Text = 'Character Appearance Visualization',
        TextSize = 10,
        ZIndex = 52,
        Parent = PreviewInner,
    })
    
    -- State variables
    local rotation = 0
    local ClonedReference = nil
    local OriginalCFrames = {}
    local AllParts = {}
    local CachedBounds = {size = 0, center = Vector3.new()}
    
    local function CloneObject()
        -- Cleanup
        for _, child in pairs(ClonedModel:GetChildren()) do
            child:Destroy()
        end
        
        if not TargetObject then 
            ClonedReference = nil
            return 
        end
        
        -- Clone and cache original CFrames
        local Cloned = TargetObject:Clone()
        Cloned.Parent = ClonedModel
        ClonedReference = Cloned
        OriginalCFrames = {}
        AllParts = {}
        
        for _, Part in pairs(Cloned:GetDescendants()) do
            if Part:IsA('BasePart') then
                OriginalCFrames[Part] = Part.CFrame
                table.insert(AllParts, Part)
            end
        end
    end
    
    task.wait(0.1)
    CloneObject()
    
    -- Main render loop
    local UpdateConnection
    UpdateConnection = RunService.RenderStepped:Connect(LPH_NO_VIRTUALIZE(function()
        if not ViewportFrame.Parent then
            UpdateConnection:Disconnect()
            return
        end
        
        if not ClonedReference or #AllParts == 0 then return end
        
        -- Rotation logic
        if ShouldRotate then
            rotation = rotation + RotateSpeed * 0.016
            local angle = math.rad(rotation)
            local rotMatrix = CFrame.Angles(0, angle, 0)
            
            for _, Part in pairs(AllParts) do
                if Part.Parent then
                    Part.CFrame = rotMatrix * OriginalCFrames[Part]
                end
            end
        end
        
        -- Calculate bounds only when needed
        local minX, minY, minZ = math.huge, math.huge, math.huge
        local maxX, maxY, maxZ = -math.huge, -math.huge, -math.huge
        
        for _, Part in pairs(AllParts) do
            local pos = Part.Position
            local halfSize = Part.Size * 0.5
            minX = math.min(minX, pos.X - halfSize.X)
            minY = math.min(minY, pos.Y - halfSize.Y)
            minZ = math.min(minZ, pos.Z - halfSize.Z)
            maxX = math.max(maxX, pos.X + halfSize.X)
            maxY = math.max(maxY, pos.Y + halfSize.Y)
            maxZ = math.max(maxZ, pos.Z + halfSize.Z)
        end
        
        -- Update camera
        local centerPos = Vector3.new((minX + maxX) * 0.5, (minY + maxY) * 0.5, (minZ + maxZ) * 0.5)
        local boundSize = math.sqrt((maxX - minX) ^ 2 + (maxY - minY) ^ 2 + (maxZ - minZ) ^ 2) * 0.5
        local camPos = centerPos + Vector3.new(0, 0, boundSize * 2)
        
        Camera.CFrame = CFrame.new(camPos, centerPos)
    end))
    
   return {
    Outer = PreviewOuter,
    Update = CloneObject,
    SetObject = function(self, obj)
        TargetObject = obj
        CloneObject()
    end,
    SetRotate = function(self, enabled)
        ShouldRotate = enabled
    end,
    SetRotateSpeed = function(self, speed)
        RotateSpeed = speed
    end,
    SetFOV = function(self, fov)
        Camera.FieldOfView = fov
    end,
    Disconnect = function(self)
        if UpdateConnectionforprewviewui then
            UpdateConnectionforprewviewui:Disconnect()
        end
    end,
}


end







-- Utility functions for executor and region detection
local function GetExecutorName()
    -- Detect executor environment
    if identifyexecutor then
        local success, name = pcall(identifyexecutor)
        if success and name then
            return name
        end
    end
    
    -- Fallback detection methods
    if KRNL_LOADED then return "Krnl"
    elseif syn then return "Synapse X"
    elseif SONA_LOADED then return "Sona"
    elseif Fluxus then return "Fluxus"
    elseif getexecutorname then
        local success, name = pcall(getexecutorname)
        if success then return name end
    elseif is_sirhurt_closure then return "SirHurt"
    elseif OXYGEN_LOADED then return "Oxygen U"
    elseif shadow_env then return "Shadow"
    elseif SENTINEL_V2 then return "Sentinel"
    elseif is_protosmasher_closure then return "ProtoSmasher"
    elseif TRIGON_LOADED then return "Trigon"
    elseif iselectron or Electron then return "Electron"
    elseif secure_load then return "Sentinel"
    elseif ARCEUS_LOADED then return "Arceus X"
    elseif IsElectron then return "Electron"
    elseif http and http.request then return "Synapse"
    else return "Unknown"
    end
end

local function GetServerRegion()
    local LocalizationService = game:GetService("LocalizationService")
    local success, result = pcall(function()
        return LocalizationService:GetCountryRegionForPlayerAsync(game.Players.LocalPlayer)
    end)
    
    if success and result then
        -- Common region codes to full names
local regionNames = {
    -- North America
    ["US"] = "United States",
    ["CA"] = "Canada",
    ["MX"] = "Mexico",

    -- South America
    ["BR"] = "Brazil",
    ["AR"] = "Argentina",
    ["CL"] = "Chile",
    ["CO"] = "Colombia",
    ["PE"] = "Peru",
    ["VE"] = "Venezuela",

    -- Europe (most common)
    ["GB"] = "United Kingdom",
    ["DE"] = "Germany",
    ["FR"] = "France",
    ["IT"] = "Italy",
    ["ES"] = "Spain",
    ["NL"] = "Netherlands",
    ["BE"] = "Belgium",
    ["SE"] = "Sweden",
    ["NO"] = "Norway",
    ["DK"] = "Denmark",
    ["FI"] = "Finland",
    ["PL"] = "Poland",
    ["CZ"] = "Czech Republic",
    ["AT"] = "Austria",
    ["CH"] = "Switzerland",
    ["PT"] = "Portugal",
    ["IE"] = "Ireland",
    ["GR"] = "Greece",
    ["HU"] = "Hungary",
    ["RO"] = "Romania",
    ["TR"] = "Turkey",          -- both Europe & Asia
    ["UA"] = "Ukraine",
    ["RU"] = "Russia",

    -- Asia-Pacific (major markets)
    ["JP"] = "Japan",
    ["KR"] = "South Korea",
    ["CN"] = "China",
    ["IN"] = "India",
    ["AU"] = "Australia",
    ["NZ"] = "New Zealand",
    ["SG"] = "Singapore",
    ["ID"] = "Indonesia",
    ["MY"] = "Malaysia",
    ["TH"] = "Thailand",
    ["PH"] = "Philippines",
    ["VN"] = "Vietnam",
    ["TW"] = "Taiwan",
    ["HK"] = "Hong Kong",
    ["MO"] = "Macau",

    -- Middle East & Africa (frequently supported nowadays)
    ["AE"] = "United Arab Emirates",
    ["SA"] = "Saudi Arabia",
    ["IL"] = "Israel",
    ["ZA"] = "South Africa",
    ["EG"] = "Egypt",
    ["NG"] = "Nigeria",
    ["KE"] = "Kenya",

    -- Smaller but still often appearing regions
    ["LU"] = "Luxembourg",
    ["IS"] = "Iceland",
    ["EE"] = "Estonia",
    ["LV"] = "Latvia",
    ["LT"] = "Lithuania",
    ["HR"] = "Croatia",
    ["SI"] = "Slovenia",
    ["SK"] = "Slovakia",
    ["BG"] = "Bulgaria",
}

-- Bonus: very short alias-style version if you prefer minimal keys
-- local regionNamesShort = {
--     US="USA", GB="UK", DE="Germany", FR="France", CA="Canada", AU="Australia",
--     JP="Japan", KR="Korea", CN="China", IN="India", BR="Brazil", TR="Turkey",
--     SG="Singapore", AE="UAE", SA="Saudi", ZA="South Africa", TW="Taiwan",
--     HK="Hong Kong", ID="Indonesia", MY="Malaysia", TH="Thailand", PH="Philippines",
-- }
	
        return regionNames[result] or result
    end
    
    return "Unknown"
end

function Library:CreateStatsPanel(ParentWindow, Config)
    Config = Config or {}
    
    local PanelSize = Config.Size or UDim2.fromOffset(220, 140)
    local OffsetY = Config.OffsetY or 320
    
    -- Create outer frame
    local StatsOuter = Library:Create('Frame', {
        BackgroundColor3 = Color3.new(0, 0, 0),
        BorderColor3 = Color3.new(0, 0, 0),
        Size = PanelSize,
        Position = UDim2.new(1, 10, 0, OffsetY),
        Parent = ParentWindow.Holder,
        ZIndex = 50,
    })
    
    -- Create glow effect (matching preview style)
    local glow = Instance.new("ImageLabel", StatsOuter)
    glow.Name = "GlowEffect"
    glow.Image = "rbxassetid://18245826428"
    glow.ScaleType = Enum.ScaleType.Slice
    glow.SliceCenter = Rect.new(21, 21, 79, 79)
    glow.ImageColor3 = Library.AccentColor
    glow.ImageTransparency = 0.6
    glow.BackgroundTransparency = 1
    glow.Size = UDim2.new(1, 40, 1, 40)
    glow.Position = UDim2.new(0, -20, 0, -20)
    glow.ZIndex = -1
    
    -- Create pulsing animation
    local startTransparency = 0.6
    local minTransparency = 0.3
    local pulseDuration = getgenv().glowwatermarkspeed or 5
    
    local pulseInfo = TweenInfo.new(
        pulseDuration / 2,
        Enum.EasingStyle.Sine,
        Enum.EasingDirection.InOut
    )
    
    local function createPulseTween()
        local tweenOut = TweenService:Create(glow, pulseInfo, {ImageTransparency = minTransparency})
        local tweenIn = TweenService:Create(glow, pulseInfo, {ImageTransparency = startTransparency})
        
        tweenOut.Completed:Connect(function()
            tweenIn:Play()
        end)
        
        tweenIn.Completed:Connect(function()
            tweenOut:Play()
        end)
        
        tweenOut:Play()
    end
    
    createPulseTween()
    
    -- Color change detection (optimized)
    local lastColor = Library.AccentColor
    local colorChangeConnection
    colorChangeConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if Library.AccentColor ~= lastColor then
            lastColor = Library.AccentColor
            local colorTweenInfo = TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            TweenService:Create(glow, colorTweenInfo, {ImageColor3 = Library.AccentColor}):Play()
        end
    end)
    
    -- Create inner frame with gradient effect
    local StatsInner = Library:Create('Frame', {
        BackgroundColor3 = Library.MainColor,
        BorderColor3 = Library.AccentColor,
        BorderMode = Enum.BorderMode.Inset,
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 1, 0, 1),
        ZIndex = 51,
        Parent = StatsOuter,
    })
    
    -- Premium gradient overlay
    local gradientOverlay = Instance.new("Frame", StatsInner)
    gradientOverlay.Name = "GradientOverlay"
    gradientOverlay.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    gradientOverlay.BackgroundTransparency = 0.95
    gradientOverlay.BorderSizePixel = 0
    gradientOverlay.Size = UDim2.new(1, 0, 0.5, 0)
    gradientOverlay.ZIndex = 51
    
    local gradient = Instance.new("UIGradient", gradientOverlay)
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Library.AccentColor),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
    })
    gradient.Rotation = 90
    
    local Highlight = Library:Create('Frame', {
        BackgroundColor3 = Library.AccentColor,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 2),
        ZIndex = 52,
        Parent = StatsInner,
    })
    
    -- Color sync loop (optimized to only check when needed)
    local colorSyncTask = task.defer(function()
        local lastMain, lastAccent = Library.MainColor, Library.AccentColor
        while task.wait(2) do
            if lastMain ~= Library.MainColor or lastAccent ~= Library.AccentColor then
                lastMain, lastAccent = Library.MainColor, Library.AccentColor
                
                TweenService:Create(StatsInner, TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    BackgroundColor3 = lastMain,
                    BorderColor3 = lastAccent
                }):Play()
                
                TweenService:Create(Highlight, TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    BackgroundColor3 = lastAccent
                }):Play()
                
                gradient.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, lastAccent),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
                })
            end
        end
    end)
    
    -- Premium title with subtle styling
    Library:CreateLabel({
        Size = UDim2.new(1, 0, 0, 18),
        Position = UDim2.new(0, 4, 0, 2),
        Text = 'STATS',
        TextSize = 11,
        TextScaled = false,
        FontFace = fonts["ProggyClean"],
        ZIndex = 53,
        Parent = StatsInner,
    })
    
    -- Create container for stats with better spacing
    local StatsContainer = Library:Create('Frame', {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.new(1, -8, 1, -25),
        Position = UDim2.new(0, 4, 0, 22),
        ZIndex = 52,
        Parent = StatsInner,
    })
    
    -- Stats labels (premium look) - Left aligned
    local MemoryLabel = Library:CreateLabel({
        Size = UDim2.new(1, 0, 0.2, 0),
        Position = UDim2.new(0, 0, 0, 0),
        Text = 'Memory: 0.0 MB',
        TextSize = 9,
        FontFace = fonts["ProggyClean"],
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 53,
        Parent = StatsContainer,
    })
    
    local FPSLabel = Library:CreateLabel({
        Size = UDim2.new(1, 0, 0.2, 0),
        Position = UDim2.new(0, 0, 0.2, 0),
        Text = 'FPS: 0 | Ping: 0ms',
        TextSize = 9,
        FontFace = fonts["ProggyClean"],
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 53,
        Parent = StatsContainer,
    })
    
    local ExecutorLabel = Library:CreateLabel({
        Size = UDim2.new(1, 0, 0.2, 0),
        Position = UDim2.new(0, 0, 0.4, 0),
        Text = 'Executor: ' .. GetExecutorName(),
        TextSize = 9,
        FontFace = fonts["ProggyClean"],
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 53,
        Parent = StatsContainer,
    })
    
    local RegionLabel = Library:CreateLabel({
        Size = UDim2.new(1, 0, 0.2, 0),
        Position = UDim2.new(0, 0, 0.6, 0),
        Text = 'Region: Loading...',
        TextSize = 9,
        FontFace = fonts["ProggyClean"],
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 53,
        Parent = StatsContainer,
    })
    
    local UpTimeLabel = Library:CreateLabel({
        Size = UDim2.new(1, 0, 0.2, 0),
        Position = UDim2.new(0, 0, 0.8, 0),
        Text = 'UpTime: 0m 0s',
        TextSize = 9,
        FontFace = fonts["ProggyClean"],
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 53,
        Parent = StatsContainer,
    })
    
    -- Async fetch server region (runs once)
    task.spawn(function()
        local region = GetServerRegion()
        RegionLabel.Text = 'Region: ' .. region
    end)
    
    -- Optimized stats update loop
    local startTime = tick()
    local frameCount = 0
    local lastFrameTime = tick()
    local lastMemoryUpdate = tick()
    local lastPingUpdate = tick()
    local cachedMemory = 0
    local cachedPing = "0ms"
    local statsService = game:GetService("Stats")
    local UpdateStatsConnection
    
local lastUpdate = 0
local UPDATE_INTERVAL = 0.1 -- Update every 100ms instead of every frame

UpdateStatsConnection = RunService.Heartbeat:Connect(function()
    local now = tick()
    if now - lastUpdate < UPDATE_INTERVAL then return end
    lastUpdate = now
        if not StatsInner.Parent then
            UpdateStatsConnection:Disconnect()
            colorChangeConnection:Disconnect()
            return
        end
        
        frameCount = frameCount + 1
        local currentTime = tick()
        local deltaTime = currentTime - lastFrameTime
        
        -- Update FPS every 0.2 seconds
        if deltaTime >= 0.2 then
            local fps = math.floor(frameCount / deltaTime)
            FPSLabel.Text = "FPS: " .. fps .. " | Ping: " .. cachedPing
            frameCount = 0
            lastFrameTime = currentTime
        end
        
        -- Update Ping every 0.5 seconds
        if currentTime - lastPingUpdate >= 0.5 then
            local pingValue = statsService:FindFirstChild("Network")
            if pingValue then
                local pingItem = pingValue:FindFirstChild("ServerStatsItem")
                if pingItem then
                    local success, result = pcall(function()
                        return pingItem:GetValueString()
                    end)
                    if success then
                        cachedPing = result
                    end
                end
            end
            lastPingUpdate = currentTime
        end
        
        -- Update Memory every 0.5 seconds
        if currentTime - lastMemoryUpdate >= 0.5 then
            cachedMemory = math.floor(gcinfo() / 1024)
            
            if cachedMemory >= 80 then
                MemoryLabel.Text = "Memory: " .. cachedMemory .. "MB [HIGH]"
getgenv().logMessage(3, "Huge Memory Leak Detected")
                MemoryLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            else

                MemoryLabel.Text = "Memory: " .. cachedMemory .. " MB"
                MemoryLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            end
            lastMemoryUpdate = currentTime
        end
        
        -- Update UpTime every second
        if frameCount % 60 == 0 then
            local upTime = math.floor(currentTime - startTime)
            local minutes = math.floor(upTime / 60)
            local seconds = upTime % 60
            UpTimeLabel.Text = "UpTime: " .. minutes .. "m " .. seconds .. "s"
        end
    end)
    
    return {
        Outer = StatsOuter,
        MemoryLabel = MemoryLabel,
        FPSLabel = FPSLabel,
        ExecutorLabel = ExecutorLabel,
        RegionLabel = RegionLabel,
        UpTimeLabel = UpTimeLabel,
        Disconnect = function(self)
            if UpdateStatsConnection then
                UpdateStatsConnection:Disconnect()
            end
            if colorChangeConnection then
                colorChangeConnection:Disconnect()
            end
        end,
    }
end





function Library:CreateLogPanel(ParentWindow, PlayerListFrame, Config)
    Config = Config or {}
    
    local PanelSize = Config.Size or UDim2.fromOffset(250, 280)
    local MaxLogs = Config.MaxLogs or 50
    
    -- Create outer frame
    local LogOuter = Library:Create('Frame', {
        BackgroundColor3 = Color3.new(0, 0, 0),
        BorderColor3 = Color3.new(0, 0, 0),
        Size = PanelSize,
        Position = UDim2.fromOffset(5, 50),
        Parent = ScreenGui,
        ZIndex = 50,
        Visible = true,
    })
    
    -- Position below PlayerList
    local function UpdatePosition()
        if PlayerListFrame and PlayerListFrame.Holder and PlayerListFrame.Holder.Parent then
            local playerListPos = PlayerListFrame.Holder.AbsolutePosition
            local playerListSize = PlayerListFrame.Holder.AbsoluteSize
            LogOuter.Position = UDim2.fromOffset(playerListPos.X, playerListPos.Y + playerListSize.Y + 10)
        end
    end
    
    if PlayerListFrame and PlayerListFrame.Holder then
        Library:GiveSignal(PlayerListFrame.Holder:GetPropertyChangedSignal('AbsolutePosition'):Connect(UpdatePosition))
        Library:GiveSignal(PlayerListFrame.Holder:GetPropertyChangedSignal('AbsoluteSize'):Connect(UpdatePosition))
        UpdatePosition()
    end
    
    -- Glow effect
    local glow = Instance.new("ImageLabel", LogOuter)
    glow.Name = "GlowEffect"
    glow.Image = "rbxassetid://18245826428"
    glow.ScaleType = Enum.ScaleType.Slice
    glow.SliceCenter = Rect.new(21, 21, 79, 79)
    glow.ImageColor3 = Library.AccentColor
    glow.ImageTransparency = 0.6
    glow.BackgroundTransparency = 1
    glow.Size = UDim2.new(1, 40, 1, 40)
    glow.Position = UDim2.new(0, -20, 0, -20)
    glow.ZIndex = -1
    
    -- Pulse animation
    local function createPulseTween()
        local tweenOut = TweenService:Create(glow, TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {ImageTransparency = 0.3})
        local tweenIn = TweenService:Create(glow, TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {ImageTransparency = 0.6})
        tweenOut.Completed:Connect(function() tweenIn:Play() end)
        tweenIn.Completed:Connect(function() tweenOut:Play() end)
        tweenOut:Play()
    end
    createPulseTween()
    
    -- Color change detection
    local lastColor = Library.AccentColor
    Library:GiveSignal(RunService.Heartbeat:Connect(function()
        if Library.AccentColor ~= lastColor then
            lastColor = Library.AccentColor
            TweenService:Create(glow, TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Library.AccentColor}):Play()
        end
    end))
    
    -- Inner frame
    local LogInner = Library:Create('Frame', {
        BackgroundColor3 = Library.MainColor,
        BorderColor3 = Library.AccentColor,
        BorderMode = Enum.BorderMode.Inset,
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 1, 0, 1),
        ZIndex = 51,
        Parent = LogOuter,
    })
    
    Library:AddToRegistry(LogInner, {BackgroundColor3 = 'MainColor', BorderColor3 = 'AccentColor'})
    
    local Highlight = Library:Create('Frame', {
        BackgroundColor3 = Library.AccentColor,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 2),
        ZIndex = 52,
        Parent = LogInner,
    })
    
    Library:AddToRegistry(Highlight, {BackgroundColor3 = 'AccentColor'})
    
    -- Title with gradient background
    local TitleContainer = Library:Create('Frame', {
        BackgroundColor3 = Library.MainColor,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 18),
        Position = UDim2.new(0, 0, 0, 2),
        ZIndex = 52,
        Parent = LogInner,
    })
    
    local TitleGradient = Library:Create('UIGradient', {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Library:GetDarkerColor(Library.MainColor)),
            ColorSequenceKeypoint.new(1, Library.MainColor),
        }),
        Rotation = 90,
        Parent = TitleContainer,
    })
    
    local TitleLabel = Library:CreateLabel({
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 4, 0, 0),
        Text = 'LOGS',
        TextSize = 12,
        FontFace = fonts["ProggyClean"],
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 53,
        Parent = TitleContainer,
    })
    
    -- Scrolling frame for logs
    local ScrollingFrame = Library:Create('ScrollingFrame', {
        BackgroundColor3 = Library.BackgroundColor,
        BackgroundTransparency = 0,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 4, 0, 24),
        Size = UDim2.new(1, -8, 1, -28),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = Library.AccentColor,
        ZIndex = 52,
        Parent = LogInner,
        TopImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png',
        BottomImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png',
    })
    
    Library:AddToRegistry(ScrollingFrame, {
        ScrollBarImageColor3 = 'AccentColor',
        BackgroundColor3 = 'BackgroundColor'
    })
    
    local ListLayout = Library:Create('UIListLayout', {
        Padding = UDim.new(0, 2),
        FillDirection = Enum.FillDirection.Vertical,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = ScrollingFrame,
    })
    
    local LogMessages = {}
    local LogTypes = {
        [0] = {prefix = "OUT", color = Color3.fromRGB(230, 230, 230), bgColor = Color3.fromRGB(40, 40, 45)},
        [1] = {prefix = "INFO", color = Color3.fromRGB(100, 180, 255), bgColor = Color3.fromRGB(30, 40, 50)},
        [2] = {prefix = "WARN", color = Color3.fromRGB(255, 200, 80), bgColor = Color3.fromRGB(50, 45, 30)},
        [3] = {prefix = "ERR", color = Color3.fromRGB(255, 100, 100), bgColor = Color3.fromRGB(50, 30, 30)},
    }
    
    local function AddLog(logType, message)
        local logInfo = LogTypes[logType] or LogTypes[0]
        
        -- Remove oldest log if at max
        if #LogMessages >= MaxLogs then
            local oldest = table.remove(LogMessages, 1)
            if oldest then oldest:Destroy() end
        end
        
        -- Create log entry frame
        local LogEntry = Library:Create('Frame', {
            BackgroundColor3 = logInfo.bgColor,
            BorderColor3 = Library.OutlineColor,
            BorderMode = Enum.BorderMode.Inset,
            Size = UDim2.new(1, -2, 0, 22),
            ZIndex = 53,
            Parent = ScrollingFrame,
        })
        
        -- Colored left accent
        local ColorAccent = Library:Create('Frame', {
            BackgroundColor3 = logInfo.color,
            BorderSizePixel = 0,
            Size = UDim2.new(0, 2, 1, 0),
            Position = UDim2.new(0, 0, 0, 0),
            ZIndex = 54,
            Parent = LogEntry,
        })
        
        -- Prefix label (colored box style)
        local PrefixLabel = Library:Create('TextLabel', {
            BackgroundColor3 = logInfo.color,
            BackgroundTransparency = 0.9,
            BorderSizePixel = 0,
            Size = UDim2.new(0, 40, 0, 14),
            Position = UDim2.new(0, 6, 0.5, -7),
            Text = logInfo.prefix,
            TextColor3 = logInfo.color,
            TextSize = 10,
            FontFace = fonts["ProggyClean"],
            TextStrokeTransparency = 1,
            ZIndex = 55,
            Parent = LogEntry,
        })
        
        Library:Create('UICorner', {
            CornerRadius = UDim.new(0, 2),
            Parent = PrefixLabel,
        })
        
        -- Message text
        local MessageLabel = Library:Create('TextLabel', {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, -52, 1, 0),
            Position = UDim2.new(0, 50, 0, 0),
            Text = message,
            TextColor3 = Color3.fromRGB(220, 220, 220),
            TextSize = 13,
            FontFace = fonts["ProggyClean"],
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Center,
            TextTruncate = Enum.TextTruncate.AtEnd,
            TextStrokeTransparency = 1,
            ZIndex = 55,
            Parent = LogEntry,
        })
        
        table.insert(LogMessages, LogEntry)
        
        -- Fade in animation
        LogEntry.BackgroundTransparency = 1
        ColorAccent.BackgroundTransparency = 1
        PrefixLabel.TextTransparency = 1
        PrefixLabel.BackgroundTransparency = 1
        MessageLabel.TextTransparency = 1
        
        TweenService:Create(LogEntry, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundTransparency = 0}):Play()
        TweenService:Create(ColorAccent, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundTransparency = 0}):Play()
        TweenService:Create(PrefixLabel, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {TextTransparency = 0, BackgroundTransparency = 0.9}):Play()
        TweenService:Create(MessageLabel, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()
        
        -- Update canvas size and scroll to bottom
        ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y)
        task.wait()
        ScrollingFrame.CanvasPosition = Vector2.new(0, ScrollingFrame.CanvasSize.Y.Offset)
    end
    
    -- Global function
    getgenv().logMessage = function(logType, message)
        AddLog(logType, tostring(message))
    end
    
    -- Sync with parent window visibility
    if ParentWindow and ParentWindow.Holder then
        ParentWindow.Holder:GetPropertyChangedSignal('Visible'):Connect(function()
            LogOuter.Visible = ParentWindow.Holder.Visible
        end)
        LogOuter.Visible = ParentWindow.Holder.Visible
    end
    
    return {
        Outer = LogOuter,
        AddLog = AddLog,
        Clear = function()
            for _, log in ipairs(LogMessages) do
                log:Destroy()
            end
            LogMessages = {}
            ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        end,
    }
end















local function OnPlayerChange()
    local PlayerList = GetPlayersString();

    for _, Value in next, Options do
        if Value.Type == 'Dropdown' and Value.SpecialType == 'Player' then
            Value:SetValues(PlayerList);
        end;
    end;
end;

Players.PlayerAdded:Connect(OnPlayerChange);
Players.PlayerRemoving:Connect(OnPlayerChange);

getgenv().Library = Library
        end
return Library
