-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors

local M = {}

---@type Base46HLGroupsList
M.override = {
	Comment = {
		italic = true,
		fg = "red",
	},
	CursorLine = {
		bg = "#161a1d",
	},
	visual = {
		bg = "#6c757d",
	},
	-- spell
	SpellBad = {
		undercurl = true,
		sp = "#e63946",
	},

	Spelllocal = {
		undercurl = true,
		sp = "#e9edc9",
	},

	SpellCap = {
		undercurl = true,
		sp = "#fca311",
	},

	SpellRare = {
		undercurl = true,
		sp = "#8338ec",
	},
}

---@type HLTable
M.add = {
	NvimTreeOpenedFolderName = { fg = "green", bold = true },
}

return M
