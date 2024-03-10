local M = {}

local lazy = require("lazy")

M.init = function()
	vim.ui.select = function(...)
		lazy.load({ plugins = { "dressing.nvim" } })
		return vim.ui.select(...)
	end

	vim.ui.input = function(...)
		lazy.load({ plugins = { "dressing.nvim" } })
		return vim.ui.input(...)
	end
end

return M
