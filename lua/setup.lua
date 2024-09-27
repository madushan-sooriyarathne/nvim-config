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
vim.opt.wrap = true
vim.opt.textwidth = 0
vim.opt.updatetime = 200

vim.cmd([[highlight SpellBad cterm=underline gui=undercurl ctermfg=red guisp=red]])
-- -- save view on leaving the buffer
-- vim.api.nvim_exec(
-- 	[[
--       augroup AutoSaveView
--           autocmd!
--           autocmd BufWinLeave *.* mkview
--       augroup END
--   ]],
-- 	false
-- )
--
-- -- Load the view when opening a buffer
-- vim.api.nvim_exec(
-- 	[[
--       augroup AutoLoadView
--           autocmd!
--           autocmd BufWinEnter *.* silent! loadview
--       augroup END
--   ]],
-- 	false
-- )

-- AUTOCMDs
local function augroup(name)
	return vim.api.nvim_create_augroup("nvchad_custom-" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- toglle theme on first load
vim.api.nvim_create_autocmd({ "VimEnter" }, {
	group = augroup("toggle-theme"),
	callback = function()
		require("base46").toggle_theme()
	end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
	group = augroup("resize_splits"),
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

-- go to last loc when opening a buffer
-- vim.api.nvim_create_autocmd("BufReadPost", {
--   group = augroup("last_loc"),
--   callback = function()
--     local exclude = { "gitcommit" }
--     local buf = vim.api.nvim_get_current_buf()
--     if vim.tbl_contains(exclude, vim.bo[buf].filetype) then
--       return
--     end
--     local mark = vim.api.nvim_buf_get_mark(buf, '"')
--     local lcount = vim.api.nvim_buf_line_count(buf)
--     if mark[1] > 0 and mark[1] <= lcount then
--       pcall(vim.api.nvim_win_set_cursor, 0, mark)
--     end
--   end,
-- })

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
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
-- vim.api.nvim_create_autocmd("FileType", {
-- 	group = augroup("wrap_spell"),
-- 	pattern = { "gitcommit", "markdown", "typescriptreact" },
-- 	callback = function()
-- 		vim.opt_local.wrap = true
-- 		vim.opt_local.spell = true
-- 		vim.opt.linebreak = true
-- 	end,
-- })

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = augroup("auto_create_dir"),
	callback = function(event)
		if event.match:match("^%w%w+://") then
			return
		end
		local file = vim.loop.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = { "*.html", "*.tsx" },
	callback = function(_)
		if not require("inline-fold.module").isHidden then
			vim.cmd("InlineFoldToggle")
		end
	end,
})
