local M = {}

M.options = {
  delay = 200,
  large_file_cutoff = 2000,
  large_file_overrides = {
    providers = { "lsp" },
  },
}

M.config = function(_, opts)
  require("illuminate").configure(opts)
  -- Keymaps are defined in lua/mappings.lua
end

M.keys = {
  { "]]", desc = "Next Reference" },
  { "[[", desc = "Prev Reference" },
}

return M
