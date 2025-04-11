local M = {}

local function wrap(f)
  return function()
    f()
  end
end

_G.actions = {
  change_window_left = "<cmd>NvimTmuxNavigateLeft<cr>",
  change_window_right = "<cmd>NvimTmuxNavigateRight<cr>",
  change_window_up = "<cmd>NvimTmuxNavigateDown<cr>",
  change_window_down = "<cmd>NvimTmuxNavigateUp<cr>",
  close_window = "<cmd>wincmd q<cr>",
  move_window_left = "<cmd>wincmd H<cr>",
  move_window_right = "<cmd>wincmd L<cr>",
  move_window_up = "<cmd>wincmd K<cr>",
  move_window_down = "<cmd>wincmd J<cr>",

  split_window_vertically = "<cmd>vsplit<cr>",
  split_window_horizontally = "<cmd>split<cr>",
  window_quit = "<cmd>q<cr>",

  go_start_of_line = "^",
  go_end_of_line = "$",

  repeat_last_search_center = "nzz",
  repeat_last_search_center_reverse = "Nzz",

  replace_under_cursor = wrap(function()
    local c = ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>"
    local keys = vim.api.nvim_replace_termcodes(c, true, false, true)
    vim.api.nvim_feedkeys(keys, "n", false)
  end),

  resize_equal_buffer_splits = "<C-w>=",

  redo = "<C-r>",

  file_save = "<cmd>w<cr>",
  no_highlight = "<cmd>noh<cr>",

  open_oil = "<cmd>Oil<cr>",
  open_mini_files = wrap(function()
    local s = require("mini.files")
    if not s then
      print("mini.files could not be found")
    end
    s.open()
  end),

  quit = "<cmd>q<cr>",
  write_quit = "<cmd>xa<cr>",

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

  lsp_signature_help = vim.lsp.buf.signature_help,
  lsp_code_action = vim.lsp.buf.code_action,
  lsp_rename = vim.lsp.buf.rename,

  neogit_open = "<cmd>Neogit<cr>",
  neogit_open_float = wrap(function()
    local s = require("neogit")
    if not s then
      print("neogit could not be found")
      return
    end
    s.open({ kind = "float" })
  end),
  neogit_open_commit = "<cmd>Neogit commit<cr>",

  generate_docs = wrap(function()
    local s = require("neogen")
    if not s then
      print("neogen could not be found")
      return
    end
    s.generate()
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
  -- map({ "n", "t" }, "<leader>wh", actions.change_window_left, { desc = "Move left" })
  -- map({ "n", "t" }, "<leader>wl", actions.change_window_right, { desc = "Move right" })
  -- map({ "n", "t" }, "<leader>wk", actions.change_window_up, { desc = "Move up" })
  -- map({ "n", "t" }, "<leader>wj", actions.change_window_down, { desc = "Move down" })
  map({ "n", "t" }, "<leader>wv", actions.split_window_vertically, { desc = "Split Window Vertically" })
  map({ "n", "t" }, "<leader>wh", actions.split_window_horizontally, { desc = "Split Window Horizontally" })
  map({ "n", "t" }, "<leader>wq", actions.window_quit, { desc = "Quit Window" })

  -- lsp
  map("n", "<leader>ca", actions.lsp_code_action, { desc = "Code Action" })
  map("n", "<leader>cr", actions.lsp_rename, { desc = "Code Rename" })
  map("n", "gK", actions.lsp_signature_help, { desc = "Go to signature help" })
  map("n", "<leader>cd", actions.generate_docs, { desc = "Generate docs" })

  -- git
  map("n", "<leader>gg", actions.neogit_open, { desc = "Open Neogit" })
  map("n", "<leader>gf", actions.neogit_open_float, { desc = "Open Neogit (float)" })
  map("n", "<leader>gc", actions.neogit_open_commit, { desc = "Open Neogit (commit)" })

  -- localleader prefixed keys
end
return M
