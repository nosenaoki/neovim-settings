-- =============================================================================
-- Treesitter 設定
-- =============================================================================

require("nvim-treesitter.configs").setup({
  -- インストールする言語
  ensure_installed = {
    "c_sharp",
    "lua",
    "vim",
    "vimdoc",
    "markdown",
    "markdown_inline",
    "json",
    "yaml",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "jsdoc",
  },

  -- 同期インストール（false推奨）
  sync_install = false,

  -- 自動インストール
  auto_install = true,

  -- ハイライト
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },

  -- インデント
  indent = {
    enable = true,
  },
})
