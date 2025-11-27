-- =============================================================================
-- キーマッピング (keymaps.lua)
-- =============================================================================

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader キー設定（プラグインより先に設定必須）
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- -----------------------------------------------------------------------------
-- 基本操作
-- -----------------------------------------------------------------------------

-- jk で Normal モードに戻る（Escの代わり）
keymap("i", "jk", "<Esc>", opts)

-- 検索ハイライトを消す
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- バッファ操作
keymap("n", "<S-l>", "<cmd>bnext<CR>", opts)      -- 次のバッファ
keymap("n", "<S-h>", "<cmd>bprev<CR>", opts)      -- 前のバッファ
keymap("n", "<leader>bd", "<cmd>bdelete<CR>", opts) -- バッファを閉じる

-- ウィンドウ移動（Ctrl + hjkl）
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- ウィンドウサイズ調整
keymap("n", "<C-Up>", "<cmd>resize +2<CR>", opts)
keymap("n", "<C-Down>", "<cmd>resize -2<CR>", opts)
keymap("n", "<C-Left>", "<cmd>vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", "<cmd>vertical resize +2<CR>", opts)

-- 行移動（Visual モードで選択行を上下に移動）
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

-- インデント調整後も選択を維持
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- ペースト時に上書きしない（Visual モードでペースト後もレジスタを維持）
keymap("v", "p", '"_dP', opts)

-- -----------------------------------------------------------------------------
-- Diagnostics（プラグイン不要の組み込み機能）
-- -----------------------------------------------------------------------------

keymap("n", "[d", vim.diagnostic.goto_prev, opts)
keymap("n", "]d", vim.diagnostic.goto_next, opts)
keymap("n", "<leader>e", vim.diagnostic.open_float, opts)
keymap("n", "<leader>q", vim.diagnostic.setloclist, opts)

-- -----------------------------------------------------------------------------
-- 保存・終了のショートカット
-- -----------------------------------------------------------------------------

keymap("n", "<leader>w", "<cmd>w<CR>", opts)      -- 保存
keymap("n", "<leader>W", "<cmd>wa<CR>", opts)     -- 全保存
keymap("n", "<leader>x", "<cmd>x<CR>", opts)      -- 保存して閉じる
