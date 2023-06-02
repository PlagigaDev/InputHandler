local root = script.Parent

local ClassTypes = require(root:WaitForChild("ClassTypes"))
local InputAction = require(root:WaitForChild("InputAction"))

local InputActionGroup = {}
InputActionGroup.__index = {}

function InputActionGroup.new(inputHandler: ClassTypes.InputHandler, name: string, enabled: boolean?): ClassTypes.ActionGroup
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

function InputActionGroup:addAction(name: string, enabled: boolean?): ClassTypes.InputAction
	local action = InputAction.new(self,name,enabled or self._enabled)
	self._inputActions[name] = action
	return action
end

function InputActionGroup:getAction(name: string): ClassTypes.InputAction?
	return self._inputActions[name]
end

function InputActionGroup:getAllActions(): {[string]: ClassTypes.InputAction}
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