vim.pack.add({
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/Saghen/blink.cmp" },
})

if not vim.fn.isdirectory('/home/rond/.local/share/nvim/site/pack/core/opt/blink.cmp/target') then
  vim.system({'cd', '~/.local/share/nvim/site/pack/core/opt/blink.cmp', '&&', 'cargo', 'build', '--release'})
end
require("blink.cmp").setup({})

vim.lsp.enable({"lua_ls", "rust_analyzer", "svelte" })
