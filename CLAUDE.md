# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Structure

This is a Neovim configuration built on top of NvChad v2.5. The configuration follows a modular structure:

- `init.lua` - Main entry point, bootstraps lazy.nvim and loads NvChad
- `lua/options.lua` - Neovim options and settings
- `lua/mappings.lua` - Key mappings and shortcuts
- `lua/plugins/init.lua` - Custom plugin specifications
- `lua/configs/` - Individual plugin configurations
- `lua/chadrc.lua` - NvChad specific configuration (theme, mason packages)

## Architecture

### Plugin Management

- Uses **lazy.nvim** as the plugin manager
- Imports plugins from two sources:
  1. NvChad core plugins (`import = "nvchad.plugins"`)
  2. Custom plugins (`import = "plugins"`)
- Plugin configurations are split into separate files in `lua/configs/`
- Always put plugin configurations in `lua/configs/` import it from `lua/plugins/init.lua`

### LSP Configuration

- LSP setup is centralized in `lua/configs/lspconfig.lua`
- Uses the new Neovim 0.11+ LSP configuration API (`vim.lsp.config()` and `vim.lsp.enable()`)
- Servers are defined in a list and enabled globally with shared configurations
- Individual server customizations follow the list definition

### Key Configuration Patterns

- Options inherit from NvChad base with custom overrides
- Mappings disable conflicting NvChad defaults before setting custom ones
- Plugin configs use the pattern: `opts = require("configs.plugin-name").options`

### Autocmds Configuration

The configuration includes several autocmds in `lua/autocmds.lua` for enhanced functionality:

- **Yank Highlighting**: Briefly highlights yanked text for visual feedback
- **Theme Toggle on Start**: Automatically toggles theme when Neovim starts
- **Window Resize Handler**: Automatically resizes splits when the window is resized
- **Last Position Restore**: Returns cursor to last position when reopening files (excludes git commits)
- **Quick Close with 'q'**: Allows closing special filetypes (help, lspinfo, man, etc.) with 'q' key
- **Text File Formatting**: Enables word wrap and spell check for markdown and git commit files
- **Auto Directory Creation**: Automatically creates parent directories when saving files
- **Handlebars Filetype**: Sets `.hbs` files to use HTML syntax highlighting
- **Spell Highlighting**: Configures spell check highlighting with underline and red color

## Common Development Commands

### Code Formatting

```bash
# Format Lua files using stylua (configured in .stylua.toml)
stylua lua/ --check  # Check formatting
stylua lua/         # Format files
```

### ClaudeCode Integration

The configuration includes custom ClaudeCode integration that:

- Changes to git root directory when launching
- Provides extensive key mappings under `<leader>a` prefix
- Custom command defined in `lua/options.lua:30-42`

## Key Mappings Overview

### Custom Leader Key Patterns

- `<leader>a*` - ClaudeCode/AI operations
- `<leader>m*` - Monorepo/project management
- `<leader>s*` - Search operations (telescope, spectre, todos)
- `<leader>x*` - Trouble/diagnostics
- `<leader>f*` - File operations
- `<leader>b*` - Buffer operations
- `<leader>u*` - UI toggles

### Navigation

- Uses `nvim-tmux-navigation` for seamless tmux/nvim pane switching
- `<C-h/j/k/l>` - Navigate between tmux panes and nvim windows
- `<S-h/l>` - Navigate between buffers

## Language Server Configuration

Configured LSP servers include:

- **Web Development**: ts_ls, eslint, html, cssls, tailwindcss, jsonls
- **Systems**: gopls, clangd, bashls, dockerls
- **Other**: yamlls, sqlls, luals

### Special LSP Features

- ESLint auto-fix on save for files with diagnostics
- CSS/SCSS unknown at-rules ignored for modern CSS features
- Tailwind class regex patterns for cva() and cx() functions
- YAML schema validation using SchemaStore

## Theme and UI

- Base theme: **kanagawa** (configurable in `chadrc.lua`)
- Custom highlights defined in `lua/highlights.lua`
- Mason auto-installs LSP servers defined in `chadrc.lua`

## Installed Plugins Reference

This table lists all plugins currently installed in the configuration for quick reference and documentation access:

| Plugin Name | Used for | Docs Link |
|-------------|----------|-----------|
| stevearc/conform.nvim | Code formatting with minimal diffs and LSP integration | https://github.com/stevearc/conform.nvim |
| neovim/nvim-lspconfig | LSP client configurations for Neovim | https://github.com/neovim/nvim-lspconfig |
| mason-org/mason.nvim | Portable package manager for LSP servers, DAP servers, linters, and formatters | https://github.com/mason-org/mason.nvim |
| mason-org/mason-lspconfig.nvim | Bridge between mason.nvim and nvim-lspconfig | https://github.com/mason-org/mason-lspconfig.nvim |
| coder/claudecode.nvim | Claude Code integration for Neovim | https://github.com/coder/claudecode.nvim |
| pmizio/typescript-tools.nvim | TypeScript integration and tooling | https://github.com/pmizio/typescript-tools.nvim |
| nvim-treesitter/nvim-treesitter | Syntax highlighting and code parsing | https://github.com/nvim-treesitter/nvim-treesitter |
| echasnovski/mini.pairs | Automatic pairs (brackets, quotes, etc.) | https://github.com/echasnovski/mini.pairs |
| echasnovski/mini.surround | Surround text objects with quotes, brackets, etc. | https://github.com/echasnovski/mini.surround |
| JoosepAlviste/nvim-ts-context-commentstring | Context-aware comment strings using treesitter | https://github.com/JoosepAlviste/nvim-ts-context-commentstring |
| echasnovski/mini.comment | Smart commenting with treesitter integration | https://github.com/echasnovski/mini.comment |
| windwp/nvim-ts-autotag | Auto close and rename HTML/XML tags | https://github.com/windwp/nvim-ts-autotag |
| lewis6991/gitsigns.nvim | Git integration and signs in the gutter | https://github.com/lewis6991/gitsigns.nvim |
| olimorris/persisted.nvim | Session management with git branching and Telescope support | https://github.com/olimorris/persisted.nvim |
| stevearc/dressing.nvim | Improve default vim.ui interfaces | https://github.com/stevearc/dressing.nvim |
| nvim-tree/nvim-tree.lua | File explorer tree | https://github.com/nvim-tree/nvim-tree.lua |
| yaocccc/nvim-foldsign | Custom fold signs and indicators | https://github.com/yaocccc/nvim-foldsign |
| folke/trouble.nvim | Pretty diagnostics, references, and quickfix lists | https://github.com/folke/trouble.nvim |
| max397574/better-escape.nvim | Better escape key mapping with no delay | https://github.com/max397574/better-escape.nvim |
| nvim-pack/nvim-spectre | Search and replace in multiple files | https://github.com/nvim-pack/nvim-spectre |
| folke/flash.nvim | Navigation with search labels and enhanced motions | https://github.com/folke/flash.nvim |
| nvim-telescope/telescope.nvim | Fuzzy finder for files, buffers, and more | https://github.com/nvim-telescope/telescope.nvim |
| ahmedkhalf/project.nvim | Project management and switching | https://github.com/ahmedkhalf/project.nvim |
| kevinhwang91/nvim-ufo | Modern folding with preview support | https://github.com/kevinhwang91/nvim-ufo |
| kevinhwang91/promise-async | Async/await style programming in Lua | https://github.com/kevinhwang91/promise-async |
| folke/todo-comments.nvim | Highlight and search TODO comments | https://github.com/folke/todo-comments.nvim |
| petertriho/nvim-scrollbar | Scrollbar with diagnostics and search indicators | https://github.com/petertriho/nvim-scrollbar |
| smjonas/inc-rename.nvim | Incremental LSP rename with live preview | https://github.com/smjonas/inc-rename.nvim |
| RRethy/vim-illuminate | Highlight other uses of word under cursor | https://github.com/RRethy/vim-illuminate |
| echasnovski/mini.bufremove | Buffer removal without layout disruption | https://github.com/echasnovski/mini.bufremove |
| L3MON4D3/LuaSnip | Snippet engine written in Lua | https://github.com/L3MON4D3/LuaSnip |
| rafamadriz/friendly-snippets | Collection of snippets for various languages | https://github.com/rafamadriz/friendly-snippets |
| saadparwaiz1/cmp_luasnip | LuaSnip completion source for nvim-cmp | https://github.com/saadparwaiz1/cmp_luasnip |
| hrsh7th/nvim-cmp | Completion engine with LSP support | https://github.com/hrsh7th/nvim-cmp |
| roobert/tailwindcss-colorizer-cmp.nvim | Tailwind CSS color preview in completion | https://github.com/roobert/tailwindcss-colorizer-cmp.nvim |
| onsails/lspkind.nvim | VSCode-like pictograms for LSP completion | https://github.com/onsails/lspkind.nvim |
| nvim-lua/plenary.nvim | Lua utility functions library | https://github.com/nvim-lua/plenary.nvim |
| imNel/monorepo.nvim | Monorepo project management and navigation | https://github.com/imNel/monorepo.nvim |
| andymass/vim-matchup | Extended matching for %, if/endif, etc. | https://github.com/andymass/vim-matchup |
| alexghergh/nvim-tmux-navigation | Seamless navigation between Neovim and tmux | https://github.com/alexghergh/nvim-tmux-navigation |
| supermaven-inc/supermaven-nvim | AI-powered code completion | https://github.com/supermaven-inc/supermaven-nvim |

## Development Tips

### Adding New Plugins

1. Add plugin spec to `lua/plugins/init.lua`
2. Create config file in `lua/configs/plugin-name.lua` if needed
3. Reference config with `opts = require("configs.plugin-name").options`

### LSP Server Management

1. Add server name to the `servers` list in `lspconfig.lua`
2. Add to Mason packages in `chadrc.lua` for auto-installation
3. Add custom configuration using `vim.lsp.config("server_name", {...})`

### Key Mapping Conventions

- Always provide descriptive `desc` field for which-key integration
- Disable conflicting NvChad mappings before setting custom ones
- Group related mappings under common leader prefixes

## Remember Shortcuts

Remember the following shortcuts which the user may invoke at any time.

### QNEW

When I type "qnew", this means:

```
Understand all BEST PRACTICES listed in CLAUDE.md.
Your code SHOULD ALWAYS follow these best practices.
```

### QPLAN

When I type "qplan", this means:

```
Analyze similar parts of the codebase and determine whether your plan:
- is consistent with rest of codebase
- introduces minimal changes
- reuses existing code
```

## QCODE

When I type "qcode", this means:

```
Implement your plan and make sure your new tests pass.
Always run tests to make sure you didn't break anything else.
Always run formatting on the newly created files to ensure standard formatting.
Always check linting and type warning or errors to make sure type checking and linting is good.
```

### QGIT

When I type "qgit", this means:

```
Add all changes to staging, create a commit, and push to remote.

Follow this checklist for writing your commit message:
- SHOULD use Conventional Commits format: https://www.conventionalcommits.org/en/v1.0.0
- SHOULD NOT refer to Claude Code or Anthropic in the commit message.
- SHOULD structure commit message as follows:
<type>[optional scope]: <description>
[optional body]
[optional footer(s)]
- commit SHOULD contain the following structural elements to communicate intent:
fix: a commit of the type fix patches a bug in your codebase (this correlates with PATCH in Semantic Versioning).
feat: a commit of the type feat introduces a new feature to the codebase (this correlates with MINOR in Semantic Versioning).
BREAKING CHANGE: a commit that has a footer BREAKING CHANGE:, or appends a ! after the type/scope, introduces a breaking API change (correlating with MAJOR in Semantic Versioning). A BREAKING CHANGE can be part of commits of any type.
types other than fix: and feat: are allowed, for example @commitlint/config-conventional (based on the Angular convention) recommends build:, chore:, ci:, docs:, style:, refactor:, perf:, test:, and others.
footers other than BREAKING CHANGE: <description> may be provided and follow a convention similar to git trailer format.
```

