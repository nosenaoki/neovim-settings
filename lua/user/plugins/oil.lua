-- =============================================================================
-- Oil.nvim 設定
-- =============================================================================

require("oil").setup({
  -- ファイラーをfloating windowで開く
  default_file_explorer = true,
  columns = {
    "icon",
    "size",
    "mtime",
  },
  view_options = {
    -- 隠しファイルを表示
    show_hidden = true,
  },
  -- floating windowの設定
  float = {
    padding = 2,
    max_width = 120,
    max_height = 40,
    border = "rounded",
  },
  keymaps = {
    ["g?"] = "actions.show_help",
    ["<CR>"] = "actions.select",
    ["<C-v>"] = "actions.select_vsplit",
    ["<C-s>"] = "actions.select_split",
    ["<C-t>"] = "actions.select_tab",
    ["<C-p>"] = "actions.preview",
    ["<C-c>"] = "actions.close",
    ["<C-r>"] = "actions.refresh",
    ["-"] = "actions.parent",
    ["_"] = "actions.open_cwd",
    ["`"] = "actions.cd",
    ["~"] = "actions.tcd",
    ["gs"] = "actions.change_sort",
    ["gx"] = "actions.open_external",
    ["g."] = "actions.toggle_hidden",
    ["g\\"] = "actions.toggle_trash",
  },
})

-- キーマップ
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>o", "<CMD>Oil --float<CR>", { desc = "Open Oil (float)" })
