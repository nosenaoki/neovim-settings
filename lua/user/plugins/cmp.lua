-- =============================================================================
-- nvim-cmp 設定（自動補完）
-- =============================================================================

local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  -- スニペット設定（必須）
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  -- キーマッピング
  mapping = cmp.mapping.preset.insert({
    -- 補完候補をスクロール
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),

    -- 補完メニューを手動で開く
    ["<C-Space>"] = cmp.mapping.complete(),

    -- 補完をキャンセル
    ["<C-e>"] = cmp.mapping.abort(),

    -- 選択した候補を確定（Enter）
    ["<CR>"] = cmp.mapping.confirm({ select = false }),

    -- Tab で次の候補 / Shift+Tab で前の候補
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),

  -- 補完ソース（優先順位順）
  sources = cmp.config.sources({
    { name = "nvim_lsp" },  -- LSP
    { name = "luasnip" },   -- スニペット
    { name = "path" },      -- ファイルパス
  }, {
    { name = "buffer" },    -- バッファ内の単語（LSPがない時のフォールバック）
  }),

  -- 見た目
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },

  -- フォーマット（アイコン表示）
  formatting = {
    format = function(entry, vim_item)
      -- 補完ソースの表示名
      local source_names = {
        nvim_lsp = "[LSP]",
        luasnip = "[Snip]",
        buffer = "[Buf]",
        path = "[Path]",
      }
      vim_item.menu = source_names[entry.source.name] or ""

      -- 種類ごとのアイコン
      local kind_icons = {
        Text = "󰉿",
        Method = "󰆧",
        Function = "󰊕",
        Constructor = "",
        Field = "󰜢",
        Variable = "󰀫",
        Class = "󰠱",
        Interface = "",
        Module = "",
        Property = "󰜢",
        Unit = "󰑭",
        Value = "󰎠",
        Enum = "",
        Keyword = "󰌋",
        Snippet = "",
        Color = "󰏘",
        File = "󰈙",
        Reference = "󰈇",
        Folder = "󰉋",
        EnumMember = "",
        Constant = "󰏿",
        Struct = "󰙅",
        Event = "",
        Operator = "󰆕",
        TypeParameter = "",
      }
      vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind] or "", vim_item.kind)

      return vim_item
    end,
  },
})

-- -----------------------------------------------------------------------------
-- コマンドライン補完
-- -----------------------------------------------------------------------------

-- `/` 検索時にバッファ内の単語を補完
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

-- `:` コマンド入力時の補完
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})
