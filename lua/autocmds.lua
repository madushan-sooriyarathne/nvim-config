vim.cmd [[highlight SpellBad cterm=underline gui=undercurl ctermfg=red guisp=red]]

-- AUTOCMDs
local function augroup(name)
  return vim.api.nvim_create_augroup("nvchad_custom-" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup "highlight_yank",
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- toglle theme on first load
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  group = augroup "toggle-theme",
  callback = function()
    require("base46").toggle_theme()
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup "resize_splits",
  callback = function()
    vim.cmd "tabdo wincmd ="
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup "last_loc",
  callback = function()
    local exclude = { "gitcommit" }
    local buf = vim.api.nvim_get_current_buf()
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) then
      return
    end
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup "close_with_q",
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup "wrap_spell",
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup "auto_create_dir",
  callback = function(event)
    if event.match:match "^%w%w+://" then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- Create a global variable to store the initial directory when Neovim starts
vim.g.initial_open_directory = nil

-- Capture the initial directory when Neovim starts and store it in the global variable
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Check if Neovim was launched with a directory argument
    local args = vim.v.argv
    local last_arg = args[#args]

    if last_arg and vim.fn.isdirectory(last_arg) == 1 then
      -- If the last argument is a directory, save it
      vim.g.initial_open_directory = last_arg
    elseif last_arg and vim.fn.filereadable(last_arg) == 1 then
      -- If the last argument is a file, save its parent directory
      vim.g.initial_open_directory = vim.fn.fnamemodify(last_arg, ":h")
    else
      -- Otherwise, save the current working directory at startup
      vim.g.initial_open_directory = vim.fn.getcwd()
    end
  end,
  group = vim.api.nvim_create_augroup("CaptureInitialDirectory", { clear = true }),
})

vim.cmd "autocmd BufRead,BufNewFile *.hbs set filetype=html"
