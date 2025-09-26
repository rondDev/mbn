vim.pack.add({
	{ src = "https://github.com/tpope/vim-surround" },
	{ src = "https://github.com/tpope/vim-sleuth" },
	{ src = "https://github.com/MysticalDevil/inlay-hints.nvim" },
	{ src = "https://github.com/vladdoster/remember.nvim" },
	{ src = "https://github.com/folke/flash.nvim" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/windwp/nvim-autopairs" },
	{ src = "https://github.com/folke/ts-comments.nvim" },
	{ src = "https://github.com/HiPhish/rainbow-delimiters.nvim" },
}, { confirm = false })

require("conform").setup({
	-- Define your formatters
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "black" },
		rust = { "rustfmt", lsp_format = "fallback" },
		javascript = { "biome", "prettierd", "prettier", stop_after_first = true },
		svelte = { "biome", stop_after_first = true },
	},
	-- Set default options
	default_format_opts = {
		lsp_format = "fallback",
	},
	-- Set up format-on-save
	format_on_save = { timeout_ms = 500 },
	-- Customize formatters
	formatters = {
		shfmt = {
			prepend_args = { "-i", "2" },
		},
	},
})
require("inlay-hints").setup({})
require("remember").setup({})
require("flash").setup({
	modes = {
		char = {
			jump_labels = true,
		},
	},
})
require("ts-comments").setup({})

require("nvim-autopairs").setup({})
