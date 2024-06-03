local Balls = workspace:WaitForChild("Balls")
local plr = game.Players.LocalPlayer
local userInputService = game:GetService("UserInputService")
local vim = game:GetService("VirtualInputManager")

-- Cache frequently accessed values
local character = plr.Character
local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
local function GetBallVelocity(Ball)
    return Ball.Velocity
end

loadstring(game:HttpGet(("https://raw.githubusercontent.com/REDzHUB/LibraryV2/main/redzLib")))()

MakeWindow(
    {
        Hub = {
            Title = "DDZC V2",
            Animation = "by : DenDenZ"
        },
        Key = {
            KeySystem = true,
            Title = "DDZC V2 - Key System",
            Description = "",
            KeyLink = "",
            Keys = {"7xJ9p2WnR4cF3qK8oD5vA1l6i2e9tP7"},
            Notifi = {
                Notifications = true,
                CorrectKey = "Thanks for using DDZC V2!",
                Incorrectkey = "Key is Incorrect, make sure you entered the right key!",
                CopyKeyLink = "Link has been inserted to your clipboard, paste it in a browser to proceed"
            }
        }
    }
)

-- CT START
local CT = MakeTab({Name = "Home"})

local crazy = AddSection(CT, {"Social Media"})

AddButton(
    CT,
    {
        Name = "Discord",
        Callback = function()
            setclipboard("https://discord.com/invite/kAtPE7UrFg")
        end
    }
)

AddButton(
    CT,
    {
        Name = "YouTube",
        Callback = function()
            setclipboard("https://youtube.com/@DenDenZZZ")
        end
    }
)
--// CT END

-- MG START
local MG = MakeTab({Name = "Main"})

local Combat = AddSection(MG, {"Combat"})

-- Function definitions and other parts of your script remain the same.

local function FindBall()
    local RealBall
    for i, v in pairs(Balls:GetChildren()) do
        if v:GetAttribute("realBall") == true then
            RealBall = v
        end
    end
    return RealBall
end

local function IsTarget()
    return character and character:FindFirstChild("Highlight")
end

-- Calculate prediction time only when needed
local function calculatePredictionTime(ball, player)
    if humanoidRootPart then
        local rootPart = humanoidRootPart
        local relativePosition = ball.Position - rootPart.Position
        local velocity = ball.Velocity + rootPart.Velocity
        local a = (ball.Size.magnitude / 2)
        local b = relativePosition.magnitude
        local c = math.sqrt(a * a + b * b)
        return (c - a) / velocity.magnitude
    end
    return math.huge
end

local function AP()
    while getgenv().AP do
        local Ball = FindBall()
        if Ball then
            for _, Ball in ipairs(Balls:GetChildren()) do
                local BallVelocity = GetBallVelocity(Ball)
                if BallVelocity.Magnitude >= 4.5 then
                    local predictionTime = calculatePredictionTime(Ball, plr)
                    local ballSpeedThreshold = math.max(0.70, 0.70 - BallVelocity.Magnitude * 0.01)
                    if predictionTime <= ballSpeedThreshold then
                        -- Assuming 'vim' is a variable representing input
                        vim:SendKeyEvent(true, Enum.KeyCode.F, false, nil)
                        vim:SendKeyEvent(false, Enum.KeyCode.F, false, nil)
                        wait(0.01)
                    end
                end
            end
        end
        wait(0.01)
    end
end

local APT =
    AddToggle(
    MG,
    {
        Name = "Auto Parry",
        Default = false,
        Callback = function(Value)
            getgenv().AP = Value
            if getgenv().AP then
                AP()
            else
                print("Auto Parry is OFF")
            end
        end
    }
)

function SPAM()
    local function CanSpam()
        return (GetSpamDistance() <= GetBallSpeed() * 0.1)
    end

    local function GetSpamDistance()
        return (plr.Character:FindFirstChild("HumanoidRootPart").Position -
            getclosestplr():FindFirstChild("HumanoidRootPart").Position).Magnitude
    end

    local function getclosestplr()
        local bot_position = workspace.CurrentCamera.Focus.Position

        local distance = math.huge
        local closest_player_character = nil

        for i, player in pairs(game.Players:GetPlayers()) do
            if player.Character:FindFirstChild("Humanoid") then
                local player_position = player.Character.HumanoidRootPart.Position
                local distance_from_bot = (bot_position - player_position).Magnitude

                if distance_from_bot < distance then
                    distance = distance_from_bot
                    closest_player_character = player.Character
                end
            end
        end

        return closest_player_character
    end

    while getgenv().spam do
        local ball = FindBall()
        if not ball then
            return
        else
            GetSpamDistance()
            wait(0.01)
            getclosestplr()
            wait(0.01)
            if CanSpam() then
                vim:SendKeyEvent(true, Enum.KeyCode.F, false, nil)
                vim:SendKeyEvent(false, Enum.KeyCode.F, false, nil)
                wait(0.01)
            end
        end
    end
end

local AST =
    AddToggle(
    MG,
    {
        Name = "Auto Spam",
        Default = false,
        Callback = function(Value)
            getgenv().spam = Value
            if getgenv().spam then
                SPAM()
            end
        end
    }
)

local MSB =
    AddButton(
    MG,
    {
        Name = "Manual Spam",
        Callback = function()
            local vim = game:GetService("VirtualInputManager")
            local gui, frame, button =
                Instance.new("ScreenGui", game.CoreGui),
                Instance.new("Frame"),
                Instance.new("TextButton")
            gui.ResetOnSpawn = false
            frame.Size,
                frame.Position,
                frame.BackgroundColor3,
                frame.BorderSizePixel,
                frame.Active,
                frame.Draggable,
                frame.Parent =
                UDim2.new(0, 150, 0, 75),
                UDim2.new(0, 10, 0, 10),
                Color3.new(0, 0, 0),
                0,
                true,
                true,
                gui
            button.Text,
                button.Size,
                button.Position,
                button.BackgroundColor3,
                button.BorderColor3,
                button.BorderSizePixel,
                button.Font,
                button.TextColor3,
                button.TextSize,
                button.Parent =
                "Manual spam",
                UDim2.new(1, -20, 1, -20),
                UDim2.new(0, 10, 0, 10),
                Color3.new(0, 0, 0),
                Color3.new(),
                2,
                Enum.Font.SourceSans,
                Color3.new(1, 1, 1),
                16,
                frame

            local activated = false

            local function toggle()
                activated, button.Text = not activated, activated and "Off" or "On"

                while activated do
                    vim:SendKeyEvent(true, Enum.KeyCode.F, false, nil) -- Send F key event
                    wait(0.001) -- Adjusted wait time here
                    button.BorderColor3 = Color3.new(math.random(), math.random(), math.random())
                end
            end

            local function showNotification()
                game.StarterGui:SetCore(
                    "SendNotification",
                    {Title = "Manual Spam", Text = "Made By DenDenZ", Duration = 5}
                )
            end

            button.MouseButton1Click:Connect(
                function()
                    toggle()
                    showNotification()
                end
            )
        end
    }
)

local CST = AddSection(MG, {"Crates"})

local ECT =
    AddToggle(
    MG,
    {
        Name = "Explosion Crate",
        Default = false,
        Callback = function(Value)
            getgenv().ECTL = Value
        end
    }
)

local SCT =
    AddToggle(
    MG,
    {
        Name = "Sword Crate",
        Default = false,
        Callback = function(Value)
            getgenv().SCTL = Value
        end
    }
)

local ECB =
    AddButton(
    MG,
    {
        Name = "Explosion Crate",
        Callback = function()
            EC()
        end
    }
)

local SCB =
    AddButton(
    MG,
    {
        Name = "Sword Crate",
        Callback = function()
            SC()
        end
    }
)

function SC()
    game:GetService("ReplicatedStorage").Remote.RemoteFunction:InvokeServer(
        "PromptPurchaseCrate",
        workspace.Spawn.Crates.NormalSwordCrate
    )
end

function EC()
    game:GetService("ReplicatedStorage").Remote.RemoteFunction:InvokeServer(
        "PromptPurchaseCrate",
        workspace.Spawn.Crates.NormalExplosionCrate
    )
end

spawn(
    function()
        while true do
            wait(3)
            if getgenv().SCTL then
                game:GetService("ReplicatedStorage").Remote.RemoteFunction:InvokeServer(
                    "PromptPurchaseCrate",
                    workspace.Spawn.Crates.NormalSwordCrate
                )
            end
        end
    end
)

spawn(
    function()
        while true do
            wait(3)
            if getgenv().ECTL then
                game:GetService("ReplicatedStorage").Remote.RemoteFunction:InvokeServer(
                    "PromptPurchaseCrate",
                    workspace.Spawn.Crates.NormalExplosionCrate
                )
            end
        end
    end
)

--// MG END

--// BREAK.2

--// MMF START

local MMF = MakeTab({Name = "Misc"})

local MMFS = AddSection(MMF, {"Extra Feautures"})

local FBT =
    AddToggle(
    MMF,
    {
        Name = "Follow Ball",
        Default = false,
        Callback = function(Value)
            getgenv().FB = Value
        end
    }
)

spawn(
    function()
        local TweenService = game:GetService("TweenService")
        local Players = game:GetService("Players")
        local Ball = workspace:WaitForChild("Balls")
        local currentTween = nil

        Players.PlayerAdded:Connect(
            function(plr)
                plr.CharacterAdded:Connect(
                    function(char)
                        local humanoid = char:WaitForChild("Humanoid")

                        humanoid.Died:Connect(
                            function()
                                if currentTween then
                                    currentTween:Pause()
                                    currentTween = nil
                                end
                            end
                        )
                    end
                )
            end
        )

        while true do
            wait(0.001)
            if getgenv().FB then
                local plr = Players.LocalPlayer
                local ball = Ball:FindFirstChildOfClass("Part")
                local char = plr.Character
                if ball and char then
                    local tweenInfo =
                        TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, false, 0)
                    local distance = (char.PrimaryPart.Position - ball.Position).magnitude
                    if distance <= 1000 then
                        if currentTween then
                            currentTween:Pause()
                        end
                        currentTween = TweenService:Create(char.PrimaryPart, tweenInfo, {CFrame = ball.CFrame})
                        currentTween:Play()
                    end
                end
            else
                if currentTween then
                    currentTween:Pause()
                    currentTween = nil
                end
            end
        end
    end
)

local IJT =
    AddToggle(
    MMF,
    {
        Name = "Infinite Jump",
        Default = false,
        Callback = function(Value)
            getgenv().IJ = Value
        end
    }
)

spawn(
    function()
        while true do
            wait(0.01)
            if getgenv().IJ then
                game:GetService "Players".LocalPlayer.Character:FindFirstChildOfClass "Humanoid":ChangeState("Jumping")
            end
        end
    end
)
