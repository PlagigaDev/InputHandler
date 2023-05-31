export type InputType = {
	value: Enum.UserInputType | Enum.KeyCode,
	valueType: Enum.UserInputType | Enum.KeyCode,
	name: string
}
export type InputTypes = {[string]: InputType}

local InputTypes = {
	MouseButton1 = {value = Enum.UserInputType.MouseButton1, valueType = Enum.UserInputType, name = "MouseButton1"},
	MouseButton2 = {value = Enum.UserInputType.MouseButton2, valueType = Enum.UserInputType, name = "MouseButton2"},
	MouseButton3 = {value = Enum.UserInputType.MouseButton3, valueType = Enum.UserInputType, name = "MouseButton3"},
	Touch = {value = Enum.UserInputType.Touch, valueType = Enum.UserInputType, name = "Touch"},
	MouseMovement = {value = Enum.UserInputType.MouseMovement, valueType = Enum.UserInputType, name = "MouseMovement"},
	Thumbstick1 = {value = Enum.KeyCode.Thumbstick1, valueType = Enum.KeyCode, name = "Thumbstick1"},
	Thumbstick2 = {value = Enum.KeyCode.Thumbstick2, valueType = Enum.KeyCode, name = "Thumbstick2"}
}

for i, enum in pairs(Enum.KeyCode:GetEnumItems()) do
	if string.find(enum.Name,"Thumbstick") then return end
	InputTypes["Button"][enum.Name] = {value = enum, valueType = Enum.KeyCode, name = enum.Name}
end


return InputTypes