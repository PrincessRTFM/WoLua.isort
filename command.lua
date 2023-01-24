local assembleCommands = require 'assemble'
local split = require 'split'

local live = Script ~= nil and Game ~= nil

local function core(argline)
	argline = argline:gsub("^%s+", ""):gsub("%s+$", "")
	local chunks = split(argline, "%s*;%s*")
	local commands = {}
	for _,chunk in ipairs(chunks) do
		print("Processing instruction chunk: " .. chunk)
		for _,line in ipairs(assembleCommands(chunk)) do
			table.insert(commands, line)
		end
	end
	print(string.format("Generated %d commands", #commands))
	if #commands == 0 then
		Game.PrintError("Nothing to do - invalid input?")
		return
	end
	for i,c in ipairs(commands) do
		print(string.format("%0" .. #tostring(#commands) .. "d: %s", i, c))
		if live then
			Game.SendChat(c)
			--Script.QueueAction(Game.SendChat, c)
			--Script.QueueDelay(i * 1)
		end
	end
	if live then
		Game.Toast.TaskComplete("Sorting operation complete!")
		--Script.QueueAction(Game.Toast.TaskComplete, "Sorting operation complete!")
	end
end

if live then
	Script(core)
else
	return core
end
