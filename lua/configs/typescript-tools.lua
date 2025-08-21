-- ============================================================================
-- TYPESCRIPT-TOOLS CONFIGURATION
-- ============================================================================
-- Enhanced TypeScript integration with better diagnostics and type checking
-- Configured to work alongside ESLint for comprehensive JS/TS development

local M = {}

M.options = {
  on_attach = function(client, bufnr)
    -- Disable typescript-tools formatting in favor of conform.nvim
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    -- TypeScript-specific keybindings
    local opts = { buffer = bufnr, silent = true }
    vim.keymap.set(
      "n",
      "<leader>to",
      "<cmd>TSToolsOrganizeImports<cr>",
      vim.tbl_extend("force", opts, { desc = "Organize imports" })
    )
    vim.keymap.set(
      "n",
      "<leader>tO",
      "<cmd>TSToolsSortImports<cr>",
      vim.tbl_extend("force", opts, { desc = "Sort imports" })
    )
    vim.keymap.set(
      "n",
      "<leader>tu",
      "<cmd>TSToolsRemoveUnused<cr>",
      vim.tbl_extend("force", opts, { desc = "Remove unused statements" })
    )
    vim.keymap.set(
      "n",
      "<leader>tz",
      "<cmd>TSToolsGoToSourceDefinition<cr>",
      vim.tbl_extend("force", opts, { desc = "Go to source definition" })
    )
    vim.keymap.set(
      "n",
      "<leader>tI",
      "<cmd>TSToolsAddMissingImports<cr>",
      vim.tbl_extend("force", opts, { desc = "Add missing imports" })
    )
    vim.keymap.set(
      "n",
      "<leader>tF",
      "<cmd>TSToolsFixAll<cr>",
      vim.tbl_extend("force", opts, { desc = "Fix all issues" })
    )
  end,
  handlers = {
    -- Enhance hover with better formatting
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "rounded",
    }),
    -- Better signature help
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = "rounded",
    }),
  },
  settings = {
    separate_diagnostic_server = true,
    publish_diagnostic_on = "insert_leave",
    expose_as_code_action = {
      "fix_all",
      "add_missing_imports",
      "remove_unused",
      "remove_unused_imports",
      "organize_imports",
    },
    tsserver_path = nil,
    tsserver_plugins = {},
    tsserver_max_memory = "auto",
    tsserver_format_options = {},
    tsserver_file_preferences = {
      -- Enable inlay hints
      includeInlayParameterNameHints = "literal",
      includeInlayParameterNameHintsWhenArgumentMatchesName = false,
      includeInlayVariableTypeHints = false,
      includeInlayFunctionParameterTypeHints = false,
      includeInlayFunctionLikeReturnTypeHints = false,
      includeInlayPropertyDeclarationTypeHints = false,
      includeInlayEnumMemberValueHints = false,
    },
    tsserver_locale = "en",
    complete_function_calls = false,
    include_completions_with_insert_text = true,
    code_lens = "off",
    disable_member_code_lens = true,
    jsx_close_tag = {
      enable = false,
      filetypes = { "javascriptreact", "typescriptreact" },
    },
  },
}

return M
