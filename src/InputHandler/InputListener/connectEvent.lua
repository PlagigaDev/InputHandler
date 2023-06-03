local ClassTypes = require(script.Parent.Parent:WaitForChild("ClassTypes"))

return function(self: ClassTypes.Listener, input: InputObject, gameProcessedEvent: boolean)
	if self._gameProcessed ~= nil and (gameProcessedEvent == nil or (not (gameProcessedEvent == self._gameProcessed))) then return end
	
	if not self._connectionType:compare(input) then return end
	self._inputAction:fire(input.UserInputState, input.Delta, input.Position)
end