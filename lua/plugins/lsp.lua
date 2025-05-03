local Utils = require("core.utils")
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "folke/lazydev.nvim", opts = {} },
      "saghen/blink.cmp",
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
      {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
        -- use opts = {} for passing setup options
        -- this is equivalent to setup({}) function
      },
    },
    opts = {
      diagnostics = {
        globals = { "vim" },
        underline = true,
        update_in_insert = true,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
          -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
          -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
          -- prefix = "icons",
        },
        severity_sort = true,
      },
      inlay_hints = { enabled = true },
    },
    config = function(_, opts)
      -- Reserve a space in the gutter
      vim.opt.signcolumn = "yes"

      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      local capabilities = vim.lsp.protocol.make_client_capabilities()

      capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities({}, false))

      capabilities = vim.tbl_deep_extend("force", capabilities, {
        textDocument = {
          foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
          },
        },
      })

      -- This is where you enable features that only work
      -- if there is a language server active in the file
      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP actions",
        callback = function(event)
          local opts = { buffer = event.buf }

          vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
          vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
          vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
          vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
          vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
          vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
          vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
          vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
          vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
          vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
        end,
      })

      require("mason").setup()
      require("mason-lspconfig").setup({
        automatic_installation = true,
        ensure_installed = {
          "astro",
          "bashls",
          "biome",
          "clangd",
          "cssls",
          -- "denols",
          "emmet_ls",
          "jsonls",
          "lemminx",
          "lua_ls",
          "marksman",
          "mdx_analyzer",
          "nil_ls",
          "prismals",
          "rust_analyzer",
          "sqls",
          "svelte",
          "tailwindcss",
          "taplo",
          "textlsp",
          "ts_ls",
          "unocss",
          "v_analyzer",
          "volar",
          "zls",
        },
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup({
              capabilities = capabilities,
              Utils.on_attach(function(client, buffer)
                if client.name == "volar" then
                  vim.keymap.set(
                    "n",
                    "<leader>gd",
                    ":TypescriptGoToSourceDefinition<cr>",
                    { silent = true, nowait = true }
                  )
                end

                vim.api.nvim_buf_create_user_command(buffer, "Format", function(_)
                  require("conform").format({ bufnr = buffer })
                end, { desc = "LSP: Format current buffer with LSP" })
              end),
            })
          end,
          lua_ls = function()
            require("lspconfig").lua_ls.setup({
              settings = {
                Lua = {
                  hint = {
                    enable = true,
                  },
                },
              },
            })
          end,
          volar = function()
            require("lspconfig").volar.setup({})
          end,
          ts_ls = function()
            local vue_typescript_plugin = require("mason-registry")
              .get_package("vue-language-server")
              :get_install_path() .. "/node_modules/@vue/language-server" .. "/node_modules/@vue/typescript-plugin"

            require("lspconfig").ts_ls.setup({
              init_options = {
                plugins = {
                  {
                    name = "@vue/typescript-plugin",
                    location = vue_typescript_plugin,
                    languages = { "javascript", "typescript", "vue" },
                  },
                },
              },
              filetypes = {
                "javascript",
                "javascriptreact",
                "javascript.jsx",
                "typescript",
                "typescriptreact",
                "typescript.tsx",
                "vue",
              },
            })
          end,
        },
      })
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    config = function()
      require("null-ls").setup({})
    end,
  },
  {
    "zeioth/garbage-day.nvim",
    dependencies = "neovim/nvim-lspconfig",
    event = "VeryLazy",
    opts = {
      -- your options here
    },
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {
      bind = false,
      max_height = 0,
      floating_window = false,
    },
    config = function(_, opts)
      require("lsp_signature").setup(opts)
    end,
  },
}
