-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()
local lspconfig = require "lspconfig"
local configs = require "nvchad.configs.lspconfig"

local on_attach = configs.on_attach
local on_init = configs.on_init
local capabilities = configs.capabilities
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- EXAMPLE
local servers = {
  "eslint",
  "html",
  "cssls",
  "clangd",
  "dockerls",
  "bashls",
  "jsonls",
  "ltex",
  "postgres_lsp",
  "rust_analyzer",
  "sqlls",
  "svelte",
  "tailwindcss",
  "ts_ls",
  "yamlls",
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- Individual Server configuration
-- Rust
require("lspconfig").rust_analyzer.setup {
  settings = {
    ["rust-analyzer"] = {
      diagnostics = {
        enable = false,
      },
    },
  },
}

-- eslint
require("lspconfig").eslint.setup {
  settings = {
    workingDirectory = { mode = "auto" },
  },
  on_attach = function()
    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function(event)
        local client = vim.lsp.get_active_clients({ bufnr = event.buf, name = "eslint" })[1]
        if client then
          local diag = vim.diagnostic.get(event.buf, { namespace = vim.lsp.diagnostic.get_namespace(client.id) })
          if #diag > 0 then
            vim.cmd "EslintFixAll"
          end
        end
      end,
    })
  end,
}

-- tailwind
require("lspconfig").tailwindcss.setup {
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
}

--json
require("lspconfig").jsonls.setup {
  settings = {
    json = {
      format = {
        enable = true,
      },
      validate = { enable = true },
    },
  },
}

require("lspconfig").yamlls.setup {

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
}
