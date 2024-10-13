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
        "williamboman/mason.nvim",

        lazy = false,
        opts = require("configs.mason").options,
      },
      {

        "williamboman/mason-lspconfig.nvim",
        config = true,
      },
    },
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
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
    "stevearc/dressing.nvim",
    lazy = true,
    init = require("configs.dressing").init,
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = require("configs.nvim-tree").options,
  },

  {
    "malbertzard/inline-fold.nvim",
    opts = require("configs.inline-fold").options,
    config = true,
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
    opts = { use_diagnostic_signs = true },
    keys = {
      "<leader>tx",
      "<leader>tX",
      "<leader>tL",
      "<leader>tQ",
      "[q",
      "]q",
    },
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
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
    },
    opts = require("configs.nvim-cmp").options,
  },

  -- Utility Plugins
  { "nvim-lua/plenary.nvim", lazy = true },
  {
    "rmagatti/auto-session",
    lazy = false,
    opts = require("configs.auto-session").options,
    config = true,
  },
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
}
