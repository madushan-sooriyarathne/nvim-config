-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors

local M = {}

---@type Base46HLGroupsList
M.override = {
  Comment = { italic = true },

  SpellBad = {
    italic = true,
    fg = "#c1121f",
    undercurl = true,
    bold = true,
  },
  SpellRare = {
    fg = "#dda15e",
    bold = true,
  },

  CursorLine = {
    bg = "#161a1d",
  },
  visual = {
    bg = "#6c757d",
  },

  Spelllocal = {
    undercurl = true,
    sp = "#e9edc9",
  },

  SpellCap = {
    undercurl = true,
    sp = "#fca311",
  },
}

---@type HLTable
M.add = {
  NvimTreeOpenedFolderName = { fg = "green", bold = true },
  CmpItemKindSupermaven = { fg = "#f0a30a" },
}

return M
