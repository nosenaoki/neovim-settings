-- =============================================================================
-- カラースキーム設定
-- =============================================================================

-- 使用するテーマを選択（"gruvbox-material", "kanagawa", "tokyonight"）
local theme = "gruvbox-material"

-- テーマ別設定
if theme == "gruvbox-material" then
  vim.g.gruvbox_material_background = "medium"
  vim.g.gruvbox_material_enable_bold = 1
  vim.g.gruvbox_material_enable_italic = 1

elseif theme == "kanagawa" then
  require("kanagawa").setup({
    commentStyle = { italic = true },
    keywordStyle = { italic = true },
    theme = "wave",  -- "wave", "dragon", "lotus"
  })

elseif theme == "tokyonight" then
  require("tokyonight").setup({
    style = "night",  -- "storm", "moon", "night", "day"
    transparent = false,
    styles = {
      comments = { italic = true },
      keywords = { italic = true },
    },
  })
end

-- テーマ適用
vim.cmd.colorscheme(theme)
