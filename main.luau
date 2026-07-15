-- Định nghĩa môi trường chạy (tránh lỗi trên các Executor khác nhau)
local _ENV = (getgenv or getrenv or getfenv)()

-- 1. Khai báo danh sách Game hỗ trợ (Chỉ giữ lại Blox Fruit)
local MyScripts = {
    {
        GameId = 994732206, -- ID của game Blox Fruit
        FileName = "BloxFruits.luau"
    }
}

-- 2. Đường dẫn đến kho GitHub của bạn (Đã điền sẵn tài khoản của bạn)
local GithubUser = "nguyenxuanthuy334-debug" 
local RepoName = "MyRobloxScripts"       
local BaseUrl = string.format("https://raw.githubusercontent.com/%s/%s/main/", GithubUser, RepoName)

-- 3. Hàm tải code từ GitHub
local function FetchScript(FileName)
    local Success, Content = pcall(function()
        return game:HttpGet(BaseUrl .. "Games/" .. FileName)
    end)
    
    if Success then
        return Content
    else
        warn("Không thể tải file: " .. FileName)
        return nil
    end
end

-- 4. Hàm kiểm tra xem người chơi có đang ở đúng game hỗ trợ không
local function CheckAndRun()
    local CurrentPlaceId = game.PlaceId
    local CurrentGameId = game.GameId

    for _, ScriptInfo in ipairs(MyScripts) do
        local IsMatch = false
        
        if ScriptInfo.PlacesIds and table.find(ScriptInfo.PlacesIds, CurrentPlaceId) then
            IsMatch = true
        elseif ScriptInfo.GameId and ScriptInfo.GameId == CurrentGameId then
            IsMatch = true
        end

        if IsMatch then
            -- Tải code từ thư mục Games/ trên GitHub
            local RawCode = FetchScript(ScriptInfo.FileName)
            if RawCode then
                local LoadedFunc, ErrorMsg = loadstring(RawCode)
                if type(LoadedFunc) == "function" then
                    return LoadedFunc() -- Chạy script tính năng!
                else
                    error("Lỗi cú pháp trong file game: " .. tostring(ErrorMsg))
                end
            end
        end
    end
    
    print("Script của bạn không hỗ trợ tựa game này!")
end

CheckAndRun()
