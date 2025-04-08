-- A lot of the code here has been taken from: https://github.com/nvim-lualine/lualine.nvim/blob/master/examples/evil_lualine.lua
local colors = {
  bg = "#202328",
  fg = "#bbc2cf",
  yellow = "#ECBE7B",
  cyan = "#008080",
  darkblue = "#081633",
  green = "#98be65",
  orange = "#FF8800",
  violet = "#a9a1e1",
  magenta = "#c678dd",
  blue = "#51afef",
  red = "#ec5f67",
  grey = "#303030",
  black = "#080808",
}

local icons = {
  misc = {
    dots = "󰇘",
    leftpad = "",
    rightpad = "",
    tab = "󰌒",
  },
  dap = {
    Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
    Breakpoint = " ",
    BreakpointCondition = " ",
    BreakpointRejected = { " ", "DiagnosticError" },
    LogPoint = ".>",
  },
  diagnostics = {
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " ",
  },
  git = {
    added = " ",
    modified = " ",
    removed = " ",
  },
  kinds = {
    Array = " ",
    Boolean = "󰨙 ",
    Class = " ",
    Codeium = "󰘦 ",
    Color = " ",
    Control = " ",
    Collapsed = " ",
    Constant = "󰏿 ",
    Constructor = " ",
    Copilot = " ",
    Enum = " ",
    EnumMember = " ",
    Event = " ",
    Field = " ",
    File = " ",
    Folder = " ",
    Function = "󰊕 ",
    Interface = " ",
    Key = " ",
    Keyword = " ",
    Method = "󰊕 ",
    Module = " ",
    Namespace = "󰦮 ",
    Null = " ",
    Number = "󰎠 ",
    Object = " ",
    Operator = " ",
    Package = " ",
    Property = " ",
    Reference = " ",
    Snippet = " ",
    String = " ",
    Struct = "󰆼 ",
    TabNine = "󰏚 ",
    Text = " ",
    TypeParameter = " ",
    Unit = " ",
    Value = " ",
    Variable = "󰀫 ",
  },
}

vim.g.gitblame_display_virtual_text = 0

local components = {
  {
    "mode",
    -- seperator = { left = "", right = "" },
    right_padding = 2,
  },
  branch = {
    "b:gitsigns_head",
    icon = branch,
    color = { gui = "bold" },
  },
  filename = {
    "filename",
    color = {},
    cond = nil,
  },
  diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    symbols = { error = " ", warn = " ", info = " " },
    diagnostics_color = {
      color_error = { fg = colors.red },
      color_warn = { fg = colors.yellow },
      color_info = { fg = colors.cyan },
    },
  },
  treesitter = {
    color = function()
      local buf = vim.api.nvim_get_current_buf()
      local ts = vim.treesitter.highlighter.active[buf]
      return { fg = ts and not vim.tbl_isempty(ts) and colors.green or colors.red }
    end,
  },
  lsp = {
    function()
      local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
      if #buf_clients == 0 then
        return "LSP Inactive"
      end

      local buf_ft = vim.bo.filetype
      local buf_client_names = {}

      -- add client
      for _, client in pairs(buf_clients) do
        if client.name ~= "null-ls" then
          table.insert(buf_client_names, client.name)
        end
      end

      local null_ls = require("null-ls")

      for _, source in ipairs(require("null-ls").get_sources()) do
        table.insert(buf_client_names, source)
      end

      local unique_client_names = table.concat(buf_client_names, ", ")
      local language_servers = string.format("[%s]", unique_client_names)

      return language_servers
    end,
    color = { gui = "bold" },
  },
  location = { "location" },
  progress = {
    "progress",
    fmt = function()
      return "%P/%L"
    end,
    color = {},
  },

  spaces = {
    function()
      local shiftwidth = vim.api.nvim_get_option_value("shiftwidth", { buf = 0 })
      return icons.misc.tab .. " " .. shiftwidth
    end,
    padding = 1,
  },
  encoding = {
    "o:encoding",
    fmt = string.upper,
    color = {},
  },
  filetype = { "filetype", cond = nil, padding = { left = 1, right = 1 } },
  scrollbar = {
    function()
      local current_line = vim.fn.line(".")
      local total_lines = vim.fn.line("$")
      local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
      local line_ratio = current_line / total_lines
      local index = math.ceil(line_ratio * #chars)
      return chars[index]
    end,
    padding = { left = 0, right = 0 },
    color = "SLProgress",
    cond = nil,
  },
}

return {
  {
    "nvim-lualine/lualine.nvim",
    event = { "VeryLazy", "BufReadPost", "BufNewFile", "BufWritePre" },
    dependencies = {
      -- "ThePrimeagen/harpoon",
      {
        "f-person/git-blame.nvim",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
      },
    },
    opts = {
      sections = {
        lualine_a = {
          {
            "mode",
            -- seperator = { left = "", right = "" },
            -- right_padding = 2,
          },
        },
        lualine_b = {},
        lualine_c = {},

        lualine_x = { components.diagnostics, components.lsp, components.spaces, components.filetype },
        lualine_y = {
          {
            "diff",
            -- Is it me or the symbol for modified us really weird
            symbols = {
              added = icons.git.added,
              modified = icons.git.modified,
              removed = icons.git.removed,
            },
            diff_color = {
              added = { fg = colors.green },
              modified = { fg = colors.orange },
              removed = { fg = colors.red },
            },
            -- cond = conditions.hide_in_width,
          },
        },
        lualine_z = {

          { "progress" },

          { "location" },
        },
      },
    },
  },
}
