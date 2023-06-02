return function (state: Enum.UserInputState): string
	if state == Enum.UserInputState.Begin then
		return "Began"
	elseif state == Enum.UserInputState.Change then
		return "Changed"
	end
	return "Ended"
end