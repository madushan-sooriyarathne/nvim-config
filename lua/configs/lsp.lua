local configs = require("nvchad.configs.lspconfig")

local on_attach = configs.on_attach
local on_init = configs.on_init
local capabilities = configs.capabilities
capabilities.textDocument.completion.completionItem.snippetSupport = true

local lspconfig = require("lspconfig")
local servers = {
	"html",
	"eslint",
	"cssls",
	"clangd",
	"dockerls",
	"bashls",
	"htmx",
	"jsonls",
	"ltex",
	"postgres_lsp",
	"rust_analyzer",
	"sqlls",
	"svelte",
	"tailwindcss",
	"tsserver",
	"yamlls",
}

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_init = on_init,
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

-- individual server setup
-- rust_analyzer
require("lspconfig").rust_analyzer.setup({
	settings = {
		["rust-analyzer"] = {
			diagnostics = {
				enable = false,
			},
		},
	},
})

-- eslint
require("lspconfig").eslint.setup({
	settings = {
		workingDirectory = { mode = "auto" },
	},
	on_attach = function()
		vim.api.nvim_create_autocmd("BufWritePre", {
			callback = function(event)
				local client = vim.lsp.get_active_clients({ bufnr = event.buf, name = "eslint" })[1]
				if client then
					local diag =
						vim.diagnostic.get(event.buf, { namespace = vim.lsp.diagnostic.get_namespace(client.id) })
					if #diag > 0 then
						vim.cmd("EslintFixAll")
					end
				end
			end,
		})
	end,
})

--tsserver
require("lspconfig").tsserver.setup({
	keys = {
		{ "<leader>co", "<cmd>TypescriptOrganizeImports<CR>", desc = "Organize Imports" },
		{ "<leader>cR", "<cmd>TypescriptRenameFile<CR>", desc = "Rename File" },
	},
	settings = {
		typescript = {
			format = {
				indentSize = vim.o.shiftwidth,
				convertTabsToSpaces = vim.o.expandtab,
				tabSize = vim.o.tabstop,
			},
		},
		javascript = {
			format = {
				indentSize = vim.o.shiftwidth,
				convertTabsToSpaces = vim.o.expandtab,
				tabSize = vim.o.tabstop,
			},
		},
		completions = {
			completeFunctionCalls = true,
		},
	},
})

-- tailwind
require("lspconfig").tailwindcss.setup({
	settings = {
		filetypes_exclude = { "markdown" },
		tailwindCSS = {
			experimental = {
				classRegex = {
					{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
					{ "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
				},
			},
		},
	},
})

--json
require("lspconfig").jsonls.setup({
	on_new_config = function(new_config)
		new_config.settings.json.schemas = new_config.settings.json.schemas or {}
		vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
	end,
	settings = {
		json = {
			format = {
				enable = true,
			},
			validate = { enable = true },
		},
	},
})

require("lspconfig").yamlls.setup({

	-- Have to add this for yamlls to understand that we support line folding
	capabilities = {
		textDocument = {
			foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			},
		},
	},
	-- lazy-load schemastore when needed
	on_new_config = function(new_config)
		new_config.settings.yaml.schemas = new_config.settings.yaml.schemas or {}
		vim.list_extend(new_config.settings.yaml.schemas, require("schemastore").yaml.schemas())
	end,
	settings = {
		redhat = { telemetry = { enabled = false } },
		yaml = {
			keyOrdering = false,
			format = {
				enable = true,
			},
			validate = true,
			schemaStore = {
				-- Must disable built-in schemaStore support to use
				-- schemas from SchemaStore.nvim plugin
				enable = false,
				-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
				url = "",
			},
		},
	},
})

-- Without the loop, you would have to manually set up each LSP
--
-- lspconfig.html.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }
--
-- lspconfig.cssls.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }
