local ClassTypes = require(script:WaitForChild("ClassTypes"))

local InputType = require(script:WaitForChild("InputType"))
local CommonTypes = require(script.InputType:WaitForChild("CommonTypes"))
local InputActionGroups = require(script:WaitForChild("InputActionGroup"))

local InputHandler = {}
InputHandler.__index = InputHandler

function InputHandler.new(): ClassTypes.InputHandler
	return setmetatable({
		_actionGroups = {},
		_commonTypes = CommonTypes,
		_customTypes = {}
	},InputHandler)
end

function InputHandler:addActionGroup(name: string, enabled: boolean?): ClassTypes.ActionGroup
	self._actionGroups[name] = InputActionGroups.new(self,name,enabled)
	return self._actionGroups[name]
end

function InputHandler:setActionGroupName(oldName: string, newName: string)
	self._actionGroups[newName] = self._actionGroups[oldName]
	self._actionGroups[newName]:setName(newName)
	self._actionGroups[oldName] = nil
end

function InputHandler:getActionGroup(name: string): ClassTypes.ActionGroup?
	return self._actionGroups[name]
end

function InputHandler:removeActionGroup(name: string)
	if self._actionGroups[name] == nil then
		error(name.. " is not an action group of this input handler")
	end
	self._actionGroups[name] = nil
end

function InputHandler:addType(value: Enum.UserInputType | Enum.KeyCode, valueType: Enum.UserInputType | Enum.KeyCode, name: string, connection: (UserStorageService | GuiButton)?): ClassTypes.InputType
	self._customTypes[name] = InputType.new(value,valueType,name,connection)
	return self._customTypes[name]
end

function InputHandler:getType(name: string): ClassTypes.InputType?
	if self._customTypes[name] then
		return self._customTypes[name]
	end
	return self._commonTypes[name]
end

function InputHandler:getTypes(): {common: {ClassTypes.InputType}, custom: {ClassTypes.InputType}}
	return {common = self._commonTypes, custom = self._customTypes}
end

function InputHandler:getCommonType(name: string): ClassTypes.InputType?
	return self._commonTypes[name]
end

function InputHandler:getCommonTypes(): {ClassTypes.InputType}
	return self._commonTypes
end

function InputHandler:getCustomType(name: string): ClassTypes.InputType?
	return self._customTypes[name]
end

function InputHandler:getCustomTypes(): {ClassTypes.InputType}
	return self._customTypes
end

function InputHandler:removeType(name: string)
	self._customTypes[name] = nil
end

return InputHandler