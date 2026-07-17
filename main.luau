-- ==================== BL HUB AUTO KEY LOADER (FILE: main.luau) ====================
local KeyLink = "https://fancy-cendol-0740a8.netlify.app/" -- Trang web chứa Key hôm nay của bạn
local AdminKey = "BLHUB-ADMIN-VIP-VMD-1102" -- Key vĩnh viễn của riêng bạn

-- Hàm tự động tạo mã Key của ngày hôm nay dựa trên ngày/tháng/năm thực tế
local function GetTodayKey()
    local date = os.date("!*t") -- Lấy thời gian UTC chuẩn quốc tế
    -- Tạo một chuỗi duy nhất theo ngày: ví dụ hôm nay ngày 17/7/2026 -> mã hóa thành một dãy số bảo mật
    local dayCode = (date.year * date.month * date.day) + 1102 
    return "BLHUB-FREE-KEY-" .. tostring(dayCode)
end

-- Hàm kiểm tra Key người dùng nhập vào
local function VerifyKey(userKey)
    -- 1. Quyền lợi Admin của bạn
    if userKey == AdminKey then
        return true, "Xin chào Admin! Đang kích hoạt quyền truy cập vĩnh viễn..."
    end

    -- 2. Tự động so khớp với Key của ngày hôm nay
    local todayKey = GetTodayKey()
    if userKey == todayKey then
        return true, "Xác nhận thành công! Key hôm nay hợp lệ."
    else
        return false, "Mã Key không chính xác hoặc đã hết hạn hôm nay!"
    end
end

-- ==================== GIAO DIỆN LOADER ====================
local TweenService = game:GetService("TweenService")
local KeyUI = Instance.new("ScreenGui", game.CoreGui)
KeyUI.Name = "BL_HUB_Loader"

local MainFrame = Instance.new("Frame", KeyUI)
MainFrame.Size = UDim2.new(0, 360, 0, 220)
MainFrame.Position = UDim2.new(0.5, -180, 0.5, -110)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
local Corner = Instance.new("UICorner", MainFrame)
Corner.CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0.2, 0)
Title.Text = "★ BL HUB PREMIUM ★"
Title.TextColor3 = Color3.fromRGB(0, 255, 200)
Title.TextSize = 18
Title.Font = Enum.Font.SourceSansBold
Title.BackgroundTransparency = 1

local Input = Instance.new("TextBox", MainFrame)
Input.Size = UDim2.new(0.9, 0, 0.18, 0)
Input.Position = UDim2.new(0.05, 0, 0.25, 0)
Input.PlaceholderText = "Nhập mã Key tự động của hôm nay..."
Input.Text = ""
Input.TextColor3 = Color3.fromRGB(255, 255, 255)
Input.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
Input.TextSize = 14
local InputCorner = Instance.new("UICorner", Input)

local Submit = Instance.new("TextButton", MainFrame)
Submit.Size = UDim2.new(0.42, 0, 0.18, 0)
Submit.Position = UDim2.new(0.05, 0, 0.48, 0)
Submit.Text = "KÍCH HOẠT"
Submit.BackgroundColor3 = Color3.fromRGB(0, 180, 100)
Submit.TextColor3 = Color3.fromRGB(255, 255, 255)
Submit.Font = Enum.Font.SourceSansBold
local SubmitCorner = Instance.new("UICorner", Submit)

local GetKeyBtn = Instance.new("TextButton", MainFrame)
GetKeyBtn.Size = UDim2.new(0.42, 0, 0.18, 0)
GetKeyBtn.Position = UDim2.new(0.53, 0, 0.48, 0)
GetKeyBtn.Text = "LẤY KEY TỰ ĐỘNG"
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
GetKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
GetKeyBtn.Font = Enum.Font.SourceSansBold
local GetKeyCorner = Instance.new("UICorner", GetKeyBtn)

local StatusLabel = Instance.new("TextLabel", MainFrame)
StatusLabel.Size = UDim2.new(0.9, 0, 0.12, 0)
StatusLabel.Position = UDim2.new(0.05, 0, 0.7, 0)
StatusLabel.Text = "Nhấn 'Lấy Key' để tự động nhận mã miễn phí"
StatusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
StatusLabel.TextSize = 12
StatusLabel.BackgroundTransparency = 1

local LoadingBarBg = Instance.new("Frame", MainFrame)
LoadingBarBg.Size = UDim2.new(0.9, 0, 0.05, 0)
LoadingBarBg.Position = UDim2.new(0.05, 0, 0.88, 0)
LoadingBarBg.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
local LCorner = Instance.new("UICorner", LoadingBarBg)

local LoadingBar = Instance.new("Frame", LoadingBarBg)
LoadingBar.Size = UDim2.new(0, 0, 1, 0)
LoadingBar.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
local LCorner2 = Instance.new("UICorner", LoadingBar)

Submit.MouseButton1Click:Connect(function()
    local success, message = VerifyKey(Input.Text)
    if success then
        StatusLabel.Text = message
        StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 120)
        
        local tweenInfo = TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(LoadingBar, tweenInfo, {Size = UDim2.new(1, 0, 1, 0)})
        tween:Play()
        
        tween.Completed:Connect(function()
            KeyUI:Destroy()
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
    GetKeyBtn.Text = "Đã Copy Link Lấy Key!"
    task.wait(1.5)
    GetKeyBtn.Text = "LẤY KEY TỰ ĐỘNG"
end)
