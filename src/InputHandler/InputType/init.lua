local UserInputService = game:GetService("UserInputService")
export type InputType = {
	value: Enum.UserInputType | Enum.KeyCode,
	valueType: Enum.UserInputType | Enum.KeyCode,
	name: string,
	connection: UserStorageService | GuiButton,
	new: (newValue: Enum.UserInputType | Enum.KeyCode, newValueType: Enum.UserInputType | Enum.KeyCode, newName: string, newConnection: (UserStorageService | GuiButton)?) -> (InputType),
	compare: (self: InputType, input: InputObject) -> (boolean)
}


local InputType = {}
InputType.__index = InputType

function InputType.new(newValue: Enum.UserInputType | Enum.KeyCode, newValueType: Enum.UserInputType | Enum.KeyCode, newName: string, newConnection: (UserStorageService | GuiButton)?): InputType
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