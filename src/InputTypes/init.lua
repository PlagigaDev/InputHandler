local InputStates = {
	Button = {Enum.UserInputState.Begin, Enum.UserInputState.End},
	Value = {Enum.UserInputState.Change}
}

local InputTypes = {
	Button = {
		MouseButton1 = {value = Enum.UserInputType.MouseButton1, valueType = Enum.UserInputType, valueStates = InputStates.Button},
		MouseButton2 = {value = Enum.UserInputType.MouseButton2, valueType = Enum.UserInputType, valueStates = InputStates.Button},
		MouseButton3 = {value = Enum.UserInputType.MouseButton3, valueType = Enum.UserInputType, valueStates = InputStates.Button},
		Touch = {value = Enum.UserInputType.Touch, valueType = Enum.UserInputType, valueStates = InputStates.Button},
	},
	Value = {
		Vector3 = {
			MouseMovement = {value = Enum.UserInputType.MouseMovement, valueType = Enum.UserInputType, valueStates = InputStates.Value},
			Thumbstick1 = {value = Enum.KeyCode.Thumbstick1, valueType = Enum.KeyCode, valueStates = InputStates.Value},
			Thumbstick2 = {value = Enum.KeyCode.Thumbstick2, valueType = Enum.KeyCode, valueStates = InputStates.Value}
		}
	}
}

for i, enum in pairs(Enum.KeyCode:GetEnumItems()) do
	if string.find(enum.Name,"Thumbstick") then return end
	InputTypes["Button"][enum.Name] = {value = enum, valueType = Enum.KeyCode}
end


return InputTypes