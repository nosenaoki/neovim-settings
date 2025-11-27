-- =============================================================================
-- which-key 設定（キーバインドヘルプ）
-- =============================================================================

local wk = require("which-key")

wk.setup({
  -- ポップアップの見た目
  win = {
    border = "rounded",
  },
  -- 表示までの遅延（ミリ秒）
  delay = 300,
  -- アイコン設定
  icons = {
    mappings = false,  -- マッピングアイコンを無効化（シンプルに）
  },
})

-- -----------------------------------------------------------------------------
-- キーグループの登録（<leader> 以下の説明）
-- -----------------------------------------------------------------------------

wk.add({
  -- トップレベルグループ
  { "<leader>f", group = "Find (Telescope)" },
  { "<leader>g", group = "Git" },
  { "<leader>h", group = "Hunk (Git)" },
  { "<leader>d", group = "Diagnostics" },
  { "<leader>b", group = "Buffer" },
  { "<leader>w", desc = "Save" },
  { "<leader>W", desc = "Save All" },
  { "<leader>x", desc = "Save & Close" },
  { "<leader>e", desc = "Float Diagnostic" },
  { "<leader>q", desc = "Diagnostic List" },

  -- Find (Telescope)
  { "<leader>ff", desc = "Find Files" },
  { "<leader>fg", desc = "Live Grep" },
  { "<leader>fb", desc = "Buffers" },
  { "<leader>fh", desc = "Help Tags" },
  { "<leader>fr", desc = "Recent Files" },

  -- Git
  { "<leader>gs", desc = "Git Status" },
  { "<leader>gc", desc = "Git Commits" },
  { "<leader>gb", desc = "Git Branches" },

  -- Hunk (Gitsigns)
  { "<leader>hp", desc = "Preview Hunk" },
  { "<leader>hb", desc = "Toggle Blame" },
  { "<leader>hd", desc = "Diff This" },
  { "<leader>hD", desc = "Diff HEAD~" },
  { "<leader>hs", desc = "Stage Hunk" },
  { "<leader>hr", desc = "Reset Hunk" },
  { "<leader>hS", desc = "Stage Buffer" },
  { "<leader>hu", desc = "Undo Stage" },
  { "<leader>hR", desc = "Reset Buffer" },

  -- Diagnostics
  { "<leader>dw", desc = "Workspace Diagnostics" },
  { "<leader>ds", desc = "Document Symbols" },

  -- Buffer
  { "<leader>bd", desc = "Delete Buffer" },

  -- LSP（バッファローカルなので参考用）
  { "<leader>rn", desc = "Rename" },
  { "<leader>ca", desc = "Code Action" },

  -- Workspace Symbols
  { "<leader>ws", desc = "Workspace Symbols" },
})
