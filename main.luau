-- ========================================== BL HUB MANUAL KEY LOADER ==========================================
-- Link rút gọn Link4M của bạn
local KeyLink = "https://link4m.net/igX5X" 

-- KHU VỰC ĐỔI KEY: Khi nào rảnh, bạn đổi mã trong ngoặc kép này để cập nhật key mới
local CurrentKey = "BLHUB-FREE-KEY-1707" 
local AdminKey = "BLHUB-ADMIN-VIP-VMD-1102" 

-- Hàm tải file hack game chính (ĐÃ ĐƯỜNG DẪN VÀO THƯ MỤC Games/ ĐÚNG NHƯ ẢNH CỦA BẠN)
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
        setclipboard(KeyLink) -- Tự động copy link Link4M của bạn
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
        if InputKey == CurrentKey or InputKey == AdminKey then
            Library:Notify({
                Title = "Chính Xác!",
                Content = "Xác thực thành công! Đang tải menu hack...",
                Time = 3
            })
            task.wait(1)
            KeyWindow:Destroy()
            LoadMainScripts() -- Kích hoạt tải file BloxFruits.luau trong thư mục Games
        else
            Library:Notify({
                Title = "Thất Bại!",
                Content = "Mã Key không đúng hoặc đã hết hạn! Vui lòng thử lại.",
                Time = 3
            })
        end
    end
})
