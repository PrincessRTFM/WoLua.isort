---Split a string into a table on a given separator, optionally limiting the number of splits and treating the separator as plain text or a pattern
---@param target string The whole string to be split
---@param separator string The pattern (or substring) to split on
---@param maxSplits? number The maximum number of times to split, or -1 for infinite
---@param plain? boolean Whether to treat the separator as a substring instead of a pattern
---@return table split The list of substrings between the separators
local function split(target, separator, maxSplits, plain)
	local self = tostring(target)
	maxSplits = math.floor(tonumber(maxSplits) or -1)
	if maxSplits == 0 then maxSplits = -1 end
	assert(separator ~= "")
	assert(maxSplits == -1 or maxSplits > 0)
	local results = {}
	if self:len() > 0 then
		local idx, start = 1, 1
		local first, last = self:find(separator, start, plain)
		while first and maxSplits ~= 0 do
			results[idx] = self:sub(start, first - 1)
			idx = idx + 1
			start = last + 1
			first, last = self:find(separator, start, plain)
			maxSplits = maxSplits - 1
		end
		results[idx] = self:sub(start)
	end
	return results
end

return split
