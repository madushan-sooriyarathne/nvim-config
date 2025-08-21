-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

local highlights = require "highlights"

---@type ChadrcConfig
local options = {

  base46 = {
    theme = "kanagawa",

    hl_override = highlights.override,
    hl_add = highlights.add,
  },
}

return options
