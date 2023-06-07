local ClassTypes = require(script.Parent.Parent.Parent:WaitForChild("ClassTypes"))

return function(listener: ClassTypes.Listener)
	local connection = listener._connectionType.connection
	connection.InputBegan:Connect(function(input, gameProcessedEvent)
		if listener._connectionType:compare(input) then
			listener:actuate(input,gameProcessedEvent)
			listener.pressed = true
		end
	end)
	connection.InputChanged:Connect(function(input, gameProcessedEvent)
		listener:actuate(input,gameProcessedEvent)
	end)
	connection.InputEnded:Connect(function(input, gameProcessedEvent)
		if listener._connectionType:compare(input) then
			listener.pressed = false
			listener:actuate(input,gameProcessedEvent)
		end
	end)
end