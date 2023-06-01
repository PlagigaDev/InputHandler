local root = script.Parent
local InputListener = require(root:WaitForChild("InputListener"))
local InputActionGroup = require(root:WaitForChild("InputActionGroup"))

local InputType = require(root:WaitForChild("InputType"))

export type InputAction = {
	_enabled: boolean,
	_name: string,
	listeners: {[string]: InputListener.Listener},
	_actionGroup: InputActionGroup.ActionGroup,
	_inputBegin: BindableEvent,
	_inputChange: BindableEvent,
	_inputEnd: BindableEvent,
	new: (inputActionGroup: InputActionGroup.ActionGroup, name: string, enabled: boolean?) -> (InputAction),
	enable: (self: InputAction) -> (),
	disable: (self: InputAction) -> (),
	setEnabled: (self: InputAction, value: boolean) -> (),
	isPressed: (self: InputAction) -> (boolean),
	readValue: (self: InputAction) -> (any),
	addListener: (self: InputAction, inputType: InputType.InputType, gameProcessed: boolean, enabled: boolean?) -> (),
	removeListener: (self: InputAction, inputType: InputType.InputType) -> (),
	connect: (self: InputAction, func: (delta: Vector3?, position: Vector3?) -> (), state: Enum.UserInputState) -> (RBXScriptConnection),
	disconnect: (self: InputAction, connection: RBXScriptConnection) -> (),
	setName: (self: InputAction, name: string) -> (),
	getName: (self: InputAction) -> (string),
	getEnabled: (self: InputAction) -> (boolean),
	fire: (self: InputAction, inputState: Enum.UserInputState, delta: Vector3, position: Vector3) -> ()
}


local InputAction = {}
InputAction.__index = InputAction

function InputAction.new(inputActionGroup: InputActionGroup.ActionGroup, name: string, enabled: boolean?): InputAction
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

function InputAction:addListener(inputType: InputType.InputType, gameProcessed: boolean, enabled: boolean?)
	if self.listener[inputType.Name] then
		return
	end
	self.listener[inputType.Name] = InputListener.new(self,inputType,enabled or self._enabled, gameProcessed)
end

function InputAction:removeListener(inputType: InputType.InputType)
	if self.listener[inputType.Name] then
		self.listener[inputType.Name]:destroy()
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