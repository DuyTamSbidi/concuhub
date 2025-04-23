-- Tải thư viện Fluent UI
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/main/source.lua"))()

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

-- Tạo TextBox (ô nhập key)
local TextBox = Instance.new("TextBox")
TextBox.Parent = KeyTab:CreateSection({
    Title = "Nhập key của bạn",
    Size = UDim2.fromOffset(400, 40)
})
TextBox.Text = ""  -- Đặt văn bản mặc định
TextBox.PlaceholderText = "Concuhub-xxxxxxxxxxxxxx"
TextBox.TextChanged:Connect(function()
    userKey = TextBox.Text
end)

-- Thêm nút kiểm tra key
local Button = KeyTab:AddButton({
    Title = "Kiểm tra Key",
    Callback = function()
        -- Gửi yêu cầu đến máy chủ PHP để xác minh key
        local response = game:HttpGet("https://concuhubkey.wuaze.com/verify.php?key=" .. userKey)
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
