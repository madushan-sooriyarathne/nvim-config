local M = {}

M.options = {
	defaultPlaceholder = "…",
	queries = {

		html = {
			{ pattern = 'class="([^"]*)"', placeholder = "✨" }, -- classes in html
			{ pattern = 'href="(.-)"' }, -- hrefs in html
			{ pattern = 'src="(.-)"' }, -- HTML img src attribute
		},
		typescript = {
			{ pattern = 'className="([^"]*)"', placeholder = "✨" }, -- classes in tsx
			-- { pattern = 'className=("([^"]*)"|{cn\\("([^"]*)"\\)})', placeholder = "✨" }, -- classes in tsx with cn()
			{ pattern = 'href="(.-)"' }, -- hrefs in html
			{ pattern = 'src="(.-)"' }, -- HTML img src attribute
		},
		typescriptreact = {
			{ pattern = 'className="([^"]*)"', placeholder = "✨" }, -- classes in tsx
			-- { pattern = 'className=("([^"]*)"|{cn\\("([^"]*)"\\)})', placeholder = "✨" }, -- classes in tsx with cn()
			{ pattern = 'href="(.-)"' }, -- hrefs in html
			{ pattern = 'src="(.-)"' }, -- HTML img src attribute
		},
	},
}

return M
