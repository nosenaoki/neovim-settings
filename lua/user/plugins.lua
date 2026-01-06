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
    event = { "BufReadPost", "BufNewFile" },
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
    cmd = "Telescope",  -- :Telescope コマンド実行時に読み込み
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
      -- Git
      { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Git Status" },
      { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git Commits" },
      { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Git Branches" },
      -- LSP
      { "<leader>ws", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Workspace Symbols" },
      { "<leader>ds", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
      { "<leader>dw", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics" },
      -- その他
      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Fuzzy Find in Buffer" },
    },
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
    event = "VeryLazy",  -- 起動後に遅延読み込み（パフォーマンス改善）
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
    config = function()
      require("user.plugins.colorscheme")
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,  -- 使用時のみ読み込み
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,  -- 使用時のみ読み込み
  },

  -- ===========================================================================
  -- 自動補完 (nvim-cmp)
  -- ===========================================================================
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
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
    event = "VeryLazy",  -- 起動後に遅延読み込み
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("user.plugins.lualine")
    end,
  },

  -- ===========================================================================
  -- LSP（カスタム設定）
  -- ===========================================================================
  {
    dir = vim.fn.stdpath("config") .. "/lua/user/plugins",
    name = "lsp-config",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("user.plugins.lsp")
    end,
  },

  -- ===========================================================================
  -- Markdown サポート
  -- ===========================================================================
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("user.plugins.markdown")
    end,
  },

  -- ===========================================================================
  -- Oil.nvim（ファイラー）
  -- ===========================================================================
  {
    "stevearc/oil.nvim",
    cmd = "Oil",  -- :Oil コマンド実行時に読み込み
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Open Oil" },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("user.plugins.oil")
    end,
  },
}, {
  ui = {
    border = "rounded",
  },
  checker = {
    enabled = false,  -- 起動時の更新チェックを無効化
  },
  change_detection = {
    notify = false,
  },
  performance = {
    rtp = {
      -- 不要な組み込みプラグインを無効化
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
