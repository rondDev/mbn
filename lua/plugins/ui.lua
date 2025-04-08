return {
	-- Better Quick Fix
	{ "kevinhwang91/nvim-bqf" },
	-- Better notifications and LSP progress messages
	{
		"j-hui/fidget.nvim",
		opts = {},
	},
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	-- {
	--   'nvimdev/dashboard-nvim',
	--   event = 'VimEnter',
	--   config = function()
	--     require('dashboard').setup {
	--       -- config
	--     }
	--   end,
	--   dependencies = { { 'nvim-tree/nvim-web-devicons' } }
	-- }
}
