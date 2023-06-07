local root = script.Parent

local ClassTypes = require(root:WaitForChild("ClassTypes"))
local connectEvent = require(script:WaitForChild("connectEvent"))
local Input = require(script:WaitForChild("Input"))
local validState = require(script:WaitForChild("validState"))

local Listener = {}
Listener.__index = Listener


function Listener.new(inputAction: ClassTypes.InputAction, inputType: ClassTypes.InputType, enabled: boolean?, gameProcessed: boolean?): ClassTypes.Listener
	if inputAction == nil or inputType == nil then
		error(string.format("Argument missing (inputAction: %s, inputType: %s)",inputAction,inputType))
		return
	end
	local self = setmetatable({
		_enabled = enabled or true,
		_connected = {},
		_connectionType = inputType,
		_inputAction = inputAction,
		_gameProcessed = gameProcessed,
		_delta = Vector3.zero,
		_position = Vector3.zero,
		pressed = false
	},
	Listener)
	Input:addListener(self)
	return self
end

function Listener:enable()
	self:reConnect()
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

function Listener:actuate(input: InputObject, gameProcessedEvent: boolean): boolean
	if self._connected[input.UserInputState] then
		return connectEvent(self,input,gameProcessedEvent)
	end
	return false
end

function Listener:connect(state: Enum.UserInputState)
	if not validState(state) then return end
	if self._connected[state] then self:disconnect(state) end

	self._connected[state] = true
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
	if self._connected then
		self._connected[state] = false
	end
end

function Listener:disconnectAll()
	for state, _ in pairs(self._connected) do
		self:disconnect(state)
	end
end

function Listener:changeInput(inputType: ClassTypes.InputType)
	Input:removeListener(self)
	self._connectionType = inputType
	Input:addListener(self)
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