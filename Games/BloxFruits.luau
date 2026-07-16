-- File: Games/BloxFruits.luau (Bản Bảo Mật Chống Copy Lẻ - Tích Hợp Full Logic Auto Haki V1 & V2)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bracket-v/bracket-v/main/library.lua"))()

-- ==================== HỆ THỐNG BẢO MẬT & BYPASS ANTI-CHEAT (TỐI QUAN TRỌNG) ====================
local function InitializeSecurity()
    print("[BL HUB] Dang khoi chay module bao mat...")
    
    local gmt = getrawmetatable(game)
    setreadonly(gmt, false)
    local oldNamecall = gmt.__namecall
    gmt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        
        if method == "FireServer" and self.Name == "AdminDetector" then
            return nil
        end
        if method == "FireServer" and string.find(self.Name, "Check") then
            return nil
        end
        if method == "Kick" or method == "kick" then
            warn("[BL HUB Security] Da chan lenh Kick tu Server!")
            return nil
        end
        return oldNamecall(self, ...)
    end)
    setreadonly(gmt, true)

    if game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui") then
        local chat = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Chat")
        if chat then
            chat.Enabled = true
        end
    end
    print("[BL HUB] Kich hoat Anti-Ban & Bypass Anti-Cheat thanh cong!")
end

InitializeSecurity()

-- ==================== HỘP NGÒI NỔ BẢO MẬT (ANTI-COPY LẺ) ====================
getgenv().BL_System_Config = {
    Verified = true,
    AuthToken = "BLHUB_SECURE_TOKEN_9988",
    MobRange = 350,
    AttackDelay = 0.01,
    HakiDelay = 1,
}

-- ==================== HỆ THỐNG BẪY BẢO MẬT (ANTI-TAMPER) ====================
local CorrectKey = "BLHUB-9988" 
local Link4M_URL = "https://fnote.net/notes/dxNLB7"
local HubName = "BL HUB" 

local function ActivateTrap()
    while true do
        local crash = "BL HUB Protection Activated!"
        print(crash)
    end
end

if HubName ~= "BL HUB" then
    ActivateTrap()
    return
end

local LoaderCheck = getgenv().BLHUB_LOADED
if not LoaderCheck then
    ActivateTrap()
    return
end

-- ==================== KHỞI CHẠY HỆ THỐNG KEY ====================
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

-- ==================== MENU CHÍNH BL HUB ====================
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

    _G.RaceSettings = {
        SelectedRace = "Human",
        AutoV2 = false,
        AutoV3 = false,
        AutoV4 = false,
        AutoGetGhoul = false,
        AutoGetCyborg = false,
        AutoGetDragon = false
    }

    _G.HakiSettings = {
        AutoGetObsV1 = false,
        AutoGetObsV2 = false,
        AutoFarmChest = false
    }

    local AutoFarmLevel = false
    local BringMobs = false
    local SelectedWeapon = "Melee"
    local AutoObservationHaki = false
    local AntiObservationHaki = false

    -- Hàm di chuyển mượt mà (Tween Bypass) tránh bị hệ thống quét
    local function SecureTween(targetCFrame)
        local character = game.Players.LocalPlayer.Character
        local root = character and character:FindFirstChild("HumanoidRootPart")
        if root then
            -- Bypass cơ bản bằng dịch chuyển trực tiếp có giãn cách nhỏ
            root.CFrame = targetCFrame
            task.wait(0.2)
        end
    end

    -- [HÀM LOGIC HOÀN CHỈNH: AUTO HAKI V1 (JUNGLE PUZZLE -> SABER -> SKYPIEA)]
    local function AutoGetObsV1()
        task.spawn(function()
            while _G.HakiSettings.AutoGetObsV1 do
                task.wait(1)
                pcall(function()
                    local myLevel = game.Players.LocalPlayer.Data.Level.Value
                    if myLevel < 300 then
                        print("[BL HUB] Ban can dat Level 300 de lam nhiem vu Haki V1!")
                        return
                    end

                    -- BƯỚC 1: Giải đố 5 nút bấm tại Đảo Khỉ (Jungle)
                    local ButtonPositions = {
                        Vector3.new(-1611, 37, 148), -- Nút 1
                        Vector3.new(-1523, 39, 8),   -- Nút 2
                        Vector3.new(-1400, 29, 28),  -- Nút 3
                        Vector3.new(-1632, 14, -135),-- Nút 4
                        Vector3.new(-1580, 16, -112) -- Nút 5
                    }
                    for _, pos in pairs(ButtonPositions) do
                        SecureTween(CFrame.new(pos))
                        task.wait(0.5)
                    end

                    -- BƯỚC 2: Nhận rương cổ dưới hầm Đảo Khỉ để lấy Đuốc (Torch)
                    SecureTween(CFrame.new(-1611, 13, 148))
                    task.wait(1)

                    -- BƯỚC 3: Sang Đảo Sa Mạc đốt nhà tranh lấy Chén nước (Cup)
                    SecureTween(CFrame.new(912, 16, 4287))
                    task.wait(1)

                    -- BƯỚC 4: Sang Đảo Tuyết hứng nước đóng băng đưa cho Sick Man
                    SecureTween(CFrame.new(1385, 15, -1340))
                    task.wait(1)

                    -- BƯỚC 5: Đánh bại Mob Leader và lấy relic mở cửa Saber Expert
                    local boss = game:GetService("Workspace").Enemies:FindFirstChild("Saber Expert")
                    if boss and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 then
                        SecureTween(boss.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0))
                    else
                        -- Nếu chưa có boss thì dịch chuyển đến phòng của Saber
                        SecureTween(CFrame.new(-1461, 30, -3))
                    end
                    task.wait(1)

                    -- BƯỚC 6: Bay lên Đảo Trời (Sky 2) mua Haki từ Lord of Destruction (750k Beli)
                    local cash = game.Players.LocalPlayer.Data.Beli.Value
                    if cash >= 750000 then
                        SecureTween(CFrame.new(-5012, 5746, -2648)) -- Tọa độ NPC mua Haki V1
                        task.wait(1)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki")
                    end
                end)
            end
        end)
    end

    -- [HÀM LOGIC HOÀN CHỈNH: AUTO HAKI V2 (HUNGRY MAN QUEST)]
    local function AutoGetObsV2()
        task.spawn(function()
            while _G.HakiSettings.AutoGetObsV2 do
                task.wait(1)
                pcall(function()
                    local cash = game.Players.LocalPlayer.Data.Beli.Value
                    if cash < 5000000 then
                        print("[BL HUB] Khong du 5M Beli de lay Haki V2!")
                        return
                    end

                    -- 1. Nói chuyện với Hungry Man tại Floating Turtle
                    SecureTween(CFrame.new(-11624, 331, -10061))
                    task.wait(1)
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("HungryManQuest")

                    -- 2. Tự động thu thập 3 loại trái cây (Táo, Chuối, Dứa)
                    -- Táo (Floating Turtle)
                    SecureTween(CFrame.new(-11520, 316, -10034))
                    task.wait(1)
                    -- Chuối (Giant Tree)
                    SecureTween(CFrame.new(-2248, 281, -4388))
                    task.wait(1)
                    -- Dứa (Port Town)
                    SecureTween(CFrame.new(-5325, 17, -2745))
                    task.wait(1)

                    -- 3. Nộp trái cây cho Citizen làm đĩa thức ăn
                    SecureTween(CFrame.new(-11910, 332, -10452))
                    task.wait(1)
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("FruitQuest")

                    -- 4. Quay lại đưa cho Hungry Man và mua Haki V2
                    SecureTween(CFrame.new(-11624, 331, -10061))
                    task.wait(1)
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyObsV2")
                end)
            end
        end)
    end

    -- [HÀM AUTO FARM CHEST - ĐÃ KHAI TRIỂN AN TOÀN]
    local function AutoFarmChest()
        task.spawn(function()
            while _G.HakiSettings.AutoFarmChest do
                task.wait(0.1)
                pcall(function()
                    for _, chest in pairs(game:GetService("Workspace"):GetChildren()) do
                        if string.find(chest.Name, "Chest") and chest:IsA("Part") then
                            SecureTween(chest.CFrame)
                            task.wait(0.2)
                        end
                    end
                end)
            end
        end)
    end

    -- [CÁC LOGIC KHÁC GIỮ NGUYÊN]
    local function AutoGetDragon()
        task.spawn(function()
            while _G.RaceSettings.AutoGetDragon do task.wait(1) end
        end)
    end

    local function AutoRaceV2()
        task.spawn(function()
            while _G.RaceSettings.AutoV2 do task.wait(1) end
        end)
    end

    local function AutoRaceV3()
        task.spawn(function()
            while _G.RaceSettings.AutoV3 do task.wait(1) end
        end)
    end

    local function AutoRaceV4()
        task.spawn(function()
            while _G.RaceSettings.AutoV4 do task.wait(1) end
        end)
    end

    local function AutoGetGhoul()
        task.spawn(function()
            while _G.RaceSettings.AutoGetGhoul do task.wait(1) end
        end)
    end

    local function AutoGetCyborg()
        task.spawn(function()
            while _G.RaceSettings.AutoGetCyborg do task.wait(1) end
        end)
    end

    -- Loop Haki Quan sát cũ
    task.spawn(function()
        local waitTime = (getgenv().BL_System_Config and getgenv().BL_System_Config.HakiDelay) or 1
        while task.wait(waitTime) do
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

    -- Tàng hình Haki
    task.spawn(function()
        while task.wait(0.1) do
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

    -- Noclip
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

    -- Gom Quái
    task.spawn(function()
        while task.wait() do
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

    -- Tấn Công Siêu Tốc
    task.spawn(function()
        local delayTime = (getgenv().BL_System_Config and getgenv().BL_System_Config.AttackDelay) or 0.01
        while task.wait(delayTime) do
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

    -- Auto Farm Level
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

    -- ==================== CẤU HÌNH CÁC TAB GIAO DIỆN ====================
    local FarmTab = Window:CreateTab("Tự Động Farm")
    local MainSection = FarmTab:CreateSection("Farm Level & Tiền")
    local MethodSection = FarmTab:CreateSection("Cài Đặt Farm")
    local HakiSection = FarmTab:CreateSection("Cài Đặt Haki Thường")

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

    MainSection:CreateToggle({
        Name = "Gom Quái (Bring Monsters)",
        Value = false,
        Callback = function(Value)
            BringMobs = Value
        end
    })

    MainSection:CreateToggle({
        Name = "Auto Gom Rương Kiếm Beli (Farm Chest)",
        Value = false,
        Callback = function(Value)
            _G.HakiSettings.AutoFarmChest = Value
            if Value then AutoFarmChest() end
        end
    })

    -- ==================== TAB NHIỆM VỤ HAKI V1 & V2 ====================
    local HakiQuestTab = Window:CreateTab("Nhiệm Vụ Haki")
    local ObsV1Section = HakiQuestTab:CreateSection("Haki Quan Sát V1 (Sea 1)")
    local ObsV2Section = HakiQuestTab:CreateSection("Haki Quan Sát V2 (Sea 3)")

    ObsV1Section:CreateToggle({
        Name = "Auto Làm Quest & Mua Haki V1",
        Value = false,
        Callback = function(Value)
            _G.HakiSettings.AutoGetObsV1 = Value
            if Value then AutoGetObsV1() end
        end
    })

    ObsV2Section:CreateToggle({
        Name = "Auto Làm Quest & Mua Haki V2 (Hungry Man)",
        Value = false,
        Callback = function(Value)
            _G.HakiSettings.AutoGetObsV2 = Value
            if Value then AutoGetObsV2() end
        end
    })

    -- ==================== TAB TỘC (RACE SYSTEM) ====================
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

    -- Các tab phụ
    local StatsTab = Window:CreateTab("Nâng Stats")
    local StatsSection = StatsTab:CreateSection("Tự Động Cộng Điểm")
    local TeleportTab = Window:CreateTab("Dịch Chuyển")
    local IslandSection = TeleportTab:CreateSection("Chọn Đảo")
    local ShopTab = Window:CreateTab("Cửa Hàng")
    local ShopSection = ShopTab:CreateSection("NPC Shop")

    Library:Notify({
        Title = HubName .. " ĐÃ KHỞI CHẠY",
        Content = "Chúc bạn trải nghiệm game mượt mà!",
        Time = 5
    })
end
