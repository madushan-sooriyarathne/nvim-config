local M = {}

M.options = {
  silent = false, -- Suppresses vim.notify messages
  autoload_telescope = true, -- Automatically load telescope extension
  data_path = vim.fn.stdpath "data", -- Where to store monorepo.json
}

return M
