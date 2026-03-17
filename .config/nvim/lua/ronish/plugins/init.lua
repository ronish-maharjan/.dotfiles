-- ============================================
-- FILE: lua/ronish/plugins/init.lua
-- PURPOSE: Bootstrap lazy.nvim plugin manager and define all plugins
-- HOW TO EDIT: Add new plugins by copying the `{ "author/plugin-name" }` pattern.
--              Remove a plugin by deleting its `{ }` block.
--
-- WHAT IS LAZY.NVIM?
--   lazy.nvim is a plugin manager for Neovim. It:
--   • Downloads plugins from GitHub automatically
--   • Keeps plugins updated
--   • Loads plugins efficiently (lazy-loading)
--   • Shows a nice UI when you run `:Lazy`
--
-- HOW THIS FILE WORKS:
--   1. First, we check if lazy.nvim is installed on your system
--   2. If it's NOT installed, we automatically download (clone) it from GitHub
--   3. We add lazy.nvim to Neovim's runtime path so it can be loaded
--   4. We call `require("lazy").setup({...})` with a list of all our plugins
--
-- PLUGIN SPEC FORMAT:
--   Each plugin is a Lua table `{ }` with these common fields:
--   • "author/repo"    → GitHub repository to install from (REQUIRED)
--   • name             → Custom name for the plugin (optional, for clarity)
--   • dependencies     → Other plugins this one needs to work (installed automatically)
--   • config           → Function that runs AFTER the plugin loads (used to configure it)
--   • event            → Load the plugin only when this event happens (for performance)
--   • ft               → Load the plugin only for specific file types
-- ============================================


-- ========================
-- STEP 1: DEFINE THE INSTALL PATH
-- ========================

-- This is where lazy.nvim will be stored on your computer
-- `vim.fn.stdpath("data")` returns "~/.local/share/nvim" on Linux/Mac
-- So lazypath = "~/.local/share/nvim/lazy/lazy.nvim"
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"


-- ========================
-- STEP 2: AUTO-INSTALL LAZY.NVIM IF MISSING
-- ========================

-- Check if the lazy.nvim folder exists on disk
-- `vim.loop.fs_stat` returns file info if it exists, or nil if it doesn't
if not vim.loop.fs_stat(lazypath) then

    -- The GitHub URL where lazy.nvim's source code lives
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"

    -- Use `git clone` to download lazy.nvim from GitHub
    -- This only runs ONCE — the very first time you open Neovim with this config
    vim.fn.system({
        "git",                      -- Use the git command
        "clone",                    -- Clone (download) a repository
        "--filter=blob:none",       -- Don't download file history (faster download)
        "--branch=stable",          -- Use the stable release branch (not bleeding edge)
        lazyrepo,                   -- The URL to clone from
        lazypath,                   -- Where to save it on your computer
    })
end


-- ========================
-- STEP 3: ADD LAZY.NVIM TO NEOVIM'S RUNTIME PATH
-- ========================

-- Prepend (add to the front of) Neovim's runtime path
-- This tells Neovim: "Hey, look in this folder for Lua modules too"
-- Without this line, `require("lazy")` below would fail because Neovim can't find it
vim.opt.rtp:prepend(lazypath)


-- ========================
-- STEP 4: LOAD LAZY.NVIM AND DEFINE ALL PLUGINS
-- ========================

-- Call lazy.nvim's setup function with a table of all the plugins we want
-- Each `{ }` block is one plugin specification
require("lazy").setup({

    -- ========================
    -- COLORSCHEME: Rose Pine
    -- ========================
    -- A beautiful, muted colorscheme with soft colors
    -- Website: https://rosepinetheme.com
    {
        "rose-pine/neovim",                                  -- GitHub repo: rose-pine/neovim
        name = "rose-pine",                                  -- Give it a friendly name (used internally by lazy)
        config = function()                                  -- Run this function after the plugin loads
            require("ronish.plugin-configs.colors")          -- Load our colorscheme config file
        end,
    },

    -- ========================
    -- QUICK NAVIGATION: Harpoon
    -- ========================
    -- Lets you "bookmark" files and jump between them instantly
    -- Much faster than using a file explorer for your most-used files
    -- Keybindings: <leader>a to add, Ctrl+E to view, <leader>1-5 to jump
    {
        "theprimeagen/harpoon",                              -- GitHub repo for harpoon (by ThePrimeagen)
        dependencies = {
            "nvim-lua/plenary.nvim",                         -- Required utility library (many plugins depend on this)
        },
        config = function()                                  -- Run after plugin loads
            require("ronish.plugin-configs.harpoon")         -- Load our harpoon config file
        end,
    },

    -- ========================
    -- FUZZY FINDER: Telescope
    -- ========================
    -- A powerful fuzzy finder to search for files, text, git commits, and more
    -- Think of it like the search bar in VS Code but way more powerful
    -- Keybindings: Ctrl+P for files, <leader>fg for text search
    {
        "nvim-telescope/telescope.nvim",                     -- GitHub repo for telescope
        tag = "0.1.8",                                       -- Use a specific stable version
        dependencies = {
            "nvim-lua/plenary.nvim",                         -- Required utility library
        },
        config = function()                                  -- Run after plugin loads
            require("ronish.plugin-configs.telescope")       -- Load our telescope config file
        end,
    },

    -- ========================
    -- FILE EXPLORER: Oil.nvim
    -- ========================
    -- Opens directory as an editable buffer
    -- Rename/delete/move files just by editing text and saving
    {
        "stevearc/oil.nvim",
        config = function()
            require("oil").setup({
                default_file_explorer = true,
                columns = {},
                skip_confirm_for_simple_edits = true,
                view_options = {
                    show_hidden = true,
                },
                keymaps = {
                    ["q"] = "actions.close",
                    ["<C-s>"] = false,
                    ["<C-h>"] = false,
                },
            })
        end,
    },

    -- ========================
    -- UNDO HISTORY: Undotree
    -- ========================
    -- Visualizes your undo history as a tree graph
    -- You can go back to ANY previous state, even after saving
    -- Keybinding: <leader>u to toggle (defined in keymaps.lua)
    {
        "mbbill/undotree",                                   -- GitHub repo for undotree
    },

    -- ========================
    -- LSP: Language Server Protocol
    -- ========================
    -- These three plugins work together to give you IDE-like features:
    --   1. mason.nvim        → Downloads and manages language servers (like an app store)
    --   2. mason-lspconfig   → Bridges mason with Neovim's LSP (connects them together)
    --   3. nvim-lspconfig    → Provides server definitions (cmd, filetypes, root patterns)
    --
    -- NOTE FOR NEOVIM 0.11+:
    --   Neovim 0.11 introduced built-in functions for LSP configuration:
    --     • vim.lsp.config()  → Configure a language server
    --     • vim.lsp.enable()  → Start a language server
    --   We use these NEW built-in functions in our lsp.lua file.
    --   nvim-lspconfig is still installed because it provides the
    --   base server definitions (what command to run, which file types, etc.)

    -- Mason: Installs and manages language servers, linters, and formatters
    -- Run `:Mason` to open the installer UI
    {
        "williamboman/mason.nvim",                           -- GitHub repo for mason
        config = function()                                  -- Run after plugin loads
            require("mason").setup()                         -- Initialize mason with default settings
        end,
    },

    -- Mason-LSPConfig: Automatically sets up servers installed by Mason
    -- `ensure_installed` lists servers to install automatically on first launch
    {
        "williamboman/mason-lspconfig.nvim",                 -- GitHub repo for mason-lspconfig
        dependencies = {
            "williamboman/mason.nvim",                       -- Must load mason first
        },
        config = function()                                  -- Run after plugin loads
            require("mason-lspconfig").setup({
                ensure_installed = {                         -- These servers will be auto-installed:
                    "ts_ls",                                 -- TypeScript/JavaScript language server
                    "html",                                  -- HTML language server
                    "cssls",                                 -- CSS language server
                    -- Add more servers here! Run `:Mason` to see all available servers
                    -- Examples: "pyright" (Python), "lua_ls" (Lua), "clangd" (C/C++)
                },
            })
        end,
    },

    -- LSPConfig: Provides base server definitions for Neovim's built-in LSP client
    -- It tells Neovim what command to run for each server, which file types it handles,
    -- and how to find the project root directory
    -- Our actual LSP configuration lives in lsp.lua using vim.lsp.config() (Neovim 0.11+)
    {
        "neovim/nvim-lspconfig",                             -- GitHub repo for lspconfig
        dependencies = {
            "williamboman/mason-lspconfig.nvim",             -- Must load mason-lspconfig first
        },
        config = function()                                  -- Run after plugin loads
            require("ronish.plugin-configs.lsp")             -- Load our LSP config file
        end,
    },

    -- ========================
    -- AUTOCOMPLETION: nvim-cmp
    -- ========================
    -- Provides smart autocompletion as you type (like IntelliSense in VS Code)
    -- Shows a popup menu with suggestions from multiple sources:
    --   • LSP (language-aware suggestions)
    --   • Buffer (words from the current file)
    --   • Path (file/folder paths)
    --   • Snippets (code templates)
    {
        "hrsh7th/nvim-cmp",                                  -- The core autocompletion engine
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",                          -- Source: suggestions from LSP servers
            "hrsh7th/cmp-buffer",                            -- Source: words from the current file
            "hrsh7th/cmp-path",                              -- Source: file system paths
            "L3MON4D3/LuaSnip",                              -- Snippet engine (required for snippet support)
            "saadparwaiz1/cmp_luasnip",                      -- Source: connects LuaSnip to nvim-cmp
            "rafamadriz/friendly-snippets",                  -- Collection of premade snippets for many languages
        },
        config = function()                                  -- Run after plugin loads
            require("ronish.plugin-configs.cmp")             -- Load our completion config file
        end,
    },

})
