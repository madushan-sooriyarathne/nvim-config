local M = {}

M.options = {
  signs = {
    add = { text = "│" },
    change = { text = "│" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
    untracked = { text = "┆" },
  },
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    follow_files = true,
  },
  auto_attach = true,
  attach_to_untracked = false,
  current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
    virt_text_priority = 100,
  },
  current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    border = "single",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "]c", function()
      if vim.wo.diff then
        return "]c"
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return "<Ignore>"
    end, { expr = true })

    map("n", "[c", function()
      if vim.wo.diff then
        return "[c"
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return "<Ignore>"
    end, { expr = true })

    -- Actions
    map("n", "<leader>gs", gs.stage_hunk, { desc = "Stage Hunk" })
    map("n", "<leader>gr", gs.reset_hunk, { desc = "Reset Hunk" })
    map("v", "<leader>gs", function()
      gs.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
    end, { desc = "Stage Hunk (in Visual Mode)" })
    map("v", "<leader>gr", function()
      gs.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
    end, { desc = "Reset Hunk (in visual mode)" })
    map("n", "<leader>gS", gs.stage_buffer, { desc = "Stage Buffer" })
    map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "Undo Staged Hunk" })
    map("n", "<leader>gR", gs.reset_buffer, { desc = "Reset Buffer" })
    map("n", "<leader>gp", gs.preview_hunk, { desc = "Preview Hunk" })
    map("n", "<leader>gb", function()
      gs.blame_line { full = true }
    end, { desc = "Go to Blame Line" })
    map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Toggle Blame for Current Line" })
    map("n", "<leader>gd", gs.diffthis, { desc = "Get Diffs" })
    map("n", "<leader>gD", function()
      gs.diffthis "~"
    end, { desc = "Get Diffs for Project" })
    map("n", "<leader>td", gs.toggle_deleted, { desc = "Toggle Deleted" })

    -- Text object
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select Hunks" })
  end,
}

return M
