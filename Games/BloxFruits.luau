-- File: Games/BloxFruits.luau (Phiên bản BL HUB - Bảo mật & Kiếm tiền qua Link4M)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bracket-v/bracket-v/main/library.lua"))()

-- ==================== CẤU HÌNH KEY & LINK4M ====================
local CorrectKey = "BLHUB-9988" -- Bạn có thể đổi Key này tùy ý
local Link4M_URL = "https://fnote.net/notes/dxNLB7" -- Người chơi bấm Get Key sẽ copy thẳng link Fnote này
local KeyEntered = false

-- 1. Tạo Cửa Sổ Nhập Key (Đã đổi tên thành BL HUB)
local KeyWindow = Library:CreateWindow({
    Name = "HỆ THỐNG KEY - BL HUB",
    MinSize = Vector2.new(400, 250),
    ToggleKey = Enum.KeyCode.RightControl
})

local KeyTab = KeyWindow:CreateTab("Xác Thực Key")
local KeySection = KeyTab:CreateSection("Nhập Key Để Tiếp Tục")

local InputKey = ""

KeySection:CreateTextBox({
    Name = "Nhập Key vào đây:",
    Placeholder = "Ví dụ: BLHUB-xxxx",
    Callback = function(Text)
        InputKey = Text
    end
})

-- Nút kiểm tra Key
KeySection:CreateButton({
    Name = "Xác Nhận Key (Submit)",
    Callback = function()
        if InputKey == CorrectKey then
            KeyEntered = true
            Library:Notify({
                Title = "Chính Xác!",
                Content = "Đang tải BL HUB...",
                Time = 3
            })
            task.wait(1)
            KeyWindow:Destroy() -- Tắt bảng nhập Key
            LoadMainScripts()   -- Chạy Menu chính BL HUB
        else
            Library:Notify({
                Title = "Thất Bại!",
                Content = "Key không đúng! Vui lòng vượt link lại để lấy key.",
                Time = 3
            })
        end
    end
})

-- Nút lấy Key qua Link4M
KeySection:CreateButton({
    Name = "Copy Link Vượt Ải Lấy Key (Link4M)",
    Callback = function()
        setclipboard(Link4M_URL) -- Tự động copy link Link4M vào bộ nhớ tạm của người chơi
        Library:Notify({
            Title = "Đã Copy Link!",
            Content = "Hãy dán (Ctrl+V) link vào trình duyệt để vượt qua Link4M lấy Key nhé!",
            Time = 5
        })
    end
})


-- ==================== MENU CHÍNH BL HUB (Chỉ hiện khi gõ đúng Key) ====================
function LoadMainScripts()
    local Window = Library:CreateWindow({
        Name = "BL HUB (PRO)", -- Đã xóa hoàn toàn tên của bạn, chỉ hiện tên thương hiệu của bạn
        MinSize = Vector2.new(500, 400),
        ToggleKey = Enum.KeyCode.RightControl
    })

    local AutoFarmLevel = false
    local BringMobs = false
    local SelectedWeapon = "Melee"
    local AutoObservationHaki = false
    local AntiObservationHaki = false

    -- ==================== HỆ THỐNG HAKI QUAN SÁT V2 (BYPASS) ====================

    -- 1. Auto Bật Haki Quan Sát liên tục
    task.spawn(function()
        while task.wait(1) do
            if AutoObservationHaki then
                pcall(function()
                    local Player = game.Players.LocalPlayer
                    if Player.Character and not Player.Character:FindFirstChild("HasBuso") then
                        local VirtualInputManager = game:GetService("VirtualInputManager")
                        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
                        task.wait(0.1)
                        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
                    end
                end)
            end
        end
    end)

    -- 2. "Tàng hình" Haki Quan Sát
    task.spawn(function()
        while task.wait(0.1) do
            if AntiObservationHaki then
                pcall(function()
                    local Character = game.Players.LocalPlayer.Character
                    if Character then
                        if Character:FindFirstChild("Head") and Character.Head:FindFirstChildOfClass("BillboardGui") then
                            Character.Head:FindFirstChildOfClass("BillboardGui").Enabled = false
                        end
                        local Root = Character:FindFirstChild("HumanoidRootPart")
                        if Root and AutoFarmLevel == false then 
                            Root.CFrame = Root.CFrame * CFrame.new(math.random(-1, 1)/10, 0, math.random(-1, 1)/10)
                        end
                    end
                end)
            end
        end
    end)

    -- ==================== HỆ THỐNG PHỤ TRỢ (AUTO FARM) ====================

    -- 3. Noclip (Xuyên tường)
    task.spawn(function()
        game:GetService("RunService").Stepped:Connect(function()
            if AutoFarmLevel then
                pcall(function()
                    local Character = game.Players.LocalPlayer.Character
                    if Character then
                        for _, Part in pairs(Character:GetChildren()) do
                            if Part:IsA("BasePart") then
                                Part.CanCollide = false
                            end
                        end
                    end
                end)
            end
        end)
    end)

    -- 4. Gom Quái Siêu Tốc (Bring Mobs Fast)
    task.spawn(function()
        while task.wait() do
            if BringMobs and AutoFarmLevel then
                pcall(function()
                    local MyCharacter = game.Players.LocalPlayer.Character
                    if MyCharacter and MyCharacter:FindFirstChild("HumanoidRootPart") then
                        local MyPos = MyCharacter.HumanoidRootPart.Position
                        for _, Enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if Enemy:FindFirstChild("HumanoidRootPart") and Enemy:FindFirstChild("Humanoid") and Enemy.Humanoid.Health > 0 then
                                if (Enemy.HumanoidRootPart.Position - MyPos).Magnitude <= 350 then
                                    Enemy.HumanoidRootPart.CFrame = MyCharacter.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
                                    Enemy.HumanoidRootPart.CanCollide = false
                                    Enemy.Humanoid.Active = false
                                end
                            end
                        end
                    end
                end)
            end
        end
    end)

    -- 5. Tấn Công Siêu Tốc (Fast Attack)
    task.spawn(function()
        while task.wait(0.01) do
            if AutoFarmLevel then
                pcall(function()
                    local Player = game.Players.LocalPlayer
                    local BackPack = Player.Backpack
                    local Character = Player.Character
                    for _, Tool in pairs(BackPack:GetChildren()) do
                        if Tool:IsA("Tool") and (Tool.ToolTip == SelectedWeapon or SelectedWeapon == "Melee" and Tool.ToolTip == "Blox Fruit") then
                            Character.Humanoid:EquipTool(Tool)
                        end
                    end
                    local VirtualUser = game:GetService("VirtualUser")
                    VirtualUser:CaptureController()
                    VirtualUser:ClickButton1(Vector2.new(850, 520))
                end)
            end
        end
    end)

    -- 6. Auto Farm
    task.spawn(function()
        while task.wait() do
            if AutoFarmLevel then
                pcall(function()
                    local MyCharacter = game.Players.LocalPlayer.Character
                    local EnemyFound = false
                    for _, Enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if Enemy.Name == "Bandit" and Enemy:FindFirstChild("HumanoidRootPart") and Enemy.Humanoid.Health > 0 then
                            EnemyFound = true
                            MyCharacter.HumanoidRootPart.CFrame = Enemy.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                            break
                        end
                    end
                    if not EnemyFound then
                        MyCharacter.HumanoidRootPart.CFrame = CFrame.new(1059.3, 16.2, 1549.2)
                    end
                end)
            end
        end
    end)

    -- ==================== TAB GIAO DIỆN (UI) ====================

    local FarmTab = Window:CreateTab("Tự Động Farm")
    local MainSection = FarmTab:CreateSection("Farm Level")
    local MethodSection = FarmTab:CreateSection("Cài Đặt Farm")
    local HakiSection = FarmTab:CreateSection("Cài Đặt Haki")

    HakiSection:CreateToggle({
        Name = "Auto Active Haki Quan Sát (E)",
        Value = false,
        Callback = function(Value)
            AutoObservationHaki = Value
        end
    })

    HakiSection:CreateToggle({
        Name = "Tàng Hình / Chống Haki V2 (Bypass)",
        Value = false,
        Callback = function(Value)
            AntiObservationHaki = Value
        end
    })

    MethodSection:CreateDropdown({
        Name = "Chọn Vũ Khí Sử Dụng",
        List = {"Melee", "Sword", "Devil Fruit"},
        Function = function(Selected)
            SelectedWeapon = Selected
        end
    })

    MainSection:CreateToggle({
        Name = "Auto Farm Level (Đảo Khởi Đầu)",
        Value = false,
        Callback = function(Value)
            AutoFarmLevel = Value
        end
    })

    MethodSection:CreateToggle({
        Name = "Gom Quái (Bring Monsters)",
        Value = false,
        Callback = function(Value)
            BringMobs = Value
        end
    })

    -- Các Tab phụ khác
    local StatsTab = Window:CreateTab("Nâng Stats")
    local StatsSection = StatsTab:CreateSection("Tự Động Cộng Điểm")
    local TeleportTab = Window:CreateTab("Dịch Chuyển")
    local IslandSection = TeleportTab:CreateSection("Chọn Đảo")
    local ShopTab = Window:CreateTab("Cửa Hàng")
    local ShopSection = ShopTab:CreateSection("NPC Shop")

    Library:Notify({
        Title = "BL HUB ĐÃ KHỞI CHẠY",
        Content = "Chúc bạn chơi game vui vẻ!",
        Time = 5
    })
end
