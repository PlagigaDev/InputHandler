local UserInputService = game:GetService("UserInputService")

local ClassTypes = require(script.Parent:WaitForChild("ClassTypes"))

local InputType = {}
InputType.__index = InputType

function InputType.new(newValue: Enum.UserInputType | Enum.KeyCode, newValueBase: Enum.UserInputType | Enum.KeyCode, newName: string, newConnection: (UserInputService | RBXScriptSignal)?): ClassTypes.InputType
	return setmetatable({
		value = newValue,
		valueBase = newValueBase,
		name = newName,
		connection = newConnection or UserInputService
	},
	InputType)
end

function InputType.from(inputType: {value: Enum.UserInputType | Enum.KeyCode, valueBase: Enum.UserInputType | Enum.KeyCode, name: string, connection: UserInputService | RBXScriptSignal}): ClassTypes.InputType
	return setmetatable(inputType,InputType)
end

function InputType:clone(): ClassTypes.InputType
	local clone = table.clone(self)
	return InputType.from(clone)
end

function InputType:setConnection(connection: UserInputService | RBXScriptSignal)
	self.connection = connection
end

function InputType:compare(input: InputObject): boolean
	return input[(tostring(self.valueBase)):gsub("Enum.","")] == self.value
end

return InputType