local extractSegments = require 'extract'

local direction = {
	["+"] = "asc",
	["-"] = "des",
}

local err = Game ~= nil and Game.PrintError or print

local function assembleCommands(argline)
	local inventories, criteria = extractSegments(argline)
	local lines = {}
	for _,inv in ipairs(inventories) do
		table.insert(lines, "/itemsort clear " .. inv)
		for i = #criteria, 1, -1 do
			local filter = criteria[i]
			local dir = direction[filter:sub(1, 1)]
			local stat = filter:sub(2)
			if dir then
				table.insert(lines, string.format("/itemsort condition %s %s %s", inv, stat, dir))
			else
				err("No direction or invalid symbol for [" .. filter .. "] (must prefix filter stat with +/- for ascending/descending order)")
			end
		end
		table.insert(lines, "/itemsort execute " .. inv)
	end
	return lines
end

return assembleCommands
