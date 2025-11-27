-- =============================================================================
-- lualine 設定（ステータスライン）
-- =============================================================================

require("lualine").setup({
  options = {
    -- テーマ（カラースキームに合わせる）
    theme = "gruvbox-material",
    -- theme = "kanagawa",
    -- theme = "tokyonight",

    -- セクション区切りの形状
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },

    -- グローバルステータスライン（全ウィンドウで1つ）
    globalstatus = true,

    -- 無効化するファイルタイプ
    disabled_filetypes = {
      statusline = { "lazy", "NvimTree", "neo-tree" },
    },
  },

  -- セクション構成
  -- +---------+----------+-----------+     +-----------+----------+---------+
  -- |    A    |    B     |     C     | ... |     X     |    Y     |    Z    |
  -- +---------+----------+-----------+     +-----------+----------+---------+
  sections = {
    lualine_a = { "mode" },
    lualine_b = {
      "branch",
      {
        "diff",
        symbols = { added = " ", modified = " ", removed = " " },
      },
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " },
      },
    },
    lualine_c = {
      {
        "filename",
        path = 1,  -- 0: ファイル名のみ, 1: 相対パス, 2: 絶対パス
        symbols = {
          modified = " ●",
          readonly = " ",
          unnamed = "[No Name]",
        },
      },
    },
    lualine_x = {
      "encoding",
      {
        "fileformat",
        symbols = {
          unix = "LF",
          dos = "CRLF",
          mac = "CR",
        },
      },
      "filetype",
    },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },

  -- 非アクティブウィンドウのステータスライン
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },

  -- 拡張機能
  extensions = { "lazy" },
})
