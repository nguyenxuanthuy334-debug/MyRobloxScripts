-- File này nằm ở: Games/BloxFruits.luau trên GitHub của bạn
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bracket-v/bracket-v/main/library.lua"))()

local Window = Library:CreateWindow({
    Name = "MY FIRST HUB - " .. game.Players.LocalPlayer.Name,
    MinSize = Vector2.new(400, 300),
    ToggleKey = Enum.KeyCode.RightControl
})

local Tab = Window:CreateTab("Auto Farm")
local Section = Tab:CreateSection("Tính Năng")

Section:CreateButton({
    Name = "Click để kiểm tra kết nối",
    Callback = function()
        Library:Notify({
            Title = "Thành công!",
            Content = "Hệ thống kết nối mượt mà không lỗi!",
            Time = 5
        })
    end
})
