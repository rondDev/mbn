vim.pack.add({
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/Saghen/blink.cmp" },
})

require("blink.cmp").setup({})

vim.lsp.enable({"lua_ls", "rust_analyzer", "svelte" })
