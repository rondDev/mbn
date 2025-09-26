vim.pack.add({
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/NeogitOrg/neogit" },
	{ src = "https://github.com/alexghergh/nvim-tmux-navigation" },
	{ src = "https://github.com/wakatime/vim-wakatime" },
	{ src = "https://github.com/lambdalisue/vim-suda" },
})

require("oil").setup({
	disable_default_keybindings = false,
	columns = {
		"icon",
		-- "permissions",
		-- "size",
		-- "mtime",
	},
	keymaps = {
		["g?"] = "actions.show_help",
		["<CR>"] = "actions.select",
		["<C-s>"] = "actions.select_vsplit",
		-- ["<C-h>"] = "actions.select_split", -- this is used to navigate left
		["<C-t>"] = "actions.select_tab",
		["<C-p>"] = "actions.preview",
		["<C-c>"] = "actions.close",
		["<C-r>"] = "actions.refresh",
		["-"] = "actions.parent",
		["_"] = "actions.open_cwd",
		["`"] = "actions.cd",
		["~"] = "actions.tcd",
		["gs"] = "actions.change_sort",
		["gx"] = "actions.open_external",
		["g."] = "actions.toggle_hidden",
	},
	use_default_keymaps = false,
	watch_for_changes = true,
})
require("which-key").setup({})
require("neogit").setup({})
require("nvim-tmux-navigation")

vim.g.suda_smart_edit = 1
