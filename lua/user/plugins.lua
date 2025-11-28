-- =============================================================================
-- プラグイン管理 (plugins.lua) - lazy.nvim
-- =============================================================================

-- lazy.nvim の自動インストール
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- プラグイン定義
require("lazy").setup({
  -- ===========================================================================
  -- Treesitter（構文解析・ハイライト）
  -- ===========================================================================
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("user.plugins.treesitter")
    end,
  },

  -- ===========================================================================
  -- Telescope（ファジーファインダー）
  -- ===========================================================================
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("user.plugins.telescope")
    end,
  },

  -- ===========================================================================
  -- Gitsigns（Git差分表示）
  -- ===========================================================================
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("user.plugins.gitsigns")
    end,
  },

  -- ===========================================================================
  -- カラースキーム
  -- ===========================================================================
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("user.plugins.colorscheme")
    end,
  },
  -- ===========================================================================
  -- 自動補完 (nvim-cmp)
  -- ===========================================================================
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",  -- 挿入モードで遅延読み込み
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",     -- LSP からの補完
      "hrsh7th/cmp-buffer",       -- バッファ内の単語
      "hrsh7th/cmp-path",         -- ファイルパス
      "hrsh7th/cmp-cmdline",      -- コマンドライン補完
      "L3MON4D3/LuaSnip",         -- スニペットエンジン（必須）
      "saadparwaiz1/cmp_luasnip", -- LuaSnip との連携
    },
    config = function()
      require("user.plugins.cmp")
    end,
  },

  -- ===========================================================================
  -- which-key（キーバインドヘルプ）
  -- ===========================================================================
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("user.plugins.which-key")
    end,
  },

  -- ===========================================================================
  -- lualine（ステータスライン）
  -- ===========================================================================
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("user.plugins.lualine")
    end,
  },

  -- ===========================================================================
  -- LSP（カスタム設定、プラグイン不要）
  -- ===========================================================================
  {
    dir = vim.fn.stdpath("config") .. "/lua/user/plugins",
    name = "lsp-config",
    config = function()
      require("user.plugins.lsp")
    end,
  },

  -- ===========================================================================
  -- Markdown サポート
  -- ===========================================================================
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },  -- Markdownファイルで遅延読み込み
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("user.plugins.markdown")
    end,
  },
}, {
  -- lazy.nvim 自体の設定
  ui = {
    border = "rounded",
  },
  checker = {
    enabled = true,      -- プラグイン更新チェック
    notify = false,      -- 通知は出さない
  },
  change_detection = {
    notify = false,      -- 設定変更時の通知を抑制
  },
})
