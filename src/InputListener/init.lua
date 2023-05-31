local UserInputService = game:GetService("UserInputService")

local root = script.Parent
local Enums = root:WaitForChild("Enums")
local InputTypes = require(Enums:WaitForChild("InputType"))
local InputAction = require(root:WaitForChild("InputAction"))
local connectEvent = require(script:WaitForChild("connectEvent"))

export type Listener = {
	_enabled: boolean,
	_connected: boolean,
	_inputAction: InputAction.InputAction,
	_connectionType: InputTypes.InputType,
	_ignoreGameProcessed: boolean,
	_gameProcessed: boolean,
	_delta: Vector3,
	_position: Vector3,
	pressed: boolean,
	new: (inputAction: InputAction.InputAction, inputType: InputTypes.InputType, enabled: boolean?, ignoreGameProcessed: boolean?, gameProcessed: boolean?) -> (Listener),
	enable: (self: Listener) -> (),
	disable: (self: Listener) -> (),
	setEnabled: (self: Listener, value: boolean) -> (),
	connect: (self: Listener) -> (),
	disconnect: (self: Listener) -> (),
	changeInput: (self: Listener, inputType: InputTypes.InputType) -> (),
	getEnabled: (self: Listener) -> (boolean),
	getDelta: (self: Listener) -> (Vector3),
	getPosition: (self: Listener) -> (Vector3),
	destroy: (self: Listener) -> nil
}


local Listener = {}
Listener.__index = Listener


function Listener.new(inputAction, inputType, enabled: boolean?, ignoreGameProcessed: boolean?, gameProcessed: boolean?): Listener
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

function Listener:_connectEvent(input: InputObject, gameProcessedEvent: boolean)
	
end

function Listener:connect()
	if self._connected then self:disconnect() end

	self._listenBegan = UserInputService.InputBegan:Connect(function(input: InputObject, gameProcessedEvent: boolean)
		connectEvent(self,input,gameProcessedEvent)
	end)

	self._listenChanged = UserInputService.InputChanged:Connect(function(input: InputObject, gameProcessedEvent: boolean)
		connectEvent(self, input, gameProcessedEvent)
	end)

	self._listenEnded = UserInputService.InputEnded:Connect(function(input: InputObject, gameProcessedEvent: boolean)
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

function Listener:changeInput(inputType: InputTypes.InputType)
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