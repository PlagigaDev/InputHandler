local InputType = require(script.Parent)

local CommonTypes = {}

for _, enum in pairs(Enum.UserInputType:GetEnumItems()) do
	CommonTypes[enum.Name] = InputType.new(enum, Enum.UserInputType, enum.Name)
end

for _, enum in pairs(Enum.KeyCode:GetEnumItems()) do
	CommonTypes[enum.Name] = InputType.new(enum, Enum.KeyCode, enum.Name)
end

return CommonTypes