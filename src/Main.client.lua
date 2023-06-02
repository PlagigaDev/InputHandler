local InputHandler = require(script.Parent:WaitForChild("InputHandler")).new()

local actionGroup = InputHandler:addActionGroup("Test", true)
local action = actionGroup:addAction("test")
action:addListener(InputHandler:getType("MouseButton1"),false,nil,{Enum.UserInputState.Begin})
action:addListener(InputHandler:getType("L"),false,nil,{Enum.UserInputState.Begin})
action:connect(function()
	print("That worked")
end, Enum.UserInputState.Begin)