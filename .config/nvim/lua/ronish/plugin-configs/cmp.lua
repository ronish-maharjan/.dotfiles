local cmp = require("cmp")
local luasnip = require("luasnip")

-- Optional: Load snippets from friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  preselect = cmp.PreselectMode.Item,        -- preselect first item

  window = {
    documentation = cmp.config.disable,      -- disable the extra documentation window
  },

  completion = {
    completeopt = "menu,menuone,noinsert",    -- VS Code‑style behavior
  },

  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),               -- manual trigger
    ["<CR>"]     = cmp.mapping.confirm({ select = true }), -- confirm with Enter
    ["<Tab>"]    = cmp.mapping.select_next_item(),         -- Tab navigate
    ["<S-Tab>"]  = cmp.mapping.select_prev_item(),         -- Shift‑Tab reverse
  }),

  sources = {
    { name = "nvim_lsp" },   -- types from language server
    { name = "luasnip" },    -- snippet completions
  },
})
