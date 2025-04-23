-- Tải thư viện Fluent UI
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- Tạo cửa sổ chính
local Window = Fluent:CreateWindow({
    Title = "Concuhub Key System",
    SubTitle = "Vui lòng nhập key để tiếp tục",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Tạo tab nhập key
local KeyTab = Window:AddTab({ Title = "Key", Icon = "key" })

-- Biến lưu trữ key người dùng nhập
local userKey = ""

-- Thêm input box nhập key
KeyTab:AddInput({
    Name = "Nhập key của bạn",
    Placeholder = "Concuhub-xxxxxxxxxxxxxx",  -- Placeholder (hiển thị mẫu key)
    RemoveTextAfterFocusLost = true,
    Callback = function(value)
        userKey = value
    end
})

-- Thêm nút kiểm tra key
KeyTab:AddButton({
    Title = "Kiểm tra key",
    Callback = function()
        -- Gửi yêu cầu đến máy chủ PHP để xác minh key
        local response = game:HttpGet("http://concuhubkey.wuaze.com" .. userKey)
        local result = game:GetService("HttpService"):JSONDecode(response)

        if result.valid then
            Fluent:Notify({
                Title = "Thành công",
                Content = "Key hợp lệ! Đang tải GUI chính...",
                Duration = 5
            })
            -- Tải GUI chính
            loadstring(game:HttpGet("https://raw.githubusercontent.com/DuyTamSbidi/concuhub/refs/heads/main/main.lua"))()
        else
            Fluent:Notify({
                Title = "Lỗi",
                Content = "Key không hợp lệ hoặc đã hết hạn.",
                Duration = 5
            })
        end
    end
})
