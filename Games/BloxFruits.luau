-- File: Games/BloxFruits.luau (Bản Bảo Mật Chống Copy Lẻ Chức Năng & Đổi Tên)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bracket-v/bracket-v/main/library.lua"))()

-- ==================== HỘP NGÒI NỔ BẢO MẬT (ANTI-COPY LẺ) ====================
getgenv().BL_System_Config = {
    Verified = true,
    AuthToken = "BLHUB_SECURE_TOKEN_9988", -- Khóa xác thực ngầm
    MobRange = 350,                        -- Khoảng cách gom quái
    AttackDelay = 0.01,                    -- Tốc độ đánh nhanh
    HakiDelay = 1,                         -- Tốc độ bật Haki
}

-- ==================== HỆ THỐNG BẪY BẢO MẬT (ANTI-TAMPER) ====================
local CorrectKey = "BLHUB-9988" 
local Link4M_URL = "https://fnote.net/notes/dxNLB7"
local HubName = "BL HUB" 

-- Hàm trừng phạt (Crash game)
local function ActivateTrap()
    while true do
        local crash = "BL HUB Protection Activated!"
        print(crash)
    end
end

-- Bẫy lớp 1: Bảo vệ tên thương hiệu
if HubName ~= "BL HUB" then
    ActivateTrap()
    return
end

-- Bẫy lớp 2: Kiểm tra chạy lậu không qua file main.luau
local LoaderCheck = getgenv().BLHUB_LOADED
if not LoaderCheck then
    ActivateTrap()
    return
end


-- ==================== KHỞI CHẠY HỆ THỐNG KEY (BL HUB) ====================
local KeyEntered = false

local KeyWindow = Library:CreateWindow({
    Name = "HỆ THỐNG KEY - " .. HubName,
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

    -- 1. Auto Bật Haki Quan Sát liên tục
    task.spawn(function()
        local waitTime = (getgenv().BL_System_Config and getgenv().BL_System_Config.HakiDelay) or 1
        while task.wait(waitTime) do
            -- Kiểm tra bẫy liên kết ngầm
            if not getgenv().BL_System_Config or getgenv().BL_System_Config.AuthToken ~= "BLHUB_SECURE_TOKEN_9988" then
                ActivateTrap()
                return
            end

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
            -- Kiểm tra bẫy liên kết ngầm
            if not getgenv().BL_System_Config or getgenv().BL_System_Config.Verified ~= true then
                ActivateTrap()
                return
            end

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

    -- 4. Gom Quái Siêu Tốc (Bring Mobs Fast - ĐÃ GÀI BẪY)
    task.spawn(function()
        while task.wait() do
            -- BẪY: Nếu copy lẻ không có hệ thống Config của BL HUB -> Sập game
            if not getgenv().BL_System_Config or getgenv().BL_System_Config.AuthToken ~= "BLHUB_SECURE_TOKEN_9988" then
                ActivateTrap()
                return
            end

            if BringMobs and AutoFarmLevel and getgenv().BL_System_Config.Verified then
                pcall(function()
                    local MyCharacter = game.Players.LocalPlayer.Character
                    if MyCharacter and MyCharacter:FindFirstChild("HumanoidRootPart") then
                        local MyPos = MyCharacter.HumanoidRootPart.Position
                        for _, Enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if Enemy:FindFirstChild("HumanoidRootPart") and Enemy:FindFirstChild("Humanoid") and Enemy.Humanoid.Health > 0 then
                                -- Sử dụng biến MobRange từ hộp bảo mật ngầm
                                if (Enemy.HumanoidRootPart.Position - MyPos).Magnitude <= getgenv().BL_System_Config.MobRange then
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

    -- 5. Tấn Công Siêu Tốc (Fast Attack - ĐÃ GÀI BẪY)
    task.spawn(function()
        local delayTime = (getgenv().BL_System_Config and getgenv().BL_System_Config.AttackDelay) or 0.01
        while task.wait(delayTime) do
            -- BẪY: Nếu copy lẻ không có hệ thống Config -> Sập game
            if not getgenv().BL_System_Config or getgenv().BL_System_Config.Verified ~= true then
                ActivateTrap()
                return
            end

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

    -- ==================== CẤU HÌNH GIAO DIỆN TAB ====================
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
        Content = "Chào mừng bạn đến với phiên bản siêu bảo mật!",
        Time = 5
    })
end
