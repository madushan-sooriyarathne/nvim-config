require("nvchad.configs.lspconfig").defaults()

local servers = {
  html = {},
  biome = {},
  eslint = {
    settings = {
      experimental = {
        useFlatConfig = true,
      },
      codeActionOnSave = {
        enable = true,
        mode = "all",
      },
      problems = {
        shortenToSingleLine = true,
      },
    },
    on_attach = function(client, bufnr)
      -- User commands for ESLint operations
      vim.api.nvim_buf_create_user_command(0, "EslintRestart", function()
        pcall(function()
          vim.cmd "LspRestart eslint"
          vim.notify("ESLint server restarted", vim.log.levels.INFO)
        end)
      end, { desc = "Restart ESLint server" })

      vim.api.nvim_buf_create_user_command(0, "EslintRefresh", function()
        local clients = vim.lsp.get_clients { bufnr = bufnr, name = "eslint" }
        if #clients > 0 then
          local eslintClient = clients[1]
          vim.diagnostic.reset(vim.lsp.diagnostic.get_namespace(eslintClient.id), bufnr)
          vim.cmd "edit!"
          vim.notify("ESLint diagnostics refreshed", vim.log.levels.INFO)
        else
          vim.notify("No ESLint client found for this buffer", vim.log.levels.WARN)
        end
      end, { desc = "Refresh ESLint diagnostics for current buffer" })

      vim.api.nvim_buf_create_user_command(0, "EslintRestartAll", function()
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
      vim.api.nvim_buf_create_user_command(0, "LspEslintFixAll", function()
        client:request_sync("workspace/executeCommand", {
          command = "eslint.applyAllFixes",
          arguments = {
            {
              uri = vim.uri_from_bufnr(bufnr),
              ---@diagnostic disable-next-line: undefined-global
              version = lsp.util.buf_versions[bufnr],
            },
          },
        }, nil, bufnr)
      end, {})

      -- Auto-fix on save
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function(event)
          local eslint_client = vim.lsp.get_clients({ bufnr = event.buf, name = "eslint" })[1]
          if eslint_client then
            local diag =
              vim.diagnostic.get(event.buf, { namespace = vim.lsp.diagnostic.get_namespace(eslint_client.id) })
            if #diag > 0 then
              vim.cmd "LspEslintFixAll"
            end
          end
        end,
      })

      -- ESLint keybindings for current buffer
      local opts = { buffer = bufnr, silent = true }
      vim.keymap.set("n", "<leader>cR", function()
        pcall(function()
          vim.cmd "LspRestart eslint"
          vim.notify("ESLint server restarted", vim.log.levels.INFO)
        end)
      end, vim.tbl_extend("force", opts, { desc = "Restart ESLint server" }))

      vim.keymap.set(
        "n",
        "<leader>cf",
        "<cmd>LspEslintFixAll<cr>",
        vim.tbl_extend("force", opts, { desc = "ESLint fix all" })
      )

      vim.keymap.set("n", "<leader>r", function()
        vim.diagnostic.reset(vim.lsp.diagnostic.get_namespace(client.id), bufnr)
        vim.cmd "edit!"
        vim.notify("ESLint diagnostics refreshed", vim.log.levels.INFO)
      end, vim.tbl_extend("force", opts, { desc = "Refresh ESLint diagnostics" }))
    end,
  },
  cssls = {
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
  },
  tailwindcss = {
    settings = {
      filetypes_exclude = { "markdown" },
      tailwindCSS = {
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
  },
  ts_ls = {},
  jsonls = {
    settings = {
      json = {
        format = {
          enable = true,
        },
        validate = { enable = true },
      },
    },
  },
  clangd = {},
  bashls = {},
  yamlls = {
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
  },
  dockerls = {},
  marksman = {},
  postgres_lsp = {},
  sqlls = {},
  gopls = {
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
  },
  lua_ls = {
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
  },
}

for name, opts in pairs(servers) do
  vim.lsp.enable(name)
  vim.lsp.config(name, opts)
end
