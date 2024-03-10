local options = {
	ensure_installed = {
		-- lua stuff
		"lua-language-server",
		"stylua",

		-- web dev stuff
		"css-lsp",
		-- "eslint-lsp",
		"html-lsp",
		"js-debug-adapter",
		"prettierd",
		"svelte-language-server",
		"tailwindcss-language-server",
		"typescript-language-server",
		"css-lsp",
		"html-lsp",
		"prettier",
		-- docker files
		"hadolint",
	},
}

require("mason").setup(options)
