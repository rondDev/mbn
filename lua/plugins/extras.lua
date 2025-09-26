vim.pack.add({
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/folke/which-key.nvim" },
  { src = "https://github.com/NeogitOrg/neogit" },

})

require("oil").setup({})
require("which-key").setup({})
require("neogit").setup({})
