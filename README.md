# Requires WoLua
This is a [WoLua](https://github.com/PrincessRTFM/WoLua) command script for FFXIV. You will need to install the WoLua plugin via Dalamud (instructions at link) in order to use it.

![GitHub last commit (branch)](https://img.shields.io/github/last-commit/PrincessRTFM/WoLua.isort/master?label=updated)
[![GitHub issues](https://img.shields.io/github/issues-raw/PrincessRTFM/WoLua.isort?label=known%20issues)](https://github.com/PrincessRTFM/WoLua.isort/issues?q=is%3Aissue+is%3Aopen+sort%3Aupdated-desc)

[![Support me!](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/V7V7IK9UU)

## Usage
It is possible to configure your own sorting order for your inventory, and even to set different orders for different inventories. For example, your main inventory, armoury chest, retainer, and saddlebags can all have custom sorting orders. However, the means to do so in vanilla is clunky and not well documented. For example, you can use multiple conditions, but this isn't mentioned in the official documentation - nor is it mentioned that the conditions are LIFO, so the _last_ one you enter is the _first_ one applied. For another, macros only run to fifteen lines, so if you want detailed sorting, especially of multiple inventory types, you have to use multiple macros in a row.

This script aims to improve item sorting by providing a single command that takes multiple (comma-separated) inventory names followed by as many (space-separated) sorting filters as you want. The filters are executed FIFO, so natural left-to-right reading order will be the order of execution. All filters are applied to all of the inventories specified. You can even combine chunks of inventory names and filters into one command by separating them with semicolons.

## Inventories
- `inventory`, `inv`
- `retainer`
- `armoury`, `armory`
- `saddlebag`
- `rightsaddlebag`
- `mh`, `mainhand`
- `oh`, `offhand`
- `head`
- `body`
- `hands`
- `legs`
- `feet`
- `neck`
- `ears`
- `wrists`
- `rings`
- `soul`, `souls`, `soulgem`, `soulgems`

## Filters
:warning: Each filter item in the call must be prefixed with either `+` for ascending sort order (low to high) or `-` for descending order (high to low).

:warning: GP and CP are not available. This is because SE didn't offer those stats are sorting criteria. This script only generates and calls the vanilla `/itemsort` commands.

- `id`
- `spiritbond`
- `category`
- `lv`, `lvl`, `level`
- `ilv`, `ilvl`, `ilevel`, `itemlv`, `itemlvl`, `itemlevel`
- `stack`, `count`, `amount`, `quantity`
- `hq`, `nq`, `quality` (HQ > NQ - descending puts HQ first, ascending puts NQ first)
- `materia`
- `pdamage`
- `mdamage`
- `delay`
- `autoattack`
- `blockrate`
- `blockstrength`
- `defense`
- `mdefense`
- `str`, `strength`
- `dex`, `dexterity`
- `vit`, `vitality`
- `int`, `intelligence`
- `mnd`, `mind`
- `craftsmanship`
- `control`
- `gathering`
- `perception`
- `tab`

### Examples
- Sort your inventory and armoury by item category (ascending), then item level (descending), then NQ/HQ status (descending - HQ first), then item ID (ascending)
  ```
  /wolua call isort inventory,armoury +category -itemlevel -quality +id
  ```

- Sort your inventory and retainer by item category (ascending), then item level (ascending), then item ID (ascending), then NQ/HQ status (descending - HQ first), then stack size (ascending), and in the same command sort your armoury by item category (ascending), minimum level to equip (descending), item level (descending), materia (descending), spiritbond completion (descending), and finally item ID (ascending).
  ```
  /wolua call isort inv,retainer +category +ilv +id -hq +count; armory +category -lv -ilv -hq -materia -spiritbond +id
  ```
