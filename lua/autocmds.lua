-- ============================================================================
-- AUTOCMDS CONFIGURATION
-- ============================================================================
-- Custom autocmds for enhanced Neovim functionality
-- Built on top of NvChad v2.5 with modern Lua API usage

-- Helper function to create augroups with consistent naming
local function augroup(name)
  return vim.api.nvim_create_augroup("nvchad_custom-" .. name, { clear = true })
end

local autocmd = vim.api.nvim_create_autocmd

-- ============================================================================
-- UI & VISUAL ENHANCEMENTS
-- ============================================================================

-- Dynamic terminal padding
autocmd("VimEnter", {
  command = ":silent !kitty @ set-spacing padding=0 margin=0",
})

autocmd("VimLeavePre", {
  command = ":silent !kitty @ set-spacing padding=20 margin=10",
})

-- Highlight yanked text briefly for visual feedback
autocmd("BufDelete", {
  group = augroup "show_nvdash",
  desc = "Show Nvdash when all buffers are closed",
  callback = function()
    local bufs = vim.t.bufs
    if #bufs == 1 and vim.api.nvim_buf_get_name(bufs[1]) == "" then
      vim.cmd "Nvdash"
    end
  end,
})

-- Highlight yanked text briefly for visual feedback
autocmd("TextYankPost", {
  group = augroup "highlight_yank",
  desc = "Highlight yanked text briefly for visual feedback",
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Toggle theme automatically on Neovim startup
autocmd("VimEnter", {
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
autocmd("VimResized", {
  group = augroup "resize_splits",
  desc = "Automatically resize splits when terminal window is resized",
  callback = function()
    vim.cmd "tabdo wincmd ="
  end,
})

-- Restore cursor to last position when reopening files
autocmd("BufReadPost", {
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
autocmd("BufWritePre", {
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

-- Refresh LSP diagnostics on file save for TypeScript/JavaScript files
autocmd("BufWritePost", {
  group = augroup "refresh_diagnostics",
  desc = "Refresh LSP diagnostics after saving TS/JS files",
  pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
  callback = function(event)
    -- Small delay to ensure file is fully written
    vim.defer_fn(function()
      -- Clear existing diagnostics for this buffer
      vim.diagnostic.reset(nil, event.buf)

      -- Force LSP clients to re-analyze the buffer
      local clients = vim.lsp.get_clients { bufnr = event.buf }
      for _, client in ipairs(clients) do
        -- Only send didSave to clients that support it
        if client.supports_method "textDocument/didSave" then
          client.notify("textDocument/didSave", {
            textDocument = { uri = vim.uri_from_bufnr(event.buf) },
          })
        end

        -- Force diagnostic refresh by sending didChange
        if client.supports_method "textDocument/didChange" then
          local lines = vim.api.nvim_buf_get_lines(event.buf, 0, -1, false)
          local content = table.concat(lines, "\n")
          client.notify("textDocument/didChange", {
            textDocument = {
              uri = vim.uri_from_bufnr(event.buf),
              version = vim.lsp.util.buf_versions[event.buf] or 0,
            },
            contentChanges = { { text = content } },
          })
        end
      end
    end, 100) -- 100ms delay
  end,
})

-- ============================================================================
-- FILETYPE-SPECIFIC CONFIGURATIONS
-- ============================================================================

-- Allow quick closing of special buffer types with 'q' key
autocmd("FileType", {
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
autocmd("FileType", {
  group = augroup "text_files",
  desc = "Enable word wrap and spell checking for text-based files",
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Set Handlebars files to use HTML syntax highlighting
autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup "handlebars_filetype",
  desc = "Set Handlebars (.hbs) files to use HTML syntax highlighting",
  pattern = "*.hbs",
  callback = function()
    vim.bo.filetype = "html"
  end,
})
