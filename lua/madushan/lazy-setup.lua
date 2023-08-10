local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
    -- core plugins
    { import = "madushan.plugins" },

    -- formatters / linters and language specific plugins
    { import = "madushan.plugins.extras.formatting.prettier" },
    { import = "madushan.plugins.extras.linting.eslint" },
    { import = "madushan.plugins.extras.lang.docker" },
    { import = "madushan.plugins.extras.lang.json" },
    { import = "madushan.plugins.extras.lang.tailwind" },
    { import = "madushan.plugins.extras.lang.typescript" },
    { import = "madushan.plugins.extras.lang.yaml" },
    { import = "madushan.plugins.extras.util.mini-hipatterns" },
    -- {import = "madushan.plugins.extras.lang.rust"},
    -- {import = "madushan.plugins.extras.lang.python"},
    -- {import = "madushan.plugins.extras.lang.python-semshi"},

    -- debug adapters
    -- { import = "madushan.plugins.extras.dap.core" },
    -- { import = "madushan.plugins.extras.dap.nlua" },

    -- Testing
    -- { import = "madushan.plugins.extras.test.core" },
  },
  install = { colorscheme = { "catppuccin" } },
  checker = { enabled = true }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
