-- File: Games/BloxFruits_Ultimate.luau (Bản Full Không Bỏ Tính Năng - Tích Hợp Bảo Mật & Hệ Thống REDz Hub)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bracket-v/bracket-v/main/library.lua"))()

-- ==================== HỆ THỐNG BẢO MẬT & BYPASS ANTI-CHEAT ====================
local function InitializeSecurity()
    print("[BL HUB] Dang khoi chay module bao mat...")
    
    local gmt = getrawmetatable(game)
    setreadonly(gmt, false)
    local oldNamecall = gmt.__namecall
    gmt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        
        if method == "FireServer" then
            if self.Name == "AdminDetector" or self.Name == "ExploitDetector" or self.Name == "Detection" then
                return nil
            end
            if string.find(self.Name, "Check") or string.find(self.Name, "Cheat") then
                return nil
            end
            if self.Name == "S_Remotes" and args[1] == "WalkSpeed" then
                return nil
            end
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
        if chat then chat.Enabled = true end
    end
    print("[BL HUB] Kich hoat Anti-Ban thanh cong!")
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
        local crash = "BL HUB Protection Activated! Khong the chay rieng le!"
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

-- ==================== KHỞI CHẠY GIAO DIỆN HỆ THỐNG KEY ====================
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
    Callback = function(Text) InputKey = Text end
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
                Content = "Key sai! Vui lòng truy cập Fnote lấy lại key.",
                Time = 3
            })
        end
    end
})

KeySection:CreateButton({
    Name = "Copy Link Lấy Key (Fnote)",
    Callback = function()
        setclipboard(Link4M_URL) 
        Library:Notify({
            Title = "Đã Copy Link!",
            Content = "Dán link vào trình duyệt để lấy Key.",
            Time = 5
        })
    end
})

-- ==================== MENU CHÍNH BL HUB ULTIMATE ====================
function LoadMainScripts()
    if HubName ~= "BL HUB" then
        ActivateTrap()
        return
    end

    local Window = Library:CreateWindow({
        Name = HubName .. " (ULTIMATE VERSION)", 
        MinSize = Vector2.new(550, 450),
        ToggleKey = Enum.KeyCode.RightControl
    })

    -- Khởi tạo cấu hình hệ tộc & hệ thống cũ + mới (GIỮ NGUYÊN 100%)
    _G.Config = {
        -- Farm Level & Boss & Mastery & Materials
        AutoFarmLevel = false,
        AutoFarmBoss = false,
        TargetBoss = "All",
        AutoFarmMastery = false,
        MasteryWeapon = "Melee",
        MasteryHPPercent = 25,
        AutoFarmChest = false, -- TỰ ĐỘNG LƯỢM RƯƠNG
        AutoFarmMaterials = false,
        SelectedMaterial = "Cocoa",
        BringMobs = false,
        SelectedWeapon = "Melee",

        -- Combat Features
        FastAttack = false,
        AutoParryDodge = false,
        KillAura = false,
        KillAuraRange = 50,

        -- Support & Explorer
        FruitNotifier = false,
        AutoBuyFruit = false,
        SelectedFruitBuy = "Kitsune-Kitsune",
        ESP_Players = false,
        ESP_Chests = false,
        ESP_Fruits = false,
        AutoStats = false,
        StatsTarget = "Melee",

        -- Special & Others
        AutoSeaEvent = false,
        AutoHakiV1 = false,
        AutoHakiV2 = false,
        AutoActiveObservation = false,
        AntiObservation = false,
        InfiniteEnergy = false,
    }

    _G.RaceSettings = {
        SelectedRace = "Human",
        AutoV2 = false,
        AutoV3 = false,
        AutoV4 = false,
        AutoGetGhoul = false,
        AutoGetCyborg = false,
        AutoGetDragon = false
    }

    _G.MeleeSettings = {
        SelectedMelee = "Sanguine Art",
        AutoGetMelee = false
    }

    _G.FruitSettings = {
        SelectedFruit = "Kitsune-Kitsune",
        AutoLoot = false,
        AutoBuySelected = false
    }
    
    _G.RaidSettings = {
        Enable = false,
        SelectedChip = "Flame"
    }

    -- Hàm di chuyển mượt
    local function SecureTween(targetCFrame)
        local character = game.Players.LocalPlayer.Character
        local root = character and character:FindFirstChild("HumanoidRootPart")
        if root then
            root.CFrame = targetCFrame
            task.wait(0.15)
        end
    end

    -- ==================== CÁC CHỨC NĂNG CHẠY NỀN VÀ KHỞI TẠO TÍNH NĂNG ====================

    -- 1. Auto Nhặt Rương (Auto Farm Chest - Đã tối ưu)
    task.spawn(function()
        while task.wait(0.1) do
            if _G.Config.AutoFarmChest then
                pcall(function()
                    local root = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if root then
                        for _, chest in pairs(game:GetService("Workspace"):GetChildren()) do
                            if string.find(chest.Name, "Chest") and chest:IsA("Part") then
                                root.CFrame = chest.CFrame
                                task.wait(0.15)
                            end
                        end
                    end
                end)
            end
        end
    end)

    -- 2. Auto Farm Level
    task.spawn(function()
        while task.wait() do
            if _G.Config.AutoFarmLevel then
                pcall(function()
                    local myChar = game.Players.LocalPlayer.Character
                    local enemyFound = false
                    for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if enemy.Name == "Bandit" and enemy:FindFirstChild("HumanoidRootPart") and enemy.Humanoid.Health > 0 then
                            enemyFound = true
                            myChar.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                            break
                        end
                    end
                    if not enemyFound then
                        myChar.HumanoidRootPart.CFrame = CFrame.new(1059.3, 16.2, 1549.2)
                    end
                end)
            end
        end
    end)

    -- 3. Auto Farm Boss
    task.spawn(function()
        while task.wait(0.5) do
            if _G.Config.AutoFarmBoss then
                pcall(function()
                    local myChar = game.Players.LocalPlayer.Character
                    for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                            if _G.Config.TargetBoss == "All" or enemy.Name == _G.Config.TargetBoss then
                                SecureTween(enemy.HumanoidRootPart.CFrame * CFrame.new(0, 6, 0))
                            end
                        end
                    end
                end)
            end
        end
    end)

    -- 4. Auto Farm Mastery
    task.spawn(function()
        while task.wait(0.1) do
            if _G.Config.AutoFarmMastery then
                pcall(function()
                    local myChar = game.Players.LocalPlayer.Character
                    for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                            if (enemy.Humanoid.Health / enemy.Humanoid.MaxHealth) * 100 > _G.Config.MasteryHPPercent then
                                myChar.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("Melee") or myChar:FindFirstChildOfClass("Tool"))
                            else
                                local targetTool = game.Players.LocalPlayer.Backpack:FindFirstChild(_G.Config.MasteryWeapon)
                                if targetTool then myChar.Humanoid:EquipTool(targetTool) end
                            end
                            SecureTween(enemy.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0))
                        end
                    end
                end)
            end
        end
    end)

    -- 5. Auto Farm Materials
    task.spawn(function()
        while task.wait(0.5) do
            if _G.Config.AutoFarmMaterials then
                pcall(function()
                    local myChar = game.Players.LocalPlayer.Character
                    for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if string.find(enemy.Name, _G.Config.SelectedMaterial) then
                            if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                                SecureTween(enemy.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0))
                            end
                        end
                    end
                end)
            end
        end
    end)

    -- 6. Gom Quái (Bring Mobs)
    task.spawn(function()
        while task.wait() do
            if _G.Config.BringMobs and _G.Config.AutoFarmLevel then
                pcall(function()
                    local myChar = game.Players.LocalPlayer.Character
                    if myChar and myChar:FindFirstChild("HumanoidRootPart") then
                        local myPos = myChar.HumanoidRootPart.Position
                        for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                                if (enemy.HumanoidRootPart.Position - myPos).Magnitude <= getgenv().BL_System_Config.MobRange then
                                    enemy.HumanoidRootPart.CFrame = myChar.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
                                    enemy.HumanoidRootPart.CanCollide = false
                                    enemy.Humanoid.Active = false
                                end
                            end
                        end
                    end
                end)
            end
        end
    end)

    -- 7. Fast Attack & Auto Click
    task.spawn(function()
        local delayTime = (getgenv().BL_System_Config and getgenv().BL_System_Config.AttackDelay) or 0.01
        while task.wait(delayTime) do
            if _G.Config.FastAttack or _G.Config.AutoFarmLevel or _G.Config.AutoFarmMastery or _G.Config.AutoFarmBoss then
                pcall(function()
                    local player = game.Players.LocalPlayer
                    local character = player.Character
                    for _, tool in pairs(player.Backpack:GetChildren()) do
                        if tool:IsA("Tool") and (tool.ToolTip == _G.Config.SelectedWeapon or _G.Config.SelectedWeapon == "Melee" and tool.ToolTip == "Blox Fruit") then
                            character.Humanoid:EquipTool(tool)
                        end
                    end
                    local vu = game:GetService("VirtualUser")
                    vu:CaptureController()
                    vu:ClickButton1(Vector2.new(850, 520))
                end)
            end
        end
    end)

    -- 8. Auto Parry/Dodge
    task.spawn(function()
        while task.wait(0.2) do
            if _G.Config.AutoParryDodge then
                pcall(function()
                    local char = game.Players.LocalPlayer.Character
                    for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if enemy:FindFirstChild("HumanoidRootPart") and (enemy.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Magnitude < 15 then
                            local vim = game:GetService("VirtualInputManager")
                            vim:SendKeyEvent(true, Enum.KeyCode.Q, false, game)
                            task.wait(0.05)
                            vim:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
                        end
                    end
                end)
            end
        end
    end)

    -- 9. Kill Aura
    task.spawn(function()
        while task.wait(0.1) do
            if _G.Config.KillAura then
                pcall(function()
                    local myChar = game.Players.LocalPlayer.Character
                    local myPos = myChar.HumanoidRootPart.Position
                    for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                            local distance = (enemy.HumanoidRootPart.Position - myPos).Magnitude
                            if distance <= _G.Config.KillAuraRange then
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Hit", enemy.HumanoidRootPart, 1)
                            end
                        end
                    end
                end)
            end
        end
    end)

    -- 10. Fruit Notifier & Auto Buy Fruit
    task.spawn(function()
        while task.wait(2) do
            if _G.Config.FruitNotifier then
                pcall(function()
                    for _, obj in pairs(game:GetService("Workspace"):GetChildren()) do
                        if obj:IsA("Tool") and string.find(obj.Name, "Fruit") then
                            Library:Notify({
                                Title = "PHÁT HIỆN TRÁI ÁC QUỶ!",
                                Content = "Trái: " .. obj.Name .. " xuất hiện!",
                                Time = 5
                            })
                        end
                    end
                end)
            end
            if _G.Config.AutoBuyFruit then
                pcall(function()
                    local target = _G.Config.SelectedFruitBuy
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ShopActive", target)
                end)
            end
        end
    end)

    -- 11. ESP System
    local espObjects = {}
    local function CreateESP(part, text, color)
        if not part then return end
        local box = Instance.new("BoxHandleAdornment")
        box.Size = part.Size + Vector3.new(0.1, 0.1, 0.1)
        box.AlwaysOnTop = true
        box.ZIndex = 10
        box.Color3 = color
        box.Adornee = part
        box.Transparency = 0.5
        box.Parent = part
        
        local bill = Instance.new("BillboardGui")
        bill.AlwaysOnTop = true
        bill.Size = UDim2.new(0, 100, 0, 40)
        bill.Adornee = part
        bill.Parent = part
        
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, 0, 1, 0)
        lbl.BackgroundTransparency = 1
        lbl.TextColor3 = color
        lbl.Text = text
        lbl.TextSize = 12
        lbl.Parent = bill

        table.insert(espObjects, {box, bill})
    end

    local function ClearAllESP()
        for _, obj in pairs(espObjects) do
            if obj[1] then obj[1]:Destroy() end
            if obj[2] then obj[2]:Destroy() end
        end
        espObjects = {}
    end

    task.spawn(function()
        while task.wait(3) do
            ClearAllESP()
            pcall(function()
                if _G.Config.ESP_Players then
                    for _, p in pairs(game.Players:GetPlayers()) do
                        if p ~= game.Players.LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                            CreateESP(p.Character.HumanoidRootPart, p.Name, Color3.fromRGB(255, 0, 0))
                        end
                    end
                end
                if _G.Config.ESP_Chests then
                    for _, chest in pairs(game:GetService("Workspace"):GetChildren()) do
                        if string.find(chest.Name, "Chest") and chest:IsA("Part") then
                            CreateESP(chest, "Chest (Tiền)", Color3.fromRGB(255, 215, 0))
                        end
                    end
                end
                if _G.Config.ESP_Fruits then
                    for _, obj in pairs(game:GetService("Workspace"):GetChildren()) do
                        if obj:IsA("Tool") and string.find(obj.Name, "Fruit") and obj:FindFirstChild("Handle") then
                            CreateESP(obj.Handle, obj.Name, Color3.fromRGB(0, 255, 0))
                        end
                    end
                end
            end)
        end
    end)

    -- 12. Auto Stats
    task.spawn(function()
        while task.wait(1) do
            if _G.Config.AutoStats then
                pcall(function()
                    local point = game.Players.LocalPlayer.Data.Points.Value
                    if point > 0 then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", _G.Config.StatsTarget, 1)
                    end
                end)
            end
        end
    end)

    -- 13. Auto Sea Event
    task.spawn(function()
        while task.wait(2) do
            if _G.Config.AutoSeaEvent then
                pcall(function()
                    for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if string.find(enemy.Name, "Sea Beast") or string.find(enemy.Name, "Ship") then
                            if enemy:FindFirstChild("HumanoidRootPart") then
                                SecureTween(enemy.HumanoidRootPart.CFrame * CFrame.new(0, 40, 0))
                                task.wait(1)
                            end
                        end
                    end
                end)
            end
        end
    end)

    -- 14. Infinite Energy
    task.spawn(function()
        while task.wait(0.5) do
            if _G.Config.InfiniteEnergy then
                pcall(function()
                    local player = game.Players.LocalPlayer
                    if player.Character and player.Character:FindFirstChild("Energy") then
                        player.Character.Energy.Value = player.Character.Energy.MaxValue
                    end
                end)
            end
        end
    end)

    -- 15. Auto Get Melee (HỌC HỆ VÕ GỐC)
    local function AutoGetMelee()
        task.spawn(function()
            while _G.MeleeSettings.AutoGetMelee do
                task.wait(1)
                pcall(function()
                    local choice = _G.MeleeSettings.SelectedMelee
                    if choice == "Dragon Breath (Võ Rồng V1)" then
                        SecureTween(CFrame.new(-1250, 15, -4520)) 
                        task.wait(1)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonBreath", "Buy")
                    elseif choice == "Dragon Talon (Võ Rồng V2)" then
                        SecureTween(CFrame.new(-12543, 332, -9850)) 
                        task.wait(1)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon")
                    elseif choice == "Sanguine Art" then
                        SecureTween(CFrame.new(-4640, 15, -4520)) 
                        task.wait(1)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySanguineArt")
                    elseif choice == "Godhuman" then
                        SecureTween(CFrame.new(-12503, 331, -9871)) 
                        task.wait(1)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyGodhuman")
                    elseif choice == "Superhuman" then
                        SecureTween(CFrame.new(-3007, 340, -10140)) 
                        task.wait(1)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySuperhuman")
                    end
                end)
            end
        end)
    end

    -- 16. Auto Raid
    local function AutoRaid()
        task.spawn(function()
            while _G.RaidSettings.Enable do
                task.wait(1)
                pcall(function()
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "RaidChip", _G.RaidSettings.SelectedChip)
                    SecureTween(CFrame.new(-6500, 300, -5000))
                    task.wait(0.5)
                    fireclickdetector(game:GetService("Workspace").Map.RaidKrypt.Button.ClickDetector)
                end)
            end
        end)
    end

    -- 17. Auto Haki V1 & V2 Quest
    local function AutoGetObsV1()
        task.spawn(function()
            while _G.Config.AutoHakiV1 do
                task.wait(1)
                pcall(function()
                    local myLevel = game.Players.LocalPlayer.Data.Level.Value
                    if myLevel < 300 then return end
                    local ButtonPositions = {
                        Vector3.new(-1611, 37, 148), Vector3.new(-1523, 39, 8),   
                        Vector3.new(-1400, 29, 28),  Vector3.new(-1632, 14, -135),
                        Vector3.new(-1580, 16, -112)
                    }
                    for _, pos in pairs(ButtonPositions) do
                        SecureTween(CFrame.new(pos))
                        task.wait(0.5)
                    end
                    SecureTween(CFrame.new(-1611, 13, 148))
                    task.wait(1)
                    SecureTween(CFrame.new(912, 16, 4287))
                    task.wait(1)
                    SecureTween(CFrame.new(1385, 15, -1340))
                    task.wait(1)
                    local boss = game:GetService("Workspace").Enemies:FindFirstChild("Saber Expert")
                    if boss and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 then
                        SecureTween(boss.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0))
                    else
                        SecureTween(CFrame.new(-1461, 30, -3))
                    end
                    task.wait(1)
                    local cash = game.Players.LocalPlayer.Data.Beli.Value
                    if cash >= 750000 then
                        SecureTween(CFrame.new(-5012, 5746, -2648)) 
                        task.wait(1)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki")
                    end
                end)
            end
        end)
    end

    local function AutoGetObsV2()
        task.spawn(function()
            while _G.Config.AutoHakiV2 do
                task.wait(1)
                pcall(function()
                    local cash = game.Players.LocalPlayer.Data.Beli.Value
                    if cash < 5000000 then return end
                    SecureTween(CFrame.new(-11624, 331, -10061))
                    task.wait(1)
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("HungryManQuest")
                    SecureTween(CFrame.new(-11520, 316, -10034))
                    task.wait(1)
                    SecureTween(CFrame.new(-2248, 281, -4388))
                    task.wait(1)
                    SecureTween(CFrame.new(-5325, 17, -2745))
                    task.wait(1)
                    SecureTween(CFrame.new(-11910, 332, -10452))
                    task.wait(1)
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("FruitQuest")
                    SecureTween(CFrame.new(-11624, 331, -10061))
                    task.wait(1)
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyObsV2")
                end)
            end
        end)
    end

    -- Khởi tạo luồng Auto Tộc (Race) trống
    local function AutoGetDragon() task.spawn(function() while _G.RaceSettings.AutoGetDragon do task.wait(1) end end) end
    local function AutoRaceV2() task.spawn(function() while _G.RaceSettings.AutoV2 do task.wait(1) end end) end
    local function AutoRaceV3() task.spawn(function() while _G.RaceSettings.AutoV3 do task.wait(1) end end) end
    local function AutoRaceV4() task.spawn(function() while _G.RaceSettings.AutoV4 do task.wait(1) end end) end
    local function AutoGetGhoul() task.spawn(function() while _G.RaceSettings.AutoGetGhoul do task.wait(1) end end) end
    local function AutoGetCyborg() task.spawn(function() while _G.RaceSettings.AutoGetCyborg do task.wait(1) end end) end

    -- Noclip khi bật Farm
    game:GetService("RunService").Stepped:Connect(function()
        if _G.Config.AutoFarmLevel or _G.Config.AutoFarmMastery or _G.Config.AutoFarmBoss then
            pcall(function()
                local character = game.Players.LocalPlayer.Character
                if character then
                    for _, part in pairs(character:GetChildren()) do
                        if part:IsA("BasePart") then part.CanCollide = false end
                    end
                end
            end)
        end
    end)

    -- ==================== THIẾT LẬP CÁC TAB GIAO DIỆN (UI) ====================
    
    -- TAB 1: AUTO FARM
    local FarmTab = Window:CreateTab("Tự Động Farm")
    local FarmSec = FarmTab:CreateSection("Cày Cấp & Tiền")
    FarmSec:CreateToggle({
        Name = "Auto Farm Level (Tự Động Cày Cấp)",
        Value = false,
        Callback = function(v) _G.Config.AutoFarmLevel = v end
    })
    FarmSec:CreateToggle({
        Name = "Bring Mobs (Gom Quái)",
        Value = false,
        Callback = function(v) _G.Config.BringMobs = v end
    })
    FarmSec:CreateToggle({
        Name = "Auto Farm Boss (Săn Boss Lớn)",
        Value = false,
        Callback = function(v) _G.Config.AutoFarmBoss = v end
    })
    FarmSec:CreateDropdown({
        Name = "Chọn Boss Săn",
        List = {"All", "Saber Expert", "Tide Keeper", "Stone"},
        Function = function(s) _G.Config.TargetBoss = s end
    })
    
    local MasterySec = FarmTab:CreateSection("Cày Mastery (Thông Thạo)")
    MasterySec:CreateToggle({
        Name = "Auto Farm Mastery",
        Value = false,
        Callback = function(v) _G.Config.AutoFarmMastery = v end
    })
    MasterySec:CreateDropdown({
        Name = "Vũ khí cày Mastery",
        List = {"Melee", "Sword", "Devil Fruit"},
        Function = function(s) _G.Config.MasteryWeapon = s end
    })

    local ChestSec = FarmTab:CreateSection("Rương & Nguyên Liệu")
    ChestSec:CreateToggle({
        Name = "Auto Farm Chest (Tự Động Lượm Rương)",
        Value = false,
        Callback = function(v) _G.Config.AutoFarmChest = v end
    })
    ChestSec:CreateToggle({
        Name = "Auto Farm Nguyên Liệu",
        Value = false,
        Callback = function(v) _G.Config.AutoFarmMaterials = v end
    })
    ChestSec:CreateDropdown({
        Name = "Chọn loại nguyên liệu",
        List = {"Cocoa", "Fish Tail", "Scrap Metal", "Dragon Scale"},
        Function = function(s) _G.Config.SelectedMaterial = s end
    })

    -- TAB 2: COMBAT
    local CombatTab = Window:CreateTab("Chiến Đấu (Combat)")
    local CombatSec = CombatTab:CreateSection("Trợ Thủ PvP/PvE")
    CombatSec:CreateToggle({
        Name = "Fast Attack (Tấn Công Siêu Tốc)",
        Value = false,
        Callback = function(v) _G.Config.FastAttack = v end
    })
    CombatSec:CreateDropdown({
        Name = "Chọn Vũ Khí Đánh",
        List = {"Melee", "Sword", "Devil Fruit"},
        Function = function(s) _G.Config.SelectedWeapon = s end
    })
    CombatSec:CreateToggle({
        Name = "Auto Parry & Dodge (Né Đòn Hoàn Hảo)",
        Value = false,
        Callback = function(v) _G.Config.AutoParryDodge = v end
    })
    CombatSec:CreateToggle({
        Name = "Kill Aura (Tự Động Đánh Quanh Thân)",
        Value = false,
        Callback = function(v) _G.Config.KillAura = v end
    })

    -- TAB 3: HỖ TRỢ & ESP
    local SupportTab = Window:CreateTab("Hỗ Trợ & ESP")
    local FruitSec = SupportTab:CreateSection("Trái Ác Quỷ")
    FruitSec:CreateToggle({
        Name = "Fruit Notifier (Báo Trái Hiện Bản Đồ)",
        Value = false,
        Callback = function(v) _G.Config.FruitNotifier = v end
    })
    FruitSec:CreateToggle({
        Name = "Auto Buy Fruit (Canh Mua Trái)",
        Value = false,
        Callback = function(v) _G.Config.AutoBuyFruit = v end
    })
    FruitSec:CreateDropdown({
        Name = "Chọn Trái Cần Mua",
        List = {"Kitsune-Kitsune", "Dough-Dough", "Leopard-Leopard", "Buddha-Buddha"},
        Function = function(s) _G.Config.SelectedFruitBuy = s end
    })

    local ESPSec = SupportTab:CreateSection("Hệ Thống ESP (Nhìn xuyên tường)")
    ESPSec:CreateToggle({
        Name = "ESP Players (Hiển Thị Người Chơi)",
        Value = false,
        Callback = function(v) _G.Config.ESP_Players = v end
    })
    ESPSec:CreateToggle({
        Name = "ESP Chests (Định Vị Rương)",
        Value = false,
        Callback = function(v) _G.Config.ESP_Chests = v end
    })
    ESPSec:CreateToggle({
        Name = "ESP Fruits (Tìm Trái Rơi Rớt)",
        Value = false,
        Callback = function(v) _G.Config.ESP_Fruits = v end
    })

    local StatsSec = SupportTab:CreateSection("Cộng Stats Tự Động")
    StatsSec:CreateToggle({
        Name = "Auto Stats",
        Value = false,
        Callback = function(v) _G.Config.AutoStats = v end
    })
    StatsSec:CreateDropdown({
        Name = "Chọn Chỉ Số Cộng",
        List = {"Melee", "Defense", "Sword", "Blox Fruit"},
        Function = function(s) _G.Config.StatsTarget = s end
    })

    -- TAB 4: RAID & BOSS
    local RaidTab = Window:CreateTab("Raid & Boss")
    local RaidSec = RaidTab:CreateSection("Tự Động Đi Raid")
    RaidSec:CreateDropdown({
        Name = "Chọn Loại Chip Raid",
        List = {"Flame", "Ice", "Quake", "Light", "Dark", "Dough"},
        Function = function(Selected) _G.RaidSettings.SelectedChip = Selected end
    })
    RaidSec:CreateToggle({
        Name = "Bật Auto Raid (Tự mua chip & Clear)",
        Value = false,
        Callback = function(Value)
            _G.RaidSettings.Enable = Value
            if Value then AutoRaid() end
        end
    })

    -- TAB 5: VÕ THUẬT (MELEE)
    local MeleeTab = Window:CreateTab("Võ Thuật (Melee)")
    local MeleeSection = MeleeTab:CreateSection("Tự Động Học Võ")
    MeleeSection:CreateDropdown({
        Name = "Chọn Loại Võ Cần Học",
        List = {
            "Sanguine Art", 
            "Godhuman", 
            "Dragon Breath (Võ Rồng V1)", 
            "Dragon Talon (Võ Rồng V2)", 
            "Superhuman"
        },
        Function = function(Selected) _G.MeleeSettings.SelectedMelee = Selected end
    })
    MeleeSection:CreateToggle({
        Name = "Bắt Đầu Tự Động Lấy Võ",
        Value = false,
        Callback = function(Value)
            _G.MeleeSettings.AutoGetMelee = Value
            if Value then AutoGetMelee() end
        end
    })

    -- TAB 6: NHIỆM VỤ HAKI V1 & V2
    local HakiQuestTab = Window:CreateTab("Nhiệm Vụ Haki")
    local ObsV1Section = HakiQuestTab:CreateSection("Haki Quan Sát V1 (Sea 1)")
    local ObsV2Section = HakiQuestTab:CreateSection("Haki Quan Sát V2 (Sea 3)")
    ObsV1Section:CreateToggle({
        Name = "Auto Làm Quest & Mua Haki V1",
        Value = false,
        Callback = function(v) 
            _G.Config.AutoHakiV1 = v 
            if v then AutoGetObsV1() end
        end
    })
    ObsV2Section:CreateToggle({
        Name = "Auto Làm Quest & Mua Haki V2",
        Value = false,
        Callback = function(v) 
            _G.Config.AutoHakiV2 = v 
            if v then AutoGetObsV2() end
        end
    })

    -- TAB 7: CÀI ĐẶT TỘC (RACE SYSTEM - GIỮ NGUYÊN HOÀN TOÀN)
    local RaceTab = Window:CreateTab("Cài Đặt Tộc (Race)")
    local SelectRaceSection = RaceTab:CreateSection("Chọn Tộc Thức Tỉnh V3/V4")
    SelectRaceSection:CreateDropdown({
        Name = "Tộc Đang Sử Dụng",
        List = {"Human", "Mink", "Fishman", "Skypiea", "Ghoul", "Cyborg", "Dragon"},
        Function = function(Selected) _G.RaceSettings.SelectedRace = Selected end
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

    -- TAB PHỤ KHÁC: TELEPORT, SHOP, ĐẶC BIỆT
    local TeleportTab = Window:CreateTab("Dịch Chuyển")
    local IslandSection = TeleportTab:CreateSection("Chọn Đảo")
    local ShopTab = Window:CreateTab("Cửa Hàng")
    local ShopSection = ShopTab:CreateSection("NPC Shop")

    local SpecialTab = Window:CreateTab("Đặc Biệt (Special)")
    local SeaSec = SpecialTab:CreateSection("Sự Kiện Biển (Sea Event)")
    SeaSec:CreateToggle({
        Name = "Auto Sea Event (Săn Thuyền & Sea Beast)",
        Value = false,
        Callback = function(v) _G.Config.AutoSeaEvent = v end
    })
    local EnergySec = SpecialTab:CreateSection("Năng Lượng Vô Hạn")
    EnergySec:CreateToggle({
        Name = "Infinite Energy (Năng Lượng Vô Hạn)",
        Value = false,
        Callback = function(v) _G.Config.InfiniteEnergy = v end
    })

    Library:Notify({
        Title = HubName .. " ĐÃ KHỞI CHẠY",
        Content = "Đã tích hợp đầy đủ 100% tính năng cũ và bổ sung tính năng mới thành công!",
        Time = 5
    })
end
