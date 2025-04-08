local M = {}

local function cmd(c)
  return string.format("<Cmd>%s<CR>", c)
end

local function wrap(f)
  return function()
    f()
  end
end

-- ["<C-h>"] = { "<cmd>NvimTmuxNavigateLeft<CR>", "Move left" },
-- ["<C-l>"] = { "<cmd>NvimTmuxNavigateRight<CR>", "Move right" },
-- ["<C-j>"] = { "<cmd>NvimTmuxNavigateDown<CR>", "Move down" },
-- ["<C-k>"] = { "<cmd>NvimTmuxNavigateUp<CR>", "Move up" },

_G.actions = {
  change_window_left = cmd("NvimTmuxNavigateLeft"),
  change_window_right = cmd("NvimTmuxNavigateRight"),
  change_window_up = cmd("NvimTmuxNavigateDown"),
  change_window_down = cmd("NvimTmuxNavigateUp"),
  close_window = cmd("wincmd q"),
  move_window_left = cmd("wincmd H"),
  move_window_right = cmd("wincmd L"),
  move_window_up = cmd("wincmd K"),
  move_window_down = cmd("wincmd J"),

  split_window_vertically = cmd("vsplit"),
  split_window_horizontally = cmd("split"),
  window_quit = cmd("q"),

  go_start_of_line = "^",
  go_end_of_line = "$",

  repeat_last_search_center = "nzz",
  repeat_last_search_center_reverse = "Nzz",

  replace_under_cursor = function()
    local c = ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>"
    local keys = vim.api.nvim_replace_termcodes(c, true, false, true)
    vim.api.nvim_feedkeys(keys, "n", false)
  end,

  resize_equal_buffer_splits = "<C-w>=",

  redo = "<C-r>",

  file_save = cmd("w"),
  no_highlight = cmd("noh"),

  open_oil = cmd("Oil"),
  open_mini_files = wrap(function()
    local s = require("mini.files")
    if not s then
      print("mini.files could not be found")
    end
    s.open()
  end),

  quit = cmd("q"),
  write_quit = cmd("xa"),

  toggle_sidebar = wrap(function()
    local s = require("sidebar-nvim")
    if not s then
      print("sidebar-nvim could not be found")
      return
    end
    s.toggle()
  end),

  move_line_up = 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', -- opts = { expr = true }
  move_line_down = 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', -- opts = { expr = true }

  increase_indent_line = ">gv", -- moves and enters visual mode
  decrease_indent_line = "<gv", -- moves and enters visual mode

  move_selected_text_down = ":m '>+1<CR>gv=gv",
  move_selected_text_up = ":m '<-2<CR>gv=gv",

  paste_no_replace = 'p:let @+=@0<CR>:let @"=@0<CR>',

  terminal_normal_mode = "[[<C-\\><C-n>]]",

  floating_diagnostics = wrap(function()
    vim.diagnostic.open_float({
      border = "rounded",
    })
  end),
}

function M.load_keys()
  local map = vim.keymap.set

  local actions = _G.actions

  map({ "n", "t" }, "<C-h>", actions.change_window_left, { desc = "Move left" })
  map({ "n", "t" }, "<C-l>", actions.change_window_right, { desc = "Move right" })
  map({ "n", "t" }, "<C-k>", actions.change_window_up, { desc = "Move up" })
  map({ "n", "t" }, "<C-j>", actions.change_window_down, { desc = "Move down" })

  map({ "n", "v" }, "H", actions.go_start_of_line, { desc = "Jump to start of line" })
  map({ "n", "v" }, "L", actions.go_end_of_line, { desc = "Jump to end of line" })

  map({ "n", "x" }, "j", actions.move_line_down, { desc = "Move down", expr = true })
  map({ "n", "x" }, "k", actions.move_line_up, { desc = "Move down", expr = true })

  map("v", ">", actions.increase_indent_line, { desc = "Increase line indentation" })
  map("v", "<", actions.decrease_indent_line, { desc = "Decrease line indentation" })

  map("v", "<A-j>", actions.move_selected_text_down, { desc = "Move selected line down", expr = true })
  map("v", "<A-k>", actions.move_selected_text_up, { desc = "Move selected line up", expr = true })

  map("x", "p", actions.paste_no_replace, { desc = "Paste without replacing" })

  map("n", "U", actions.redo, { desc = "Redo" })

  map("n", "n", actions.repeat_last_search_center, { desc = "Repeat last search and center" })
  map("n", "N", actions.repeat_last_search_center_reverse, { desc = "Repeat last search and center (reverse)" })

  -- leader prefixed keys
  map("n", "<leader>d", actions.floating_diagnostics, { desc = "Floating Diagnostics" })
  map("n", "<leader>fs", actions.file_save, { desc = "Save file" })
  -- map("n", "<leader>no", actions.no_highlight, { desc = "No highlight" })
  map("n", "<leader>oo", actions.open_oil, { desc = "Open oil" })
  map("n", "<leader>om", actions.open_mini_files, { desc = "Open mini files" })
  map("n", "<leader>q", actions.quit, { desc = "Quit" })
  map("n", "<leader>ts", actions.toggle_sidebar, { desc = "Toggle Sidebar" })

  -- window
  map({ "n", "t" }, "<leader>wh", actions.change_window_left, { desc = "Move left" })
  map({ "n", "t" }, "<leader>wl", actions.change_window_right, { desc = "Move right" })
  map({ "n", "t" }, "<leader>wk", actions.change_window_up, { desc = "Move up" })
  map({ "n", "t" }, "<leader>wj", actions.change_window_down, { desc = "Move down" })

  -- localleader prefixed keys
end
return M
