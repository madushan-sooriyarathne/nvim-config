-- initial setup
-- Load options first and then the plugins
require("madushan.core.options")
-- config lazy.nvim
require("madushan.lazy-setup")

-- load options and keymaps
require("madushan.core.config").init()

-- other configurations
require("madushan.core.config").setup()
