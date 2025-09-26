vim.pack.add({
	{ src = "https://github.com/folke/snacks.nvim" },
})

require("snacks").setup({
	bigfile = { enabled = false },
	bufdelete = { enabled = true },
	dashboard = { enabled = true },
	debug = { enabled = true },
	dim = { enabled = true },
	explorer = { enabled = false },
	git = { enabled = true },
	gitbrowse = { enabled = true },
	image = { enabled = true },
	indent = { enabled = true },
	input = { enabled = true },
	layout = { enabled = true },
	lazygit = { enabled = false },
	notifier = {
		enabled = true,
		timeout = 3000,
	},
	picker = { enabled = true },
	quickfile = { enabled = true },
	scope = { enabled = true },
	scroll = { enabled = true },
	statuscolumn = { enabled = true },
	words = { enabled = true },
	styles = {
		notification = {
			wo = { wrap = true }, -- Wrap notifications
		},
	},
	zen = { enabled = true },
})
