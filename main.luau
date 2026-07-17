-- ========================================== BL HUB AUTO KEY LOADER (FILE: main.luau) ==========================================
local KeyLink = "https://fancy-cendol-0740a8.netlify.app/" 
local AdminKey = "BLHUB-ADMIN-VIP-VMD-1102" -- Key vĩnh viễn không bao giờ hết hạn của riêng bạn

-- Hàm tự động tính toán 4 mốc Key đồng bộ với hệ thống Web riêng lẻ
local function CheckValidKey(Input)
    local date = os.date("!*t") -- Lấy thời gian chuẩn UTC quốc tế
    local nowTime = os.time()    -- Lấy timestamp hiện tại tính bằng giây
    
    -- 1. Công thức tính toán mã số (đồng bộ 100% với các file html tương ứng trên Netlify)
    local code24 = (date.year * date.month * date.day) + 1102
    local code48 = math.floor(nowTime / (48 * 3600)) % 99999 + 2204
    local code72 = math.floor(nowTime / (72 * 3600)) % 99999 + 3306
    local code100 = math.floor(nowTime / (100 * 3600)) % 99999 + 4408

    -- 2. Tạo chuỗi Key hoàn chỉnh để đối chiếu
    local correct24 = "BLHUB-KEY24H-" .. tostring(code24)
    local correct48 = "BLHUB-KEY48H-" .. tostring(code48)
    local correct72 = "BLHUB-KEY72H-" .. tostring(code72)
    local correct100 = "BLHUB-KEY100H-" .. tostring(code100)
    
    -- 3. Kiểm tra mã nhập vào (Khớp 1 trong 4 gói hoặc khớp Admin Key là được qua)
    if Input == correct24 or Input == correct48 or Input == correct72 or Input == correct100 or Input == AdminKey then
        return true
    end
    return false
end

-- Hàm tải file hack game chính từ GitHub sau khi đã xác thực Key thành công
local function LoadMainScripts()
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/nguyenxuanthuy334-debug/MyRobloxScripts/main/Games/BloxFruits.luau"))()
    end)
    
    if not success then
        warn("Không thể tải file hack chính: " .. tostring(err))
    end
end

-- ========================================== PHẦN GIAO DIỆN XÁC THỰC KEY ==========================================
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
        setclipboard(KeyLink) -- Tự động copy link trang chủ điều hướng Netlify
        Library:Notify({
            Title = "Thông Báo",
            Content = "Đã copy link cổng lấy key! Hãy dán ra trình duyệt để chọn gói phù hợp.",
            Time = 5
        })
    end
})

KeySection:CreateButton({
    Name = "Xác Nhận (Submit Key)",
    Callback = function()
        if CheckValidKey(InputKey) then
            Library:Notify({
                Title = "Chính Xác!",
                Content = "Xác thực thành công! Đang tải menu hack...",
                Time = 3
            })
            task.wait(1)
            KeyWindow:Destroy() -- Tắt bảng nhập key
            LoadMainScripts()   -- Chạy file BloxFruits.luau
        else
            Library:Notify({
                Title = "Thất Bại!",
                Content = "Mã Key không đúng hoặc đã hết hạn! Vui lòng thử lại.",
                Time = 3
            })
        end
    end
})
