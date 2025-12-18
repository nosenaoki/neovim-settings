-- =============================================================================
-- 基本設定 (options.lua)
-- =============================================================================

local opt = vim.opt

-- 行番号
opt.number = true
opt.relativenumber = true  -- 相対行番号（ジャンプ時に便利）

-- インデント
opt.tabstop = 4            -- タブ幅
opt.shiftwidth = 4         -- 自動インデント幅
opt.expandtab = true       -- タブをスペースに変換
opt.smartindent = true     -- スマートインデント

-- 検索
opt.ignorecase = true      -- 大文字小文字を区別しない
opt.smartcase = true       -- 大文字が含まれる場合は区別する
opt.hlsearch = true        -- 検索結果をハイライト
opt.incsearch = true       -- インクリメンタル検索

-- 表示
opt.termguicolors = true   -- 24bit カラー
opt.signcolumn = "yes"     -- サイン列を常に表示（LSP/Git用）
opt.cursorline = true      -- カーソル行をハイライト
opt.wrap = false           -- 折り返し無効
opt.scrolloff = 8          -- スクロール時の余白

-- ファイル
opt.backup = false         -- バックアップファイルを作らない
opt.swapfile = false       -- スワップファイルを作らない
opt.undofile = true        -- Undo履歴を永続化
opt.autoread = true        -- 外部変更を自動読込

-- クリップボード（システムと共有）
opt.clipboard = "unnamedplus"

-- 分割ウィンドウ
opt.splitbelow = true      -- 水平分割は下に
opt.splitright = true      -- 垂直分割は右に

-- その他
opt.updatetime = 250       -- CursorHold イベントの待ち時間短縮
opt.timeoutlen = 300       -- キーマッピングのタイムアウト
opt.completeopt = "menuone,noselect"  -- 補完メニュー設定

-- エンコーディング
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
