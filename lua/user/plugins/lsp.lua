-- =============================================================================
-- LSP 設定
-- =============================================================================

local api = vim.api
local lsp_group = api.nvim_create_augroup("UserLspConfig", { clear = true })

-- nvim-cmp の LSP 補完機能を取得（プラグインが読み込まれていない場合は空テーブル）
local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_nvim_lsp_ok then
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

-- -----------------------------------------------------------------------------
-- Diagnostics（診断）の表示設定
-- -----------------------------------------------------------------------------

vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
    source = "if_many",
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = "󰌵 ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
  },
})

-- -----------------------------------------------------------------------------
-- 共通の on_attach 関数（LSPアタッチ時のキーマッピング）
-- -----------------------------------------------------------------------------

local function on_attach(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  local keymap = vim.keymap.set
  local telescope = require("telescope.builtin")

  -- 定義・参照
  keymap("n", "gd", vim.lsp.buf.definition, opts)
  keymap("n", "gD", vim.lsp.buf.declaration, opts)
  keymap("n", "gi", vim.lsp.buf.implementation, opts)
  keymap("n", "gr", telescope.lsp_references, opts)
  keymap("n", "gt", vim.lsp.buf.type_definition, opts)

  -- 情報表示
  keymap("n", "K", vim.lsp.buf.hover, opts)
  keymap("n", "<C-k>", vim.lsp.buf.signature_help, opts)

  -- アクション
  keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
  keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  keymap("n", "<leader>f", function()
    vim.lsp.buf.format({ async = true })
  end, opts)
end

-- -----------------------------------------------------------------------------
-- C# (csharp-ls) LSP 設定
-- -----------------------------------------------------------------------------

api.nvim_create_autocmd("FileType", {
  pattern = "cs",
  group = lsp_group,
  callback = function(ev)
    local file_dir = vim.fs.dirname(ev.file)

    -- .sln ファイルを探す（優先）
    local sln_file = vim.fs.find(
      function(name, _)
        return name:match("%.sln$")
      end,
      { upward = true, path = file_dir }
    )[1]

    -- .csproj ファイルを探す（フォールバック）
    local csproj_file = vim.fs.find(
      function(name, _)
        return name:match("%.csproj$")
      end,
      { upward = true, path = file_dir }
    )[1]

    -- ルートディレクトリを決定
    local root_dir = nil
    if sln_file then
      root_dir = vim.loop.fs_realpath(vim.fs.dirname(sln_file))
    elseif csproj_file then
      root_dir = vim.loop.fs_realpath(vim.fs.dirname(csproj_file))
    else
      root_dir = vim.loop.fs_realpath(file_dir)
    end

    -- コマンドライン引数を構築
    local cmd = { "csharp-ls" }
    if sln_file then
      -- .sln が見つかった場合は -s オプションで指定
      local sln_path = vim.loop.fs_realpath(sln_file)
      table.insert(cmd, "-s")
      table.insert(cmd, sln_path)
    end

    -- LSP 起動
    vim.lsp.start({
      name = "csharp_ls",
      cmd = cmd,
      root_dir = root_dir,
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end,
})

-- -----------------------------------------------------------------------------
-- TypeScript / React (typescript-language-server) LSP 設定
-- -----------------------------------------------------------------------------

api.nvim_create_autocmd("FileType", {
  pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  group = lsp_group,
  callback = function(ev)
    local file_dir = vim.fs.dirname(ev.file)

    -- package.json または tsconfig.json を探してルートを決定
    local root_markers = vim.fs.find(
      { "package.json", "tsconfig.json", "jsconfig.json" },
      { upward = true, path = file_dir }
    )[1]

    local root_dir = nil
    if root_markers then
      root_dir = vim.loop.fs_realpath(vim.fs.dirname(root_markers))
    else
      root_dir = vim.loop.fs_realpath(file_dir)
    end

    -- LSP 起動
    vim.lsp.start({
      name = "typescript-language-server",
      cmd = { "typescript-language-server", "--stdio" },
      root_dir = root_dir,
      on_attach = on_attach,
      capabilities = capabilities,
      init_options = {
        preferences = {
          -- import 時のパス形式
          importModuleSpecifierPreference = "relative",
        },
      },
      settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
          },
        },
        javascript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
          },
        },
      },
    })
  end,
})
