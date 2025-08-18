-- load defaults i.e lua_lsp
local lspconfig = require "lspconfig"
local configs = require "nvchad.configs.lspconfig"

configs.defaults()
local on_attach = configs.on_attach
local on_init = configs.on_init
local capabilities = configs.capabilities
capabilities.textDocument.completion.completionItem.snippetSupport = true

local servers = {
  "eslint",
  "html",
  -- "denols",
  "cssls",
  "clangd",
  "dockerls",
  "bashls",
  "jsonls",
  "marksman",
  "postgres_lsp",
  -- "rust_analyzer",
  "sqlls",
  -- "svelte",
  "tailwindcss",
  "ts_ls",
  "yamlls",
  "gopls",
  "luals",
}

-- default setup for all servers
vim.lsp.config("*", {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
})

vim.lsp.enable(servers)

-- Individual Server configuration
--
-- Lua
vim.lsp.config("luals", {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".luarc.jsonc" },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

-- Rust
-- vim.lsp.config("rust_analyzer", {
--   settings = {
--     ["rust-analyzer"] = {
--       diagnostics = {
--         enable = false,
--       },
--     },
--   },
-- })

-- Go
vim.lsp.config("gopls", {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = lspconfig.util.root_pattern("go.mod", "go.work", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      staticcheck = true,
      analyses = {
        unusedparams = true,
      },
    },
  },
})

-- Deno
-- vim.lsp.config("denols", {
--   on_attach = on_attach,
--   root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
-- })

-- Typescript
-- vim.lsp.config("ts_ls", {
--   on_attach = on_attach,
--   root_dir = lspconfig.util.root_pattern("turbo.json", "tsconfig.json", "jsconfig.json", "package.json"),
--   single_file_support = true,
-- })

-- eslint
vim.lsp.config("eslint", {
  settings = {
    workingDirectory = { mode = "auto" },
  },
  on_attach = function(client, bufnr)
    -- Auto-fix on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function(event)
        local eslint_client = vim.lsp.get_clients({ bufnr = event.buf, name = "eslint" })[1]
        if eslint_client then
          local diag = vim.diagnostic.get(event.buf, { namespace = vim.lsp.diagnostic.get_namespace(eslint_client.id) })
          if #diag > 0 then
            vim.cmd "EslintFixAll"
          end
        end
      end,
    })

    -- ESLint keybindings for current buffer
    local opts = { buffer = bufnr, silent = true }
    vim.keymap.set("n", "<leader>lR", function()
      pcall(function()
        vim.cmd "LspRestart eslint"
        vim.notify("ESLint server restarted", vim.log.levels.INFO)
      end)
    end, vim.tbl_extend("force", opts, { desc = "Restart ESLint server" }))

    vim.keymap.set(
      "n",
      "<leader>lf",
      "<cmd>EslintFixAll<cr>",
      vim.tbl_extend("force", opts, { desc = "ESLint fix all" })
    )

    vim.keymap.set("n", "<leader>lr", function()
      vim.diagnostic.reset(vim.lsp.diagnostic.get_namespace(client.id), bufnr)
      vim.cmd "edit!"
      vim.notify("ESLint diagnostics refreshed", vim.log.levels.INFO)
    end, vim.tbl_extend("force", opts, { desc = "Refresh ESLint diagnostics" }))
  end,
})

-- cssls
vim.lsp.config("cssls", {
  settings = {
    css = { validate = true, lint = {
      unknownAtRules = "ignore",
    } },
    scss = { validate = true, lint = {
      unknownAtRules = "ignore",
    } },
    less = { validate = true, lint = {
      unknownAtRules = "ignore",
    } },
  },
})

-- tailwindcss
vim.lsp.config("tailwindcss", {
  settings = {

    filetypes_exclude = { "markdown" },
    tailwindCSS = {
      classAttributes = {
        "class",
        "className",
        "class:list",
        "classList",
        "ngClass",
      },
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidScreen = "error",
        invalidVariant = "error",
        invalidConfigPath = "error",
        invalidTailwindDirective = "error",
        recommendedVariantOrder = "warning",
        unknownAtRules = "ignore",
      },
      experimental = {
        classRegex = {
          { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
          { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
        },
      },
    },
  },
})

-- json
vim.lsp.config("jsonls", {
  settings = {
    json = {
      format = {
        enable = true,
      },
      validate = { enable = true },
    },
  },
})

-- yaml
vim.lsp.config("yamlls", {

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

-- marksman (markdown)
vim.lsp.config("marksman", {
  filetypes = { "markdown" },
})

-- User commands for ESLint operations
vim.api.nvim_create_user_command("EslintRestart", function()
  pcall(function()
    vim.cmd "LspRestart eslint"
    vim.notify("ESLint server restarted", vim.log.levels.INFO)
  end)
end, { desc = "Restart ESLint server" })

vim.api.nvim_create_user_command("EslintRefresh", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients { bufnr = bufnr, name = "eslint" }
  if #clients > 0 then
    local client = clients[1]
    vim.diagnostic.reset(vim.lsp.diagnostic.get_namespace(client.id), bufnr)
    vim.cmd "edit!"
    vim.notify("ESLint diagnostics refreshed", vim.log.levels.INFO)
  else
    vim.notify("No ESLint client found for this buffer", vim.log.levels.WARN)
  end
end, { desc = "Refresh ESLint diagnostics for current buffer" })

vim.api.nvim_create_user_command("EslintRestartAll", function()
  local all_clients = vim.lsp.get_clients { name = "eslint" }
  if #all_clients > 0 then
    pcall(function()
      vim.cmd "LspRestart eslint"
      vim.schedule(function()
        vim.diagnostic.reset()
        vim.notify("ESLint server restarted and all diagnostics cleared", vim.log.levels.INFO)
      end)
    end)
  else
    vim.notify("No ESLint clients found", vim.log.levels.WARN)
  end
end, { desc = "Restart ESLint server and clear all diagnostics" })
