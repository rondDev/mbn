vim.pack.add({
  { src = "https://github.com/tpope/vim-surround" },
  { src = "https://github.com/tpope/vim-sleuth" },
  { src = "https://github.com/MysticalDevil/inlay-hints.nvim" },
  { src = "https://github.com/vladdoster/remember.nvim" }
})


require("inlay-hints").setup({})
require("remember").setup({})
