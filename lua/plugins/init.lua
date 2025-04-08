-- catch-all for plugin spec
return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
  {
    "alexghergh/nvim-tmux-navigation",
    event = { "VeryLazy" },
    init = function()
      require("nvim-tmux-navigation")
    end,
  },
}
