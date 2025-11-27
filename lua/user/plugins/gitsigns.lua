-- =============================================================================
-- Gitsigns 設定
-- =============================================================================

require("gitsigns").setup({
  -- サインの見た目
  signs = {
    add          = { text = "│" },
    change       = { text = "│" },
    delete       = { text = "_" },
    topdelete    = { text = "‾" },
    changedelete = { text = "~" },
  },

  -- 現在行の blame を常に表示（薄く）
  current_line_blame = false,  -- <leader>hb でトグル
  current_line_blame_opts = {
    delay = 500,
    virt_text_pos = "eol",
  },

  -- キーマッピング
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- 変更箇所間の移動
    map("n", "]c", function()
      if vim.wo.diff then return "]c" end
      vim.schedule(function() gs.next_hunk() end)
      return "<Ignore>"
    end, { expr = true, desc = "Next Hunk" })

    map("n", "[c", function()
      if vim.wo.diff then return "[c" end
      vim.schedule(function() gs.prev_hunk() end)
      return "<Ignore>"
    end, { expr = true, desc = "Prev Hunk" })

    -- アクション
    map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview Hunk" })
    map("n", "<leader>hb", gs.toggle_current_line_blame, { desc = "Toggle Blame" })
    map("n", "<leader>hd", gs.diffthis, { desc = "Diff This" })
    map("n", "<leader>hD", function() gs.diffthis("~") end, { desc = "Diff HEAD~" })

    -- ステージング（Git操作）
    map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage Hunk" })
    map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset Hunk" })
    map("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Stage Hunk" })
    map("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Reset Hunk" })
    map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage Buffer" })
    map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo Stage Hunk" })
    map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset Buffer" })
  end,
})
