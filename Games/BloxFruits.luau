-- File: Games/BloxFruits.luau (Bản nâng cấp có Logic Farm thật)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bracket-v/bracket-v/main/library.lua"))()

-- 1. Tạo Menu chính
local Window = Library:CreateWindow({
    Name = "MY FIRST HUB (PRO) - " .. game.Players.LocalPlayer.Name,
    MinSize = Vector2.new(500, 400),
    ToggleKey = Enum.KeyCode.RightControl
})

-- Các biến trạng thái (Tránh lỗi)
local AutoFarmLevel = false
local BringMobs = false
local SelectedWeapon = "Melee"

-- ==================== PHẦN LOGIC CHẠY NGẦM (BACKEND) ====================

-- 1. Logic Tự Động Gom Quái (Bring Mobs) cực mượt
task.spawn(function()
    while task.wait() do
        if BringMobs and AutoFarmLevel then
            pcall(function()
                local MyCharacter = game.Players.LocalPlayer.Character
                if MyCharacter and MyCharacter:FindFirstChild("HumanoidRootPart") then
                    local MyPos = MyCharacter.HumanoidRootPart.Position
                    
                    -- Quét toàn bộ quái vật trong thư mục Enemies của game
                    for _, Enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if Enemy:FindFirstChild("HumanoidRootPart") and Enemy:FindFirstChild("Humanoid") and Enemy.Humanoid.Health > 0 then
                            -- Nếu quái ở gần (khoảng cách dưới 300m), dịch chuyển nó lại trước mặt người chơi
                            if (Enemy.HumanoidRootPart.Position - MyPos).Magnitude <= 300 then
                                Enemy.HumanoidRootPart.CFrame = MyCharacter.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
                                Enemy.HumanoidRootPart.CanCollide = false
                                Enemy.Humanoid.Active = false -- Làm quái đứng yên, không chạy lung tung
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- 2. Logic Tự Động Đánh (Auto Click/Attack)
task.spawn(function()
    while task.wait() do
        if AutoFarmLevel then
            pcall(function()
                -- Trang bị vũ khí đã chọn trên tay trước khi đánh
                local Player = game.Players.LocalPlayer
                local BackPack = Player.Backpack
                local Character = Player.Character
                
                -- Tìm vũ khí theo loại bạn chọn
                for _, Tool in pairs(BackPack:GetChildren()) do
                    if Tool:IsA("Tool") and (Tool.ToolTip == SelectedWeapon or SelectedWeapon == "Melee" and Tool.ToolTip == "Blox Fruit") then
                        Character.Humanoid:EquipTool(Tool)
                    end
                end
                
                -- Giả lập bấm chuột trái liên tục để đánh quái
                local VirtualUser = game:GetService("VirtualUser")
                VirtualUser:CaptureController()
                VirtualUser:ClickButton1(Vector2.new(850, 520))
            end)
        end
    end
end)

-- 3. Logic Auto Farm chính (Tìm quái và bay đến)
task.spawn(function()
    while task.wait() do
        if AutoFarmLevel then
            pcall(function()
                local MyCharacter = game.Players.LocalPlayer.Character
                local EnemyFound = false
                
                -- Tìm con quái gần nhất để farm (Ví dụ dưới đây farm quái "Bandit" ở Đảo Khởi Đầu)
                for _, Enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    if Enemy.Name == "Bandit" and Enemy:FindFirstChild("HumanoidRootPart") and Enemy.Humanoid.Health > 0 then
                        EnemyFound = true
                        
                        -- Bay lơ lửng phía trên đầu con quái 5 mét để tránh bị nó đánh trúng
                        MyCharacter.HumanoidRootPart.CFrame = Enemy.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                        break
                    end
                end
                
                -- Nếu không thấy quái, tự động bay về điểm hồi sinh của quái để đợi
                if not EnemyFound then
                    MyCharacter.HumanoidRootPart.CFrame = CFrame.new(1059.3, 16.2, 1549.2) -- Toạ độ bãi quái Bandit
                end
            end)
        end
    end
end)


-- ==================== TAB GIAO DIỆN (UI) ====================

local FarmTab = Window:CreateTab("Tự Động Farm")
local MainSection = FarmTab:CreateSection("Farm Level")
local MethodSection = FarmTab:CreateSection("Cài Đặt Farm")

-- Chọn vũ khí
MethodSection:CreateDropdown({
    Name = "Chọn Vũ Khí Sử Dụng",
    List = {"Melee", "Sword", "Devil Fruit"},
    Function = function(Selected)
        SelectedWeapon = Selected
    end
})

-- Bật/Tắt Farm
MainSection:CreateToggle({
    Name = "Auto Farm Level (Đảo Khởi Đầu)",
    Value = false,
    Callback = function(Value)
        AutoFarmLevel = Value
    end
})

-- Bật/Tắt Gom Quái
MethodSection:CreateToggle({
    Name = "Gom Quái (Bring Monsters)",
    Value = false,
    Callback = function(Value)
        BringMobs = Value
    end
})

-- Các Tab phụ khác giữ nguyên
local StatsTab = Window:CreateTab("Nâng Stats")
local StatsSection = StatsTab:CreateSection("Tự Động Cộng Điểm")
-- (Bạn có thể tự thêm các nút cộng stats vào đây)

-- Gửi thông báo khởi chạy thành công
Library:Notify({
    Title = "Thành công!",
    Content = "Đã kích hoạt hệ thống Auto Farm + Bring Mobs!",
    Time = 5
})
