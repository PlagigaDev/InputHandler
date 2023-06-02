local root = script.Parent

local ClassTypes = require(root:WaitForChild("ClassTypes"))
local InputType = require(root:WaitForChild("InputType"))
local connectEvent = require(script:WaitForChild("connectEvent"))

local Listener = {}
Listener.__index = Listener


function Listener.new(inputAction: ClassTypes.InputAction, inputType, enabled: boolean?, ignoreGameProcessed: boolean?, gameProcessed: boolean?): ClassTypes.Listener
	local self = setmetatable({
		_enabled = enabled or true,
		_connected = false,
		_inputAction = inputAction,
		_connectionType = inputType,
		_ignoreGameProcessed = ignoreGameProcessed or false,
		_gameProcessed = gameProcessed or false,
		_delta = Vector3.zero,
		_position = Vector3.zero,
		pressed = false
	},
	Listener)
	self:connect()
	return self
end

function Listener:enable()
	self:connect()
	self._enabled = true
end

function Listener:disable()
	self:disconnect()
	self._enabled = false
end

function Listener:setEnabled(value: boolean)
	if value then
		self:enable()
		return
	end
	self:disable()
end


function Listener:connect()
	if self._connected then self:disconnect() end

	self._listenBegan = self._connectionType.connection.InputBegan:Connect(function(input: InputObject, gameProcessedEvent: boolean)
		connectEvent(self,input,gameProcessedEvent)
	end)

	self._listenChanged = self._connectionType.connection.InputChanged:Connect(function(input: InputObject, gameProcessedEvent: boolean)
		connectEvent(self, input, gameProcessedEvent)
	end)

	self._listenEnded = self._connectionType.connection.InputEnded:Connect(function(input: InputObject, gameProcessedEvent: boolean)
		connectEvent(self, input, gameProcessedEvent)
	end)

	self._connected = true
end

function Listener:disconnect()
	self._listenBegin:Disconnect()

	self._listenChange:Disconnect()

	self._listenEnd:Disconnect()
	self._connected = false
end

function Listener:changeInput(inputType: ClassTypes.InputType)
	self._connectionType = inputType
	self:connect()
end

function Listener:getEnabled(): boolean
	return self._enabled
end

function Listener:getDelta(): Vector3
	return self._delta
end

function Listener:getPosition(): Vector3
	return self._position
end

function Listener:destroy(): nil
	self:disconnect()
	self = nil
end

return Listener