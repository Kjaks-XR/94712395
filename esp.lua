local Workspace, RunService, Players, CoreGui, Lighting, UserInputService = cloneref(game:GetService("Workspace")), cloneref(game:GetService("RunService")), cloneref(game:GetService("Players")), game:GetService("CoreGui"), cloneref(game:GetService("Lighting")), cloneref(game:GetService("UserInputService"))
local ESP = {
    Enabled = false,
    TeamCheck = false,
    MaxDistance = 200,
    FontSize = 11,
    FOV = {
        Enabled = false,
        Radius = 150,
        ShowCircle = false,
        Color = Color3.fromRGB(119, 120, 255),
        Transparency = 0.0,
        Thickness = 2,
    },
    Snaplines = {
        Enabled = false,
        FromMouse = false,
        Color = Color3.fromRGB(119, 120, 255),
        Transparency = 1.0,
        Thickness = 2,
    },
    PlayerInfo = {
        Enabled = false,
        ShowOnlyVisible = true,
        ShowOnlyInFOV = true,
        Position = UDim2.new(1, -305, 0.5, -75),
        BackgroundColor = Color3.fromRGB(20, 20, 30),
        BackgroundTransparency = 0.2,
        TextColor = Color3.fromRGB(255, 255, 255),
        BorderColor = Color3.fromRGB(119, 120, 255),
    },
    FadeOut = {
        OnDistance = false,
        OnDeath = false,
        OnLeave = false,
    },
    Options = { 
        Teamcheck = false, TeamcheckRGB = Color3.fromRGB(0, 255, 0),
        Friendcheck = false, FriendcheckRGB = Color3.fromRGB(0, 255, 0),
        Highlight = false, HighlightRGB = Color3.fromRGB(255, 0, 0),
    },
    Drawing = {
        Chams = {
            Enabled = false,
            Thermal = true,
            FillRGB = Color3.fromRGB(119, 120, 255),
            Fill_Transparency = 100,
            OutlineRGB = Color3.fromRGB(119, 120, 255),
            Outline_Transparency = 100,
            VisibleCheck = true,
        },
        Names = {
            Enabled = false,
            RGB = Color3.fromRGB(255, 255, 255),
        },
        Flags = {
            Enabled = false,
        },
        Distances = {
            Enabled = false, 
            Position = "Text",
            RGB = Color3.fromRGB(255, 255, 255),
        },
        Healthbar = {
            Enabled = false,  
            HealthText = true, Lerp = false, HealthTextRGB = Color3.fromRGB(119, 120, 255),
            Width = 2.5,
            Gradient = true, GradientRGB1 = Color3.fromRGB(200, 0, 0), GradientRGB2 = Color3.fromRGB(60, 60, 125), GradientRGB3 = Color3.fromRGB(119, 120, 255), 
        },
        Boxes = {
            Animate = true,
            RotationSpeed = 300,
            Gradient = false, GradientRGB1 = Color3.fromRGB(119, 120, 255), GradientRGB2 = Color3.fromRGB(0, 0, 0), 
            GradientFill = false, GradientFillRGB1 = Color3.fromRGB(119, 120, 255), GradientFillRGB2 = Color3.fromRGB(0, 0, 0), 
            Full = {
                Enabled = false,
                RGB = Color3.fromRGB(255, 255, 255),
            },
            Corner = {
                Enabled = false,
                RGB = Color3.fromRGB(255, 255, 255),
            },
        };
    };
    Connections = {
        RunService = RunService;
    };
    Fonts = {};
}

local Euphoria = ESP.Connections;
local lplayer = Players.LocalPlayer;
local camera = game.Workspace.CurrentCamera;
local Cam = Workspace.CurrentCamera;
local mouse = lplayer:GetMouse();
local RotationAngle, Tick = -45, tick();

local PlayerESPObjects = {}
local playersInFOV = {}

local Snapline = Drawing.new("Line")
Snapline.Visible = false
Snapline.Thickness = ESP.Snaplines.Thickness
Snapline.Color = ESP.Snaplines.Color
Snapline.Transparency = ESP.Snaplines.Transparency

local function RecreateSnapline()
    if Snapline then
        Snapline:Remove()
    end
    Snapline = Drawing.new("Line")
    Snapline.Visible = false
    Snapline.Thickness = ESP.Snaplines.Thickness
    Snapline.Color = ESP.Snaplines.Color
    Snapline.Transparency = ESP.Snaplines.Transparency
end

local Functions = {}
do
    function Functions:Create(Class, Properties)
        local _Instance = typeof(Class) == 'string' and Instance.new(Class) or Class
        for Property, Value in pairs(Properties) do
            _Instance[Property] = Value
        end
        return _Instance;
    end
    
    function Functions:FadeOutOnDist(element, distance)
        local transparency = math.max(0.1, 1 - (distance / ESP.MaxDistance))
        if element:IsA("TextLabel") then
            element.TextTransparency = 1 - transparency
        elseif element:IsA("ImageLabel") then
            element.ImageTransparency = 1 - transparency
        elseif element:IsA("UIStroke") then
            element.Transparency = 1 - transparency
        elseif element:IsA("Frame") then
            element.BackgroundTransparency = 1 - transparency
        elseif element:IsA("Highlight") then
            element.FillTransparency = 1 - transparency
            element.OutlineTransparency = 1 - transparency
        end;
    end
    
    function Functions:IsInFOV(targetPos)
        local screenPos, onScreen = Cam:WorldToScreenPoint(targetPos)
        if not onScreen then return false end
        
        local centerX, centerY = Cam.ViewportSize.X / 2, Cam.ViewportSize.Y / 2
        local distance = math.sqrt((screenPos.X - centerX)^2 + (screenPos.Y - centerY)^2)
        
        return distance <= ESP.FOV.Radius
    end
    
    function Functions:IsVisible(targetPos, targetCharacter)
        if not ESP.PlayerInfo.ShowOnlyVisible then return true end
        
        local origin = Cam.CFrame.Position
        local direction = (targetPos - origin).Unit
        local distance = (targetPos - origin).Magnitude
        
        local raycastParams = RaycastParams.new()
        raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
        raycastParams.FilterDescendantsInstances = {lplayer.Character, targetCharacter}
        
        local raycastResult = Workspace:Raycast(origin, direction * distance, raycastParams)
        
        return raycastResult == nil
    end
    
    function Functions:FindTargetWithinFOV()
        local mousePos = Vector2.new(mouse.X, mouse.Y)
        local closestTarget = nil
        local shortestDistance = ESP.FOV.Radius

        for _, targetPlayer in pairs(Players:GetPlayers()) do
            if targetPlayer ~= lplayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = targetPlayer.Character.HumanoidRootPart
                local screenPos, onScreen = Cam:WorldToViewportPoint(hrp.Position)

                if onScreen then
                    local screenPoint = Vector2.new(screenPos.X, screenPos.Y)
                    local distance = (screenPoint - mousePos).Magnitude

                    if distance < shortestDistance then
                        if Functions:IsVisible(hrp.Position, targetPlayer.Character) then
                            shortestDistance = distance
                            closestTarget = targetPlayer.Character
                        end
                    end
                end
            end
        end

        return closestTarget
    end
    
    function Functions:HidePlayerESP(espObjects)
        if not espObjects then return end
        
        local guiElements = {
            "Name", "Distance", "Box", "Healthbar", "BehindHealthbar", "HealthText",
            "LeftTop", "LeftSide", "RightTop", "RightSide", "BottomSide", "BottomDown",
            "BottomRightSide", "BottomRightDown", "Flag1", "Flag2"
        }
        
        for _, elementName in pairs(guiElements) do
            local obj = espObjects[elementName]
            if obj and obj.Visible ~= nil then
                obj.Visible = false
            end
        end
        
        if espObjects.Chams and espObjects.Chams.Enabled ~= nil then
            espObjects.Chams.Enabled = false
        end
    end
    
    function Functions:UpdatePlayerESP(plr, espObjects)
        if not ESP.Enabled or not plr.Character or not plr.Character:FindFirstChild("HumanoidRootPart") then
            Functions:HidePlayerESP(espObjects)
            return
        end
        
        local HRP = plr.Character.HumanoidRootPart
        local Humanoid = plr.Character:FindFirstChild("Humanoid")
        if not Humanoid then 
            Functions:HidePlayerESP(espObjects)
            return 
        end
        
        local Pos, OnScreen = Cam:WorldToScreenPoint(HRP.Position)
        local Dist = (Cam.CFrame.Position - HRP.Position).Magnitude / 3.5714285714
        
        if OnScreen and Dist <= ESP.MaxDistance then
                        local Size = HRP.Size.Y
                        local scaleFactor = (Size * Cam.ViewportSize.Y) / (Pos.Z * 2)
                        local w, h = 3 * scaleFactor, 4.5 * scaleFactor

            local inFOV = Functions:IsInFOV(HRP.Position)
            local isVisible = Functions:IsVisible(HRP.Position, plr.Character)
            
            if inFOV and isVisible then
                playersInFOV[plr] = {
                    name = plr.Name,
                    distance = Dist,
                    health = Humanoid.Health,
                    maxHealth = Humanoid.MaxHealth,
                    position = HRP.Position,
                    character = plr.Character
                }
            else
                playersInFOV[plr] = nil
            end

                        if ESP.FadeOut.OnDistance then
                for _, obj in pairs(espObjects) do
                    if obj and obj ~= espObjects.Chams then
                        Functions:FadeOutOnDist(obj, Dist)
                    end
                end
                if espObjects.Chams then
                    Functions:FadeOutOnDist(espObjects.Chams, Dist)
                end
                        end

            local shouldShow = plr ~= lplayer

            if ESP.TeamCheck then
                shouldShow = shouldShow and (not lplayer.Team or not plr.Team or lplayer.Team ~= plr.Team)
            end
            
            if shouldShow then

                espObjects.Chams.Adornee = plr.Character
                espObjects.Chams.Enabled = ESP.Drawing.Chams.Enabled
                espObjects.Chams.FillColor = ESP.Drawing.Chams.FillRGB
                espObjects.Chams.OutlineColor = ESP.Drawing.Chams.OutlineRGB
                
                                    if ESP.Drawing.Chams.Thermal then
                                        local breathe_effect = math.atan(math.sin(tick() * 2)) * 2 / math.pi
                    espObjects.Chams.FillTransparency = ESP.Drawing.Chams.Fill_Transparency * breathe_effect * 0.01
                    espObjects.Chams.OutlineTransparency = ESP.Drawing.Chams.Outline_Transparency * breathe_effect * 0.01
                                    end
                
                                if ESP.Drawing.Chams.VisibleCheck then
                    espObjects.Chams.DepthMode = "Occluded"
                else
                    espObjects.Chams.DepthMode = "AlwaysOnTop"
                end

                local corners = {espObjects.LeftTop, espObjects.LeftSide, espObjects.BottomSide, espObjects.BottomDown, 
                               espObjects.RightTop, espObjects.RightSide, espObjects.BottomRightSide, espObjects.BottomRightDown}
                               
                for _, corner in pairs(corners) do
                    corner.Visible = ESP.Drawing.Boxes.Corner.Enabled
                end
                
                if ESP.Drawing.Boxes.Corner.Enabled then
                    espObjects.LeftTop.Position = UDim2.new(0, Pos.X - w / 2, 0, Pos.Y - h / 2)
                    espObjects.LeftTop.Size = UDim2.new(0, w / 5, 0, 1)
                    
                    espObjects.LeftSide.Position = UDim2.new(0, Pos.X - w / 2, 0, Pos.Y - h / 2)
                    espObjects.LeftSide.Size = UDim2.new(0, 1, 0, h / 5)
                    
                    espObjects.BottomSide.Position = UDim2.new(0, Pos.X - w / 2, 0, Pos.Y + h / 2)
                    espObjects.BottomSide.Size = UDim2.new(0, 1, 0, h / 5)
                    espObjects.BottomSide.AnchorPoint = Vector2.new(0, 5)
                    
                    espObjects.BottomDown.Position = UDim2.new(0, Pos.X - w / 2, 0, Pos.Y + h / 2)
                    espObjects.BottomDown.Size = UDim2.new(0, w / 5, 0, 1)
                    espObjects.BottomDown.AnchorPoint = Vector2.new(0, 1)
                    
                    espObjects.RightTop.Position = UDim2.new(0, Pos.X + w / 2, 0, Pos.Y - h / 2)
                    espObjects.RightTop.Size = UDim2.new(0, w / 5, 0, 1)
                    espObjects.RightTop.AnchorPoint = Vector2.new(1, 0)
                    
                    espObjects.RightSide.Position = UDim2.new(0, Pos.X + w / 2 - 1, 0, Pos.Y - h / 2)
                    espObjects.RightSide.Size = UDim2.new(0, 1, 0, h / 5)
                    espObjects.RightSide.AnchorPoint = Vector2.new(0, 0)
                    
                    espObjects.BottomRightSide.Position = UDim2.new(0, Pos.X + w / 2, 0, Pos.Y + h / 2)
                    espObjects.BottomRightSide.Size = UDim2.new(0, 1, 0, h / 5)
                    espObjects.BottomRightSide.AnchorPoint = Vector2.new(1, 1)
                    
                    espObjects.BottomRightDown.Position = UDim2.new(0, Pos.X + w / 2, 0, Pos.Y + h / 2)
                    espObjects.BottomRightDown.Size = UDim2.new(0, w / 5, 0, 1)
                    espObjects.BottomRightDown.AnchorPoint = Vector2.new(1, 1)
                end

                espObjects.Box.Position = UDim2.new(0, Pos.X - w / 2, 0, Pos.Y - h / 2)
                espObjects.Box.Size = UDim2.new(0, w, 0, h)
                espObjects.Box.Visible = ESP.Drawing.Boxes.Full.Enabled
                
                                RotationAngle = RotationAngle + (tick() - Tick) * ESP.Drawing.Boxes.RotationSpeed * math.cos(math.pi / 4 * tick() - math.pi / 2)
                                if ESP.Drawing.Boxes.Animate then
                    espObjects.Gradient2.Rotation = RotationAngle
                                else
                    espObjects.Gradient2.Rotation = -45
                                end
                                Tick = tick()

                local health = Humanoid.Health / Humanoid.MaxHealth
                espObjects.Healthbar.Visible = ESP.Drawing.Healthbar.Enabled
                espObjects.Healthbar.Position = UDim2.new(0, Pos.X - w / 2 - 6, 0, Pos.Y - h / 2 + h * (1 - health))
                espObjects.Healthbar.Size = UDim2.new(0, ESP.Drawing.Healthbar.Width, 0, h * health)
                
                espObjects.BehindHealthbar.Visible = ESP.Drawing.Healthbar.Enabled
                espObjects.BehindHealthbar.Position = UDim2.new(0, Pos.X - w / 2 - 6, 0, Pos.Y - h / 2)
                espObjects.BehindHealthbar.Size = UDim2.new(0, ESP.Drawing.Healthbar.Width, 0, h)
                
                                    if ESP.Drawing.Healthbar.HealthText then
                                        local healthPercentage = math.floor(Humanoid.Health / Humanoid.MaxHealth * 100)
                    espObjects.HealthText.Position = UDim2.new(0, Pos.X - w / 2 - 6, 0, Pos.Y - h / 2 + h * (1 - healthPercentage / 100) + 3)
                    espObjects.HealthText.Text = tostring(healthPercentage)
                    espObjects.HealthText.Visible = Humanoid.Health < Humanoid.MaxHealth
                                        if ESP.Drawing.Healthbar.Lerp then
                                            local color = health >= 0.75 and Color3.fromRGB(0, 255, 0) or health >= 0.5 and Color3.fromRGB(255, 255, 0) or health >= 0.25 and Color3.fromRGB(255, 170, 0) or Color3.fromRGB(255, 0, 0)
                        espObjects.HealthText.TextColor3 = color
                                        else
                        espObjects.HealthText.TextColor3 = ESP.Drawing.Healthbar.HealthTextRGB
                                        end
                else
                    espObjects.HealthText.Visible = false
                            end

                espObjects.Name.Visible = ESP.Drawing.Names.Enabled
                                if ESP.Options.Friendcheck and lplayer:IsFriendsWith(plr.UserId) then
                    espObjects.Name.Text = string.format('(<font color="rgb(%d, %d, %d)">F</font>) %s', ESP.Options.FriendcheckRGB.R * 255, ESP.Options.FriendcheckRGB.G * 255, ESP.Options.FriendcheckRGB.B * 255, plr.Name)
                                else
                    espObjects.Name.Text = string.format('(<font color="rgb(%d, %d, %d)">E</font>) %s', 255, 0, 0, plr.Name)
                                end
                espObjects.Name.Position = UDim2.new(0, Pos.X, 0, Pos.Y - h / 2 - 9)
                            
                                if ESP.Drawing.Distances.Enabled then
                                    if ESP.Drawing.Distances.Position == "Bottom" then
                        espObjects.Distance.Position = UDim2.new(0, Pos.X, 0, Pos.Y + h / 2 + 7)
                        espObjects.Distance.Text = string.format("%d meters", math.floor(Dist))
                        espObjects.Distance.Visible = true
                                    elseif ESP.Drawing.Distances.Position == "Text" then
                        espObjects.Distance.Visible = false
                                        if ESP.Options.Friendcheck and lplayer:IsFriendsWith(plr.UserId) then
                            espObjects.Name.Text = string.format('(<font color="rgb(%d, %d, %d)">F</font>) %s [%d]', ESP.Options.FriendcheckRGB.R * 255, ESP.Options.FriendcheckRGB.G * 255, ESP.Options.FriendcheckRGB.B * 255, plr.Name, math.floor(Dist))
                        else
                            espObjects.Name.Text = string.format('(<font color="rgb(%d, %d, %d)">E</font>) %s [%d]', 255, 0, 0, plr.Name, math.floor(Dist))
                        end
                        espObjects.Name.Visible = ESP.Drawing.Names.Enabled
                    end
                else
                    espObjects.Distance.Visible = false
                end
            else
                Functions:HidePlayerESP(espObjects)
            end
        else
            Functions:HidePlayerESP(espObjects)
                                    end
                                end
                            end

do
    local ScreenGui = Functions:Create("ScreenGui", {
        Parent = CoreGui,
        Name = "NexusScriptsESP",
    });
    
    local FOVCircle = Functions:Create("Frame", {
        Parent = ScreenGui,
        Name = "FOVCircle",
        Size = UDim2.new(0, ESP.FOV.Radius * 2, 0, ESP.FOV.Radius * 2),
        Position = UDim2.new(0.5, -ESP.FOV.Radius, 0.5, -ESP.FOV.Radius),
        BackgroundTransparency = 1,
        ZIndex = 1,
    })
    
    local FOVCircleStroke = Functions:Create("UIStroke", {
        Parent = FOVCircle,
        Color = ESP.FOV.Color,
        Transparency = ESP.FOV.Transparency,
        Thickness = ESP.FOV.Thickness,
    })
    
    local FOVCircleCorner = Functions:Create("UICorner", {
        Parent = FOVCircle,
        CornerRadius = UDim.new(0.5, 0),
    })
    
    local PlayerInfoPanel = Functions:Create("Frame", {
        Parent = ScreenGui,
        Name = "PlayerInfoPanel",
        Size = UDim2.new(0, 300, 0, 150),
        Position = ESP.PlayerInfo.Position,
        BackgroundColor3 = ESP.PlayerInfo.BackgroundColor,
        BackgroundTransparency = ESP.PlayerInfo.BackgroundTransparency,
        BorderSizePixel = 0,
        ZIndex = 3,
        Visible = false,
    })
    
    local PlayerInfoStroke = Functions:Create("UIStroke", {
        Parent = PlayerInfoPanel,
        Color = ESP.PlayerInfo.BorderColor,
        Transparency = 0,
        Thickness = 1,
    })
    
    local PlayerInfoCorner = Functions:Create("UICorner", {
        Parent = PlayerInfoPanel,
        CornerRadius = UDim.new(0, 8),
    })
    
    local PlayerInfoText = Functions:Create("TextLabel", {
        Parent = PlayerInfoPanel,
        Size = UDim2.new(1, -20, 1, -20),
        Position = UDim2.new(0, 10, 0, 10),
        BackgroundTransparency = 1,
        TextColor3 = ESP.PlayerInfo.TextColor,
        Font = Enum.Font.Code,
        TextSize = 14,
        TextStrokeTransparency = 0,
        TextStrokeColor3 = Color3.fromRGB(0, 0, 0),
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        RichText = true,
        Text = "",
    })
    
    local DupeCheck = function(plr)
        if ScreenGui:FindFirstChild(plr.Name) then
            ScreenGui[plr.Name]:Destroy()
        end
        if PlayerESPObjects[plr] then
            for _, obj in pairs(PlayerESPObjects[plr]) do
                if obj and obj.Destroy then
                    obj:Destroy()
                end
            end
            PlayerESPObjects[plr] = nil
        end
    end

    local CreatePlayerESP = function(plr)
        coroutine.wrap(DupeCheck)(plr)
        
        local espObjects = {}
        
        espObjects.Name = Functions:Create("TextLabel", {Parent = ScreenGui, Position = UDim2.new(0.5, 0, 0, -11), Size = UDim2.new(0, 100, 0, 20), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = ESP.FontSize, TextStrokeTransparency = 0, TextStrokeColor3 = Color3.fromRGB(0, 0, 0), RichText = true})
        espObjects.Distance = Functions:Create("TextLabel", {Parent = ScreenGui, Position = UDim2.new(0.5, 0, 0, 11), Size = UDim2.new(0, 100, 0, 20), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = ESP.FontSize, TextStrokeTransparency = 0, TextStrokeColor3 = Color3.fromRGB(0, 0, 0), RichText = true})
        espObjects.Box = Functions:Create("Frame", {Parent = ScreenGui, BackgroundTransparency = 1, BorderSizePixel = 0})
        espObjects.Gradient1 = Functions:Create("UIGradient", {Parent = espObjects.Box, Enabled = false})
        espObjects.Outline = Functions:Create("UIStroke", {Parent = espObjects.Box, Enabled = ESP.Drawing.Boxes.Gradient, Transparency = 0, Color = Color3.fromRGB(255, 255, 255), LineJoinMode = Enum.LineJoinMode.Miter})
        espObjects.Gradient2 = Functions:Create("UIGradient", {Parent = espObjects.Outline, Enabled = ESP.Drawing.Boxes.Gradient, Color = ColorSequence.new{ColorSequenceKeypoint.new(0, ESP.Drawing.Boxes.GradientRGB1), ColorSequenceKeypoint.new(1, ESP.Drawing.Boxes.GradientRGB2)}})
        espObjects.Healthbar = Functions:Create("Frame", {Parent = ScreenGui, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0})
        espObjects.BehindHealthbar = Functions:Create("Frame", {Parent = ScreenGui, ZIndex = -1, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0})
        espObjects.HealthbarGradient = Functions:Create("UIGradient", {Parent = espObjects.Healthbar, Enabled = ESP.Drawing.Healthbar.Gradient, Rotation = -90, Color = ColorSequence.new{ColorSequenceKeypoint.new(0, ESP.Drawing.Healthbar.GradientRGB1), ColorSequenceKeypoint.new(0.5, ESP.Drawing.Healthbar.GradientRGB2), ColorSequenceKeypoint.new(1, ESP.Drawing.Healthbar.GradientRGB3)}})
        espObjects.HealthText = Functions:Create("TextLabel", {Parent = ScreenGui, Position = UDim2.new(0.5, 0, 0, 31), Size = UDim2.new(0, 100, 0, 20), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = ESP.FontSize, TextStrokeTransparency = 0, TextStrokeColor3 = Color3.fromRGB(0, 0, 0)})
        espObjects.Chams = Functions:Create("Highlight", {Parent = ScreenGui, FillTransparency = 1, OutlineTransparency = 0, OutlineColor = Color3.fromRGB(119, 120, 255), DepthMode = "AlwaysOnTop"})
        espObjects.LeftTop = Functions:Create("Frame", {Parent = ScreenGui, BackgroundColor3 = ESP.Drawing.Boxes.Corner.RGB, Position = UDim2.new(0, 0, 0, 0)})
        espObjects.LeftSide = Functions:Create("Frame", {Parent = ScreenGui, BackgroundColor3 = ESP.Drawing.Boxes.Corner.RGB, Position = UDim2.new(0, 0, 0, 0)})
        espObjects.RightTop = Functions:Create("Frame", {Parent = ScreenGui, BackgroundColor3 = ESP.Drawing.Boxes.Corner.RGB, Position = UDim2.new(0, 0, 0, 0)})
        espObjects.RightSide = Functions:Create("Frame", {Parent = ScreenGui, BackgroundColor3 = ESP.Drawing.Boxes.Corner.RGB, Position = UDim2.new(0, 0, 0, 0)})
        espObjects.BottomSide = Functions:Create("Frame", {Parent = ScreenGui, BackgroundColor3 = ESP.Drawing.Boxes.Corner.RGB, Position = UDim2.new(0, 0, 0, 0)})
        espObjects.BottomDown = Functions:Create("Frame", {Parent = ScreenGui, BackgroundColor3 = ESP.Drawing.Boxes.Corner.RGB, Position = UDim2.new(0, 0, 0, 0)})
        espObjects.BottomRightSide = Functions:Create("Frame", {Parent = ScreenGui, BackgroundColor3 = ESP.Drawing.Boxes.Corner.RGB, Position = UDim2.new(0, 0, 0, 0)})
        espObjects.BottomRightDown = Functions:Create("Frame", {Parent = ScreenGui, BackgroundColor3 = ESP.Drawing.Boxes.Corner.RGB, Position = UDim2.new(0, 0, 0, 0)})
        espObjects.Flag1 = Functions:Create("TextLabel", {Parent = ScreenGui, Position = UDim2.new(1, 0, 0, 0), Size = UDim2.new(0, 100, 0, 20), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = ESP.FontSize, TextStrokeTransparency = 0, TextStrokeColor3 = Color3.fromRGB(0, 0, 0)})
        espObjects.Flag2 = Functions:Create("TextLabel", {Parent = ScreenGui, Position = UDim2.new(1, 0, 0, 0), Size = UDim2.new(0, 100, 0, 20), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = ESP.FontSize, TextStrokeTransparency = 0, TextStrokeColor3 = Color3.fromRGB(0, 0, 0)})
        
        PlayerESPObjects[plr] = espObjects
    end
    
    local masterRenderConnection = RunService.RenderStepped:Connect(function()
        
        for plr, espObjects in pairs(PlayerESPObjects) do
            if plr and plr.Parent and espObjects then
                Functions:UpdatePlayerESP(plr, espObjects)
            else
                
                if espObjects then
                    for _, obj in pairs(espObjects) do
                        if obj and obj.Destroy then
                            obj:Destroy()
                        end
                    end
                end
                PlayerESPObjects[plr] = nil
                playersInFOV[plr] = nil
            end
        end
        
        if ESP.Snaplines.Enabled then
            local targetCharacter = Functions:FindTargetWithinFOV()
            
            if targetCharacter and targetCharacter:FindFirstChild("HumanoidRootPart") then
                local targetPos, onScreen = Cam:WorldToViewportPoint(targetCharacter.HumanoidRootPart.Position)
                
                if onScreen then
                    local mousePos = Vector2.new(mouse.X, mouse.Y)
                    
                    local success = pcall(function()
                        
                        if not Snapline then
                            RecreateSnapline()
                        end
                        
                        Snapline.Color = ESP.Snaplines.Color
                        Snapline.Transparency = ESP.Snaplines.Transparency
                        Snapline.Thickness = ESP.Snaplines.Thickness
                        
                        if ESP.Snaplines.FromMouse then
                            Snapline.From = mousePos
                        else
                            Snapline.From = Vector2.new(Cam.ViewportSize.X / 2, Cam.ViewportSize.Y / 2)
                        end
                        
                        Snapline.To = Vector2.new(targetPos.X, targetPos.Y)
                        Snapline.Visible = true
                    end)
                    
                    if not success then
                        pcall(RecreateSnapline)
                    end
                else
                    Snapline.Visible = false
                end
            else
                Snapline.Visible = false
            end
        else
            Snapline.Visible = false
        end
        
        FOVCircle.Visible = ESP.FOV.ShowCircle and ESP.FOV.Enabled
        FOVCircle.Size = UDim2.new(0, ESP.FOV.Radius * 2, 0, ESP.FOV.Radius * 2)
        FOVCircle.Position = UDim2.new(0.5, -ESP.FOV.Radius, 0.5, -ESP.FOV.Radius)
        FOVCircleStroke.Color = ESP.FOV.Color
        FOVCircleStroke.Transparency = ESP.FOV.Transparency
        FOVCircleStroke.Thickness = ESP.FOV.Thickness
        
        if ESP.PlayerInfo.Enabled then
            local playerCount = 0
            local infoText = "<b>Players in FOV:</b>\n\n"
            
            for plr, data in pairs(playersInFOV) do
                if data then
                    playerCount = playerCount + 1
                    local healthPercentage = math.floor((data.health / data.maxHealth) * 100)
                    local friendStatus = ESP.Options.Friendcheck and lplayer:IsFriendsWith(plr.UserId) and "Friend" or "Enemy"
                    
                    infoText = infoText .. string.format(
                        '<font color="rgb(%d, %d, %d)"><b>%s</b></font> - <font color="rgb(200, 200, 200)">%s</font>\n' ..
                        '<font color="rgb(150, 150, 255)">Distance:</font> <font color="rgb(255, 255, 255)"><b>%d</b> meters</font>\n' ..
                        '<font color="rgb(150, 255, 150)">Health:</font> <font color="rgb(255, 255, 255)"><b>%d%%</b> (%d/%d)</font>\n\n',
                        ESP.Options.Friendcheck and lplayer:IsFriendsWith(plr.UserId) and ESP.Options.FriendcheckRGB.R * 255 or 255,
                        ESP.Options.Friendcheck and lplayer:IsFriendsWith(plr.UserId) and ESP.Options.FriendcheckRGB.G * 255 or 100,
                        ESP.Options.Friendcheck and lplayer:IsFriendsWith(plr.UserId) and ESP.Options.FriendcheckRGB.B * 255 or 100,
                        data.name,
                        friendStatus,
                        math.floor(data.distance),
                        healthPercentage,
                        data.health,
                        data.maxHealth
                    )
                end
            end
            
            if playerCount > 0 then
                PlayerInfoPanel.Visible = true
                PlayerInfoText.Text = infoText
                PlayerInfoText.TextSize = 13
                PlayerInfoText.TextStrokeTransparency = 0.3
                PlayerInfoPanel.Size = UDim2.new(0, 300, 0, math.max(150, playerCount * 80 + 50))
            else
                PlayerInfoPanel.Visible = false
            end
        else
            PlayerInfoPanel.Visible = false
        end
    end)
    
    ESP.Connections.MasterRender = masterRenderConnection
    
    do
        for _, v in pairs(game:GetService("Players"):GetPlayers()) do
            if v.Name ~= lplayer.Name then
                coroutine.wrap(CreatePlayerESP)(v)
            end      
        end
    
        game:GetService("Players").PlayerAdded:Connect(function(v)
            coroutine.wrap(CreatePlayerESP)(v)
        end);
        
        game:GetService("Players").PlayerRemoving:Connect(function(v)
            if PlayerESPObjects[v] then
                for _, obj in pairs(PlayerESPObjects[v]) do
                    if obj and obj.Destroy then
                        obj:Destroy()
                    end
                end
                PlayerESPObjects[v] = nil
            end
            playersInFOV[v] = nil
        end);
    end;
end;

return ESP
