vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/Saghen/blink.cmp" },
	{ src = "https://github.com/mrcjkb/rustaceanvim" },
	{ src = "https://github.com/SmiteshP/nvim-navic" },
	{ src = "https://github.com/LunarVim/breadcrumbs.nvim" },
})

if vim.fn.isdirectory("/home/rond/.local/share/nvim/site/pack/core/opt/blink.cmp/target") ~= 1 then
	vim.cmd("lcd ~/.local/share/nvim/site/pack/core/opt/blink.cmp/")
	vim.system({ "cargo", "build", "--release" })
end
require("blink.cmp").setup({})

vim.lsp.enable({ "lua_ls", "svelte" })

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			hint = {
				enable = true,
			},
			format = {
				enable = false,
			},
		},
	},
})

vim.diagnostic.config({
	globals = { "vim" },
	underline = true,
	virtual_text = {
		spacing = 4,
		source = "if_many",
		prefix = "●",
		-- this will set set the prefix to a function that returns the diagnostics icon based on the severity
		-- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
		-- prefix = "icons",
	},
	severity_sort = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = " ",
			[vim.diagnostic.severity.INFO] = " ",
		},
	},
})
require("breadcrumbs").setup({})
