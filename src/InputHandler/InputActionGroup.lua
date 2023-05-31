local root = script.Parent
local InputHandler = require(root)
local InputAction = require(root:WaitForChild("InputAction"))

export type ActionGroup = {
	_enabled: boolean,
	_name: string,
	_inputActions: {[string]: InputAction.InputAction},
	new: (inputHandler: InputHandler.InputHandler,name: string, enabled: boolean?) -> (ActionGroup),
	enable: (self: ActionGroup) -> (),
	disable: (self: ActionGroup) -> (),
	setEnabled: (self: ActionGroup, value: boolean) -> (),
	addAction: (self: ActionGroup, name: string, enabled: boolean?) -> (InputAction.InputAction),
	getAction: (self: ActionGroup, name: string) -> (InputAction.InputAction?),
	getAllActions: (self: ActionGroup) -> ({[string]: InputAction.InputAction}),
	removeAction: (self: ActionGroup, name: string) -> (),
	getEnabled: (self: ActionGroup) -> (boolean),
	setActionName: (oldName: string, newName: string) -> (),
	setName: (self: ActionGroup, name: string) -> (),
	getName: (self: ActionGroup) -> (string)
}

local InputActionGroup = {}
InputActionGroup.__index = {}

function InputActionGroup.new(inputHandler: InputHandler.InputHandler, name: string, enabled: boolean?): ActionGroup
	return setmetatable({
		_enabled = enabled or true,
		_name = name,
		_inputHandler = inputHandler,
		_inputActions = {}
	}, 
	InputActionGroup)
end

function InputActionGroup:enable()
	for _, action in pairs(self.inputActions) do
		action:enable()
	end
	self._enabled = true
end

function InputActionGroup:disable()
	for _, action in pairs(self.inputActions) do
		action:disable()
	end
	self._enabled = false
end

function InputActionGroup:setEnabled(value: boolean)
	if value then
		self:enable()
		return
	end
	self:disable()
end

function InputActionGroup:addAction(name: string, enabled: boolean?): InputAction.InputAction
	local action = InputAction.new(self,name,enabled or self._enabled)
	self._inputActions[name] = action
	return action
end

function InputActionGroup:getAction(name: string): InputAction.InputAction?
	return self._inputActions[name]
end

function InputActionGroup:getAllActions(): {[string]: InputAction.InputAction}
	return self._inputActions
end

function InputActionGroup:removeAction(name: string)
	self._inputActions[name] = nil
end

function InputActionGroup:getEnabled(): boolean
	return self._enabled
end

function InputActionGroup:setActionName(oldName: string, newName: string)
	local current = self._inputActions[oldName]
	if current == nil then
		error(oldName.. " is not a valid inputAction in ".. self._name)
		return
	end
	current:setName(newName)
	self._inputActions[newName] = current
	self._inputActions[oldName] = nil
end

function InputActionGroup:setName(name: string)
	self._name = name
end

function InputActionGroup:getName(): string
	return self._name
end

return InputActionGroup