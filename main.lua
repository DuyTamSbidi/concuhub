-- Tải thư viện Fluent UI
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- Tạo cửa sổ giao diện chính
local MainWindow = Fluent:CreateWindow({
    Title = "Concuhub - Giao diện chính",
    SubTitle = "Chào mừng!",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Tạo tab chức năng
local MainTab = MainWindow:AddTab({ Title = "Chức năng", Icon = "settings" })

-- Thêm nút chức năng
MainTab:AddButton({
    Title = "Bắt đầu Auto Farm",
    Description = "Tự động farm tài nguyên",
    Callback = function()
        print("Auto Farm đã được kích hoạt.")
        -- Thêm mã script của bạn tại đây
    end
})
