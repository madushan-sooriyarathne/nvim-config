return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		---@diagnostic disable-next-line: different-requires
		opts = require("configs.conform").options,
		---@diagnostic disable-next-line: different-requires
		keys = require("configs.conform").keys,
	},

	-- lsp config
	-- {
	-- 	"neovim/nvim-lspconfig",
	-- 	event = { "BufReadPre", "BufNewFile" },
	-- 	dependencies = {
	-- 		{ "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
	-- 		{ "folke/neodev.nvim", opts = {} },
	-- 		"mason.nvim",
	-- 		"williamboman/mason-lspconfig.nvim",
	-- 		{
	-- 			"hrsh7th/cmp-nvim-lsp",
	-- 			cond = function()
	-- 				return require("utils").has("nvim-cmp")
	-- 			end,
	-- 		},
	-- 		-- typescript
	-- 		"jose-elias-alvarez/typescript.nvim",
	-- 		-- json and yaml
	-- 		{
	-- 			"b0o/SchemaStore.nvim",
	-- 			version = false, -- last release is way too old
	-- 		},
	-- 	},
	--
	-- 	---@class PluginLspOpts
	-- 	opts = {
	-- 		-- options for vim.diagnostic.config()
	-- 		diagnostics = {
	-- 			underline = true,
	-- 			update_in_insert = false,
	-- 			virtual_text = {
	-- 				spacing = 4,
	-- 				source = "if_many",
	-- 				prefix = "●",
	-- 			},
	-- 			severity_sort = true,
	-- 		},
	-- 		inlay_hints = {
	-- 			enabled = false,
	-- 		},
	-- 		-- global capabilities
	-- 		capabilities = {},
	-- 		-- Automatically format on save
	-- 		autoformat = true,
	-- 		format_notify = false,
	-- 		format = {
	-- 			formatting_options = nil,
	-- 			timeout_ms = nil,
	-- 		},
	-- 		servers = {
	-- 			eslint = {
	-- 				settings = {
	-- 					workingDirectory = { mode = "auto" },
	-- 				},
	-- 			},
	--
	-- 			lua_ls = {
	-- 				settings = {
	-- 					Lua = {
	-- 						workspace = {
	-- 							checkThirdParty = false,
	-- 						},
	-- 						completion = {
	-- 							callSnippet = "Replace",
	-- 						},
	-- 					},
	-- 				},
	-- 			},
	--
	-- 			tsserver = {
	-- 				keys = {
	-- 					{ "<leader>co", "<cmd>TypescriptOrganizeImports<CR>", desc = "Organize Imports" },
	-- 					{ "<leader>cR", "<cmd>TypescriptRenameFile<CR>", desc = "Rename File" },
	-- 				},
	-- 				settings = {
	-- 					typescript = {
	-- 						format = {
	-- 							indentSize = vim.o.shiftwidth,
	-- 							convertTabsToSpaces = vim.o.expandtab,
	-- 							tabSize = vim.o.tabstop,
	-- 						},
	-- 					},
	-- 					javascript = {
	-- 						format = {
	-- 							indentSize = vim.o.shiftwidth,
	-- 							convertTabsToSpaces = vim.o.expandtab,
	-- 							tabSize = vim.o.tabstop,
	-- 						},
	-- 					},
	-- 					completions = {
	-- 						completeFunctionCalls = true,
	-- 					},
	-- 				},
	-- 			},
	--
	-- 			tailwindcss = {
	-- 				filetypes_exclude = { "markdown" },
	-- 			},
	--
	-- 			-- docker files
	-- 			dockerls = {},
	-- 			docker_compose_language_service = {},
	--
	-- 			-- json
	-- 			jsonls = {
	-- 				-- lazy-load schemastore when needed
	-- 				on_new_config = function(new_config)
	-- 					new_config.settings.json.schemas = new_config.settings.json.schemas or {}
	-- 					vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
	-- 				end,
	-- 				settings = {
	-- 					json = {
	-- 						format = {
	-- 							enable = true,
	-- 						},
	-- 						validate = { enable = true },
	-- 					},
	-- 				},
	-- 			},
	-- 			-- yaml
	-- 			yamlls = {
	-- 				-- Have to add this for yamlls to understand that we support line folding
	-- 				capabilities = {
	-- 					textDocument = {
	-- 						foldingRange = {
	-- 							dynamicRegistration = false,
	-- 							lineFoldingOnly = true,
	-- 						},
	-- 					},
	-- 				},
	-- 				-- lazy-load schemastore when needed
	-- 				on_new_config = function(new_config)
	-- 					new_config.settings.yaml.schemas = new_config.settings.yaml.schemas or {}
	-- 					vim.list_extend(new_config.settings.yaml.schemas, require("schemastore").yaml.schemas())
	-- 				end,
	-- 				settings = {
	-- 					redhat = { telemetry = { enabled = false } },
	-- 					yaml = {
	-- 						keyOrdering = false,
	-- 						format = {
	-- 							enable = true,
	-- 						},
	-- 						validate = true,
	-- 						schemaStore = {
	-- 							-- Must disable built-in schemaStore support to use
	-- 							-- schemas from SchemaStore.nvim plugin
	-- 							enable = false,
	-- 							-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
	-- 							url = "",
	-- 						},
	-- 					},
	-- 				},
	-- 			},
	-- 		},
	-- 		setup = {
	-- 			-- eslint
	-- 			eslint = function()
	-- 				vim.api.nvim_create_autocmd("BufWritePre", {
	-- 					callback = function(event)
	-- 						local client = vim.lsp.get_active_clients({ bufnr = event.buf, name = "eslint" })[1]
	-- 						if client then
	-- 							local diag = vim.diagnostic.get(
	-- 								event.buf,
	-- 								{ namespace = vim.lsp.diagnostic.get_namespace(client.id) }
	-- 							)
	-- 							if #diag > 0 then
	-- 								vim.cmd("EslintFixAll")
	-- 							end
	-- 						end
	-- 					end,
	-- 				})
	-- 			end,
	--
	-- 			-- typescript
	-- 			tsserver = function(_, opts)
	-- 				require("typescript").setup({ server = opts })
	-- 				return true
	-- 			end,
	--
	-- 			tailwindcss = function(_, opts)
	-- 				local tw = require("lspconfig.server_configurations.tailwindcss")
	-- 				--- @param ft string
	-- 				opts.filetypes = vim.tbl_filter(function(ft)
	-- 					return not vim.tbl_contains(opts.filetypes_exclude or {}, ft)
	-- 				end, tw.default_config.filetypes)
	--
	-- 				require("lspconfig").tailwindcss.setup({
	-- 					settings = {
	-- 						tailwindCSS = {
	-- 							experimental = {
	-- 								classRegex = {
	-- 									{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
	-- 									{ "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
	-- 								},
	-- 							},
	-- 						},
	-- 					},
	-- 				})
	-- 			end,
	-- 		},
	-- 	},
	-- 	---@param opts PluginLspOpts
	-- 	config = function(_, opts)
	-- 		local lspconfig = require("custom.configs.lspconfig")
	-- 		lspconfig.setup(opts)
	-- 	end,
	-- },

	-- mason
	{
		"williamboman/mason.nvim",
		config = function()
			require("configs.mason")
		end,
	},

	-- treesiter
	{
		"nvim-treesitter/nvim-treesitter",
		opts = require("configs.nvim-treesitter"),
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
	{ "windwp/nvim-ts-autotag", lazy = false, config = true },

	-- EDITOR RELATED PLUGINS =======================================================================
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
	-- diagnostic window
	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
		opts = { use_diagnostic_signs = true },
		keys = {
			"<leader>xx",
			"<leader>xX",
			"<leader>xL",
			"<leader>xQ",
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
		vscode = true,
		opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o",               function() require("flash").remote() end,     desc = "Remote Flash" },
      {
        "R",
        mode = { "o", "x" },
        function() require("flash").treesitter_search() end,
        desc =
        "Treesitter Search"
      },
      {
        "<c-s>",
        mode = { "c" },
        function() require("flash").toggle() end,
        desc =
        "Toggle Flash Search"
      },
    },
	},

	-- Flash Telescope config
	{
		"nvim-telescope/telescope.nvim",
		optional = true,
		opts = function(_, opts)
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
		end,
	},

	-- telescope projects
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
	{
		"gbprod/yanky.nvim",
		dependencies = { { "kkharji/sqlite.lua", enabled = not jit.os:find("Windows") } },
		opts = require("configs.yanky").options,
		keys = require("configs.yanky").keys,
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
