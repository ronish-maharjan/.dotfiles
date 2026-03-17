-- ============================================
-- FILE: lua/ronish/plugin-configs/harpoon.lua
-- PURPOSE: Configure Harpoon for quick file navigation
-- HOW TO EDIT: Change the settings below to customize
--              how many files you can mark, menu size, etc.
--
-- WHAT IS HARPOON?
--   Harpoon (by ThePrimeagen) lets you "bookmark" files and jump
--   between them instantly with keyboard shortcuts.
--
--   Think of it like browser bookmarks, but for code files:
--     1. You mark your most-used files (like index.js, App.tsx, utils.lua)
--     2. You jump between them with a single keystroke
--     3. No need to search or browse the file tree every time
--
-- WHY USE HARPOON INSTEAD OF TABS OR FILE EXPLORER?
--   • Tabs get cluttered fast — you end up with 20 tabs open
--   • File explorer requires navigating through folders every time
--   • Harpoon gives you INSTANT access to 3-5 files you're actively working on
--   • It's like having speed-dial for your most important files
--
-- TYPICAL WORKFLOW:
--   1. Open a file you'll be working on frequently
--   2. Press <leader>a to add it to Harpoon (bookmark it)
--   3. Repeat for 2-4 other files you're actively editing
--   4. Now jump between them instantly:
--      • <leader>1 → jump to 1st bookmarked file
--      • <leader>2 → jump to 2nd bookmarked file
--      • <leader>3 → jump to 3rd bookmarked file
--      • etc.
--   5. Press Ctrl+E to see all bookmarked files in a popup menu
--   6. When you close Neovim, bookmarks are cleared (see keymaps.lua)
--
-- KEYBINDINGS (defined in keymaps.lua):
--   • <leader>a   → Add current file to Harpoon's bookmark list
--   • Ctrl+E      → Open/close the Harpoon quick menu (shows all bookmarks)
--   • <leader>1   → Jump to 1st bookmarked file
--   • <leader>2   → Jump to 2nd bookmarked file
--   • <leader>3   → Jump to 3rd bookmarked file
--   • <leader>4   → Jump to 4th bookmarked file
--   • <leader>5   → Jump to 5th bookmarked file
--
-- KEYBINDINGS INSIDE THE HARPOON MENU (when the popup is open):
--   • Enter       → Open the file under the cursor
--   • q or Esc    → Close the menu without selecting
--   • dd          → Remove a file from the bookmark list
--   • You can also reorder files by cutting (dd) and pasting (p)
-- ============================================


-- Call harpoon's setup function to configure it
require("harpoon").setup({

    -- ========================
    -- GLOBAL SETTINGS
    -- ========================

    global_settings = {

        -- Save harpoon marks automatically when Neovim closes
        -- When true, your bookmarks persist between sessions (survive restart)
        -- NOTE: In our keymaps.lua, we clear all marks on exit with an autocommand
        -- So even though this is true, marks get cleared because of that autocommand
        -- If you REMOVE the clear_all autocommand from keymaps.lua,
        -- then your bookmarks WILL persist between sessions
        save_on_toggle = false,

        -- Save harpoon marks whenever you switch to a different file
        -- When true, the bookmark list is saved to disk every time you change buffers
        -- This prevents losing bookmarks if Neovim crashes
        save_on_change = true,

        -- Enter terminal mode automatically when navigating to a terminal bookmark
        -- Harpoon can bookmark terminal windows too, not just files
        -- When true, jumping to a terminal bookmark puts you in insert mode immediately
        -- so you can start typing commands right away
        enter_on_sendcmd = false,

        -- Set marks (bookmarks) specific to each git branch
        -- When false, all branches share the same bookmark list
        -- When true, each branch gets its own separate bookmarks
        -- Useful for large projects where you work on different files per branch
        mark_branch = false,

        -- How many items to show in the Harpoon popup menu
        -- If you bookmark more than this number, you'll need to scroll in the menu
        -- 5 is a good default — you rarely need more than 5 "speed dial" files
        tabline = false,

        -- Characters used in the Harpoon tabline (if tabline is enabled)
        -- We keep tabline disabled so this doesn't matter, but here for reference
        tabline_prefix = "   ",
        tabline_suffix = "   ",
    },

    -- ========================
    -- MENU SETTINGS
    -- ========================

    menu = {

        -- Width of the Harpoon popup menu (in columns/characters)
        -- This controls how wide the popup window is when you press Ctrl+E
        -- Increase this if your file paths are long and get cut off
        width = vim.api.nvim_win_get_width(0) - 4,  -- Almost full window width minus 4 for padding

        -- Height of the Harpoon popup menu (in lines)
        -- This controls how tall the popup window is
        -- It expands automatically based on how many files you've bookmarked
        -- but won't exceed this height
        height = vim.api.nvim_win_get_height(0) - 4, -- Almost full window height minus 4 for padding
    },
})
