local InputType = require(script.Parent)

local CommonTypes = {
	MouseButton1 = InputType.new(Enum.UserInputType.MouseButton1, Enum.UserInputType, "MouseButton1"),
	MouseButton2 =  InputType.new(Enum.UserInputType.MouseButton2,  Enum.UserInputType,  "MouseButton2"),
	MouseButton3 = InputType.new(Enum.UserInputType.MouseButton3, Enum.UserInputType, "MouseButton3"),
	Touch = InputType.new(Enum.UserInputType.Touch,  Enum.UserInputType, "Touch"),
	MouseMovement = InputType.new(Enum.UserInputType.MouseMovement, Enum.UserInputType, "MouseMovement"),
}

for i, enum in pairs(Enum.KeyCode:GetEnumItems()) do
	CommonTypes[enum.Name] = InputType.new(enum, Enum.KeyCode, enum.Name)
end

return CommonTypes