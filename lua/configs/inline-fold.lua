local M = {}

M.options = {
	defaultPlaceholder = "…",
	queries = {
		html = {
			{ pattern = 'class="([^"]*)"', placeholder = "✨" }, -- classes in html
			{ pattern = 'd="([^"]*)"', placeholder = "✨" }, -- classes in tsx
			-- { pattern = 'href="(.-)"' }, -- hrefs in html
			-- { pattern = 'src="(.-)"' }, -- HTML img src attribute
		},
		typescript = {
			{ pattern = 'className="([^"]*)"', placeholder = "✨" }, -- classes in tsx
			{ pattern = 'className=("([^"]*)"|{cn\\("([^"]*)"\\)})', placeholder = "✨" }, -- classes in tsx with cn()
			{ pattern = "className={cn\\(\\s*\\n*([\\s\\S]*?)\\n*\\s*\\)}", placeholder = "✨" }, -- classes in tsx with cn()
			{ pattern = "className={cn\\(\\s*([\\s\\S]*?)\\s*\\)}", placeholder = "✨" }, -- classes in tsx
			{ pattern = 'd="([^"]*)"', placeholder = "✨" }, -- classes in tsx
			-- { pattern = 'className={cn("([^"]*)")}', placeholder = "✨" }, -- classes in tsx
			-- { pattern = 'href="(.-)"' }, -- hrefs in html
			-- { pattern = 'src="(.-)"' }, -- HTML img src attribute
		},
		typescriptreact = {
			{ pattern = 'className="([^"]*)"', placeholder = "✨" }, -- classes in tsx
			{ pattern = 'className=("([^"]*)"|{cn\\("([^"]*)"\\)})', placeholder = "✨" }, -- classes in tsx with cn()
			{ pattern = "className={cn\\(\\s*\\n*([\\s\\S]*?)\\n*\\s*\\)}", placeholder = "✨" }, -- classes in tsx with cn()
			{ pattern = "className={cn\\(\\s*([\\s\\S]*?)\\s*\\)}", placeholder = "✨" }, -- classes in tsx
			{ pattern = 'd="([^"]*)"', placeholder = "✨" }, -- classes in tsx
			-- { pattern = 'className={cn("([^"]*)")}', placeholder = "✨" }, -- classes in tsx
			-- { pattern = 'href="(.-)"' }, -- hrefs in html
			-- { pattern = 'src="(.-)"' }, -- HTML img src attribute
		},
	},
}

M.keys = {
	{ "<leader>uI", "<cmd>InlineFoldToggle<CR>", desc = "Toggle Inline Fold" },
}

return M
