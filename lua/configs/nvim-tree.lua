local M = {}

M.options = {
  filters = {
    dotfiles = false,
  },
  git = {
    enable = true,
  },
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
