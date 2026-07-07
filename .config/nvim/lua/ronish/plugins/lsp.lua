return {
    {
        "neovim/nvim-lspconfig",

        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "williamboman/mason-lspconfig.nvim",
        },

        config = function()
            -- =========================
            -- CAPABILITIES (nvim-cmp bridge)
            -- =========================
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- =========================
            -- GLOBAL DEFAULT CONFIG
            -- =========================
            vim.lsp.config("*", {
                capabilities = capabilities,
            })

            -- =========================
            -- SERVERS (NO lspconfig)
            -- =========================
            vim.lsp.config("ts_ls", {})
            vim.lsp.config("html", {})
            vim.lsp.config("cssls", {})
            vim.lsp.config("lua_ls", {})
            vim.lsp.config("clangd", {})

            -- =========================
            -- ENABLE SERVERS
            -- =========================
            vim.lsp.enable({
                "ts_ls",
                "html",
                "cssls",
                "lua_ls",
                "clangd"
            })
        end,
    },
}

