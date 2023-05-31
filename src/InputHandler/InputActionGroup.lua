local root = script.Parent
local InputAction = require(root:WaitForChild("InputAction"))

export type ActionGroup = {
	_enabled: boolean,
	_name: string,
	inputActions: {[string]: InputAction.InputAction},
	new: (name: string, enabled: boolean?) -> (ActionGroup),
	enable: (self: ActionGroup) -> (),
	disable: (self: ActionGroup) -> (),
	setEnabled: (self: ActionGroup, value: boolean) -> (),
	addInputAction: (self: ActionGroup, name: string, enabled: boolean?) -> (),
	removeInputAction: (self: ActionGroup, name: string) -> (),
	getEnabled: (self: ActionGroup) -> (boolean),
	setName: (self: ActionGroup, name: string) -> (),
	getName: (self: ActionGroup) -> (string)
}

local InputActionGroup = {}
InputActionGroup.__index = {}

return InputActionGroup