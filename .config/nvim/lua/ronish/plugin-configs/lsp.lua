-- ============================================
-- FILE: lua/ronish/plugin-configs/lsp.lua
-- PURPOSE: Minimal LSP setup — errors, go-to-definition, rename. That's it.
-- HOW TO EDIT: Add servers to vim.lsp.config() and vim.lsp.enable()
--
-- WHAT IS LSP?
--   A background program that understands your code and gives you:
--   • Error/warning detection
--   • Go-to-definition
--   • Rename across files
--   • Hover docs
--   That's all you need. No fancy UI. Just the tools.
--
-- KEYBINDINGS (only work when a server is attached):
--   gd          → Go to definition
--   gr          → Show references
--   K           → Hover docs
--   <leader>rn  → Rename symbol
--   <leader>ca  → Code actions
--   <leader>d   → Show error details
--   [d / ]d     → Jump between errors
-- ============================================


-- ========================
-- CAPABILITIES (shared by all servers)
-- ========================

-- Tell all servers that we support autocompletion features from nvim-cmp
-- "*" means this applies to every server — set once, done forever
vim.lsp.config("*", {
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
})


-- ========================
-- SERVER CONFIGS
-- ========================

-- Each server gets a vim.lsp.config() call
-- Most servers need zero custom settings — just an empty table
-- Only add settings if a server specifically needs them

vim.lsp.config("ts_ls", {})    -- TypeScript / JavaScript
vim.lsp.config("html", {})     -- HTML
vim.lsp.config("cssls", {})    -- CSS

-- Add more servers:
-- vim.lsp.config("pyright", {})       -- Python
-- vim.lsp.config("clangd", {})        -- C / C++
-- vim.lsp.config("gopls", {})         -- Go
-- vim.lsp.config("lua_ls", {          -- Lua
--     settings = {
--         Lua = {
--             diagnostics = { globals = { "vim" } },
--         },
--     },
-- })


-- ========================
-- ENABLE SERVERS
-- ========================

-- Actually start the servers — without this line nothing runs
vim.lsp.enable({
    "ts_ls",
    "html",
    "cssls",
    -- "pyright",
    -- "lua_ls",
})


-- ========================
-- KEYBINDINGS (via LspAttach event)
-- ========================

-- These keybinds ONLY activate when a language server connects to your file
-- No server attached = these keys do nothing = no errors on random files
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        -- Shortcut to set buffer-local keymaps
        local opts = { buffer = args.buf }

        -- Navigation
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)       -- Jump to where it's defined
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)       -- Show everywhere it's used
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)   -- Jump to implementation
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)             -- Show docs popup

        -- Actions
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)      -- Rename everywhere
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts) -- Quick fixes

        -- Diagnostics
        vim.keymap.set("n", "<C-k>", vim.diagnostic.open_float, opts) -- Full error message
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)         -- Previous error
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)         -- Next error
    end,
})


-- ========================
-- DIAGNOSTICS CONFIG
-- ========================

-- Minimal diagnostic display — just the essentials
vim.diagnostic.config({

    -- Show short error text at the end of the line
    virtual_text = true,

    -- Show error signs in the left column
    -- NEW way to set signs (replaces deprecated vim.fn.sign_define)
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "E",   -- Simple "E" for errors
            [vim.diagnostic.severity.WARN]  = "W",   -- Simple "W" for warnings
            [vim.diagnostic.severity.HINT]  = "H",   -- Simple "H" for hints
            [vim.diagnostic.severity.INFO]  = "I",   -- Simple "I" for info
        },
    },

    -- Underline problematic code
    underline = true,

    -- Don't update errors while typing — only when you leave insert mode
    update_in_insert = false,

    -- Show errors before warnings before hints
    severity_sort = true,
})
