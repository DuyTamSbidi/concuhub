-- Tải thư viện Fluent UI
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- Tạo cửa sổ giao diện
local Window = Fluent:CreateWindow({
    Title = "Concuhub - Key System",
    SubTitle = "Vui lòng nhập key để tiếp tục",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Tạo tab và phần nhập key
local KeyTab = Window:AddTab({ Title = "Nhập Key", Icon = "key" })

local userKey = ""

KeyTab:AddInput({
    Title = "Key của bạn:",
    Default = "",
    Placeholder = "Nhập key tại đây",
    Callback = function(text)
        userKey = text
    end
})

KeyTab:AddButton({
    Title = "✅ Kiểm tra Key",
    Callback = function()
        local HttpService = game:GetService("HttpService")
        local response = syn.request({
            Url = "concuhubkey.wuaze.com" .. userKey,
            Method = "GET"
        })

        local result = HttpService:JSONDecode(response.Body)

        if result.valid then
            Fluent:Notify({
                Title = "Thành công",
                Content = "Key hợp lệ! Đang chuyển sang GUI chính...",
                Duration = 4
            })

            wait(1.5)

            -- 👉 Tải GUI chính từ GitHub
            loadstring(game:HttpGet("https://raw.githubusercontent.com/DuyTamSbidi/concuhub/refs/heads/main/main.lua"))()

        else
            Fluent:Notify({
                Title = "Sai key",
                Content = "Vui lòng kiểm tra lại key.",
                Duration = 5
            })
        end
    end
})
