local M = {}

M.options = function(_, opts)
  local conf = require "nvchad.configs.telescope"

  local flashNvim, flash_status = pcall(require, "falsh.nvim")
  if not flash_status then
    return
  end

  local function flash(prompt_bufnr)
    ---@diagnostic disable-next-line: undefined-field
    flashNvim.jump {
      pattern = "^",
      label = { after = { 0, 0 } },
      search = {
        mode = "search",
        exclude = {
          function(win)
            return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
          end,
        },
      },
      action = function(match)
        local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
        picker:set_selection(match.pos[1] - 1)
      end,
    }
  end
  opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
    mappings = { n = { s = flash }, i = { ["<c-s>"] = flash } },
  })

  -- Get the repository root once at startup
  local root_dir = vim.fn.system("git rev-parse --show-toplevel"):gsub("\n", "")
  if vim.v.shell_error ~= 0 then
    -- If not in a git repo, use the current directory
    root_dir = vim.fn.getcwd()
  end

  -- setup path configs
  opts.defaults.cwd = root_dir
  opts.pickers = {
    find_files = {
      cwd = root_dir,
    },
    live_grep = {
      cwd = root_dir,
    },
  }

  -- Load persisted telescope extension
  require("telescope").load_extension "persisted"

  return conf
end

return M
