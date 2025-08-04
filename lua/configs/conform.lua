local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    python = { "isort", "black" },
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    json = { "prettier" },
    graphql = { "prettier" },
    svelte = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    markdown = { "prettier" },
    sql = { "pgformat" },
    sh = { "shfmt" },
    xml = { "xmllint" },
    svg = { "xmllint" },
    go = { "gofmt" },
  },

  format_on_save = {
    timeout_ms = 2500,
    lsp_fallback = true,
  },

  formatters = {
    shfmt = {
      prepend_args = { "-i", "2" },
    },
    xmllint = {
      prepend_args = { "--format" },
      command = "/usr/bin/xmllint",
    },
  },
}

return options
