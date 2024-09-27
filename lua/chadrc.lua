local M = {}
local hightlights = require("highlights")

M.ui = {
  theme = "doomchad",
  theme_toggle = { "doomchad", "doomchad" },

  hl_override = hightlights.override,

  hl_add = hightlights.add,

  lsp = { signature = true },

  cheatsheet = {
    theme = "grid",                                                     -- simple/grid
    excluded_groups = { "terminal (t)", "autopairs", "Nvim", "Opens" }, -- can add group name or with mode
  },

  mason = {
    cmd = true,
    pkgs = {
      "lua-language-server",
      "html-lsp",
      "prettier",
      "prettierd",
      "stylua",
      "shfmt",


      -- web dev stuff
      "cssls",
      "html",
      "svelte",
      "tailwindcss",
      "ts_ls",
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
    }
  },

  nvdash = {
    load_on_startup = true,

    header = {
      "███╗░░██╗██╗██╗░░██╗██╗██╗░░░░░  ░█████╗░██████╗░░██████╗████████╗░█████╗░████████╗",
      "████╗░██║██║██║░░██║██║██║░░░░░  ██╔══██╗██╔══██╗██╔════╝╚══██╔══╝██╔══██╗╚══██╔══╝",
      "██╔██╗██║██║███████║██║██║░░░░░  ██║░░██║██████╦╝╚█████╗░░░░██║░░░███████║░░░██║░░░",
      "██║╚████║██║██╔══██║██║██║░░░░░  ██║░░██║██╔══██╗░╚═══██╗░░░██║░░░██╔══██║░░░██║░░░",
      "██║░╚███║██║██║░░██║██║███████╗  ╚█████╔╝██████╦╝██████╔╝░░░██║░░░██║░░██║░░░██║░░░",
      "╚═╝░░╚══╝╚═╝╚═╝░░╚═╝╚═╝╚══════╝  ░╚════╝░╚═════╝░╚═════╝░░░░╚═╝░░░╚═╝░░╚═╝░░░╚═╝░░░",
      "                          Nothing stands in the way                                ",
      "                                                                                   ",
      "              Custom NeoVim configuration by Madushan Sooriyarathne                ",
      "                            ✉️ hello@madushan.dev                                   ",
      "                          🌐 https://madushan.dev                                  ",
    },
    buttons = {
      { "  Find File", "Spc f f", "Telescope find_files" },
      { "  Recent Projects", "Spc f p", "Telescope projects" },
      { "󰈚  Recent Files", "Spc f o", "Telescope oldfiles" },
      { "󰈭  Find Word", "Spc f w", "Telescope live_grep" },
      { "  Bookmarks", "Spc m a", "Telescope marks" },
      { "ℳ  Mason", "Spc m m", "Mason" },
      { "  Themes", "Spc t h", "Telescope themes" },
      { "  Mappings", "Spc c h", "NvCheatsheet" },
    },
  },
}

return M
