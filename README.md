# Neovim Configuration

A modern Neovim configuration built on top of **NvChad v2.5** with extensive customizations for development workflows. This configuration provides a comprehensive IDE-like experience with LSP support, advanced syntax highlighting, git integration, and intelligent code completion.

## 🚀 Features

- **Modern LSP Configuration**: Built with Neovim 0.11+ LSP API using `vim.lsp.config()` and `vim.lsp.enable()`
- **Plugin Management**: Uses lazy.nvim for fast startup and plugin management
- **Theme**: Kanagawa theme with custom highlights
- **AI Integration**: Claude Code and Supermaven for AI-powered development
- **Git Integration**: Comprehensive git workflow with Gitsigns
- **Advanced Search**: Telescope with project management and monorepo support
- **Code Formatting**: Conform.nvim with format-on-save
- **Session Management**: Automatic session handling with git branch awareness

## 📁 Project Structure

```
├── init.lua                    # Main entry point
├── lua/
│   ├── options.lua            # Neovim options and settings
│   ├── mappings.lua           # Custom keybindings
│   ├── autocmds.lua           # Auto commands
│   ├── chadrc.lua             # NvChad configuration
│   ├── highlights.lua         # Custom highlights
│   ├── configs/               # Plugin configurations
│   └── plugins/
│       └── init.lua          # Plugin specifications
└── CLAUDE.md                  # Project documentation
```

## 🔌 Plugins

### LSP & Language Support
| Plugin | Purpose |
|--------|---------|
| [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP client configurations |
| [mason-org/mason.nvim](https://github.com/mason-org/mason.nvim) | LSP server management |
| [pmizio/typescript-tools.nvim](https://github.com/pmizio/typescript-tools.nvim) | Enhanced TypeScript tooling |
| [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting and parsing |

### Code Completion & Snippets
| Plugin | Purpose |
|--------|---------|
| [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Completion engine |
| [L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Snippet engine |
| [rafamadriz/friendly-snippets](https://github.com/rafamadriz/friendly-snippets) | Snippet collection |
| [saadparwaiz1/cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip) | LuaSnip completion source |
| [onsails/lspkind.nvim](https://github.com/onsails/lspkind.nvim) | VSCode-like completion icons |
| [roobert/tailwindcss-colorizer-cmp.nvim](https://github.com/roobert/tailwindcss-colorizer-cmp.nvim) | Tailwind color preview |

### AI & Code Enhancement
| Plugin | Purpose |
|--------|---------|
| [coder/claudecode.nvim](https://github.com/coder/claudecode.nvim) | Claude Code integration |
| [supermaven-inc/supermaven-nvim](https://github.com/supermaven-inc/supermaven-nvim) | AI-powered completion |
| [smjonas/inc-rename.nvim](https://github.com/smjonas/inc-rename.nvim) | Incremental LSP rename |
| [RRethy/vim-illuminate](https://github.com/RRethy/vim-illuminate) | Highlight word references |

### Code Formatting & Editing
| Plugin | Purpose |
|--------|---------|
| [stevearc/conform.nvim](https://github.com/stevearc/conform.nvim) | Code formatting |
| [echasnovski/mini.pairs](https://github.com/echasnovski/mini.pairs) | Auto pairs |
| [echasnovski/mini.surround](https://github.com/echasnovski/mini.surround) | Surround operations |
| [echasnovski/mini.comment](https://github.com/echasnovski/mini.comment) | Smart commenting |
| [JoosepAlviste/nvim-ts-context-commentstring](https://github.com/JoosepAlviste/nvim-ts-context-commentstring) | Context-aware comment strings |
| [windwp/nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag) | Auto close HTML/XML tags |

### Navigation & Search
| Plugin | Purpose |
|--------|---------|
| [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder |
| [folke/flash.nvim](https://github.com/folke/flash.nvim) | Fast navigation with labels |
| [nvim-pack/nvim-spectre](https://github.com/nvim-pack/nvim-spectre) | Search and replace |
| [ahmedkhalf/project.nvim](https://github.com/ahmedkhalf/project.nvim) | Project management |
| [imNel/monorepo.nvim](https://github.com/imNel/monorepo.nvim) | Monorepo support |

### Git Integration
| Plugin | Purpose |
|--------|---------|
| [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git signs and operations |

### UI & Visual Enhancements
| Plugin | Purpose |
|--------|---------|
| [folke/trouble.nvim](https://github.com/folke/trouble.nvim) | Diagnostics and quickfix |
| [folke/todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | TODO comment highlighting |
| [stevearc/dressing.nvim](https://github.com/stevearc/dressing.nvim) | Improved UI components |
| [nvim-tree/nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | File explorer |
| [petertriho/nvim-scrollbar](https://github.com/petertriho/nvim-scrollbar) | Enhanced scrollbar |
| [yaocccc/nvim-foldsign](https://github.com/yaocccc/nvim-foldsign) | Custom fold indicators |

### Utility & System Integration
| Plugin | Purpose |
|--------|---------|
| [alexghergh/nvim-tmux-navigation](https://github.com/alexghergh/nvim-tmux-navigation) | Tmux/Neovim navigation |
| [olimorris/persisted.nvim](https://github.com/olimorris/persisted.nvim) | Session management |
| [kevinhwang91/nvim-ufo](https://github.com/kevinhwang91/nvim-ufo) | Modern folding |
| [kevinhwang91/promise-async](https://github.com/kevinhwang91/promise-async) | Async/await programming |
| [andymass/vim-matchup](https://github.com/andymass/vim-matchup) | Enhanced matching |
| [max397574/better-escape.nvim](https://github.com/max397574/better-escape.nvim) | Better escape sequences |
| [echasnovski/mini.bufremove](https://github.com/echasnovski/mini.bufremove) | Smart buffer removal |
| [nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim) | Lua utility functions |

## ⚡ Auto Commands

The configuration includes several autocmds for enhanced functionality:

### UI & Visual Enhancements
- **Yank Highlighting**: Briefly highlights yanked text for visual feedback
- **Theme Toggle on Start**: Automatically toggles theme when Neovim starts
- **Terminal Padding**: Dynamic kitty terminal padding management (sets padding=0 on enter, padding=20 on exit)
- **Nvdash on Buffer Close**: Shows dashboard when all buffers are closed

### Window & Buffer Management
- **Window Resize Handler**: Automatically resizes splits when the window is resized
- **Last Position Restore**: Returns cursor to last position when reopening files (excludes git commits)
- **Auto Directory Creation**: Automatically creates parent directories when saving files

### Filetype-Specific Configurations
- **Quick Close with 'q'**: Allows closing special filetypes (help, lspinfo, man, checkhealth, notify, qf, etc.) with 'q' key
- **Text File Formatting**: Enables word wrap and spell check for markdown and git commit files
- **Handlebars Filetype**: Sets `.hbs` files to use HTML syntax highlighting

## ⌨️ Custom Keybindings

### General Operations
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `;` | n | `:` | Enter command mode |
| `<leader>qq` | n | `:qa` | Exit Neovim |
| `x` | n | `"_x` | Delete without copying |
| `gw` | n/x | `*N` | Search word under cursor |
| `jk` / `kj` | i | `<ESC>` | Exit insert mode |
| `<leader>K` | n | `norm! K` | Keywordprg lookup |

### Buffer Management
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<S-h>` | n | `bprevious` | Previous buffer |
| `<S-l>` | n | `bnext` | Next buffer |
| `<leader>bP` | n | Close all except unsaved | Close all buffers except unsaved |
| `<leader>fn` | n | `enew` | New file |

### Navigation & Movement
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<C-h/j/k/l>` | n | Tmux navigation | Move between tmux panes/nvim windows |
| `<A-j/k>` | n/i/v | Move lines | Move line up/down |
| `]]` / `[[` | n | Navigate references | Next/previous reference |

### Git Operations
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `]c` / `[c` | n | Git hunk navigation | Next/previous git hunk |
| `<leader>gs` | n/v | Stage hunk | Stage git hunk |
| `<leader>gr` | n/v | Reset hunk | Reset git hunk |
| `<leader>gS` | n | Stage buffer | Stage entire buffer |
| `<leader>gR` | n | Reset buffer | Reset entire buffer |
| `<leader>gu` | n | Undo stage hunk | Undo staged hunk |
| `<leader>gp` | n | Preview hunk | Preview git hunk |
| `<leader>gb` | n | Blame line | Git blame for current line |
| `<leader>tb` | n | Toggle blame | Toggle current line blame |
| `<leader>gd` | n | Diff this | Get diffs |
| `<leader>gD` | n | Diff project | Get diffs for project |
| `<leader>td` | n | Toggle deleted | Toggle deleted lines |

### LSP & Code Actions
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>ca` | n | Code action | Open code actions popup |
| `<leader>cd` | n | Line diagnostics | Show line diagnostics |
| `<leader>rn` / `F2` | n | Rename variable | LSP rename |
| `<leader>lf` | n | ESLint fix all | Fix all ESLint issues |
| `<leader>lR` | n | Restart ESLint | Restart ESLint server |
| `<leader>lr` | n | Refresh diagnostics | Refresh ESLint diagnostics |

### Search & Replace
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>sr` | n | Spectre | Search and replace in files |
| `<leader>st` | n | Todo Telescope | Search TODO comments |
| `<leader>sT` | n | Todo/Fix/Fixme | Search TODO/FIX/FIXME |
| `<leader>xt` | n | Todo Trouble | TODO comments in Trouble |
| `<leader>xT` | n | Todo/Fix/Fixme Trouble | TODO/FIX/FIXME in Trouble |

### Project & Monorepo
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>m` | n | Monorepo projects | Open monorepo project picker |
| `<leader>n` | n | Toggle project | Toggle monorepo project |
| `<leader>fp` | n | Projects | Open project picker |

### UI & Utilities
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>up` | n | Toggle theme | Switch between themes |
| `<leader>ui` | n | Highlight cursor word | Show highlight info |
| `<leader>ur` | n | Redraw screen | Clear search/redraw |
| `<leader>uw` | n | Toggle wrap | Toggle line wrapping |

### Window Management
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<C-Up/Down>` | n | Resize height | Increase/decrease window height |
| `<C-Left/Right>` | n | Resize width | Decrease/increase window width |

### Todo Comments
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `]t` / `[t` | n | Navigate todos | Next/previous TODO comment |

### Visual Mode
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `>` / `<` | v | Indent | Indent right/left and reselect |

### Git Text Objects
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `ih` | o/x | Select hunk | Select git hunk text object |

## 🛠️ LSP Configuration

### Supported Language Servers

#### Web Development
- **TypeScript/JavaScript**: `ts_ls` - Full TypeScript support
- **ESLint**: `eslint` - Linting with auto-fix on save and extensive custom commands
- **HTML**: `html` - HTML language support
- **CSS/SCSS/Less**: `cssls` - CSS language support with unknown at-rules ignored
- **Tailwind CSS**: `tailwindcss` - Tailwind CSS support with custom class regex patterns
- **JSON**: `jsonls` - JSON validation and formatting

#### Systems Programming
- **Go**: `gopls` - Complete Go language support with static analysis
- **C/C++**: `clangd` - C/C++ language support
- **Bash**: `bashls` - Shell script support

#### Configuration & Data
- **YAML**: `yamlls` - YAML with SchemaStore integration and folding support
- **Docker**: `dockerls` - Dockerfile support
- **Markdown**: `marksman` - Markdown language support
- **SQL**: `sqlls`, `postgres_lsp` - SQL language support

#### Lua
- **Lua**: `lua_ls` - Lua language support optimized for Neovim

### Special LSP Features

#### ESLint Integration
- **Auto-fix on Save**: Automatically fixes ESLint issues when file has diagnostics
- **Custom Commands**: `EslintRestart`, `EslintRefresh`, `EslintRestartAll`, `LspEslintFixAll`
- **Buffer-specific Keybindings**: ESLint operations available per buffer
- **Flat Config Support**: Experimental flat config support enabled

#### CSS/SCSS Configuration
- **Unknown At-Rules**: Ignored for modern CSS features compatibility
- **Validation**: Enabled for CSS, SCSS, and Less files

#### Tailwind CSS
- **Custom Class Patterns**: Supports `cva()` and `cx()` function patterns
- **Lint Configuration**: Comprehensive linting with proper error levels
- **Filetype Exclusions**: Markdown files excluded from Tailwind processing

#### YAML with SchemaStore
- **Schema Validation**: Automatic schema validation using SchemaStore
- **Folding Support**: Line-based folding for YAML files
- **Telemetry Disabled**: RedHat telemetry disabled for privacy

#### Go Language Support
- **Import Management**: Complete unimported packages automatically
- **Static Analysis**: Staticcheck integration for code quality
- **Placeholder Support**: Enhanced completion with placeholders
- **Unused Parameters**: Analysis for unused parameters enabled

#### Lua Configuration
- **LuaJIT Runtime**: Configured for LuaJIT runtime
- **Neovim Globals**: `vim` global recognized for Neovim development
- **Workspace Library**: Full Neovim runtime library included
- **Telemetry Disabled**: Lua LS telemetry disabled

## 🎨 Theme & Styling

- **Base Theme**: Kanagawa with custom highlights
- **Visual Enhancements**: Custom spell check highlighting, cursor line styling
- **Color Column**: Set at 100 characters for code formatting guidelines
- **Cursor Line**: Enabled with both line and number highlighting
- **Relative Numbers**: Enabled for better navigation
- **Spell Check**: Enabled by default with US English dictionary

## 🔧 Development Commands

### Code Formatting
```bash
# Format Lua files using stylua
stylua lua/ --check  # Check formatting
stylua lua/         # Format files
```

### ClaudeCode Integration
The configuration includes enhanced ClaudeCode integration:
- Automatically changes to git root directory when launching
- Custom command with git root detection defined in `lua/options.lua:30-42`
- Extensive keybindings under `<leader>a` prefix

## 📝 Configuration Tips

### Adding New Plugins
1. Add plugin spec to `lua/plugins/init.lua`
2. Create config file in `lua/configs/plugin-name.lua` if needed
3. Reference config with `opts = require("configs.plugin-name").options`

### LSP Server Management
1. Add server name to the `servers` table in `lua/configs/lspconfig.lua`
2. Add to Mason packages in `lua/chadrc.lua` for auto-installation
3. Add custom configuration using `vim.lsp.config("server_name", {...})`

### Custom Keybindings
- Always provide descriptive `desc` field for which-key integration
- Disable conflicting NvChad mappings before setting custom ones
- Group related mappings under common leader prefixes

## 🚀 Installation

1. **Backup existing configuration**:
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Clone this repository**:
   ```bash
   git clone <repository-url> ~/.config/nvim
   ```

3. **Remove .git directory** (or fork the repository):
   ```bash
   rm -rf ~/.config/nvim/.git
   ```

4. **Start Neovim**:
   ```bash
   nvim
   ```

   Lazy.nvim will automatically install all plugins on first launch.

## 📄 Credits

- Built on top of [NvChad](https://github.com/NvChad/NvChad) v2.5
- Inspired by [LazyVim starter](https://github.com/LazyVim/starter) configuration patterns
- Uses modern Neovim 0.11+ LSP API for enhanced language server integration
