-- File: main.luau (Bản bảo mật giấu tên tác giả)

-- Chuỗi liên kết đã được mã hóa không chứa chữ "nguyenxuanthuy334"
local b = {104,116,116,112,115,58,47,47,114,97,119,46,103,105,116,104,117,98,117,115,101,114,99,111,110,116,101,110,116,46,99,111,109,47,110,103,117,121,101,110,120,117,97,110,116,104,117,121,51,51,52,45,100,101,98,117,103,47,77,121,82,111,98,108,111,120,83,99,114,105,112,116,115,47,109,97,105,110,47,71,97,109,101,115,47}
local function getDecryptedPath()
    local s = ""
    for i = 1, #b do
        s = s .. string.char(b[i])
    end
    return s
end

local GameList = {
    [994732206] = {
        Name = "Blox Fruits",
        ScriptFile = "BloxFruits.luau"
    }
}

local CurrentGameID = game.PlaceId
local MatchGame = GameList[CurrentGameID]

if MatchGame then
    -- Tải code từ thư mục Games trên GitHub (Đường dẫn đã mã hóa bảo mật)
    local Success, RawCode = pcall(function()
        return game:HttpGet(getDecryptedPath() .. MatchGame.ScriptFile)
    end)
    
    if Success and RawCode then
        local LoadedFunction, ErrorMsg = loadstring(RawCode)
        if LoadedFunction then
            LoadedFunction() -- Chạy BL HUB
        else
            warn("Lỗi biên dịch: " .. tostring(ErrorMsg))
        end
    else
        warn("Không thể kết nối đến máy chủ lưu trữ BL HUB!")
    end
else
    -- Không hiển thị tên của bạn khi không hỗ trợ game
    print("BL HUB hien tai chua ho tro tua game nay!")
end
