local M = {}
M.options = {
  offset = -2,
  foldsigns = {
    open = "-", -- mark the beginning of a fold
    close = "+", -- show a closed fold
    seps = { "│", "┃" }, -- open fold middle marker
  },
}

return M
