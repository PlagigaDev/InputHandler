return function (state: Enum.UserInputState): boolean
	local UserInputState = Enum.UserInputState
	return state == UserInputState.Begin or state == UserInputState.Change or UserInputState == UserInputState.End
end