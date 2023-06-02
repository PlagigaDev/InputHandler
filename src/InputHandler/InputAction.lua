local root = script.Parent
local ClassTypes = require(root:WaitForChild("ClassTypes"))
local InputListener = require(root:WaitForChild("InputListener"))

local InputAction = {}
InputAction.__index = InputAction

function InputAction.new(inputActionGroup: ClassTypes.ActionGroup, name: string, enabled: boolean?): ClassTypes.InputAction
	return setmetatable({
		_enabled = enabled or true,
		_name = name,
		_listeners = {},
		_actionGroup = inputActionGroup,
		_inputBegin = Instance.new("BindableEvent"),
		_inputChange = Instance.new("BindableEvent"),
		_inputEnd = Instance.new("BindableEvent"),
	},
	InputAction)
end

function InputAction:enable()
	for _, listener in pairs(self._listeners) do
		listener:enable()
	end
	self._enabled = true
end

function InputAction:disable()
	for _, listener in pairs(self._listeners) do
		listener:disable()
	end
	self._enabled = false
end

function InputAction:setEnabled(value: boolean)
	if value then
		self:enable()
		return
	end
	self:disable()
end

function InputAction:isPressed(): boolean
	for _, listener in pairs(self._listeners) do
		if listener.pressed then
			return true
		end
	end
	return false
end

function InputAction:readValue(): any
	for _, listener in pairs(self._listeners) do
		local delta = listener:getDelta()
		local position = listener:getPostion()
		if delta ~= Vector3.zero or position ~= Vector3.zero then
			return delta, position
		end
	end
	return Vector3.zero, Vector3.zero
end

function InputAction:addListener(inputType: ClassTypes.InputType, enabled: boolean?, gameProcessed: boolean?, ignoreGameProcessed: boolean?, listenerStates: {Enum.UserInputState}?): ClassTypes.Listener
	if self._listeners[inputType.name] then
		return
	end
	local listener = InputListener.new(self,inputType,enabled or self._enabled,ignoreGameProcessed, gameProcessed)

	if listenerStates then
		for _, state in pairs(listenerStates) do
			listener:connect(state)
		end
	end

	self._listeners[inputType.name] = listener
	return listener
end

function InputAction:getListener(name: string)
	return self._listeners[name]
end

function InputAction:getListeners()
	return self._listeners
end

function InputAction:addListernerState(name: string, state: Enum.UserInputState)
	self._listeners[name]:connect(state)
end

function InputAction:addAllListernerStates(name: string)
	self._listeners[name]:connectAll()
end

function InputAction:removeListernerState(name: string, state: Enum.UserInputState)
	self._listeners[name]:disconnect(state)
end

function InputAction:removeAllListernerStates(name: string)
	self._listeners[name]:disconnectAll()
end

function InputAction:removeListener(inputType: ClassTypes.InputType)
	if self._listeners[inputType.name] then
		self._listeners[inputType.name]:destroy()
	end
end

function InputAction:connect(func: (delta: Vector3?, position: Vector3?) -> (any), state: Enum.UserInputState): RBXScriptConnection
	return self["_input".. state.Name].Event:Connect(func)
end

function InputAction:disconnect(connection: RBXScriptConnection)
	connection:Disconnect()
end

function InputAction:setName(name: string)
	self._name = name
end

function InputAction:getName(): string
	return self._name
end

function InputAction:getEnabled(): boolean
	return self._enabled
end

function InputAction:fire(inputState: Enum.UserInputState, delta: Vector3, position: Vector3)
	self["_input".. inputState.Name]:Fire(delta, position)
end

function InputAction:destroy(): nil
	for _, listener in pairs(self._listeners) do
		listener:destroy()
	end
	self = nil
end

return InputAction