local ClassTypes = require(script.Parent.Parent:WaitForChild("ClassTypes"))

return function(self: ClassTypes.Listener, input: InputObject)
	self._inputAction:fire(input.UserInputState, input.Delta, input.Position)
	return true
end