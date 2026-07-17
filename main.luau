-- ========================================== BL HUB MANUAL KEY LOADER (GỘP) ==========================================
-- Link rút gọn Link4M của bạn (Người chơi bấm Get Key sẽ nhảy ra link này)
local KeyLink = "https://link4m.net/igX5X" 

-- KHU VỰC ĐỔI KEY: Khi nào rảnh, bạn chỉ cần lên GitHub đổi chữ trong ngoặc kép này thành key mới là xong!
local CurrentKey = "BLHUB-FREE-KEY-1707" 
local AdminKey = "BLHUB-ADMIN-VIP-VMD-1102" -- Key vĩnh viễn của riêng bạn

-- ========================================== HÀM CHẠY MENU HACK CHÍNH ==========================================
-- Khi nhập đúng Key, hàm này sẽ được gọi để kích hoạt menu hack Blox Fruits trực tiếp mà không cần tải file phụ
local function LoadMainScripts()
    print("BL HUB: Đã xác thực thành công và kích hoạt code game!")

    -- Giao diện hack chính sử dụng thư viện Fluent
    local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
    local Window = Fluent:CreateWindow({
        Title = "★ BL HUB - Blox Fruits Ultimate ★",
        SubTitle = "bởi Admin",
        TabWidth = 160,
        Size = Vector2.new(580, 460),
        Acrylic = true,
        Theme = "Dark"
    })

    local Tabs = {
        Main = Window:AddTab({ Title = "Tự Động Farm", Icon = "home" })
    }

    Tabs.Main:AddToggle("AutoFarmToggle", {Title = "Tự Động Farm Quái (Auto Farm)", Default = false})

    Fluent:Notify({
        Title = "BL HUB",
        Content = "Menu hack Blox Fruits đã được khởi chạy thành công!",
        Duration = 5
    })
end

-- ========================================== GIAO DIỆN XÁC THỰC NHẬP KEY ==========================================
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
        setclipboard(KeyLink) -- Tự động copy link rút gọn Link4M của bạn
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
            LoadMainScripts() -- Chạy trực tiếp menu hack ở phía trên
        else
            Library:Notify({
                Title = "Thất Bại!",
                Content = "Mã Key không đúng hoặc đã hết hạn! Vui lòng thử lại.",
                Time = 3
            })
        end
    end
})
