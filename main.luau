-- ==================== BL HUB PREMIUM LOADER ====================
local KeyLink = "https://fancy-cendol-0740a8.netlify.app/"
local SecuritySalt = 5839 

-- Hàm kiểm tra tính hợp lệ của Key
local function VerifyKey(userKey)
    local prefix, duration, rawExpiry, hash = string.match(userKey, "^([^-]+)-([^-]+)-([^-]+)-([^-]+)$")
    if not prefix or prefix ~= "BLHUB" then 
        return false, "Mã Key sai định dạng!", nil 
    end
    
    local expiryTime = tonumber(rawExpiry)
    local keyHash = tonumber(hash)
    if not expiryTime or not keyHash then 
        return false, "Mã Key không hợp lệ!", nil 
    end
    
    -- Kiểm tra Hash chống sửa đổi thời gian
    local expectedHash = (expiryTime % 9999) + SecuritySalt
    if keyHash ~= expectedHash then 
        return false, "Phát hiện Key lậu (Fake Hash)!", nil 
    end
    
    -- Kiểm tra hạn dùng
    if os.time() > expiryTime then 
        return false, "Key này đã hết hạn sử dụng!", nil 
    end
    
    local timeLeft = expiryTime - os.time()
    local hoursLeft = math.floor(timeLeft / 3600)
    return true, string.format("Key hợp lệ! Gói: %s (%d Giờ)", duration, hoursLeft), duration
end

-- ==================== THIẾT KẾ GIAO DIỆN CHUYÊN NGHIỆP ====================
local TweenService = game:GetService("TweenService")
local KeyUI = Instance.new("ScreenGui", game.CoreGui)
KeyUI.Name = "BL_HUB_Loader"

-- Khung chính
local MainFrame = Instance.new("Frame", KeyUI)
MainFrame.Size = UDim2.new(0, 360, 0, 220)
MainFrame.Position = UDim2.new(0.5, -180, 0.5, -110)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

local Corner = Instance.new("UICorner", MainFrame)
Corner.CornerRadius = UDim.new(0, 10)

-- Tiêu đề Hub
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0.2, 0)
Title.Text = "★ BL HUB PREMIUM ★"
Title.TextColor3 = Color3.fromRGB(0, 255, 200)
Title.TextSize = 18
Title.Font = Enum.Font.SourceSansBold
Title.BackgroundTransparency = 1

-- Ô nhập Key
local Input = Instance.new("TextBox", MainFrame)
Input.Size = UDim2.new(0.9, 0, 0.18, 0)
Input.Position = UDim2.new(0.05, 0, 0.25, 0)
Input.PlaceholderText = "Nhập mã Key kích hoạt tại đây..."
Input.Text = ""
Input.TextColor3 = Color3.fromRGB(255, 255, 255)
Input.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
Input.TextSize = 14
local InputCorner = Instance.new("UICorner", Input)

-- Nút Submit (Xác nhận)
local Submit = Instance.new("TextButton", MainFrame)
Submit.Size = UDim2.new(0.42, 0, 0.18, 0)
Submit.Position = UDim2.new(0.05, 0, 0.48, 0)
Submit.Text = "KÍCH HOẠT"
Submit.BackgroundColor3 = Color3.fromRGB(0, 180, 100)
Submit.TextColor3 = Color3.fromRGB(255, 255, 255)
Submit.Font = Enum.Font.SourceSansBold
local SubmitCorner = Instance.new("UICorner", Submit)

-- Nút Get Key (Lấy Key)
local GetKeyBtn = Instance.new("TextButton", MainFrame)
GetKeyBtn.Size = UDim2.new(0.42, 0, 0.18, 0)
GetKeyBtn.Position = UDim2.new(0.53, 0, 0.48, 0)
GetKeyBtn.Text = "LẤY KEY (FREE)"
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
GetKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
GetKeyBtn.Font = Enum.Font.SourceSansBold
local GetKeyCorner = Instance.new("UICorner", GetKeyBtn)

-- Trạng thái thông báo
local StatusLabel = Instance.new("TextLabel", MainFrame)
StatusLabel.Size = UDim2.new(0.9, 0, 0.12, 0)
StatusLabel.Position = UDim2.new(0.05, 0, 0.7, 0)
StatusLabel.Text = "Vui lòng nhập Key để mở khóa tính năng"
StatusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
StatusLabel.TextSize = 12
StatusLabel.BackgroundTransparency = 1

-- Thanh Loading giả lập cực mượt khi Key đúng
local LoadingBarBg = Instance.new("Frame", MainFrame)
LoadingBarBg.Size = UDim2.new(0.9, 0, 0.05, 0)
LoadingBarBg.Position = UDim2.new(0.05, 0, 0.88, 0)
LoadingBarBg.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
local LCorner = Instance.new("UICorner", LoadingBarBg)

local LoadingBar = Instance.new("Frame", LoadingBarBg)
LoadingBar.Size = UDim2.new(0, 0, 1, 0)
LoadingBar.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
local LCorner2 = Instance.new("UICorner", LoadingBar)

-- Xử lý sự kiện
Submit.MouseButton1Click:Connect(function()
    local success, message, keyType = VerifyKey(Input.Text)
    if success then
        StatusLabel.Text = message
        StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 120)
        
        -- Chạy hiệu ứng thanh Loading Bar
        local tweenInfo = TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(LoadingBar, tweenInfo, {Size = UDim2.new(1, 0, 1, 0)})
        tween:Play()
        
        tween.Completed:Connect(function()
            KeyUI:Destroy()
            -- Cho phép chạy file chính an toàn
            getgenv().BLHUB_LOADED = true
            loadstring(game:HttpGet("https://raw.githubusercontent.com/nguyenxuanthuy334-debug/MyRobloxScripts/main/Games/BloxFruits.luau"))()
        end)
    else
        StatusLabel.Text = message
        StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
        Input.Text = ""
    end
end)

GetKeyBtn.MouseButton1Click:Connect(function()
    setclipboard(KeyLink)
    GetKeyBtn.Text = "Đã copy link web!"
    task.wait(1.5)
    GetKeyBtn.Text = "LẤY KEY (FREE)"
end)
