-- bootstrap lazy.nvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "--branch=stable", lazyrepo, lazypath,
  })
end

-- add lazy.nvim to runtime path
vim.opt.rtp:prepend(lazypath)

-- plugin specs
require("lazy").setup({

  ------------------------------------------------
  -- UI / Appearance
  ------------------------------------------------

  -- Rose‑Pine color scheme
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("ronish.plugin-configs.colors")
    end,
  },

  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    name = "nvim-tree",
    config = function()
      require("ronish.plugin-configs.nvim_tree")
    end,
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("ronish.plugin-configs.lualine")
    end,
  },

  -- Harpoon (quick file navigation)
  {
    "theprimeagen/harpoon",
    config = function()
      require("ronish.plugin-configs.harpoon")
    end,
  },

  -- Telescope (fuzzy finder)
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      require("ronish.plugin-configs.telescope")
    end,
  },

  ------------------------------------------------
  -- LSP (Language Server Protocol)
  ------------------------------------------------

  -- Mason: Installer for LSP servers, linters, formatters
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- Bridge Mason + lspconfig for automatic LSP install
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "tsserver",  -- JavaScript/TypeScript
          "html",      -- HTML
          "cssls",     -- CSS
        },
      })
    end,
  },

  -- Core LSP config
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("ronish.plugin-configs.lsp")
    end,
  },

  ------------------------------------------------
  -- Autocomplete (nvim-cmp)
  ------------------------------------------------

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",   -- LSP source
      "hrsh7th/cmp-buffer",     -- buffer completions
      "hrsh7th/cmp-path",       -- path completions
      "L3MON4D3/LuaSnip",       -- snippet engine
      "saadparwaiz1/cmp_luasnip", -- LuaSnip completions
      "rafamadriz/friendly-snippets", -- snippets collection
    },
    config = function()
      require("ronish.plugin-configs.cmp")
    end,
  },

  ------------------------------------------------
  -- OPTIONAL: Additional plugins
  ------------------------------------------------

  -- Treesitter (syntax / textobjects)
  -- {
   -- "nvim-treesitter/nvim-treesitter",
    --config = function()
     -- require("ronish.plugin-configs.treesitter")
  -- end,
 -- },

})
