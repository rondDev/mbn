return {
  -- emmet for neovim
  {
    "olrtg/nvim-emmet",
    keys = {
      { "<leader>xe", function()
        require("nvim-emmet").wrap_with_abbreviation()
      end }
    },
    opts = {},
  }
}
