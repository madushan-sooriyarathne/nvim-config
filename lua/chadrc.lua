local M = {}

-- Path to overriding theme and highlights files
local highlights = require("highlights")

M.ui = {
	theme = "doomchad",
	hl_override = highlights.override,
	hl_add = highlights.add,

	nvdash = {
		load_on_startup = true,

		header = {
			"███╗░░██╗██╗██╗░░██╗██╗██╗░░░░░  ░█████╗░██████╗░░██████╗████████╗░█████╗░████████╗",
			"████╗░██║██║██║░░██║██║██║░░░░░  ██╔══██╗██╔══██╗██╔════╝╚══██╔══╝██╔══██╗╚══██╔══╝",
			"██╔██╗██║██║███████║██║██║░░░░░  ██║░░██║██████╦╝╚█████╗░░░░██║░░░███████║░░░██║░░░",
			"██║╚████║██║██╔══██║██║██║░░░░░  ██║░░██║██╔══██╗░╚═══██╗░░░██║░░░██╔══██║░░░██║░░░",
			"██║░╚███║██║██║░░██║██║███████╗  ╚█████╔╝██████╦╝██████╔╝░░░██║░░░██║░░██║░░░██║░░░",
			"╚═╝░░╚══╝╚═╝╚═╝░░╚═╝╚═╝╚══════╝  ░╚════╝░╚═════╝░╚═════╝░░░░╚═╝░░░╚═╝░░╚═╝░░░╚═╝░░░",
			"                          Nothing stands in the way                                ",
			"                                                                                   ",
			"              Custom NeoVim configuration by Madushan Sooriyarathne                ",
			"                            ✉️ hello@madushan.dev                                   ",
			"                          🌐 https://madushan.dev                                  ",
		},
		buttons = {
			{ "  Find File", "Spc f f", "Telescope find_files" },
			{ "  Recent Projects", "Spc f p", "Telescope projects" },
			{ "󰈚  Recent Files", "Spc f o", "Telescope oldfiles" },
			{ "󰈭  Find Word", "Spc f w", "Telescope live_grep" },
			{ "  Bookmarks", "Spc m a", "Telescope marks" },
			{ "ℳ  Mason", "Spc m m", "Mason" },
			{ "  Themes", "Spc t h", "Telescope themes" },
			{ "  Mappings", "Spc c h", "NvCheatsheet" },
		},
	},
}

return M
