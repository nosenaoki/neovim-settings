# Neovim 設定

Lua ベースの Neovim 設定ファイル。

## 必要なツール

### 必須

| ツール | 用途 | インストール |
|--------|------|--------------|
| Neovim 0.10+ | エディタ本体 | `winget install Neovim.Neovim` |
| Git | プラグイン管理 | `winget install Git.Git` |
| Zig | Treesitter パーサーのコンパイル | `winget install zig.zig` |
| ripgrep | Telescope の全文検索 | `winget install BurntSushi.ripgrep` |
| Nerd Font | アイコン表示 | https://www.nerdfonts.com/ |

### LSP サーバー

| 言語 | LSP | インストール |
|------|-----|--------------|
| C# | csharp-ls | `dotnet tool install -g csharp-ls` |
| TypeScript/React | typescript-language-server | `npm install -g typescript-language-server typescript` |
| Go | gopls | `go install golang.org/x/tools/gopls@latest` |

## セットアップ

```powershell
# 1. リポジトリをクローン
git clone <your-repo> "$env:LOCALAPPDATA\nvim"

# 2. LSP サーバーをインストール
dotnet tool install -g csharp-ls
npm install -g typescript-language-server typescript
go install golang.org/x/tools/gopls@latest

# 3. Neovim を起動（プラグインが自動インストールされる）
nvim
```

## ディレクトリ構成

```
nvim/
├── init.lua              # エントリーポイント
└── lua/user/
    ├── options.lua       # 基本設定
    ├── keymaps.lua       # キーマッピング
    ├── plugins.lua       # lazy.nvim プラグイン管理
    └── plugins/
        ├── colorscheme.lua   # カラースキーム
        ├── cmp.lua           # 自動補完
        ├── gitsigns.lua      # Git 差分表示
        ├── lsp.lua           # LSP 設定
        ├── lualine.lua       # ステータスライン
        ├── telescope.lua     # ファジーファインダー
        ├── treesitter.lua    # 構文ハイライト
        └── which-key.lua     # キーバインドヘルプ
```

## 主なキーマッピング

Leader キーは `Space`

### 基本操作

| キー | 動作 |
|------|------|
| `jk` | Normal モードに戻る |
| `Space w` | 保存 |
| `Space h` | 検索ハイライトを消す |
| `Shift+H/L` | 前/次のバッファ |
| `Ctrl+h/j/k/l` | ウィンドウ移動 |

### Telescope（検索）

| キー | 動作 |
|------|------|
| `Space ff` | ファイル検索 |
| `Space fg` | 全文検索（grep） |
| `Space fb` | バッファ一覧 |
| `Space fr` | 最近開いたファイル |
| `Space /` | 現在のバッファ内検索 |

### LSP

| キー | 動作 |
|------|------|
| `gd` | 定義へジャンプ |
| `gr` | 参照一覧 |
| `gi` | 実装へジャンプ |
| `K` | ホバー情報 |
| `Space rn` | リネーム |
| `Space ca` | コードアクション |
| `Space f` | フォーマット |

### Git (Gitsigns)

| キー | 動作 |
|------|------|
| `]c` / `[c` | 次/前の変更箇所 |
| `Space hp` | 変更プレビュー |
| `Space hb` | Blame 表示切替 |
| `Space hs` | ハンクをステージ |
| `Space hr` | ハンクをリセット |

### Diagnostics

| キー | 動作 |
|------|------|
| `]d` / `[d` | 次/前のエラー |
| `Space e` | エラー詳細表示 |
| `Space dw` | ワークスペース全体のエラー一覧 |

## プラグイン管理

```vim
:Lazy          " プラグイン管理画面を開く
:Lazy sync     " インストール・更新・クリーンアップを一括実行
:Lazy update   " プラグインを更新
```

## カラースキーム変更

`lua/user/plugins/colorscheme.lua` を編集：

```lua
-- 使いたいテーマのコメントを外す
vim.cmd.colorscheme("gruvbox-material")
-- vim.cmd.colorscheme("kanagawa")
-- vim.cmd.colorscheme("tokyonight")
```

`lua/user/plugins/lualine.lua` のテーマも合わせて変更：

```lua
theme = "gruvbox-material",
-- theme = "kanagawa",
-- theme = "tokyonight",
```
