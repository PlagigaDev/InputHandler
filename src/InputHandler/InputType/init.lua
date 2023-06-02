local UserInputService = game:GetService("UserInputService")

local ClassTypes = require(script.Parent:WaitForChild("ClassTypes"))

local InputType = {}
InputType.__index = InputType

function InputType.new(newValue: Enum.UserInputType | Enum.KeyCode, newValueType: Enum.UserInputType | Enum.KeyCode, newName: string, newConnection: (UserStorageService | GuiButton)?): ClassTypes.InputType
	return setmetatable({
		value = newValue,
		valueType = newValueType,
		name = newName,
		connection = newConnection or UserInputService
	},
	InputType)
end

function InputType:compare(input: InputObject): boolean
	return input[self.valueType.Name] == self.value
end

return InputType