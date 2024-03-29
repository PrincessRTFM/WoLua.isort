local inventories = {
	inventory = true;
	retainer = true;
	armoury = true;
	saddlebag = true;
	rightsaddlebag = true;
	mh = true;
	oh = true;
	head = true;
	body = true;
	hands = true;
	legs = true;
	feet = true;
	neck = true;
	ears = true;
	wrists = true;
	rings = true;
	soul = true;
}
local conditions = {
	id = true;
	spiritbond = true;
	category = true;
	lv = true;
	ilv = true;
	stack = true;
	hq = true;
	materia = true;
	pdamage = true;
	mdamage = true;
	delay = true;
	autoattack = true;
	blockrate = true;
	blockstrength = true;
	defense = true;
	mdefense = true;
	str = true;
	dex = true;
	vit = true;
	int = true;
	mnd = true;
	craftsmanship = true;
	control = true;
	gathering = true;
	perception = true;
	tab = true;
}

local inventoryAliases = {
	inv = "inventory";
	armory = "armoury";
	mainhand = "mh";
	offhand = "oh";
	souls = "soul";
	soulgem = "soul";
	soulgems = "soul";
}
local conditionAliases = {
	lvl = "lv";
	level = "lv";
	ilvl = "ilv";
	ilevel = "ilv";
	itemlv = "ilv";
	itemlvl = "ilv";
	itemlevel = "ilv";
	count = "stack";
	amount = "stack";
	quantity = "stack";
	nq = "hq";
	quality = "hq";
	strength = "str";
	dexterity = "dex";
	vitality = "vit";
	intelligence = "int";
	mind = "mnd";
}

local split = require "split"

local message, warning, pause, output, live = table.unpack(require "context")

---Takes the user's sorting specification for a group of inventories and their ordering, and produces the alias-resolved list of inventory names and sorting criteria to operate on
---@param argline string The set of comma-separated inventories followed by space-separated sorting criteria
---@return table inventories The list of inventories that these sorting criteria apply to
---@return table criteria The list of sorting criteria to apply to these inventories
local function extractSegments(argline)
	local targetstr, orderstr = argline:lower():match("([a-z,]+)%s+(.+)")
	local rawTargets = split(tostring(targetstr), ",")
	local rawCriteria = split(tostring(orderstr), "%s+")
	local targets = {}
	local criteria = {}
	print(string.format("Parsed %d inventor%s from %s", #rawTargets, #rawTargets == 1 and "y" or "ies", tostring(targetstr)))
	print(string.format("Parsed %d criteria from %s", #rawCriteria, tostring(orderstr)))
	for i, v in ipairs(rawTargets) do
		while inventoryAliases[v] do
			v = inventoryAliases[v]
		end
		if inventories[v] then
			table.insert(targets, v)
		else
			warning(string.format("Filtering out invalid inventory name %s", v))
		end
	end
	for i, v in ipairs(rawCriteria) do
		while conditionAliases[v:sub(2)] do
			v = v:sub(1, 1) .. conditionAliases[v:sub(2)]
		end
		if conditions[v:sub(2)] then
			table.insert(criteria, v)
		else
			warning(string.format("Filtering out invalid sorting criteria string %s", v))
		end
	end
	return targets, criteria
end

return extractSegments
