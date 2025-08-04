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
- `<leader>w*` - Session management
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

