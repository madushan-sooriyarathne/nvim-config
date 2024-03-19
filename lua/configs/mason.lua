local M = {}

M.options = {
	ensure_installed = {
		"lua-language-server",
		"html-lsp",
		"prettier",
		"prettierd",
		"stylua",
		"shfmt",
	},
	icons = {
		package_installed = "✓",
		package_pending = "➜",
		package_uninstalled = "✗",
	},
}

return M
