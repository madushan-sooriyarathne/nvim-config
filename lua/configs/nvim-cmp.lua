local M = {}

M.options = function(_, opts)
  local format_kinds = opts.formatting.format
  opts.formatting.format = function(entry, item)
    format_kinds(entry, item) -- add icons
    return require("tailwindcss-colorizer-cmp").formatter(entry, item)
  end
  opts.snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  }
  opts.sources = vim.list_extend(opts.sources, { { name = "supermaven" }, { name = "luasnip" } })
end

M.config = function(_, opts)
  require("luasnip.loaders.from_vscode").lazy_load { paths = { "./snippets/typescript" } }
  require("cmp").setup(opts)
end

return M
