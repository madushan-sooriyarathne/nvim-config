local M = {}

M.options = {
	lsp_fallback = true,

	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "black" },
		javascript = { { "prettierd", "prettier" } },
		html = { { "prettierd", "prettier" } },
		css = { { "prettierd", "prettier" } },
		javascriptreact = { { "prettierd", "prettier" } },
		json = { { "prettierd", "prettier" } },
		graphql = { { "prettierd", "prettier" } },
		svlete = { { "prettierd", "prettier" } },
		typescript = { { "prettierd", "prettier" } },
		typescriptreact = { { "prettierd", "prettier" } },
		markdown = { { "prettierd", "prettier" } },
		sql = { "pgformat" },
		sh = { "shfmt" },
	},
	-- Set up format-on-save
	format_on_save = { timeout_ms = 500, lsp_fallback = true },
	-- Customize formatters
	formatters = {
		shfmt = {
			prepend_args = { "-i", "2" },
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
