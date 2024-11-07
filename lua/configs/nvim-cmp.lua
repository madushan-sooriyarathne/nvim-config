local M = {}

M.options = function(_, opts)
  local format_kinds = opts.formatting.format
  opts.formatting.format = function(entry, item)
    format_kinds(entry, item) -- add icons
    return require("tailwindcss-colorizer-cmp").formatter(entry, item)
  end
  opts.sources = vim.list_extend(opts.sources, { { name = "supermaven" } })
end

return M
