require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- disabled keys
map("n", "<leader>xx", "")
map("n", "<leader>x", "")
map("n", "<C-h>", "")
map("n", "<C-l>", "")
map("n", "<C-j>", "")
map("n", "<C-k>", "")
map("n", "<leader>b", "")
map("n", "s", "")

-- NORMAL MODE
map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "<leader>qq", ":qa <CR>", { desc = "Exit Neovim" })
map("n", "x", '"_x', { desc = "Delete without coping" })

map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })

-- Resize window with Ctrl + Arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increse window width" })

-- Switch between panes with Tmux
map("n", "<C-h>", "<cmd>NvimTmuxNavigateLeft <CR>", { desc = "Move to down pane" })
map("n", "<C-l>", "<cmd>NvimTmuxNavigateRight <CR>", { desc = "Move to right pane" })
map("n", "<C-j>", "<cmd>NvimTmuxNavigateDown <CR>", { desc = "Move to down pane" })
map("n", "<C-k>", "<cmd>NvimTmuxNavigateUp <CR>", { desc = "Move to top pane" })
map("n", "C-\\", "<cmd>NvimTmuxNavigateLastActive <CR>", { desc = "Move to last active pane" })

-- close all buffers except unsaved and current one
map(
  "n",
  "<leader>bP",
  "<cmd>bufdo if (bufnr('%') != bufnr('#')) | bd | endif <CR>",
  { desc = "Close all buffers except unsaved onces" }
)

-- Inc rename:
map("n", "<leader>rn", function()
  return ":IncRename " .. vim.fn.expand "<cword>"
end, { desc = "" })

map("n", "F2", function()
  return ":IncRename " .. vim.fn.expand "<cword>"
end, { desc = "" })

-- Search and replace entire codebase
map("n", "<leader>sr", function()
  require("spectre").open()
end, { desc = "Replace in files (Spectre)" })

-- Highlight under cursor
map("n", "<leader>ui", vim.show_pos, { desc = "Highlight word under cursor" })

-- Clear search diff update and redaraw
map(
  "n",
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / clear hlsearch / diff update" }
)

map("n", "gw", "*N", { desc = "Search word under cursor" })

-- keywordprg
map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "keywordprg" })

-- navigate buffers
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Go to previous buffer" })
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Go to next buffer" })

-- new file
map("n", "<leader>fn", "<cmd>enew<CR>", { desc = "New file" })

-- trouble
-- map("n", "<leader>tt", function()
--   require("trouble").toggle()
-- end)
--
-- map("n", "<leader>tx", "<cmd>TroubleToggle document_diagnostics<cr>", { desc = "Document Diagnostics (Trouble)" })
-- map("n", "<leader>tX", "<cmd>TroubleToggle document_diagnostics<cr>", { desc = "Document Diagnostics (Trouble)" })
-- map("n", "<leader>tL", "<cmd>TroubleToggle loclist<cr>", { desc = "Location List (Trouble)" })
-- map("n", "<leader>tQ", "<cmd>TroubleToggle quickfix<cr>", { desc = "Quickfix List (Trouble)" })
-- map("n", "[q", function()
--   if require("trouble").is_open() then
--     require("trouble").previous { skip_groups = true, jump = true }
--   else
--     local ok, err = pcall(vim.cmd.cprev)
--     if not ok then
--       vim.notify(err, vim.log.levels.ERROR)
--     end
--   end
-- end, { desc = "Previous trouble/quickfix item" })
--
-- map("n", "]q", function()
--   if require("trouble").is_open() then
--     require("trouble").next { skip_groups = true, jump = true }
--   else
--     local ok, err = pcall(vim.cmd.cnext)
--     if not ok then
--       vim.notify(err, vim.log.levels.ERROR)
--     end
--   end
-- end, { desc = "Next trouble/quickfix item" })

map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })

-- Todo comments
map("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

map("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

map("n", "<leader>xt", "<cmd>TodoTrouble<cr>", { desc = "Todo (Trouble)" })
map("n", "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", { desc = "Todo/Fix/Fixme (Trouble)" })
map("n", "<leader>st", "<cmd>TodoTelescope<cr>", { desc = "Todo" })
map("n", "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", { desc = "Todo/Fix/Fixme" })

map("n", "<leader>up", function()
  require("base46").toggle_theme()
end, { desc = "" })

-- INSERT MODE
-- move lines
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move line up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move line down" })

-- Exit insert mode
map("i", "jk", "<ESC>")
map("i", "kj", "<ESC>")

-- VISUAL MODE
-- move lines
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move line down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move line up" })

-- indent
map("v", ">", ">gv", { desc = "Indent right" })
map("v", "<", "<gv", { desc = "Indent left" })

-- X MODE
map("x", "gw", "*N", { desc = "Search word under cursor" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
