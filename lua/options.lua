require "nvchad.options"

vim.cmd [[highlight Comment cterm=italic gui=italic ctermfg=gray guifg=gray]]

vim.g.vscode_snippets_path = "./snippets/typescript"

vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.tabstop = 2 -- Number of spaces tabs count for
vim.opt.termguicolors = true -- True color support
vim.opt.timeoutlen = 300
vim.opt.smartcase = true -- Don't ignore case with capitals
vim.opt.smartindent = true
vim.opt.sidescrolloff = 8 -- Columns of context
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 4 -- Lines of context
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
vim.opt.shiftround = true -- Round indent
vim.opt.shiftwidth = 2
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.colorcolumn = "100"
vim.opt.foldmethod = "manual"
vim.opt.spelllang = "en_us"
vim.opt.spell = true

local o = vim.o
o.cursorlineopt = "both" -- to enable cursorline!
