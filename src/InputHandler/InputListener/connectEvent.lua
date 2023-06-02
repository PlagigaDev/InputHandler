local ClassTypes = require(script.Parent.Parent:WaitForChild("ClassTypes"))

return function(self: ClassTypes.Listener, input: InputObject, gameProcessedEvent: boolean)
	if (not self._ignoreGameProcessed) and (not (gameProcessedEvent == self._gameProcessed)) then return end
	
	if not self._connectionType:compare(input) then return end

	self.pressed = true
	self._inputAction:fire(input.UserInputState, input.Delta, input.Position)
end