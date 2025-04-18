local M = {}

local lazy = require "lazy"

M.init = function()
  ---@diagnostic disable-next-line: duplicate-set-field
  vim.ui.select = function(...)
    lazy.load { plugins = { "dressing.nvim" } }
    return vim.ui.select(...)
  end

  ---@diagnostic disable-next-line: duplicate-set-field
  vim.ui.input = function(...)
    lazy.load { plugins = { "dressing.nvim" } }
    return vim.ui.input(...)
  end
end

return M
