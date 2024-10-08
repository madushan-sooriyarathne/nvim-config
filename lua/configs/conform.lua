local M = {}

M.options = {
	lsp_fallback = true,

	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "black" },
		javascript = { "prettierd", "prettier" },
		html = { "prettierd", "prettier" },
		css = { "prettierd", "prettier" },
		javascriptreact = { "prettierd", "prettier" },
		json = { "prettierd", "prettier" },
		graphql = { "prettierd", "prettier" },
		svlete = { "prettierd", "prettier" },
		typescript = { "prettierd" },
		typescriptreact = { "prettierd" },
		markdown = { "prettierd", "prettier" },
		sql = { "pgformat" },
		sh = { "shfmt" },
		xml = { "xmllint" },
		svg = { "xmllint" },
	},
	-- Set up format-on-save
	format_on_save = { timeout_ms = 2000, lsp_fallback = true },
	-- Customize formatters
	formatters = {
		shfmt = {
			prepend_args = { "-i", "2" },
		},
		xmllint = {
			prepend_args = { "--format" },
			command = "/usr/bin/xmllint",
		},
	},
}

M.keys = {
	{
		-- Customize or remove this keymap to your liking
		"<leader>f",
		function()
			require("conform").format({ async = true, lsp_fallback = true })
		end,
		mode = "",
		desc = "Format buffer",
	},
}

return M
