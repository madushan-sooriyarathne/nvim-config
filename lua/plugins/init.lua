return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- for format on save
    cmd = { "ConformInfo" },
    opts = require "configs.conform",
  },

  -- LSP Config
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "mason-org/mason.nvim",
        lazy = false,
        opts = require("configs.mason").options,
      },
    },
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    keys = require("configs.claudecode").keys,
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    -- ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    -- opts = require("configs.typescript-tools").options,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = require "configs.treesitter",
  },

  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
  },
  -- Fast and feature-rich surround actions. For text that includes
  {
    "echasnovski/mini.surround",
    keys = require("configs.mini-surround").keys,
    opts = require("configs.mini-surround").options,
  },

  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    opts = require("configs.mini-comment").options,
  },
  {
    "windwp/nvim-ts-autotag",
    lazy = false,
    config = true,
  },

  -- Editor Related Plugins
  { "lewis6991/gitsigns.nvim", opts = require("configs.gitsigns").options, config = true },
  {
    "olimorris/persisted.nvim",
    event = "BufReadPre",
    opts = require("configs.persisted").options,
    keys = require("configs.persisted").keys,
  },
  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = require("configs.dressing").init,
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = require("configs.nvim-tree").options,
  },
  {
    "yaocccc/nvim-foldsign",
    lazy = false,
    opts = require("configs.nvim-foldsign").options,
    config = true,
  },

  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = require("configs.trouble").options,
    keys = require("configs.trouble").keys,
  },
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },
  -- search/replace in multiple files
  {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
    -- stylua: ignore
    keys = {
      "<leader>sr"
    },
  },

  -- fast search in the buffer with S key
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = require("configs.flash").keys,
  },

  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    dependencies = {
      {
        "ahmedkhalf/project.nvim",
        opts = {},
        event = "VeryLazy",
        config = function(_, opts)
          require("project_nvim").setup(opts)
          require("telescope").load_extension "projects"
        end,
        keys = {
          { "<leader>fp", "<Cmd>Telescope projects<CR>", desc = "Projects" },
        },
      },
      {
        "imNel/monorepo.nvim",
        config = function()
          ---@diagnostic disable-next-line: different-requires
          require("monorepo").setup(require("configs.monorepo").options)
        end,
        dependencies = {
          "nvim-telescope/telescope.nvim",
          "nvim-lua/plenary.nvim",
        },
      },
    },
    opts = require("configs.nvim-telescope").options,
  },

  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    event = "VimEnter", -- needed for folds to load in time and comments closed
    init = require("configs.nvim-ufo").init,
    opts = require("configs.nvim-ufo").options,
    keys = require("configs.nvim-ufo").keys,
  },

  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    config = true,
    ---@diagnostic disable-next-line: different-requires
    keys = require("configs.todo-comments").keys,
  },
  { "petertriho/nvim-scrollbar", version = "*", lazy = false, config = true },

  {
    "smjonas/inc-rename.nvim",
    opts = {
      input_buffer_type = "dressing",
    },
    config = true,
  },
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    opts = require("configs.vim-illuminate").options,
    config = require("configs.vim-illuminate").config,
    keys = require("configs.vim-illuminate").keys,
  },

  {
    "echasnovski/mini.bufremove",
    keys = require("configs.mini-buffermove").keys,
  },
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    dependencies = { "rafamadriz/friendly-snippets", "saadparwaiz1/cmp_luasnip" },
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
      { "onsails/lspkind.nvim", config = true },
    },
    opts = require("configs.nvim-cmp").options,
    config = require("configs.nvim-cmp").config,
  },

  -- Utility Plugins
  { "nvim-lua/plenary.nvim", lazy = true },
  {
    "andymass/vim-matchup",
    config = require("configs.vim-matchup").config,
  },
  {
    "alexghergh/nvim-tmux-navigation",
    lazy = false,
    opts = require("configs.nvim-tmux-navigation").options,
    config = true,
  },
  -- {
  --   "Exafunction/codeium.vim",
  --   event = "BufEnter",
  -- },
  {
    "supermaven-inc/supermaven-nvim",
    event = "BufEnter",
    config = function()
      require("supermaven-nvim").setup {}
    end,
  },
}
