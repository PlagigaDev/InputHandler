local InputTypes = {
	Button = {
		MouseButton1 = {value = Enum.UserInputType.MouseButton1, valueType = Enum.UserInputType},
		MouseButton2 = {value = Enum.UserInputType.MouseButton2, valueType = Enum.UserInputType},
		MouseButton3 = {value = Enum.UserInputType.MouseButton3, valueType = Enum.UserInputType},
		Touch = {value = Enum.UserInputType.Touch, valueType = Enum.UserInputType},
	},
	Value = {
		Vector3 = {
			MouseMovement = {value = Enum.UserInputType.MouseMovement, valueType = Enum.UserInputType},
			Thumbstick1 = {value = Enum.KeyCode.Thumbstick1, valueType = Enum.KeyCode},
			Thumbstick2 = {value = Enum.KeyCode.Thumbstick2, valueType = Enum.KeyCode}
		}
	}
}

for i, enum in pairs(Enum.KeyCode:GetEnumItems()) do
	if string.find(enum.Name,"Thumbstick") then return end
	InputTypes["Button"][enum.Name] = {value = enum, valueType = Enum.KeyCode}
end


return InputTypes