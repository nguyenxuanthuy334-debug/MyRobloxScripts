-- ========================================== BL HUB MANUAL KEY LOADER ==========================================
-- Link trang web Lootlabs hoặc trang đích của bạn (Người chơi bấm Get Key sẽ nhảy ra đây)
local KeyLink = "https://fancy-cendol-0740a8.netlify.app/" 

-- KHU VỰC ĐỔI KEY: Khi nào rảnh, bạn chỉ cần lên GitHub đổi chữ trong ngoặc kép này thành key mới là xong!
local CurrentKey = "BLHUB-FREE-KEY-1707" 
local AdminKey = "BLHUB-ADMIN-VIP-VMD-1102" -- Key vĩnh viễn của riêng bạn

-- Hàm tải file hack game chính sau khi người dùng nhập đúng Key
local function LoadMainScripts()
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/nguyenxuanthuy334-debug/MyRobloxScripts/main/Games/BloxFruits.luau"))()
    end)
    if not success then
        warn("Không thể tải file hack chính: " .. tostring(err))
    end
end

-- ========================================== GIAO DIỆN NHẬP KEY ==========================================
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/mstudio45/BracketV2/main/library.lua"))()
local KeyWindow = Library:CreateWindow({
    Name = "BL HUB - Xác Thực Hệ Thống",
    MinSize = Vector2.new(300, 200),
    ToggleKey = Enum.KeyCode.RightControl,
    CanDoubleToggle = false
})

local KeyTab = KeyWindow:CreateTab("Hệ Thống Key")
local KeySection = KeyTab:CreateSection("Nhập Key Để Tiếp Tục")

local InputKey = ""

KeySection:CreateTextBox({
    Name = "Nhập mã Key tại đây:",
    Placeholder = "Dán Key của bạn vào...",
    Callback = function(val)
        InputKey = val
    end
})

KeySection:CreateButton({
    Name = "Lấy Key (Get Key)",
    Callback = function()
        setclipboard(KeyLink) -- Tự động copy link trang web của bạn
        Library:Notify({
            Title = "Thông Báo",
            Content = "Đã copy link cổng lấy key! Hãy dán ra trình duyệt để vượt link.",
            Time = 5
        })
    end
})

KeySection:CreateButton({
    Name = "Xác Nhận (Submit Key)",
    Callback = function()
        -- Nếu người dùng nhập trúng CurrentKey hoặc AdminKey thì cho qua
        if InputKey == CurrentKey or InputKey == AdminKey then
            Library:Notify({
                Title = "Chính Xác!",
                Content = "Xác thực thành công! Đang tải menu hack...",
                Time = 3
            })
            task.wait(1)
            KeyWindow:Destroy()
            LoadMainScripts() -- Chạy file BloxFruits.luau
        else
            Library:Notify({
                Title = "Thất Bại!",
                Content = "Mã Key không đúng hoặc đã hết hạn! Vui lòng thử lại.",
                Time = 3
            })
        end
    end
})
