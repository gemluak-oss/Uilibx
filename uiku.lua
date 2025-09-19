local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Framework = {}

-- 🎬 Intro Custom
local function ShowIntro()
    local IntroGui = Instance.new("ScreenGui")
    IntroGui.Name = "IntroGui"
    IntroGui.Parent = game:GetService("CoreGui")

    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 300, 0, 100)
    Frame.Position = UDim2.new(0.5, -150, 0.5, -50)
    Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Frame.Parent = IntroGui

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 1, 0)
    Label.Text = "RUINZ-UI"
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 20
    Label.TextColor3 = Color3.fromRGB(255,255,255)
    Label.BackgroundTransparency = 1
    Label.Parent = Frame

    Frame.BackgroundTransparency = 1
    local tweenIn = TweenService:Create(Frame, TweenInfo.new(0.8), {BackgroundTransparency = 0})
    tweenIn:Play()

    task.wait(2)

    local tweenOut = TweenService:Create(Frame, TweenInfo.new(0.8), {BackgroundTransparency = 1})
    tweenOut:Play()
    tweenOut.Completed:Wait()
    IntroGui:Destroy()
end

-- 🏠 Create Window
function Framework:CreateWindow(Settings)
    ShowIntro()

    local Window = {}
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = Settings.Name or "MyFramework"
    ScreenGui.Parent = game:GetService("CoreGui")

    local Main = Instance.new("Frame")
    Main.Size = UDim2.new(0, 500, 0, 350)
    Main.Position = UDim2.new(0.5, -250, 0.5, -175)
    Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Main.Parent = ScreenGui

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.Text = Settings.Title or "My Hub"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 18
    Title.TextColor3 = Color3.fromRGB(255,255,255)
    Title.BackgroundTransparency = 1
    Title.Parent = Main

    Window.Main = Main

    -- ⚡ Draggable system
    do
        local dragging, dragInput, dragStart, startPos
        local function update(input)
            local delta = input.Position - dragStart
            Main.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end

        Main.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                dragStart = input.Position
                startPos = Main.Position

                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)

        Main.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                dragInput = input
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                update(input)
            end
        end)
    end

    -- 📑 Tab system
    local TabButtons = Instance.new("Frame")
    TabButtons.Size = UDim2.new(1, 0, 0, 30)
    TabButtons.Position = UDim2.new(0, 0, 0, 30) -- geser ke bawah 30px
    TabButtons.BackgroundTransparency = 1
    TabButtons.Parent = Main
    local Layout = Instance.new("UIListLayout")
    Layout.FillDirection = Enum.FillDirection.Horizontal
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Parent = TabButtons


    function Window:CreateTab(TabName)
        local Tab = {}

        -- tombol tab
        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(0, 100, 1, 0)
        TabButton.Text = TabName
        TabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        TabButton.TextColor3 = Color3.fromRGB(255,255,255)
        TabButton.Parent = TabButtons

        -- konten tab
        local TabContent = Instance.new("Frame")
        TabContent.Size = UDim2.new(1, 0, 1, -30)
        TabContent.Position = UDim2.new(0, 0, 0, 30)
        TabContent.BackgroundTransparency = 1
        TabContent.Visible = false
        TabContent.Parent = Main

        -- switch tab
        TabButton.MouseButton1Click:Connect(function()
            for _, child in pairs(Main:GetChildren()) do
                if child:IsA("Frame") and child ~= TabButtons then
                    child.Visible = false
                end
            end
            TabContent.Visible = true
        end)

        -- API: CreateButton
        function Tab:CreateButton(Text, Callback)
            local Button = Instance.new("TextButton")
            Button.Size = UDim2.new(0, 200, 0, 40)
            Button.Position = UDim2.new(0, 10, 0, 10 + (#TabContent:GetChildren() * 50))
            Button.Text = Text
            Button.BackgroundColor3 = Color3.fromRGB(45,45,45)
            Button.TextColor3 = Color3.fromRGB(255,255,255)
            Button.Parent = TabContent

            Button.MouseButton1Click:Connect(function()
                if Callback then Callback() end
            end)

            Button.MouseEnter:Connect(function()
                TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60,60,60)}):Play()
            end)
            Button.MouseLeave:Connect(function()
                TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45,45,45)}):Play()
            end)
        end

        return Tab
    end

    return Window
end

return Framework
