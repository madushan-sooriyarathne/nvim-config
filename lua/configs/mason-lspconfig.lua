local M = {}
M.options = {

	ensure_installed = {
		-- lua stuff
		"lua_ls",

		-- web dev stuff
		"cssls",
		"html",
		"svelte",
		"tailwindcss",
		"tsserver",
		"jsonls",
		"eslint",

		-- rust
		"rust_analyzer",

		-- sql
		"sqlls",

		-- docker
		"dockerls",

		--yaml
		"yamlls",
	},
}

return M
