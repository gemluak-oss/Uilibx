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
ShowIntro()
function Framework:CreateWindow(Settings)
    local Window = {}
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = Settings.Name or "RuinzUI"
    ScreenGui.Parent = game:GetService("CoreGui")

    -- Main window
    local Main = Instance.new("Frame")
    Main.Size = UDim2.new(0, 550, 0, 400)
    Main.Position = UDim2.new(0.5, -275, 0.5, -200)
    Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Main.BorderSizePixel = 0
    Main.Parent = ScreenGui

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 12)
    MainCorner.Parent = Main

    -- Header bar
    local Header = Instance.new("Frame")
    Header.Size = UDim2.new(1, 0, 0, 35)
    Header.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Header.BorderSizePixel = 0
    Header.Parent = Main

    local Title = Instance.new("TextLabel")
    Title.Text = Settings.Title or "RUINZ"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 16
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(0, 200, 1, 0)
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = Header

    -- ⚡ Draggable window
    do
        local dragging, dragInput, dragStart, startPos
        local function update(input)
            local delta = input.Position - dragStart
            Main.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
        Header.InputBegan:Connect(function(input)
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
        Header.InputChanged:Connect(function(input)
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

    -- Tab bar
    local TabButtons = Instance.new("Frame")
    TabButtons.Size = UDim2.new(1, -20, 0, 35)
    TabButtons.Position = UDim2.new(0, 10, 0, 45)
    TabButtons.BackgroundTransparency = 1
    TabButtons.Parent = Main

    local TabLayout = Instance.new("UIListLayout", TabButtons)
    TabLayout.FillDirection = Enum.FillDirection.Horizontal
    TabLayout.Padding = UDim.new(0, 8)
    TabLayout.SortOrder = Enum.SortOrder.LayoutOrder

    -- Container untuk tab contents
    local Tabs = {}

    function Window:CreateTab(TabName)
        local Tab = {}

        -- Tombol tab
        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(0, 120, 1, 0)
        TabButton.Text = TabName
        TabButton.Font = Enum.Font.Gotham
        TabButton.TextSize = 14
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        TabButton.AutoButtonColor = false
        TabButton.Parent = TabButtons

        local BtnCorner = Instance.new("UICorner", TabButton)
        BtnCorner.CornerRadius = UDim.new(0, 8)

        -- Konten tab
        local TabContent = Instance.new("Frame")
        TabContent.Size = UDim2.new(1, -20, 1, -90)
        TabContent.Position = UDim2.new(0, 10, 0, 85)
        TabContent.BackgroundTransparency = 1
        TabContent.Visible = false
        TabContent.Parent = Main

        local ContentLayout = Instance.new("UIListLayout", TabContent)
        ContentLayout.Padding = UDim.new(0, 8)
        ContentLayout.FillDirection = Enum.FillDirection.Vertical
        ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder

        Tabs[TabName] = TabContent

        -- Klik tab → tampilkan kontennya
        TabButton.MouseButton1Click:Connect(function()
            for _, frame in pairs(Tabs) do
                frame.Visible = false
            end
            TabContent.Visible = true
        end)

        -- API: Button
        function Tab:CreateButton(Text, Callback)
            local Button = Instance.new("TextButton")
            Button.Size = UDim2.new(1, 0, 0, 40)
            Button.Text = Text
            Button.Font = Enum.Font.Gotham
            Button.TextSize = 14
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Button.AutoButtonColor = false
            Button.Parent = TabContent

            local BtnCorner = Instance.new("UICorner", Button)
            BtnCorner.CornerRadius = UDim.new(0, 6)

            Button.MouseButton1Click:Connect(function()
                if Callback then Callback() end
            end)
        end

        -- API: Toggle
        function Tab:CreateToggle(Text, Default, Callback)
            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Size = UDim2.new(1, 0, 0, 40)
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            ToggleFrame.Parent = TabContent

            local Corner = Instance.new("UICorner", ToggleFrame)
            Corner.CornerRadius = UDim.new(0, 6)

            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1, -50, 1, 0)
            Label.Position = UDim2.new(0, 10, 0, 0)
            Label.BackgroundTransparency = 1
            Label.Text = Text
            Label.Font = Enum.Font.Gotham
            Label.TextSize = 14
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Parent = ToggleFrame

            local ToggleBtn = Instance.new("TextButton")
            ToggleBtn.Size = UDim2.new(0, 40, 0, 20)
            ToggleBtn.Position = UDim2.new(1, -45, 0.5, -10)
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            ToggleBtn.Text = ""
            ToggleBtn.Parent = ToggleFrame

            local BtnCorner = Instance.new("UICorner", ToggleBtn)
            BtnCorner.CornerRadius = UDim.new(1, 0)

            local state = Default or false
            local function updateToggle()
                ToggleBtn.BackgroundColor3 = state and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(60, 60, 60)
            end
            updateToggle()

            ToggleBtn.MouseButton1Click:Connect(function()
                state = not state
                updateToggle()
                if Callback then Callback(state) end
            end)
        end

        return Tab
    end

    return Window
end

return Framework
