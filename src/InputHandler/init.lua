local InputType = require(script:WaitForChild("InputType"))
local CommonTypes = require(script.InputType:WaitForChild("CommonTypes"))
local InputActionGroups = require(script:WaitForChild("InputActionGroup"))

export type InputHandler = {
	_actionGroups: {[string]: InputActionGroups.ActionGroup},
	_commonTypes: {[string]: InputType.InputType},
	_customTypes: {[string]: InputType.InputType},
	new: () -> (InputHandler),
}


local InputHandler = {}
InputHandler.__index = InputHandler

function InputHandler.new(): InputHandler
	return setmetatable({
		_actionGroups = {},
		_commonTypes = CommonTypes,
		_customTypes = {}
	},InputHandler)
end

function InputHandler:addActionGroup(name: string, enabled: boolean?): InputActionGroups.ActionGroup
	self._actionGroups[name] = InputActionGroups.new(self,name,enabled)
	return self._actionGroups[name]
end

function InputHandler:getActionGroup(name: string): InputActionGroups.ActionGroup?
	return self._actionGroups[name]
end

function InputHandler:removeActionGroup(name: string)
	if self._actionGroups[name] == nil then
		error(name.. " is not an action group of this input handler")
	end
	self._actionGroups[name] = nil
end

function InputHandler:addInputType(value: Enum.UserInputType | Enum.KeyCode, valueType: Enum.UserInputType | Enum.KeyCode, name: string, connection: (UserStorageService | GuiButton)?): InputType.InputType
	self._customTypes[name] = InputType.new(value,valueType,name,connection)
	return self._customTypes[name]
end

function InputHandler:getType(name: string): InputType.InputType?
	if self._customTypes[name] then
		return self._customTypes[name]
	end
	return self._commonTypes[name]
end

function InputHandler:getTypes(): {common: {InputType.InputType}, custom: {InputType.InputType}}
	return {common = self._commonTypes, custom = self._customTypes}
end

function InputHandler:getCommonType(name: string): InputType.InputType?
	return self._commonTypes[name]
end

function InputHandler:getCommonTypes(): {InputType.InputType}
	return self._commonTypes
end

function InputHandler:getCustomType(name: string): InputType.InputType?
	return self._customTypes[name]
end

function InputHandler:getCustomTypes(): {InputType.InputType}
	return self._customTypes
end

function InputHandler:removeType(name: string)
	self._customTypes[name] = nil
end

return InputHandler