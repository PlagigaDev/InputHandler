local UserInputService = game:GetService("UserInputService")

local root = script.Parent
local Enums = root:WaitForChild("Enums")

local InputType = require(Enums:WaitForChild("InputType"))

local Listener = {}
Listener.__index = Listener


function Listener.new(inputAction, inputType, enabled: boolean?, alwaysActive: boolean?)
	local self = setmetatable({
		_enabled = enabled or true,
		_connected = false,
		_inputAction = inputAction,
		_connectionType = inputType,
		pressed = false
	},
	Listener)
	self:connect()
	return self
end

function Listener:enable()
	self:connect()
	self._enabled = true
end

function Listener:disable()
	self:disconnect()
	self._enabled = false
end

function Listener:setEnabled(value: boolean)
	if value then
		self:enable()
		return
	end
	self:disable()
end

function Listener:connect()
	if self._connected then self:disconnect() end

	self._listenBegan = UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
		
	end)
	self._listenChanged = UserInputService.InputChanged:Connect(function(input, gameProcessedEvent)
		
	end)
	self._listenEnded = UserInputService.InputEnded:Connect(function(input, gameProcessedEvent)
		
	end)

	self._connected = true
end

function Listener:disconnect()
	self._listenBegan:Disconnect()

	self._listenChanged:Disconnect()

	self._listenEnded:Disconnect()
	self._connected = false
end

function Listener:changeInput(inputType)
	self._connectionType = inputType
	self:connect()
end

return Listener