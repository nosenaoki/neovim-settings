-- =============================================================================
-- カラースキーム設定
-- =============================================================================

-- Gruvbox Material
vim.g.gruvbox_material_background = "medium"
vim.g.gruvbox_material_enable_bold = 1
vim.g.gruvbox_material_enable_italic = 1

-- Kanagawa
require("kanagawa").setup({
  commentStyle = { italic = true },
  keywordStyle = { italic = true },
  theme = "wave",  -- "wave", "dragon", "lotus"
})

-- Tokyonight
require("tokyonight").setup({
  style = "night",  -- "storm", "moon", "night", "day"
  transparent = false,
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
  },
})

-- =============================================================================
-- テーマ適用（使いたいものをコメント解除）
-- =============================================================================

vim.cmd.colorscheme("gruvbox-material")
-- vim.cmd.colorscheme("kanagawa")
-- vim.cmd.colorscheme("tokyonight")
