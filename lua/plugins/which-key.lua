return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
      {
        "<leader>b",
        group = "buffers",
        expand = function()
          -- return require("which-key.extras").expand.buf()
          print(require("which-key.extras").expand.buf())
        end
      },
      {
        -- Don't copy the replaced text after pasting in visual mode
        -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
        "p",
        desc = "Paste without yanking selection",
        "p:let @+=@0<CR>:let @\"=@0<CR>",
        mode = { "v" },
      },
      { "H", "^", desc = "Jump to start of line" },
      { "L", "$", desc = "Jump to end of line" },

      {
        "<leader>f",
        desc = "Files",
      },
      {
        "<leader>fs",
        "<cmd>w<cr>",
        desc = "Save the buffer",
      },
      {
        "<leader>oo",
        "<cmd>lua MiniFiles.open()<cr>"
      },

    },
  }
}
