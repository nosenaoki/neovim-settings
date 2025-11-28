-- =============================================================================
-- Markdown 設定
-- =============================================================================

-- ---------------------------------------------------------------------------
-- render-markdown.nvim 設定
-- ---------------------------------------------------------------------------
require("render-markdown").setup({
  -- 有効にするファイルタイプ
  file_types = { "markdown" },

  -- 見出しの設定
  heading = {
    enabled = true,
    sign = true,           -- サイン列にアイコン表示
    icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
  },

  -- コードブロック
  code = {
    enabled = true,
    sign = false,
    style = "full",        -- 言語名とボーダー両方表示
    width = "block",       -- コード幅に合わせる
    border = "thin",
  },

  -- 箇条書き
  bullet = {
    enabled = true,
    icons = { "●", "○", "◆", "◇" },
  },

  -- チェックボックス
  checkbox = {
    enabled = true,
    unchecked = { icon = "󰄱 " },
    checked = { icon = "󰱒 " },
  },

  -- リンク
  link = {
    enabled = true,
    image = "󰥶 ",
    hyperlink = "󰌹 ",
  },

  -- テーブル
  pipe_table = {
    enabled = true,
    style = "full",
  },
})

-- ---------------------------------------------------------------------------
-- Markdown ファイル用のローカル設定
-- ---------------------------------------------------------------------------
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    local opt = vim.opt_local

    -- 折り返し有効（Markdownは長い文章が多い）
    opt.wrap = true
    opt.linebreak = true        -- 単語単位で折り返し
    opt.breakindent = true      -- 折り返し行もインデント維持

    -- スペルチェック（英語）
    -- opt.spell = true
    -- opt.spelllang = "en,cjk"  -- CJKはスペルチェック対象外

    -- Conceal レベル（2で適度に隠す）
    opt.conceallevel = 2

    -- タブ幅（Markdownは2が一般的）
    opt.tabstop = 2
    opt.shiftwidth = 2

    -- テキスト幅（自動改行用、0で無効）
    opt.textwidth = 0
  end,
})

-- ---------------------------------------------------------------------------
-- Markdown 用キーマッピング
-- ---------------------------------------------------------------------------
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    local opts = { buffer = true, silent = true }

    -- 見出し間ジャンプ
    vim.keymap.set("n", "]]", function()
      vim.fn.search("^#", "W")
    end, vim.tbl_extend("force", opts, { desc = "Next heading" }))

    vim.keymap.set("n", "[[", function()
      vim.fn.search("^#", "bW")
    end, vim.tbl_extend("force", opts, { desc = "Previous heading" }))

    -- チェックボックスのトグル
    vim.keymap.set("n", "<leader>mt", function()
      local line = vim.api.nvim_get_current_line()
      local new_line
      if line:match("%[%s%]") then
        new_line = line:gsub("%[%s%]", "[x]", 1)
      elseif line:match("%[x%]") then
        new_line = line:gsub("%[x%]", "[ ]", 1)
      else
        return
      end
      vim.api.nvim_set_current_line(new_line)
    end, vim.tbl_extend("force", opts, { desc = "Toggle checkbox" }))

    -- 太字挿入（ビジュアルモード）
    vim.keymap.set("v", "<leader>mb", function()
      -- 選択範囲を**で囲む
      vim.cmd("normal! c**<C-r>\"**")
    end, vim.tbl_extend("force", opts, { desc = "Bold" }))

    -- リンク挿入
    vim.keymap.set("n", "<leader>ml", "i[]()<Esc>hhi", vim.tbl_extend("force", opts, { desc = "Insert link" }))

    -- コードブロック挿入
    vim.keymap.set("n", "<leader>mc", "o```<CR>```<Esc>kA", vim.tbl_extend("force", opts, { desc = "Insert code block" }))

    -- render-markdown のトグル
    vim.keymap.set("n", "<leader>mr", "<cmd>RenderMarkdown toggle<CR>", vim.tbl_extend("force", opts, { desc = "Toggle render" }))
  end,
})
