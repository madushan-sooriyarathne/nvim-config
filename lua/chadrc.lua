-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

local highlights = require "highlights"

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "kanagawa",

  hl_override = highlights.override,
  hl_add = highlights.add,
}

M.ui = {
  mason = {
    cmd = true,
    pkgs = {
      "lua-language-server",
      "eslint-lsp",
      "html-lsp",
      "prettier",
      "prettierd",
      "stylua",
      "shfmt",

      -- web dev stuff
      "cssls",
      "html",
      -- "svelte",
      "tailwindcss",
      "ts_ls",
      "jsonls",
      -- rust
      -- "rust_analyzer",

      -- sql
      "sqlls",

      -- docker
      "dockerls",

      --yaml
      "yamlls",

      -- go
      "gopls",
    },
  },
}
return M
