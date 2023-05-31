local root = script.Parent.Parent
local Enums = root:WaitForChild("Enums")
local compare = require(Enums:WaitForChild("Compare"))

local InputListener = require(script.Parent)

return function(self: InputListener.Listener, input: InputObject, gameProcessedEvent: boolean)
	if (not self._ignoreGameProcessed) and (not (gameProcessedEvent == self._gameProcessed)) then return end
	
	if not compare(input, self._connectionType) then return end

	self.pressed = true
	self._inputAction:fire(input.UserInputState, input.Delta, input.Position)
end