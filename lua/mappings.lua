require "nvchad.mappings"

local map = vim.keymap.set

-- =============================================
-- DISABLED KEYS
-- =============================================
map("n", "<leader>xx", "")
map("n", "<leader>wl", "")
map("n", "<leader>x", "")
map("n", "<C-h>", "")
map("n", "<C-l>", "")
map("n", "<C-j>", "")
map("n", "<C-k>", "")
map("n", "<leader>b", "")
map("n", "s", "")
map("i", "<C-l>", "")
map("i", "<C-j>", "")

-- =============================================
-- NORMAL MODE
-- =============================================

-- General / Neovim Core
map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "<leader>qq", ":qa <CR>", { desc = "Exit Neovim" })
map("n", "x", '"_x', { desc = "Delete without coping" })
map("n", "gw", "*N", { desc = "Search word under cursor" })
map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "keywordprg" })

-- Base46 (Theme)
map("n", "<leader>up", function()
  require("base46").toggle_theme()
end, { desc = "Toggle theme" })

-- Buffer Management
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Go to previous buffer" })
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Go to next buffer" })
map(
  "n",
  "<leader>bP",
  "<cmd>bufdo if (bufnr('%') != bufnr('#')) | bd | endif <CR>",
  { desc = "Close all buffers except unsaved onces" }
)

-- Diagnostics
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })

-- File Operations
map("n", "<leader>fn", "<cmd>enew<CR>", { desc = "New file" })

-- Gitsigns
map("n", "]c", function()
  local gs = package.loaded.gitsigns
  if vim.wo.diff then
    return "]c"
  end
  vim.schedule(function()
    gs.next_hunk()
  end)
  return "<Ignore>"
end, { expr = true, desc = "Next git hunk" })

map("n", "[c", function()
  local gs = package.loaded.gitsigns
  if vim.wo.diff then
    return "[c"
  end
  vim.schedule(function()
    gs.prev_hunk()
  end)
  return "<Ignore>"
end, { expr = true, desc = "Previous git hunk" })

map("n", "<leader>gs", function()
  package.loaded.gitsigns.stage_hunk()
end, { desc = "Stage Hunk" })

map("n", "<leader>gr", function()
  package.loaded.gitsigns.reset_hunk()
end, { desc = "Reset Hunk" })

map("n", "<leader>gS", function()
  package.loaded.gitsigns.stage_buffer()
end, { desc = "Stage Buffer" })

map("n", "<leader>gu", function()
  package.loaded.gitsigns.undo_stage_hunk()
end, { desc = "Undo Staged Hunk" })

map("n", "<leader>gR", function()
  package.loaded.gitsigns.reset_buffer()
end, { desc = "Reset Buffer" })

map("n", "<leader>gp", function()
  package.loaded.gitsigns.preview_hunk()
end, { desc = "Preview Hunk" })

map("n", "<leader>gb", function()
  package.loaded.gitsigns.blame_line { full = true }
end, { desc = "Go to Blame Line" })

map("n", "<leader>tb", function()
  package.loaded.gitsigns.toggle_current_line_blame()
end, { desc = "Toggle Blame for Current Line" })

map("n", "<leader>gd", function()
  package.loaded.gitsigns.diffthis()
end, { desc = "Get Diffs" })

map("n", "<leader>gD", function()
  package.loaded.gitsigns.diffthis "~"
end, { desc = "Get Diffs for Project" })

map("n", "<leader>td", function()
  package.loaded.gitsigns.toggle_deleted()
end, { desc = "Toggle Deleted" })

-- Inc-rename
map("n", "<leader>rn", function()
  return ":IncRename " .. vim.fn.expand "<cword>"
end, { desc = "Rename variable" })

map("n", "F2", function()
  return ":IncRename " .. vim.fn.expand "<cword>"
end, { desc = "Rename variable" })

-- Line Movement
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })

-- Monorepo Management
map("n", "<leader>m", function()
  require("telescope").extensions.monorepo.monorepo()
end, { desc = "Monorepo projects" })

map("n", "<leader>n", function()
  require("monorepo").toggle_project()
end, { desc = "Toggle monorepo project" })

-- LSP
map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action() <CR>", { desc = "Open code actions popup" })

-- Spectre (Search and Replace)
map("n", "<leader>sr", function()
  require("spectre").open()
end, { desc = "Replace in files (Spectre)" })

-- Todo Comments
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

-- Tmux Navigation
map("n", "<C-h>", "<cmd>NvimTmuxNavigateLeft <CR>", { desc = "Move to left pane" })
map("n", "<C-l>", "<cmd>NvimTmuxNavigateRight <CR>", { desc = "Move to right pane" })
map("n", "<C-j>", "<cmd>NvimTmuxNavigateDown <CR>", { desc = "Move to down pane" })
map("n", "<C-k>", "<cmd>NvimTmuxNavigateUp <CR>", { desc = "Move to top pane" })
map("n", "C-\\\\", "<cmd>NvimTmuxNavigateLastActive <CR>", { desc = "Move to last active pane" })

-- UI Utilities
map("n", "<leader>ui", vim.show_pos, { desc = "Highlight word under cursor" })
map(
  "n",
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / clear hlsearch / diff update" }
)

map("n", "<leader>uw", function()
  vim.wo.wrap = not vim.wo.wrap
  local status = vim.wo.wrap and "enabled" or "disabled"
  print("Line wrapping " .. status)
end, { desc = "Toggle line wrapping" })

-- Vim-illuminate
map("n", "]]", function()
  require("illuminate").goto_next_reference(false)
end, { desc = "Next Reference" })

map("n", "[[", function()
  require("illuminate").goto_prev_reference(false)
end, { desc = "Prev Reference" })

-- Window Resize
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- =============================================
-- INSERT MODE
-- =============================================

-- Exit Insert Mode
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })
map("i", "kj", "<ESC>", { desc = "Exit insert mode" })

-- Line Movement
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move line up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move line down" })

-- =============================================
-- VISUAL MODE
-- =============================================

-- Gitsigns
map("v", "<leader>gs", function()
  package.loaded.gitsigns.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
end, { desc = "Stage Hunk (in Visual Mode)" })

map("v", "<leader>gr", function()
  package.loaded.gitsigns.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
end, { desc = "Reset Hunk (in visual mode)" })

-- Indentation
map("v", ">", ">gv", { desc = "Indent right" })
map("v", "<", "<gv", { desc = "Indent left" })

-- Line Movement
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move line down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move line up" })

-- =============================================
-- OPERATOR-PENDING & VISUAL MODE
-- =============================================

-- Gitsigns Text Objects
map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select Hunks" })

-- =============================================
-- VISUAL (X) MODE
-- =============================================

-- Search
map("x", "gw", "*N", { desc = "Search word under cursor" })
