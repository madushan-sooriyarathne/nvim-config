-- ============================================================================
-- AUTOCMDS CONFIGURATION
-- ============================================================================
-- Custom autocmds for enhanced Neovim functionality
-- Built on top of NvChad v2.5 with modern Lua API usage

-- Helper function to create augroups with consistent naming
local function augroup(name)
  return vim.api.nvim_create_augroup("nvchad_custom-" .. name, { clear = true })
end

-- ============================================================================
-- UI & VISUAL ENHANCEMENTS
-- ============================================================================

-- Highlight yanked text briefly for visual feedback
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup "highlight_yank",
  desc = "Highlight yanked text briefly for visual feedback",
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Toggle theme automatically on Neovim startup
vim.api.nvim_create_autocmd("VimEnter", {
  group = augroup "toggle_theme",
  desc = "Toggle theme on first load to apply custom theme settings",
  callback = function()
    require("base46").toggle_theme()
  end,
})

-- ============================================================================
-- WINDOW & BUFFER MANAGEMENT
-- ============================================================================

-- Automatically resize splits when window is resized
vim.api.nvim_create_autocmd("VimResized", {
  group = augroup "resize_splits",
  desc = "Automatically resize splits when terminal window is resized",
  callback = function()
    vim.cmd "tabdo wincmd ="
  end,
})

-- Restore cursor to last position when reopening files
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup "last_position",
  desc = "Jump to last cursor position when reopening files (excludes git commits)",
  callback = function()
    local exclude_filetypes = { "gitcommit" }
    local buf = vim.api.nvim_get_current_buf()

    -- Skip for excluded filetypes
    if vim.tbl_contains(exclude_filetypes, vim.bo[buf].filetype) then
      return
    end

    -- Get last cursor position from '"' mark
    local last_pos = vim.api.nvim_buf_get_mark(buf, '"')
    local line_count = vim.api.nvim_buf_line_count(buf)

    -- Jump to position if valid
    if last_pos[1] > 0 and last_pos[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, last_pos)
    end
  end,
})

-- Auto-create parent directories when saving files
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup "auto_create_dir",
  desc = "Automatically create parent directories when saving files",
  callback = function(event)
    -- Skip for URLs (like fugitive buffers)
    if event.match:match "^%w%w+://" then
      return
    end

    local file_path = vim.fn.resolve(event.match)
    local parent_dir = vim.fn.fnamemodify(file_path, ":p:h")

    -- Create parent directory if it doesn't exist
    vim.fn.mkdir(parent_dir, "p")
  end,
})

-- ============================================================================
-- FILETYPE-SPECIFIC CONFIGURATIONS
-- ============================================================================

-- Allow quick closing of special buffer types with 'q' key
vim.api.nvim_create_autocmd("FileType", {
  group = augroup "close_with_q",
  desc = "Enable quick closing with 'q' key for special buffer types",
  pattern = {
    "PlenaryTestPopup",
    "checkhealth",
    "help",
    "lspinfo",
    "man",
    "neotest-output",
    "neotest-output-panel",
    "neotest-summary",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
  },
  callback = function(event)
    -- Make buffer not listed and add 'q' mapping to close
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", {
      buffer = event.buf,
      silent = true,
      desc = "Close buffer with q",
    })
  end,
})

-- Enable word wrap and spell checking for text-based files
vim.api.nvim_create_autocmd("FileType", {
  group = augroup "text_files",
  desc = "Enable word wrap and spell checking for text-based files",
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Set Handlebars files to use HTML syntax highlighting
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup "handlebars_filetype",
  desc = "Set Handlebars (.hbs) files to use HTML syntax highlighting",
  pattern = "*.hbs",
  callback = function()
    vim.bo.filetype = "html"
  end,
})
