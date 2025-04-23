-- Tải thư viện Fluent UI
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/main/source.lua"))()

-- Tạo cửa sổ chính với hiệu ứng Acrylic
local Window = Fluent:CreateWindow({
    Title = "Concuhub Key System",        -- Tiêu đề cửa sổ
    SubTitle = "Vui lòng nhập key để tiếp tục",  -- Dòng phụ
    TabWidth = 160,                       -- Chiều rộng tab
    Size = UDim2.fromOffset(580, 460),    -- Kích thước cửa sổ
    Acrylic = true,                       -- Bật hiệu ứng Acrylic
    Theme = "Dark",                       -- Màu nền tối
    MinimizeKey = Enum.KeyCode.LeftControl  -- Phím thu nhỏ cửa sổ
})

-- Tạo tab nhập key
local KeyTab = Window:AddTab({ Title = "Key", Icon = "key" })

-- Biến lưu trữ key người dùng nhập
local userKey = ""

-- Thêm Title đẹp cho tab
KeyTab:AddLabel({
    Title = "Nhập key để tiếp tục",
    Font = Enum.Font.GothamBold,
    TextSize = 18,
    Color = Color3.fromRGB(255, 255, 255)  -- Màu trắng cho dòng tiêu đề
})

-- Thêm TextBox (ô nhập key) với thiết kế đẹp
local TextBox = Instance.new("TextBox")
TextBox.Parent = KeyTab:CreateSection({
    Title = "Nhập key của bạn",
    Size = UDim2.fromOffset(400, 40)
})
TextBox.Text = ""  -- Đặt văn bản mặc định
TextBox.PlaceholderText = "Concuhub-xxxxxxxxxxxxxx"  -- Placeholder mẫu
TextBox.TextChanged:Connect(function()
    userKey = TextBox.Text  -- Lưu giá trị key người dùng nhập
end)

-- Tạo nút kiểm tra key với hiệu ứng đẹp
KeyTab:AddButton({
    Title = "Kiểm tra Key",
    Callback = function()
        -- Gửi yêu cầu đến máy chủ PHP để xác minh key
        local response = game:HttpGet("http://concuhubkey.wuaze.com/" .. userKey)
        local result = game:GetService("HttpService"):JSONDecode(response)

        if result.valid then
            Fluent:Notify({
                Title = "Thành công",
                Content = "Key hợp lệ! Đang tải GUI chính...",
                Duration = 5,  -- Thời gian thông báo hiển thị
                Color = Color3.fromRGB(0, 255, 0)  -- Màu thông báo thành công (Xanh lá)
            })
            -- Tải GUI chính
            loadstring(game:HttpGet("https://raw.githubusercontent.com/DuyTamSbidi/concuhub/refs/heads/main/main.lua"))()
        else
            Fluent:Notify({
                Title = "Lỗi",
                Content = "Key không hợp lệ hoặc đã hết hạn.",
                Duration = 5,  -- Thời gian thông báo hiển thị
                Color = Color3.fromRGB(255, 0, 0)  -- Màu thông báo lỗi (Đỏ)
            })
        end
    end
})

-- Tùy chỉnh thêm một button đẹp cho người dùng xác thực lại key
KeyTab:AddButton({
    Title = "Nhập lại key",
    Callback = function()
        TextBox.Text = ""  -- Xóa nội dung trong ô nhập key khi nhấn vào nút này
        Fluent:Notify({
            Title = "Thông báo",
            Content = "Bạn đã xóa key. Hãy nhập lại.",
            Duration = 5,
            Color = Color3.fromRGB(255, 165, 0)  -- Màu thông báo (cam)
        })
    end
})
