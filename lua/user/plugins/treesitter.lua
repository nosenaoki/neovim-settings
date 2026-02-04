-- =============================================================================
-- Treesitter 設定 (新 API 対応)
-- =============================================================================

local treesitter = require("nvim-treesitter")

-- 基本設定
treesitter.setup()

-- インストールする言語
local languages = {
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
  "go",
}

-- パーサーのインストール（未インストールの場合のみ）
treesitter.install(languages)

-- FileType autocmd でハイライト・インデントを有効化
vim.api.nvim_create_autocmd("FileType", {
  pattern = languages,
  callback = function()
    -- treesitter ハイライトを有効化
    pcall(vim.treesitter.start)
    -- treesitter インデントを有効化
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
