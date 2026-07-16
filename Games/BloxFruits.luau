-- File: Games/BloxFruits.luau (Bản Bảo Mật Chống Copy & Đổi Tên Thương Hiệu)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bracket-v/bracket-v/main/library.lua"))()

-- ==================== HỆ THỐNG BẪY BẢO MẬT (ANTI-TAMPER) ====================

local CorrectKey = "BLHUB-9988" 
local Link4M_URL = "https://fnote.net/notes/dxNLB7"
local HubName = "BL HUB" -- Tên thương hiệu bắt buộc phải giữ nguyên

-- Hàm trừng phạt: Gây lag cực nặng và văng game (Crash)
local function ActivateTrap()
    while true do
        -- Vòng lặp vô hạn không có thời gian chờ (task.wait) sẽ khiến CPU quá tải 100% và crash game ngay lập tức
        local crash = "BL HUB Anti-Cheat Kích Hoạt!"
        print(crash)
    end
end

-- Bẫy lớp 1: Kiểm tra nguồn tải hợp lệ (Chỉ cho phép tải từ tài khoản của bạn)
local Success, SourceCode = pcall(function()
    return game:HttpGet("https://raw.githubusercontent.com/nguyenxuanthuy334-debug/MyRobloxScripts/main/main.luau")
end)

-- Nếu không kết nối được hoặc nguồn tải bị thay đổi không còn chứa tên tài khoản của bạn
if not Success or not string.find(SourceCode, "nguyenxuanthuy334") then
    ActivateTrap()
    return
end

-- Bẫy lớp 2: Kiểm tra nếu tên thương hiệu bị đổi
if HubName ~= "BL HUB" then
    ActivateTrap()
    return
end


-- ==================== KHỞI CHẠY HỆ THỐNG KEY (BL HUB) ====================

local KeyEntered = false

local KeyWindow = Library:CreateWindow({
    Name = "HỆ THỐNG KEY - " .. HubName, -- Sử dụng biến HubName để kiểm tra
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

KeySection:CreateButton({
    Name = "Xác Nhận Key (Submit)",
    Callback = function()
        -- Bẫy lớp 2 phụ: Kiểm tra lại tên thương hiệu lần nữa trước khi mở khóa
        if HubName ~= "BL HUB" then
            ActivateTrap()
            return
        end
        
        if InputKey == CorrectKey then
            KeyEntered = true
            Library:Notify({
                Title = "Chính Xác!",
                Content = "Đang tải " .. HubName .. "...",
                Time = 3
            })
            task.wait(1)
            KeyWindow:Destroy() 
            LoadMainScripts()   
        else
            Library:Notify({
                Title = "Thất Bại!",
                Content = "Key không đúng! Vui lòng vào Fnote lấy lại key.",
                Time = 3
            })
        end
    end
})

KeySection:CreateButton({
    Name = "Copy Link Trang Lấy Key (Fnote)",
    Callback = function()
        setclipboard(Link4M_URL) 
        Library:Notify({
            Title = "Đã Copy Link!",
            Content = "Hãy dán link vào trình duyệt để vào trang Fnote lấy Key nhé!",
            Time = 5
        })
    end
})


-- ==================== MENU CHÍNH BL HUB (Chỉ hiện khi gõ đúng Key) ====================
function LoadMainScripts()
    -- Bẫy lớp 2 tối hậu: Kiểm tra tên thương hiệu lần cuối trước khi vẽ giao diện chính
    if HubName ~= "BL HUB" then
        ActivateTrap()
        return
    end

    local Window = Library:CreateWindow({
        Name = HubName .. " (PRO)", 
        MinSize = Vector2.new(500, 400),
        ToggleKey = Enum.KeyCode.RightControl
    })

    local AutoFarmLevel = false
    local BringMobs = false
    local SelectedWeapon = "Melee"
    local AutoObservationHaki = false
    local AntiObservationHaki = false

    -- [Giữ nguyên toàn bộ phần logic Auto Farm, Haki, Noclip và Gom quái của bạn ở đây...]
    -- (Để tránh dài dòng mình đã rút gọn đoạn hiển thị này, bạn chỉ cần giữ nguyên phần code cũ phía dưới giống hệt phiên bản trước nhé!)

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

    local StatsTab = Window:CreateTab("Nâng Stats")
    local StatsSection = StatsTab:CreateSection("Tự Động Cộng Điểm")
    local TeleportTab = Window:CreateTab("Dịch Chuyển")
    local IslandSection = TeleportTab:CreateSection("Chọn Đảo")
    local ShopTab = Window:CreateTab("Cửa Hàng")
    local ShopSection = ShopTab:CreateSection("NPC Shop")

    Library:Notify({
        Title = HubName .. " ĐÃ KHỞI CHẠY",
        Content = "Chào mừng bạn đến với phiên bản bảo mật!",
        Time = 5
    })
end
