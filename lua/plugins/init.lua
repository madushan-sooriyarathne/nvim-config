return {
	--lspensure
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
				opts = require("configs.mason-lspconfig").options,
				config = true,
			},
		},
		config = function()
			require("nvchad.configs.lspconfig").defaults()
			require("configs.lsp")
		end,
	},

	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
	},

	-- formatting
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		---@diagnostic disable-next-line: different-requires
		opts = require("configs.conform").options,
		---@diagnostic disable-next-line: different-requires
		keys = require("configs.conform").keys,
	},

	-- treesiter
	{
		"nvim-treesitter/nvim-treesitter",
		opts = require("configs.nvim-treesitter"),
	},
	-- AI code completion with Fitten
	{
		"luozhiya/fittencode.nvim",
		config = function()
			require("fittencode").setup()
		end,
	},

	-- CODING =======================================================================================
	-- auto pairs
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

	-- comments
	{ "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
	{
		"echasnovski/mini.comment",
		event = "VeryLazy",
		opts = require("configs.mini-comment").options,
	},

	-- auto add closing tags
	{
		"windwp/nvim-ts-autotag",
		lazy = false,
		config = true,
	},

	-- EDITOR RELATED PLUGINS =======================================================================
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
		cmd = "InlineFoldToggle",
		keys = require("configs.inline-fold").keys,
	},
	{
		"yaocccc/nvim-foldsign",
		lazy = false,
		opts = require("configs.nvim-foldsign").options,
		config = true,
	},
	-- diagnostic window
	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
		opts = { use_diagnostic_signs = true },
		keys = {
			{
				"<leader>tt",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>tX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>ts",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>tl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>tL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>tQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
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
				require("telescope").load_extension("projects")
			end,
			keys = {
				{ "<leader>fp", "<Cmd>Telescope projects<CR>", desc = "Projects" },
			},
		},
		opts = function(_, opts)
			local conf = require("nvchad.configs.telescope")

			local flashNvim, flash_status = pcall(require, "falsh.nvim")
			if not flash_status then
				return
			end

			local function flash(prompt_bufnr)
				---@diagnostic disable-next-line: undefined-field
				flashNvim.jump({
					pattern = "^",
					label = { after = { 0, 0 } },
					search = {
						mode = "search",
						exclude = {
							function(win)
								return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
							end,
						},
					},
					action = function(match)
						local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
						picker:set_selection(match.pos[1] - 1)
					end,
				})
			end
			opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
				mappings = { n = { s = flash }, i = { ["<c-s>"] = flash } },
			})

			-- table.insert(conf.defaults.mappings.n, )

			return conf
		end,
	},

	-- folding
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

	-- Finds and lists all of the TODO, HACK, BUG, etc comment
	-- in you project and loads them into a browsable list.
	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = { "BufReadPost", "BufNewFile" },
		config = true,
		---@diagnostic disable-next-line: different-requires
		keys = require("configs.todo-comments").keys,
	},

	-- better yank/paste
	-- {
	-- 	"gbprod/yanky.nvim",
	-- 	dependencies = { { "kkharji/sqlite.lua", enabled = not jit.os:find("Windows") } },
	-- 	opts = require("configs.yanky").options,
	-- 	keys = require("configs.yanky").keys,
	-- },

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

	-- buffer remove
	{
		"echasnovski/mini.bufremove",
		keys = require("configs.mini-bufremove").keys,
	},

	-- LANGUAGUE RELATED PLUGINS ----------------------------------------------------------------------------------------
	-- TAILWIND
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{ "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
		},
		opts = function(_, opts)
			local format_kinds = opts.formatting.format
			opts.formatting.format = function(entry, item)
				format_kinds(entry, item) -- add icons
				return require("tailwindcss-colorizer-cmp").formatter(entry, item)
			end
		end,
	},

	-- UTILS
	-- library used by other plugins
	{ "nvim-lua/plenary.nvim", lazy = true },

	-- session management
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

	-- vim + tmux config
	{
		"alexghergh/nvim-tmux-navigation",
		lazy = false,
		opts = require("configs.nvim-tmux-navigation").options,
		config = true,
	},
}
