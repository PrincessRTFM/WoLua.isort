local function split(target, separator, maxSplits, plain)
	self = tostring(target)
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
