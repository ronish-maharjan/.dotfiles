-- ============================================
-- FILE: lua/ronish/plugin-configs/cmp.lua
-- PURPOSE: Minimal autocompletion — Tab to select, Enter to confirm. That's it.
-- HOW TO EDIT: Change keybindings in the mapping section.
--
-- WHAT THIS DOES:
--   Shows a popup with suggestions as you type.
--   Suggestions come from: LSP, snippets, current file words, file paths.
--   Tab cycles through them, Enter picks one. Done.
--
-- KEYBINDINGS (only when completion menu is visible):
--   Tab       → Next suggestion / next snippet placeholder
--   Shift+Tab → Previous suggestion / previous snippet placeholder
--   Enter     → Confirm selection
--   Ctrl+e    → Close menu
--   Ctrl+Space → Manually trigger menu
-- ============================================


-- Load the plugins
local cmp = require("cmp")
local luasnip = require("luasnip")

-- Load premade snippets (for loops, functions, etc. in many languages)
require("luasnip.loaders.from_vscode").lazy_load()


-- Setup
cmp.setup({

    -- Tell cmp to use LuaSnip for expanding snippets
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },

    -- Keybindings — minimal, just what you need
    mapping = cmp.mapping.preset.insert({

        -- Tab: next item or next snippet placeholder
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()                -- Menu open → go down
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()              -- In snippet → next placeholder
            else
                fallback()                            -- Otherwise → normal Tab
            end
        end, { "i", "s" }),

        -- Shift+Tab: previous item or previous snippet placeholder
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()                -- Menu open → go up
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)                      -- In snippet → previous placeholder
            else
                fallback()                            -- Otherwise → normal Shift+Tab
            end
        end, { "i", "s" }),

        -- Enter: confirm the selected item
        ["<CR>"] = cmp.mapping.confirm({ select = false }),

        -- Ctrl+Space: manually trigger completion
        ["<C-Space>"] = cmp.mapping.complete(),

        -- Ctrl+E: close the menu
        ["<C-e>"] = cmp.mapping.abort(),
    }),

    -- Where suggestions come from (order = priority)
    sources = cmp.config.sources({
        { name = "nvim_lsp" },     -- Language server suggestions (highest priority)
        { name = "luasnip" },      -- Snippet suggestions
    }, {
        { name = "buffer" },       -- Words from current file (fallback)
        { name = "path" },         -- File paths (fallback)
    }),
})
