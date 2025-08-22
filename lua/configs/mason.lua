local M = {}

M.options = {
  icons = {
    package_installed = "✓",
    package_pending = "➜",
    package_uninstalled = "✗",
  },
  ensure_installed = {
    "lua_ls",
    "eslint",
    "html",
    "cssls",
    "clangd",
    "dockerls",
    "bashls",
    "jsonls",
    "marksman",
    "postgrestools",
    "sqlls",
    "tailwindcss",
    "ts_ls",
    "yamlls",
    "gopls",
  },
}

return M
