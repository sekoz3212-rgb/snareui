--// Destroy other instances
for _,v in pairs(game.CoreGui:GetChildren()) do
    if v.Name == "dark_UI" then
        v:Destroy()
    end
end

local dark_UI = Instance.new("ScreenGui")
dark_UI.Name = "dark_UI"
dark_UI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
dark_UI.Parent = game.CoreGui

local Library = {}
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local HTTPService = game:GetService("HttpService")

-- Color palette
local colors = {
    background = Color3.fromRGB(26, 26, 26),      -- #1a1a1a
    container = Color3.fromRGB(36, 36, 36),       -- #242424
    element = Color3.fromRGB(45, 45, 45),         -- #2d2d2d
    elementHover = Color3.fromRGB(55, 55, 55),    -- #373737
    elementActive = Color3.fromRGB(60, 60, 60),   -- #3c3c3c
    text = Color3.fromRGB(220, 220, 220),         -- #dcdcdc
    textDim = Color3.fromRGB(160, 160, 160),      -- #a0a0a0
    accent = Color3.fromRGB(0, 160, 255),         -- #00a0ff
    accentDark = Color3.fromRGB(0, 120, 200),     -- #0078c8
    success = Color3.fromRGB(46, 204, 113),       -- #2ecc71
    successDark = Color3.fromRGB(39, 174, 96),    -- #27ae60
    shadow = Color3.fromRGB(10, 10, 10)           -- #0a0a0a
}

function Library:Create(table)
    local windowName = table.Name

    local main = Instance.new("Frame")
    main.Name = "main"
    main.BackgroundColor3 = colors.background
    main.Position = UDim2.fromScale(0.244, 0.292)
    main.Size = UDim2.fromOffset(488, 299)
    main.AnchorPoint = Vector2.new(0.5,0.5)
    main.Parent = dark_UI

    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 12)
    mainCorner.Parent = main

    local title = Instance.new("TextLabel")
    title.Name = "title"
    title.Font = Enum.Font.GothamSemibold
    title.Text = windowName
    title.TextColor3 = colors.text
    title.TextSize = 22
    title.BackgroundTransparency = 1
    title.Position = UDim2.fromScale(0.5, 0.07)
    title.AnchorPoint = Vector2.new(0.5, 0)
    title.Size = UDim2.fromOffset(0, 30)
    title.AutomaticSize = Enum.AutomaticSize.X
    title.Parent = main

    -- Subtle accent line under title
    local accentLine = Instance.new("Frame")
    accentLine.Name = "accentLine"
    accentLine.BackgroundColor3 = colors.accent
    accentLine.Position = UDim2.fromScale(0.5, 0.15)
    accentLine.AnchorPoint = Vector2.new(0.5, 0)
    accentLine.Size = UDim2.fromOffset(60, 2)
    accentLine.Parent = main

    local tabContainer = Instance.new("Frame")
    tabContainer.Name = "tabContainer"
    tabContainer.BackgroundColor3 = colors.container
    tabContainer.Position = UDim2.fromScale(0.0342, 0.188)
    tabContainer.Size = UDim2.fromOffset(454, 36)
    tabContainer.Parent = main

    local tabContainerCorner = Instance.new("UICorner")
    tabContainerCorner.CornerRadius = UDim.new(0, 8)
    tabContainerCorner.Parent = tabContainer

    local uIListLayout = Instance.new("UIListLayout")
    uIListLayout.Name = "uIListLayout"
    uIListLayout.Padding = UDim.new(0, 8)
    uIListLayout.FillDirection = Enum.FillDirection.Horizontal
    uIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    uIListLayout.Parent = tabContainer

    local uIPadding = Instance.new("UIPadding")
    uIPadding.Name = "uIPadding"
    uIPadding.PaddingLeft = UDim.new(0, 10)
    uIPadding.PaddingTop = UDim.new(0, 6)
    uIPadding.Parent = tabContainer

    local shadow = Instance.new("ImageLabel")
    shadow.Name = "shadow"
    shadow.Image = "rbxassetid://13111322187" -- softer shadow
    shadow.ImageColor3 = colors.shadow
    shadow.ImageTransparency = 0.4
    shadow.SliceCenter = Rect.new(20, 20, 280, 280)
    shadow.BackgroundTransparency = 1
    shadow.Size = UDim2.fromOffset(528, 340)
    shadow.ZIndex = -1
    shadow.AnchorPoint = Vector2.new(0.5,0.5)
    shadow.Position = main.Position
    shadow.Parent = dark_UI

    local tabHandler = {}

    function tabHandler:Exit()
        dark_UI:Destroy()
    end

    function tabHandler:Tab(name)
        local tabButton = Instance.new("TextButton")
        tabButton.Name = name
        tabButton.Font = Enum.Font.Gotham
        tabButton.Text = name
        tabButton.TextColor3 = colors.textDim
        tabButton.TextSize = 14
        tabButton.AutomaticSize = Enum.AutomaticSize.X
        tabButton.BackgroundTransparency = 1
        tabButton.Size = UDim2.fromOffset(10, 24)
        tabButton.Parent = tabContainer

        local container = Instance.new("Frame")
        container.Name = "container"
        container.BackgroundColor3 = colors.container
        container.Position = UDim2.fromScale(0.0342, 0.31)
        container.Size = UDim2.fromOffset(454, 183)
        container.Visible = false
        container.Parent = main

        local containerCorner = Instance.new("UICorner")
        containerCorner.CornerRadius = UDim.new(0, 8)
        containerCorner.Parent = container

        local holder = Instance.new("ScrollingFrame")
        holder.Name = "holder"
        holder.ScrollBarImageColor3 = colors.textDim
        holder.ScrollBarThickness = 3
        holder.ScrollingDirection = Enum.ScrollingDirection.Y
        holder.Active = true
        holder.BackgroundTransparency = 1
        holder.BorderSizePixel = 0
        holder.Position = UDim2.fromScale(0.005, 0.005)
        holder.Size = UDim2.fromScale(0.99, 0.99)
        holder.Parent = container

        local uIPadding1 = Instance.new("UIPadding")
        uIPadding1.Name = "uIPadding1"
        uIPadding1.PaddingLeft = UDim.new(0, 8)
        uIPadding1.PaddingTop = UDim.new(0, 8)
        uIPadding1.Parent = holder

        local uIListLayout1 = Instance.new("UIListLayout")
        uIListLayout1.Name = "uIListLayout1"
        uIListLayout1.Padding = UDim.new(0, 6)
        uIListLayout1.SortOrder = Enum.SortOrder.LayoutOrder
        uIListLayout1.Parent = holder

        -- Tab selection logic
        tabButton.MouseButton1Click:Connect(function()
            for _,v in pairs(main:GetChildren()) do
                if v.Name == "container" then
                    v.Visible = false
                end
            end
            for _,v in pairs(tabContainer:GetChildren()) do
                if v:IsA('TextButton') then
                    TweenService:Create(v, TweenInfo.new(0.2), {TextColor3 = colors.textDim}):Play()
                end
            end
            container.Visible = true
            TweenService:Create(tabButton, TweenInfo.new(0.2), {TextColor3 = colors.text}):Play()
        end)

        local ElementHandler = {}
        function ElementHandler:Label(text)
            local label = Instance.new("Frame")
            label.Name = "label"
            label.BackgroundColor3 = colors.element
            label.Size = UDim2.fromOffset(430, 34)
            label.Parent = holder

            local labelCorner = Instance.new("UICorner")
            labelCorner.CornerRadius = UDim.new(0, 6)
            labelCorner.Parent = label

            local textLabel = Instance.new("TextLabel")
            textLabel.Name = "textLabel"
            textLabel.Font = Enum.Font.Gotham
            textLabel.Text = text
            textLabel.TextColor3 = colors.text
            textLabel.TextSize = 14
            textLabel.TextXAlignment = Enum.TextXAlignment.Left
            textLabel.BackgroundTransparency = 1
            textLabel.Position = UDim2.fromScale(0.03, 0)
            textLabel.Size = UDim2.fromOffset(1, 34)
            textLabel.Parent = label
        end

        function ElementHandler:Button(text, callback)
            text = text or "Button"
            callback = callback or function() end

            local button = Instance.new("TextButton")
            button.Name = "button"
            button.BackgroundColor3 = colors.element
            button.Size = UDim2.fromOffset(430, 34)
            button.Text = ""
            button.AutoButtonColor = false
            button.Parent = holder

            local buttonCorner = Instance.new("UICorner")
            buttonCorner.CornerRadius = UDim.new(0, 6)
            buttonCorner.Parent = button

            local textLabel = Instance.new("TextLabel")
            textLabel.Name = "textLabel"
            textLabel.Font = Enum.Font.Gotham
            textLabel.Text = text
            textLabel.TextColor3 = colors.text
            textLabel.TextSize = 14
            textLabel.TextXAlignment = Enum.TextXAlignment.Left
            textLabel.BackgroundTransparency = 1
            textLabel.Position = UDim2.fromScale(0.03, 0)
            textLabel.Size = UDim2.fromOffset(1, 34)
            textLabel.Parent = button

            local arrow = Instance.new("ImageLabel")
            arrow.Name = "arrow"
            arrow.Image = "rbxassetid://3926305904" -- simple right arrow
            arrow.ImageColor3 = colors.textDim
            arrow.BackgroundTransparency = 1
            arrow.Position = UDim2.fromScale(0.95, 0.5)
            arrow.AnchorPoint = Vector2.new(0.5, 0.5)
            arrow.Size = UDim2.fromOffset(16, 16)
            arrow.Parent = button

            button.MouseEnter:Connect(function()
                TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = colors.elementHover}):Play()
                TweenService:Create(arrow, TweenInfo.new(0.2), {ImageColor3 = colors.text}):Play()
            end)

            button.MouseLeave:Connect(function()
                TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = colors.element}):Play()
                TweenService:Create(arrow, TweenInfo.new(0.2), {ImageColor3 = colors.textDim}):Play()
            end)

            button.MouseButton1Click:Connect(callback)
        end

        function ElementHandler:Slider(text, default, min, max, callback)
            text = text or "Slider"
            default = default or 0
            min = min or 0
            max = max or 100
            callback = callback or function() end

            local slider = Instance.new("TextButton")
            slider.Name = "slider"
            slider.BackgroundColor3 = colors.element
            slider.Size = UDim2.fromOffset(430, 34)
            slider.Text = ""
            slider.AutoButtonColor = false
            slider.Parent = holder

            local sliderCorner = Instance.new("UICorner")
            sliderCorner.CornerRadius = UDim.new(0, 6)
            sliderCorner.Parent = slider

            local textLabel = Instance.new("TextLabel")
            textLabel.Name = "textLabel"
            textLabel.Font = Enum.Font.Gotham
            textLabel.Text = text
            textLabel.TextColor3 = colors.text
            textLabel.TextSize = 14
            textLabel.TextXAlignment = Enum.TextXAlignment.Left
            textLabel.BackgroundTransparency = 1
            textLabel.Position = UDim2.fromScale(0.03, 0)
            textLabel.Size = UDim2.fromOffset(1, 34)
            textLabel.Parent = slider

            local valueLabel = Instance.new("TextLabel")
            valueLabel.Name = "valueLabel"
            valueLabel.Font = Enum.Font.Gotham
            valueLabel.Text = tostring(default)
            valueLabel.TextColor3 = colors.accent
            valueLabel.TextSize = 14
            valueLabel.BackgroundTransparency = 1
            valueLabel.Position = UDim2.fromScale(0.8, 0)
            valueLabel.Size = UDim2.fromOffset(40, 34)
            valueLabel.Parent = slider

            local sliderBg = Instance.new("Frame")
            sliderBg.Name = "sliderBg"
            sliderBg.BackgroundColor3 = colors.container
            sliderBg.Position = UDim2.fromScale(0.6, 0.5)
            sliderBg.AnchorPoint = Vector2.new(0, 0.5)
            sliderBg.Size = UDim2.fromOffset(120, 6)
            sliderBg.Parent = slider

            local sliderBgCorner = Instance.new("UICorner")
            sliderBgCorner.CornerRadius = UDim.new(0, 3)
            sliderBgCorner.Parent = sliderBg

            local sliderFill = Instance.new("Frame")
            sliderFill.Name = "sliderFill"
            sliderFill.BackgroundColor3 = colors.accent
            sliderFill.Size = UDim2.fromScale((default - min) / (max - min), 1)
            sliderFill.Parent = sliderBg

            local sliderFillCorner = Instance.new("UICorner")
            sliderFillCorner.CornerRadius = UDim.new(0, 3)
            sliderFillCorner.Parent = sliderFill

            local thumb = Instance.new("Frame")
            thumb.Name = "thumb"
            thumb.BackgroundColor3 = colors.text
            thumb.Position = UDim2.fromScale(sliderFill.Size.X.Scale, 0.5)
            thumb.AnchorPoint = Vector2.new(0.5, 0.5)
            thumb.Size = UDim2.fromOffset(12, 12)
            thumb.Parent = sliderBg

            local thumbCorner = Instance.new("UICorner")
            thumbCorner.CornerRadius = UDim.new(0, 6)
            thumbCorner.Parent = thumb

            local hovered = false
            local down = false

            slider.MouseEnter:Connect(function()
                hovered = true
                TweenService:Create(slider, TweenInfo.new(0.2), {BackgroundColor3 = colors.elementHover}):Play()
            end)

            slider.MouseLeave:Connect(function()
                hovered = false
                if not down then
                    TweenService:Create(slider, TweenInfo.new(0.2), {BackgroundColor3 = colors.element}):Play()
                end
            end)

            UserInputService.InputEnded:Connect(function(key)
                if key.UserInputType == Enum.UserInputType.MouseButton1 then
                    down = false
                    TweenService:Create(slider, TweenInfo.new(0.2), {BackgroundColor3 = colors.element}):Play()
                end
            end)

            local function updateSlider(input)
                local mousePos = UserInputService:GetMouseLocation()
                local absPos = sliderBg.AbsolutePosition
                local absSize = sliderBg.AbsoluteSize
                local relativeX = math.clamp(mousePos.X - absPos.X, 0, absSize.X)
                local percentage = relativeX / absSize.X
                local value = math.floor((max - min) * percentage + min)
                valueLabel.Text = tostring(value)

                TweenService:Create(sliderFill, TweenInfo.new(0.1), {Size = UDim2.fromScale(percentage, 1)}):Play()
                TweenService:Create(thumb, TweenInfo.new(0.1), {Position = UDim2.fromScale(percentage, 0.5)}):Play()

                callback(value)
            end

            slider.MouseButton1Down:Connect(function()
                down = true
                TweenService:Create(slider, TweenInfo.new(0.2), {BackgroundColor3 = colors.elementActive}):Play()
                updateSlider()
                local connection
                connection = RunService.RenderStepped:Connect(function()
                    if down then
                        updateSlider()
                    else
                        connection:Disconnect()
                    end
                end)
            end)
        end

        function ElementHandler:Toggle(text, callback)
            text = text or "Toggle"
            callback = callback or function() end

            local toggle = Instance.new("TextButton")
            toggle.Name = "toggle"
            toggle.BackgroundColor3 = colors.element
            toggle.Size = UDim2.fromOffset(430, 34)
            toggle.Text = ""
            toggle.AutoButtonColor = false
            toggle.Parent = holder

            local toggleCorner = Instance.new("UICorner")
            toggleCorner.CornerRadius = UDim.new(0, 6)
            toggleCorner.Parent = toggle

            local textLabel = Instance.new("TextLabel")
            textLabel.Name = "textLabel"
            textLabel.Font = Enum.Font.Gotham
            textLabel.Text = text
            textLabel.TextColor3 = colors.text
            textLabel.TextSize = 14
            textLabel.TextXAlignment = Enum.TextXAlignment.Left
            textLabel.BackgroundTransparency = 1
            textLabel.Position = UDim2.fromScale(0.03, 0)
            textLabel.Size = UDim2.fromOffset(1, 34)
            textLabel.Parent = toggle

            local toggleBg = Instance.new("Frame")
            toggleBg.Name = "toggleBg"
            toggleBg.BackgroundColor3 = colors.container
            toggleBg.Position = UDim2.fromScale(0.9, 0.5)
            toggleBg.AnchorPoint = Vector2.new(0.5, 0.5)
            toggleBg.Size = UDim2.fromOffset(40, 20)
            toggleBg.Parent = toggle

            local toggleBgCorner = Instance.new("UICorner")
            toggleBgCorner.CornerRadius = UDim.new(0, 10)
            toggleBgCorner.Parent = toggleBg

            local toggleIndicator = Instance.new("Frame")
            toggleIndicator.Name = "toggleIndicator"
            toggleIndicator.BackgroundColor3 = colors.textDim
            toggleIndicator.Position = UDim2.fromScale(0.05, 0.5)
            toggleIndicator.AnchorPoint = Vector2.new(0, 0.5)
            toggleIndicator.Size = UDim2.fromOffset(16, 16)
            toggleIndicator.Parent = toggleBg

            local indicatorCorner = Instance.new("UICorner")
            indicatorCorner.CornerRadius = UDim.new(0, 8)
            indicatorCorner.Parent = toggleIndicator

            local state = false

            local function updateToggle()
                if state then
                    TweenService:Create(toggleBg, TweenInfo.new(0.2), {BackgroundColor3 = colors.success}):Play()
                    TweenService:Create(toggleIndicator, TweenInfo.new(0.2), {
                        Position = UDim2.fromScale(0.95, 0.5),
                        BackgroundColor3 = colors.text
                    }):Play()
                else
                    TweenService:Create(toggleBg, TweenInfo.new(0.2), {BackgroundColor3 = colors.container}):Play()
                    TweenService:Create(toggleIndicator, TweenInfo.new(0.2), {
                        Position = UDim2.fromScale(0.05, 0.5),
                        BackgroundColor3 = colors.textDim
                    }):Play()
                end
            end

            toggle.MouseEnter:Connect(function()
                TweenService:Create(toggle, TweenInfo.new(0.2), {BackgroundColor3 = colors.elementHover}):Play()
            end)

            toggle.MouseLeave:Connect(function()
                TweenService:Create(toggle, TweenInfo.new(0.2), {BackgroundColor3 = colors.element}):Play()
            end)

            toggle.MouseButton1Click:Connect(function()
                state = not state
                callback(state)
                updateToggle()
            end)

            updateToggle()
        end

        function ElementHandler:Textbox(text, callback)
            text = text or "Textbox"
            callback = callback or function() end

            local textbox = Instance.new("Frame")
            textbox.Name = "textbox"
            textbox.BackgroundColor3 = colors.element
            textbox.Size = UDim2.fromOffset(430, 34)
            textbox.Parent = holder

            local textboxCorner = Instance.new("UICorner")
            textboxCorner.CornerRadius = UDim.new(0, 6)
            textboxCorner.Parent = textbox

            local textLabel = Instance.new("TextLabel")
            textLabel.Name = "textLabel"
            textLabel.Font = Enum.Font.Gotham
            textLabel.Text = text
            textLabel.TextColor3 = colors.text
            textLabel.TextSize = 14
            textLabel.TextXAlignment = Enum.TextXAlignment.Left
            textLabel.BackgroundTransparency = 1
            textLabel.Position = UDim2.fromScale(0.03, 0)
            textLabel.Size = UDim2.fromOffset(1, 34)
            textLabel.Parent = textbox

            local textBox = Instance.new("TextBox")
            textBox.Name = "textBox"
            textBox.Font = Enum.Font.Gotham
            textBox.Text = ""
            textBox.TextColor3 = colors.text
            textBox.TextSize = 14
            textBox.PlaceholderText = "Input..."
            textBox.PlaceholderColor3 = colors.textDim
            textBox.BackgroundColor3 = colors.container
            textBox.Position = UDim2.fromScale(0.7, 0.5)
            textBox.AnchorPoint = Vector2.new(0, 0.5)
            textBox.Size = UDim2.fromOffset(100, 24)
            textBox.Parent = textbox

            local textBoxCorner = Instance.new("UICorner")
            textBoxCorner.CornerRadius = UDim.new(0, 6)
            textBoxCorner.Parent = textBox

            textbox.MouseEnter:Connect(function()
                TweenService:Create(textbox, TweenInfo.new(0.2), {BackgroundColor3 = colors.elementHover}):Play()
            end)

            textbox.MouseLeave:Connect(function()
                TweenService:Create(textbox, TweenInfo.new(0.2), {BackgroundColor3 = colors.element}):Play()
            end)

            textBox.FocusLost:Connect(function()
                callback(textBox.Text)
            end)
        end

        return ElementHandler
    end

    -- Drag functionality (improved)
    local dragging = false
    local dragInput, dragStart, startPos

    local function updateDrag(input)
        local delta = input.Position - dragStart
        local newPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        main.Position = newPos
        shadow.Position = newPos
    end

    main.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = main.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    main.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            updateDrag(input)
        end
    end)

    -- Make first tab visible automatically
    local function setFirstTabVisible()
        local firstTab = tabContainer:FindFirstChildWhichIsA("TextButton")
        if firstTab then
            for _,v in pairs(main:GetChildren()) do
                if v.Name == "container" then
                    v.Visible = false
                end
            end
            for _,v in pairs(tabContainer:GetChildren()) do
                if v:IsA('TextButton') then
                    v.TextColor3 = colors.textDim
                end
            end
            local container = main:FindFirstChild("container")
            if container then
                container.Visible = true
                firstTab.TextColor3 = colors.text
            end
        end
    end

    spawn(function()
        repeat wait() until tabContainer:FindFirstChildWhichIsA("TextButton")
        setFirstTabVisible()
    end)

    -- Startup sound (unchanged)
    spawn(function()
        if table.StartupSound and table.StartupSound.Toggle and table.StartupSound.SoundID then
            local sound = Instance.new('Sound', dark_UI)
            sound.Name = "StartupSound"
            sound.SoundId = table.StartupSound.SoundID
            sound.Volume = 1.5
            sound.TimePosition = table.StartupSound.TimePosition or 0
            sound:Play()
            sound.Stopped:Wait()
            sound:Destroy()
        end
    end)

    return tabHandler
end

return Library
