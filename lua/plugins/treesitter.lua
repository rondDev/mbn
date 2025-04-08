return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      {
        "windwp/nvim-ts-autotag",
        config = function()
          require("nvim-ts-autotag").setup({
            opts = {
              -- Defaults
              enable_close = true, -- Auto close tags
              enable_rename = true, -- Auto rename pairs of tags
              enable_close_on_slash = true, -- Auto close on trailing </
            },
            -- Also override individual filetype configs, these take priority.
            --
            -- Empty by default, useful if one of the "opts" global settings
            -- doesn't work well in a specific filetype
            per_filetype = {
              ["html"] = {
                enable_close = false,
              },
            },
          })
        end,
      },
    },
    opts = {
      ensure_installed = { "comment", "markdown_inline", "regex" },
    },
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = { "comment", "markdown_inline", "regex" },
        sync_install = true,
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        ignore_install = {},
        modules = {},
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
  },
}
