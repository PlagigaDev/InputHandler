local UserInputService = game:GetService("UserInputService")
local Listener = {}
Listener.__index = Listener


function Listener.new(InputAction, ActionKey, ActionType, activeWhileInChat: boolean?)
	return setmetatable({Parent = InputAction, InputRegister = ActionType, gameProcessed = activeWhileInChat or false},Listener)
end

function Listener:Connect()
	if self.Listen and self.Listen.Connected then
		self:Disconnect()
	end
	self.Listen = UserInputService[self.InputRegister]:Connect(function(input, gameProcessedEvent)
		if not (self.gameProcessed == gameProcessedEvent) then return end

	end)
end

function Listener:Disconnect()
	self.Listen:Disconnect()
end

return Listener