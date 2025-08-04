local M = {}

M.options = {
  -- Save sessions automatically
  save_dir = vim.fn.expand(vim.fn.stdpath "data" .. "/sessions/"),

  -- Monorepo-focused configuration
  silent = false,
  use_git_branch = true, -- Branch-specific sessions for monorepos
  follow_cwd = false, -- Keep sessions tied to project root, not file cwd
  autoload = false, -- Disable autoload to avoid conflicts
  autostart = true, -- Enable plugin on startup

  -- Focus on development directories
  allowed_dirs = {
    "~/",
    "~/Projects",
    "~/dev",
    "~/Code",
    "~/work",
  },

  -- Ignore temp and system directories
  ignored_dirs = {
    "~/.config",
    "~/.local",
    "/tmp",
    "/var",
    "/usr",
  },

  -- Telescope integration
  telescope = {
    reset_prompt = true,
    mappings = {
      change_branch = "<c-b>",
      copy_session = "<c-c>",
      delete_session = "<c-d>",
    },
  },
}

M.keys = {
  {
    "<leader>Ss",
    function()
      require("persisted").save()
    end,
    desc = "Save session",
  },
  {
    "<leader>Sl",
    function()
      require("persisted").load()
    end,
    desc = "Load session for current directory",
  },
  {
    "<leader>Se",
    "<cmd>Telescope persisted<cr>",
    desc = "Select session",
  },
  {
    "<leader>Sd",
    function()
      require("persisted").delete()
    end,
    desc = "Delete current session",
  },
  {
    "<leader>St",
    function()
      require("persisted").toggle()
    end,
    desc = "Toggle session recording",
  },
}

return M
