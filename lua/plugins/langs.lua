return {
  -- -- emmet for neovim
  -- {
  --   "olrtg/nvim-emmet",
  --   opts = {},
  -- },
  -- Documentation generation
  {
    "danymat/neogen",
    config = true,
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*"
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^6", -- Recommended
    lazy = false, -- This plugin is already lazy
    config = function()
      vim.g.rust_recommended_style = false
    end,
  },
}
