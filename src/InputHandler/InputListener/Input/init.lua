local UserInputService = game:GetService("UserInputService")
local ClassTypes = require(script.Parent.Parent:WaitForChild("ClassTypes"))

local setCustomConnections = require(script:WaitForChild("setCustomConnection"))

local Input = {
	_listeners = {},
	_customListeners = {}
}

function Input:addInputListener(listener: ClassTypes.Listener)
	if self._listeners[listener._connectionType.value] == nil then
		self._listeners[listener._connectionType.value] = {}
	end
	table.insert(self._listeners[listener._connectionType.value],listener)
end

function Input:addCustomInputListen(listener: ClassTypes.Listener)
	self._customListeners[listener._connectionType] = listener
	setCustomConnections(listener)
end

function Input:addListener(listener: ClassTypes.Listener)
	if listener._connectionType.connection == UserInputService then
		self:addInputListener(listener)
		return
	end
	self:addCustomInputListen(listener)
end

function Input:removeListener(listener: ClassTypes.Listener)
	local currentValueTable = self._listeners[listener._connectionType.value]
	table.remove(currentValueTable,table.find(currentValueTable, listener))
end

function Input:removeCustomInputListen(listener: ClassTypes.Listener)
	self._customListeners[listener._connectionType] = nil
end

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
	actuateListeners(input,gameProcessedEvent)
end)

UserInputService.InputChanged:Connect(function(input, gameProcessedEvent)
	actuateListeners(input,gameProcessedEvent)
end)

UserInputService.InputEnded:Connect(function(input, gameProcessedEvent)
	actuateListeners(input,gameProcessedEvent)
end)

function actuateListeners(input: InputObject, gameProcessedEvent: boolean)
	local inputTypeValue = input.KeyCode ~= Enum.KeyCode.Unknown and input.KeyCode or input.UserInputType
	local listenersToActuate = Input._listeners[inputTypeValue]
	if listenersToActuate == nil or #listenersToActuate == 0 then return end
	
	for _, listener: ClassTypes.Listener in pairs(listenersToActuate) do
		task.spawn(function()
			if not (input.UserInputState == Enum.UserInputState.Change) and (listener._gameProcessed == nil or gameProcessedEvent == listener._gameProcessed) then
				listener.pressed = not listener.pressed
				listener:actuate(input, gameProcessedEvent)
			end
		end)
	end
end

return Input