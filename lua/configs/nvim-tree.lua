local M = {}

M.options = {
  filters = {
    dotfiles = false,
  },
  git = {
    enable = true,
  },
  view = { adaptive_size = true },
  actions = {
    change_dir = {
      enable = false,
      global = false,
      restrict_above_cwd = true,
    },
  },
  respect_buf_cwd = false,
  sync_root_with_cwd = false,
  update_focused_file = {
    enable = true,
    update_root = {
      enable = false,
      ignore_list = {},
    },
    exclude = false,
  },
  view = { adaptive_size = true },
  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

return M
