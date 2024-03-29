local message
local warning
local pause
local output

local isLive = Script ~= nil and Game ~= nil

if isLive then
	message = Game.PrintMessage
	warning = Game.PrintError
	pause = Script.QueueDelay
	---Queues a line of text to be entered as a chat command
	---@param content string The chat command t0 queue
	output = function(content) Script.QueueAction(Game.SendChat, content) end
else
	message = function(content) print("[PRINT] " .. content) end
	warning = function(content) print("[ERROR] " .. content) end
	pause = function(content) print("[PAUSE] " .. content) end
	output = function(content) print("[QUEUE] " .. content) end
end

return { message, warning, pause, output, isLive }
