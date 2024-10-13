local M = {}
M.config = function()
  -- may set any options here
  vim.g.matchup_matchparen_offscreen = { method = "popup" }
end

return M
