return {
  {
    "nyoom-engineering/oxocarbon.nvim",
  },
  {
    "eldritch-theme/eldritch.nvim",
    lazy = false,
    priority = 10000,
    opts = {},
    config = function()
      vim.cmd.colorscheme("eldritch")
    end,
  },
}
