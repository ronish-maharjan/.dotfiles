-- ============================================
-- FILE: init.lua
-- PURPOSE: Entry point for the entire Neovim configuration
-- HOW TO EDIT: You generally don't need to touch this file.
--              It just loads the other config modules in order.
-- ============================================

-- WHY LOAD ORDER MATTERS:
-- 1. Settings must load FIRST so things like leader key, tab size,
--    and UI options are ready before anything else runs.
-- 2. Keymaps load SECOND so your custom shortcuts are defined
--    before plugins try to set up their own mappings.
-- 3. Plugins load LAST because they depend on settings (like leader key)
--    and may interact with keymaps we already defined.
--
-- If you load plugins BEFORE setting the leader key, any plugin keybind
-- that uses <leader> will break or use the wrong key.

-- STEP 1: Load general Neovim settings (line numbers, tabs, search, UI, etc.)
require("ronish.core.settings")

-- STEP 2: Load all custom keybindings (shortcuts for navigation, plugins, etc.)
require("ronish.core.keymaps")

-- STEP 3: Load the plugin manager (lazy.nvim) and all plugin specifications
-- This will automatically install missing plugins on first launch
require("ronish.plugins")
