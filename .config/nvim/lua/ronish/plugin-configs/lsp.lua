-- ─────────────────────────────────────────────
-- LSP (Language Server Protocol) configuration
-- Uses native Neovim 0.11+ API: vim.lsp.config & vim.lsp.enable
-- Ensures LSPs are installed via Mason and enabled automatically
-- ─────────────────────────────────────────────

-- 🧰 Setup Mason (LSP server installer)
require("mason").setup()

-- 🪝 Setup Mason LSPConfig bridge
require("mason-lspconfig").setup({
  ensure_installed = {
    "ts_ls",   -- JavaScript/TypeScript
    "html",    -- HTML
    "cssls",   -- CSS
  },
})

-- 🔧 Get default capabilities from nvim‑cmp for LSP completion
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- 📍 Define base LSP config
-- You can override individual servers here if needed
-- e.g., add settings or on_attach callbacks
vim.lsp.config("ts_ls", {
  capabilities = capabilities,
  -- Add additional per‑server config here if desired
})

vim.lsp.config("html", {
  capabilities = capabilities,
})

vim.lsp.config("cssls", {
  capabilities = capabilities,
})

-- 🚀 Enable the listed LSP servers
-- This tells Neovim to auto‑start these servers when appropriate filetypes open
vim.lsp.enable({ "ts_ls", "html", "cssls" })
