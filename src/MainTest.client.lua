local InputHandler = require(script.Parent:WaitForChild("InputHandler")).new()

local playerGui: PlayerGui = game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("ScreenGui")
local Button: TextButton = playerGui:WaitForChild("TextButton")
local label: TextLabel = playerGui:WaitForChild("Counter")

local count = 0

local actionGroup = InputHandler:addActionGroup("Test", true)
local action = actionGroup:addAction("test")
action:addListener(InputHandler:getType("MouseButton1"), true, false, {Enum.UserInputState.Begin})
action:addListener(InputHandler:getType("L"), true, false, {Enum.UserInputState.Begin})

--local buttonType = InputHandler:addFromType("MouseButton1", "ButtonPress", Button)
--action:addListener(buttonType, true, true, false, {Enum.UserInputState.Begin})

action:connect(function()
	count += 1
	label.Text = "Clicks: ".. count
end, Enum.UserInputState.Begin)
