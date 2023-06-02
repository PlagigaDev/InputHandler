local root = script.Parent

local ClassTypes = require(root:WaitForChild("ClassTypes"))
local connectEvent = require(script:WaitForChild("connectEvent"))
local connectState = require(script:WaitForChild("connectState"))
local validState = require(script:WaitForChild("validState"))

local Listener = {}
Listener.__index = Listener


function Listener.new(inputAction: ClassTypes.InputAction, inputType: ClassTypes.InputType, enabled: boolean?, ignoreGameProcessed: boolean?, gameProcessed: boolean?): ClassTypes.Listener
	if inputAction == nil or inputType == nil then
		error(string.format("Argument missing (inputAction: %s, inputType: %s)",inputAction,inputType))
		return
	end
	local self = setmetatable({
		_enabled = enabled or true,
		_connected = {},
		_connectionType = inputType,
		_inputAction = inputAction,
		_ignoreGameProcessed = ignoreGameProcessed or false,
		_gameProcessed = gameProcessed or false,
		_delta = Vector3.zero,
		_position = Vector3.zero,
		pressed = false
	},
	Listener)
	return self
end

function Listener:enable()
	self._enabled = true
end

function Listener:disable()
	self:disconnectAll()
	self._enabled = false
end

function Listener:setEnabled(value: boolean)
	if value then
		self:enable()
		return
	end
	self:disable()
end


function Listener:connect(state)
	if not validState(state) then return end
	if self._connected[state] then self:disconnect(state) end
	
	local connection: string = connectState(state)
	self._connected[state] = self._connectionType.connection["Input"..connection]:Connect(function(input: InputObject, gameProcessedEvent: boolean)
		connectEvent(self,input,gameProcessedEvent)
	end)
end

function Listener:reConnect()
	for state , connection in pairs(self._connected) do
		if connection == false then
			self:connect(state)
		end
	end
end

function Listener:connectAll()
	self:connect(Enum.UserInputState.Begin)
	self:connect(Enum.UserInputState.Change)
	self:connect(Enum.UserInputState.End)
end

function Listener:disconnect(state)
	self._connected[state]:Disconnect()
	--for reconnection we keep the key value but change it to a bool value
	self._connected[state] = false
end

function Listener:disconnectAll()
	for _, connection in pairs(self._connected) do
		connection:Disconnect()
	end
end

function Listener:changeInput(inputType: ClassTypes.InputType)
	self._connectionType = inputType
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