-- =============================================================================
-- Telescope 設定
-- =============================================================================

local telescope = require("telescope")
local builtin = require("telescope.builtin")
local keymap = vim.keymap.set

-- Telescope 本体の設定
telescope.setup({
  defaults = {
    -- 検索結果のレイアウト
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        preview_width = 0.55,
      },
    },
    -- 無視するパターン
    file_ignore_patterns = {
      "node_modules",
      ".git/",
      "bin/",
      "obj/",
      "%.dll",
      "%.exe",
      "%.pdb",
    },
    -- ソート設定
    sorting_strategy = "ascending",
    -- プロンプトの位置
    prompt_prefix = "🔍 ",
    selection_caret = " ",
  },
  pickers = {
    find_files = {
      hidden = true,  -- 隠しファイルも表示
    },
  },
})

-- -----------------------------------------------------------------------------
-- キーマッピング
-- -----------------------------------------------------------------------------

-- ファイル検索
keymap("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
keymap("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
keymap("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
keymap("n", "<leader>fh", builtin.help_tags, { desc = "Help Tags" })
keymap("n", "<leader>fr", builtin.oldfiles, { desc = "Recent Files" })

-- Git
keymap("n", "<leader>gs", builtin.git_status, { desc = "Git Status" })
keymap("n", "<leader>gc", builtin.git_commits, { desc = "Git Commits" })
keymap("n", "<leader>gb", builtin.git_branches, { desc = "Git Branches" })

-- LSP 連携
keymap("n", "<leader>ws", builtin.lsp_workspace_symbols, { desc = "Workspace Symbols" })
keymap("n", "<leader>ds", builtin.lsp_document_symbols, { desc = "Document Symbols" })
keymap("n", "<leader>dw", builtin.diagnostics, { desc = "Workspace Diagnostics" })

-- その他
keymap("n", "<leader>:", builtin.command_history, { desc = "Command History" })
keymap("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "Fuzzy Find in Buffer" })
