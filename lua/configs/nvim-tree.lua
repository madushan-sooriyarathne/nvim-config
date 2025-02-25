local M = {}

M.options = {
  filters = {
    dotfiles = false,
  },
  git = {
    enable = true,
  },
  sync_root_with_cwd = false,
  update_focused_file = {
    enable = false,
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
