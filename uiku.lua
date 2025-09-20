local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local screenSize = workspace.CurrentCamera.ViewportSize
local Framework = {}
local Tabs = {}
local tabCount = 0

-- 🎬 Intro Custom (Center + Animasi Fix + Outro Bertahap)
-- 🎬 Intro Custom (Typewriter + Glow + Outro Bertahap)
local function ShowIntro()
    local IntroGui = Instance.new("ScreenGui")
    IntroGui.Name = "IntroGui"
    IntroGui.ResetOnSpawn = false
    IntroGui.IgnoreGuiInset = true
    IntroGui.Parent = game:GetService("CoreGui")

    local Frame = Instance.new("Frame")
    Frame.AnchorPoint = Vector2.new(0.5, 0.5)
    Frame.Position = UDim2.new(0.5, 0, 0.5, 0) -- Selalu tengah
    Frame.Size = UDim2.new(0, 0, 0, 0) -- mulai kecil
    Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Frame.BackgroundTransparency = 1
    Frame.Parent = IntroGui

    local UICorner = Instance.new("UICorner", Frame)
    UICorner.CornerRadius = UDim.new(0, 12)

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 1, 0)
    Label.Text = "" -- kosong dulu (typewriter)
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 24
    Label.TextColor3 = Color3.fromRGB(255,255,255)
    Label.BackgroundTransparency = 1
    Label.TextTransparency = 0
    Label.Parent = Frame

    -- 🌟 Glow effect
    local UIStroke = Instance.new("UIStroke", Label)
    UIStroke.Thickness = 1.5
    UIStroke.Color = Color3.fromRGB(0, 170, 255)
    UIStroke.Transparency = 0.5

    -- 🎞️ Tween masuk (kotak expand)
    TweenService:Create(Frame, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 300, 0, 100),
        BackgroundTransparency = 0
    }):Play()

    -- 🎹 Typewriter effect
    local fullText = "RUINZ-UI"
    task.delay(0.4, function()
        for i = 1, #fullText do
            Label.Text = string.sub(fullText, 1, i)
            task.wait(0.08) -- kecepatan ketik
        end
    end)

    -- 🎞️ Outro (teks dulu → kotak)
    task.wait(2.5) -- jeda tampil

    -- Fade out teks + glow bersamaan
    local fadeText = TweenService:Create(Label, TweenInfo.new(0.6), {TextTransparency = 1})
    local fadeGlow = TweenService:Create(UIStroke, TweenInfo.new(0.6), {Transparency = 1})
    fadeText:Play()
    fadeGlow:Play()
    fadeText.Completed:Wait()

    -- Baru shrink kotaknya
    local tweenOut = TweenService:Create(Frame, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1
    })
    tweenOut:Play()
    tweenOut.Completed:Wait()

    IntroGui:Destroy()
    
end



-- 🏠 Create Window
function Framework:CreateWindow(Settings)
    ShowIntro()
    local Window = {}
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = Settings.Name or "RuinzUI"
    ScreenGui.Parent = game:GetService("CoreGui")

    -- Main window
    local Main = Instance.new("Frame")

    if UserInputService.TouchEnabled then
        -- 📱 Mobile: window lebih kecil & proporsional
        Main.Size = UDim2.new(0, math.clamp(screenSize.X * 0.7, 280, 380), 0, math.clamp(screenSize.Y * 0.5, 220, 300))
    else
        -- 💻 PC: window lebih besar
        Main.Size = UDim2.new(0, 450, 0, 350)
    end

    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Main.BorderSizePixel = 0
    Main.Parent = ScreenGui

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

    -- 🔘 Tombol Hide di pojok kanan atas
    local HideButton = Instance.new("TextButton")
    HideButton.Size = UDim2.new(0, 30, 0, 30)
    HideButton.Position = UDim2.new(1, -35, 0, 2)
    HideButton.Text = "–"
    HideButton.Font = Enum.Font.GothamBold
    HideButton.TextSize = 18
    HideButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    HideButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- default abu gelap
    HideButton.AutoButtonColor = false
    HideButton.Parent = Header

    local BtnCorner = Instance.new("UICorner", HideButton)
    BtnCorner.CornerRadius = UDim.new(0, 6)

    -- 🎨 Efek hover (abu abu terang saat kursor masuk)
    HideButton.MouseEnter:Connect(function()
        HideButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    end)

    HideButton.MouseLeave:Connect(function()
        HideButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    end)

    -- Saat ditekan
    HideButton.MouseButton1Click:Connect(function()
        Main.Visible = false
        UnhideBox.Visible = true
    end)


    -- 🔲 Tombol Unhide (atas tengah, logo aja)
    local UnhideBox = Instance.new("ImageButton")
    UnhideBox.Size = UDim2.new(0, 50, 0, 50) -- sesuaikan ukuran logo
    UnhideBox.AnchorPoint = Vector2.new(0.5, 0)
    UnhideBox.Position = UDim2.new(0.5, 0, 0, 10) -- atas tengah
    UnhideBox.BackgroundTransparency = 1 -- transparan
    UnhideBox.Image = "rbxassetid://71678601582898" -- ganti dengan asset ID logomu
    UnhideBox.Visible = false
    UnhideBox.Parent = ScreenGui

    -- 🔘 bikin sudut bulat
    local BoxCorner = Instance.new("UICorner")
    BoxCorner.CornerRadius = UDim.new(0, 12) -- atur bulatnya (semakin besar semakin bulat)
    BoxCorner.Parent = UnhideBox

     -- ⚡ Biar UnhideBox bisa digeser di PC & Mobile
    do
        local dragging, dragInput, dragStart, startPos
        local function update(input)
            local delta = input.Position - dragStart
            UnhideBox.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end

        UnhideBox.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 
            or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = UnhideBox.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)

        UnhideBox.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement 
            or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                update(input)
            end
        end)
    end


    -- 🔄 Animasi RGB Outline
    task.spawn(function()
        local t = 0
        while true do
            t += 1
            local r = math.sin(t/50) * 127 + 128
            local g = math.sin(t/50 + 2) * 127 + 128
            local b = math.sin(t/50 + 4) * 127 + 128
            Outline.Color = Color3.fromRGB(r, g, b)
            task.wait(0.03)
        end
    end)

    -- 🔄 Logic hide/unhide
    HideButton.MouseButton1Click:Connect(function()
        Main.Visible = false
        UnhideBox.Visible = true
    end)

    UnhideBox.MouseButton1Click:Connect(function()
        Main.Visible = true
        UnhideBox.Visible = false
    end)

    -- ⚡ Draggable window (PC & Mobile)
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
            if input.UserInputType == Enum.UserInputType.MouseButton1 
            or input.UserInputType == Enum.UserInputType.Touch then -- ✅ dukung mobile
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
            if input.UserInputType == Enum.UserInputType.MouseMovement 
            or input.UserInputType == Enum.UserInputType.Touch then -- ✅ dukung mobile
                dragInput = input
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                update(input)
            end
        end)
    end



    -- 📑 Tab bar
    local TabButtons = Instance.new("ScrollingFrame")
    TabButtons.Size = UDim2.new(1, -20, 0, 30) -- lebih tipis
    TabButtons.Position = UDim2.new(0, 10, 0, 45)
    TabButtons.BackgroundTransparency = 1
    TabButtons.ScrollBarThickness = 0
    TabButtons.ScrollingDirection = Enum.ScrollingDirection.X
    TabButtons.CanvasSize = UDim2.new(0,0,0,0)
    TabButtons.Parent = Main

    local TabLayout = Instance.new("UIListLayout", TabButtons)
    TabLayout.FillDirection = Enum.FillDirection.Horizontal
    TabLayout.Padding = UDim.new(0, 6) -- jarak antar tab lebih kecil
    TabLayout.SortOrder = Enum.SortOrder.LayoutOrder

    -- Separator
    local Separator = Instance.new("Frame")
    Separator.Size = UDim2.new(1, -20, 0, 1)
    Separator.Position = UDim2.new(0, 10, 0, 80) -- pas di bawah tab
    Separator.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    Separator.BorderSizePixel = 0
    Separator.Parent = Main

    -- auto resize canvas
    TabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabButtons.CanvasSize = UDim2.new(0, TabLayout.AbsoluteContentSize.X, 0, 0)
    end)



    -- Container untuk tab contents
    local Tabs = {}

    function Window:CreateTab(TabName)
        local Tab = {}

        -- Tombol tab
        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(0, 90, 0, 28) -- seragam: lebar 90px, tinggi 28px
        TabButton.Text = TabName
        TabButton.Font = Enum.Font.GothamMedium
        TabButton.TextSize = 13
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        TabButton.AutoButtonColor = false
        TabButton.Parent = TabButtons

        local BtnCorner = Instance.new("UICorner", TabButton)
        BtnCorner.CornerRadius = UDim.new(0, 6)
                
        -- Konten tab
        local TabContent = Instance.new("ScrollingFrame")
        TabContent.Size = UDim2.new(1, -20, 1, -120)
        TabContent.Position = UDim2.new(0, 10, 0, 95)
        TabContent.BackgroundTransparency = 1
        TabContent.ScrollBarThickness = 6
        TabContent.ClipsDescendants = true
        TabContent.Visible = false
        TabContent.Parent = Main

        -- ✅ Tambahin padding biar konten ga kepotong
        local ContentPadding = Instance.new("UIPadding")
        ContentPadding.PaddingBottom = UDim.new(0, 20) -- jarak ekstra bawah
        ContentPadding.PaddingTop = UDim.new(0, 5)
        ContentPadding.PaddingLeft = UDim.new(0, 5)
        ContentPadding.PaddingRight = UDim.new(0, 5)
        ContentPadding.Parent = TabContent

        -- Layout isi tab
        local ContentLayout = Instance.new("UIListLayout", TabContent)
        ContentLayout.Padding = UDim.new(0, 8)
        ContentLayout.FillDirection = Enum.FillDirection.Vertical
        ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder

        -- auto update tinggi canvas
        ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabContent.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y)
        end)


        -- biar bisa scroll pakai mouse wheel langsung di area konten
        TabContent.ScrollingDirection = Enum.ScrollingDirection.Y -- hanya vertical

        -- biar bisa drag scroll di mobile
        TabContent.ScrollingDirection = Enum.ScrollingDirection.Y -- scroll vertikal

        -- layout isi tab
        local ContentLayout = Instance.new("UIListLayout", TabContent)
        ContentLayout.Padding = UDim.new(0, 8)
        ContentLayout.FillDirection = Enum.FillDirection.Vertical
        ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder

        -- auto update tinggi canvas
        ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabContent.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y)
        end)


        -- simpan ke tabel
        Tabs[TabName] = TabContent

        -- kalau ini tab pertama, langsung aktif
        tabCount = tabCount + 1
        if tabCount == 1 then
            TabContent.Visible = true
        end

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

        -- API: Slider
        function Tab:CreateSlider(Text, Min, Max, Default, Callback)
            local SliderFrame = Instance.new("Frame")
            SliderFrame.Size = UDim2.new(1, 0, 0, 50)
            SliderFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            SliderFrame.Parent = TabContent

            local Corner = Instance.new("UICorner", SliderFrame)
            Corner.CornerRadius = UDim.new(0, 6)

            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1, 0, 0, 20)
            Label.Position = UDim2.new(0, 10, 0, 0)
            Label.BackgroundTransparency = 1
            Label.Text = Text .. " ("..tostring(Default)..")"
            Label.Font = Enum.Font.Gotham
            Label.TextSize = 14
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Parent = SliderFrame

            local Bar = Instance.new("Frame")
            Bar.Size = UDim2.new(1, -20, 0, 6)
            Bar.Position = UDim2.new(0, 10, 0, 30)
            Bar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Bar.Parent = SliderFrame

            local BarCorner = Instance.new("UICorner", Bar)
            BarCorner.CornerRadius = UDim.new(0, 3)

            local Fill = Instance.new("Frame")
            Fill.Size = UDim2.new((Default - Min) / (Max - Min), 0, 1, 0)
            Fill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
            Fill.Parent = Bar

            local FillCorner = Instance.new("UICorner", Fill)
            FillCorner.CornerRadius = UDim.new(0, 3)

            local dragging = false
            local value = Default

            local function update(input)
                local pos = math.clamp((input.Position.X - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X, 0, 1)
                value = math.floor(Min + (Max - Min) * pos)
                Fill.Size = UDim2.new(pos, 0, 1, 0)
                Label.Text = Text .. " ("..tostring(value)..")"
                if Callback then Callback(value) end
            end

            Bar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                    update(input)
                end
            end)

            Bar.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)

            UserInputService.InputChanged:Connect(function(input)
                if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    update(input)
                end
            end)
        end

        return Tab
    end

    return Window
end

return Framework
