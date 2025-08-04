local M = {}

M.options = {
  enabled = false,
  root_dir = vim.fn.stdpath "data" .. "/sessions/",

  log_level = "error",
  show_auto_restore_notif = true,
  use_git_branch = true,
  -- cwd_change_handling = true,
  pre_save_cmds = {
    function()
      -- Check if the initial directory was captured
      if vim.g.initial_open_directory and vim.g.initial_open_directory ~= "" then
        vim.cmd("cd " .. vim.fn.fnameescape(vim.g.initial_open_directory))
        print("Changed directory to: " .. vim.g.initial_open_directory)
      else
        print "No initial directory was captured"
      end
    end,
  },
  -- post_restore_cmds = {
  --   function()
  --     -- Restore nvim-tree after a session is restored
  --     local nvim_tree_api = require "nvim-tree.api"
  --     nvim_tree_api.tree.open()
  --     nvim_tree_api.tree.change_root(vim.fn.getcwd())
  --     nvim_tree_api.tree.reload()
  --   end,
  -- },
}

M.keys = {
  -- Will use Telescope if installed or a vim.ui.select picker otherwise
  { "<leader>wm", "<cmd>SessionSearch<CR>", desc = "Session search" },
  { "<leader>ws", "<cmd>SessionSave<CR>", desc = "Save session" },
  { "<leader>wa", "<cmd>SessionToggleAutoSave<CR>", desc = "Toggle autosave" },
}

return M
