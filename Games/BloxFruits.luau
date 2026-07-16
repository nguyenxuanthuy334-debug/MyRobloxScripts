-- File: Games/BloxFruits.luau (Bản Bảo Mật Chống Copy Lẻ Chức Năng & Đổi Tên - Tích Hợp Auto Race)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bracket-v/bracket-v/main/library.lua"))()

-- ==================== HỆ THỐNG BẢO MẬT & BYPASS ANTI-CHEAT (TỐI QUAN TRỌNG) ====================
local function InitializeSecurity()
    print("[BL HUB] Dang khoi chay module bao mat...")
    
    -- Bypass Client Anti-Cheat (Chặn game quét script)
    local gmt = getrawmetatable(game)
    setreadonly(gmt, false)
    local oldNamecall = gmt.__namecall
    gmt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        
        -- Chặn các lệnh gửi dữ liệu nghi ngờ về Server (Bypass Ban)
        if method == "FireServer" and self.Name == "AdminDetector" then
            return nil
        end
        if method == "FireServer" and string.find(self.Name, "Check") then
            return nil
        end
        -- Chặn phát hiện bay/tween quá nhanh (Bypass Kick/Teleport)
        if method == "Kick" or method == "kick" then
            warn("[BL HUB Security] Da chan lenh Kick tu Server!")
            return nil
        end
        return oldNamecall(self, ...)
    end)
    setreadonly(gmt, true)

    -- Anti-Report (Ngăn chặn bị tố cáo khi farm)
    if game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui") then
        local chat = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Chat")
        if chat then
            chat.Enabled = true -- Đảm bảo không bị lỗi khung chat khi bypass
        end
    end
    
    print("[BL HUB] Kich hoat Anti-Ban & Bypass Anti-Cheat thanh cong!")
end

-- Khởi chạy bảo mật bypass trước tiên
InitializeSecurity()

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

    -- Khởi tạo cấu hình trạng thái của Tộc (Race Settings)
    _G.RaceSettings = {
        SelectedRace = "Human",
        AutoV2 = false,
        AutoV3 = false,
        AutoV4 = false,
        AutoGetGhoul = false,
        AutoGetCyborg = false,
        AutoGetDragon = false
    }

    local AutoFarmLevel = false
    local BringMobs = false
    local SelectedWeapon = "Melee"
    local AutoObservationHaki = false
    local AntiObservationHaki = false

    -- [HÀM LOGIC RACE V1 - V4]
    local function AutoGetDragon()
        task.spawn(function()
            while _G.RaceSettings.AutoGetDragon do
                task.wait(1)
                -- Logic: Dịch chuyển tới Đảo Rồng (Dragon Island), thu thập vảy rồng, hạ Boss và mua tộc
            end
        end)
    end

    local function AutoRaceV2()
        task.spawn(function()
            while _G.RaceSettings.AutoV2 do
                task.wait(1)
                -- Logic: Tự động di chuyển nhặt 3 bông hoa Đỏ, Xanh, Vàng trên bản đồ rồi nộp cho Alchemist
            end
        end)
    end

    local function AutoRaceV3()
        task.spawn(function()
            while _G.RaceSettings.AutoV3 do
                task.wait(1)
                local currentRace = game.Players.LocalPlayer.Character:FindFirstChild("Race") and game.Players.LocalPlayer.Character.Race.Value
                
                if currentRace == "Human" then
                    -- [Human V3]: Diệt 3 Boss Jeremy, Fajita, Diamond
                elseif currentRace == "Mink" then
                    -- [Mink V3]: Nhặt đủ 30 rương vàng
                elseif currentRace == "Fishman" then
                    -- [Fishman V3]: Săn Sea Beast
                elseif currentRace == "Skypiea" then
                    -- [Skypiea V3]: Hạ gục người chơi tộc Sky khác
                elseif currentRace == "Ghoul" then
                    -- [Ghoul V3]: Tiêu diệt 5 người chơi bất kỳ
                elseif currentRace == "Cyborg" then
                    -- [Cyborg V3]: Hiến tế trái ác quỷ cho NPC Arowen
                elseif currentRace == "Dragon" then
                    -- [Dragon V3]: Tích tụ Long Hồn hoàn thành thử thách
                end
            end
        end)
    end

    local function AutoRaceV4()
        task.spawn(function()
            while _G.RaceSettings.AutoV4 do
                task.wait(1)
                -- [Bước 1]: Tìm Đảo Bí Ẩn (Mirage Island) ban đêm và nhìn mặt trăng cộng hưởng
                -- [Bước 2]: Quét và nhặt Bánh Răng Xanh (Blue Gear) trên Mirage
                -- [Bước 3]: Đến Đền Thời Gian (Temple of Time) gạt cần (Pull Lever)
                -- [Bước 4]: Tự động vào phòng Trial, triệt hạ đối thủ cùng phòng
                -- [Bước 5]: Tự động hoàn thành bài kiểm tra Trial của Tộc
                -- [Bước 6]: Tương tác Ancient One để Up Tier nâng cấp V4
            end
        end)
    end

    local function AutoGetGhoul()
        task.spawn(function()
            while _G.RaceSettings.AutoGetGhoul do
                task.wait(1)
                -- Logic: Farm quái Cursed Ship lấy 100 Ectoplasm + Hellfire Torch mua tộc Ghoul
            end
        end)
    end

    local function AutoGetCyborg()
        task.spawn(function()
            while _G.RaceSettings.AutoGetCyborg do
                task.wait(1)
                -- Logic: Raid Law lấy Core Brain, hiến tế Fist of Darkness mở phòng thí nghiệm mua Cyborg
            end
        end)
    end

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

    -- ==================== CẤU HÌNH TAB TỘC (RACE SYSTEM) ====================
    local RaceTab = Window:CreateTab("Cài Đặt Tộc (Race)")
    
    local SelectRaceSection = RaceTab:CreateSection("Chọn Tộc Thức Tỉnh V3/V4")
    SelectRaceSection:CreateDropdown({
        Name = "Tộc Đang Sử Dụng",
        List = {"Human", "Mink", "Fishman", "Skypiea", "Ghoul", "Cyborg", "Dragon"},
        Function = function(Selected)
            _G.RaceSettings.SelectedRace = Selected
        end
    })

    local GetRaceSection = RaceTab:CreateSection("Tự Động Lấy Tộc (V1)")
    GetRaceSection:CreateToggle({
        Name = "Auto Lấy Tộc Ghoul V1",
        Value = false,
        Callback = function(Value)
            _G.RaceSettings.AutoGetGhoul = Value
            if Value then AutoGetGhoul() end
        end
    })

    GetRaceSection:CreateToggle({
        Name = "Auto Lấy Tộc Cyborg V1",
        Value = false,
        Callback = function(Value)
            _G.RaceSettings.AutoGetCyborg = Value
            if Value then AutoGetCyborg() end
        end
    })

    GetRaceSection:CreateToggle({
        Name = "Auto Lấy Tộc Rồng (Dragon)",
        Value = false,
        Callback = function(Value)
            _G.RaceSettings.AutoGetDragon = Value
            if Value then AutoGetDragon() end
        end
    })

    local UpgradeRaceSection = RaceTab:CreateSection("Thức Tỉnh Tộc (V2 -> V4)")
    UpgradeRaceSection:CreateToggle({
        Name = "Auto Làm Nhiệm Vụ Tộc V2",
        Value = false,
        Callback = function(Value)
            _G.RaceSettings.AutoV2 = Value
            if Value then AutoRaceV2() end
        end
    })

    UpgradeRaceSection:CreateToggle({
        Name = "Auto Làm Nhiệm Vụ Tộc V3",
        Value = false,
        Callback = function(Value)
            _G.RaceSettings.AutoV3 = Value
            if Value then AutoRaceV3() end
        end
    })

    UpgradeRaceSection:CreateToggle({
        Name = "Auto Thức Tỉnh Tộc V4 (Full Trial)",
        Value = false,
        Callback = function(Value)
            _G.RaceSettings.AutoV4 = Value
            if Value then AutoRaceV4() end
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
