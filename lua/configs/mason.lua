local options = {
	ensure_installed = {
		-- lua stuff
		"lua-language-server",
		"stylua",

		-- web dev stuff
		"css-lsp",
		"html-lsp",
		"js-debug-adapter",
		"prettierd",
		"svelte-language-server",
		"tailwindcss-language-server",
		"typescript-language-server",
		"prettier",
		"json-lsp",

		-- rust
		"rust-analyzer",

		-- sql
		"sqlls",

		-- docker
		"docker-compose-language-service",
		"dockerfile-language-server",

		--yaml
		"yaml-language-server",
	},
}

require("mason").setup(options)
