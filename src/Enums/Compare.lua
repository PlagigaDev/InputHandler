return function (input: InputObject, inputType)
	return input[inputType.valueType.Name] == inputType.value
end