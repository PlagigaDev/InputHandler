local UserInputService = game:GetService("UserInputService")
local Listener = {}
Listener.__index = Listener


function Listener.new(InputAction, InputType, hasGameProcessed: boolean?)
	return setmetatable({parent = InputAction, inputType = InputType, gameProcessed = hasGameProcessed or false},Listener)
end

function Listener:Connect()
	if self.Listen and self.Listen.Connected then
		self:Disconnect()
	end
	self.Listen = UserInputService[self.InputType]:Connect(function(input, gameProcessedEvent)
		if not (self.gameProcessed == gameProcessedEvent) then return end

	end)
end

function Listener:Disconnect()
	self.Listen:Disconnect()
end

return Listener