local InputHandler = require(script.Parent:WaitForChild("InputHandler")).new()

local actionGroup = InputHandler:addActionGroup("Test", true)
local action = actionGroup:addAction("Click")
action:addListener(InputHandler:getType("MouseButton1"),false)
action:addListener(InputHandler:getType("L"),false)
action:connect(function()
	print("That worked")
end)