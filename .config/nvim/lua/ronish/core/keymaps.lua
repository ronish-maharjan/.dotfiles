-- ============================================
-- FILE: lua/ronish/core/keymaps.lua
-- PURPOSE: All custom keybindings in one place
-- HOW TO EDIT: Change the key string (e.g., "<C-n>") or
--              the command string to customize any shortcut.
--
-- TERMINOLOGY FOR BEGINNERS:
--
--   vim.keymap.set(mode, key, action, opts)
--   │              │     │    │       │
--   │              │     │    │       └── Options table (see below)
--   │              │     │    └── What happens when you press the key
--   │              │     └── The key combination you press
--   │              └── Which mode: "n"=normal, "i"=insert, "v"=visual
--   └── Modern Lua function to create keybindings
--
--   OPTIONS EXPLAINED:
--   • noremap = true → Use the key literally, don't follow other remaps
--                       (prevents infinite loops if key A maps to B maps to A)
--   • silent = true  → Don't show the command in the bottom command bar
--                       (keeps the UI clean when pressing shortcuts)
--   • desc = "..."   → A human-readable description shown in which-key or Telescope
--
--   WHY `vim.keymap.set` INSTEAD OF `vim.api.nvim_set_keymap`:
--   • `vim.keymap.set` is the modern, recommended way (added in Neovim 0.7+)
--   • It accepts Lua functions directly as actions (not just strings)
--   • It sets `noremap = true` by default (safer)
--   • It's shorter and cleaner to write
--   • `vim.api.nvim_set_keymap` is the older API — it still works but is more verbose
-- ============================================


-- ========================
-- LEADER KEY
-- ========================

-- The leader key is a prefix key used to create custom shortcuts
-- Setting it to Space means you press Space + another key for custom commands
-- Example: <leader>a means press Space, then press a
-- IMPORTANT: This MUST be set before any keybinding that uses <leader>

vim.g.mapleader = " "


-- ========================
-- GENERAL MAPPINGS
-- ========================

-- Make Ctrl+C behave exactly like Escape in insert mode
-- Why: Some plugins only respond to real <Esc> presses, not Ctrl+C
-- This ensures consistent behavior when exiting insert mode
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Exit insert mode with Ctrl+C" })


-- ========================
-- NAVIGATION
-- ========================

-- Scroll half a page DOWN and center the cursor on screen
-- Why: Without `zz`, scrolling can leave your cursor at the screen edge
-- This keeps the cursor in the middle so you always have context above and below
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center cursor" })

-- Scroll half a page UP and center the cursor on screen
-- Same reason as above — keeps the cursor centered for comfortable reading
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center cursor" })

-- Jump to NEXT search match and center the screen + open folds
-- `zz` centers the screen, `zv` opens any fold the match might be hidden inside
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })

-- Jump to PREVIOUS search match and center the screen + open folds
-- Same as above but in the reverse direction
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })


-- ========================
-- LINE MOVEMENT (Visual Mode)
-- ========================

-- Move selected lines DOWN by one line in visual mode
-- How to use: Select lines with V, then press J to move them down
-- `:m '>+1<CR>` moves the selection below the next line
-- `gv=gv` re-selects the moved lines and re-indents them
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })

-- Move selected lines UP by one line in visual mode
-- How to use: Select lines with V, then press K to move them up
-- `:m '<-2<CR>` moves the selection above the previous line
-- `gv=gv` re-selects the moved lines and re-indents them
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })


-- ========================
-- PLUGIN: NvimTree (File Explorer)
-- ========================

-- Toggle the file explorer sidebar on/off with Ctrl+N
-- NvimTree shows your project's file structure like a sidebar in VS Code
vim.keymap.set("n", "<C-n>", "<cmd>Oil<CR>", { desc = "Open oil" })

-- ========================
-- PLUGIN: Telescope (Fuzzy Finder)
-- ========================

-- Open the file finder with Ctrl+P
-- This lets you search for files by name in your project (like Ctrl+P in VS Code)
vim.keymap.set("n", "<C-p>", function()
    require("telescope.builtin").find_files()  -- Call Telescope's file finder function
end, { desc = "Find files" })

-- Search inside all files with Leader+fg (live grep)
-- This lets you search for a text string across your entire project
-- Requires `ripgrep` to be installed on your system (brew install ripgrep / apt install ripgrep)
vim.keymap.set("n", "<leader>fg", function()
    require("telescope.builtin").live_grep()  -- Call Telescope's live grep function
end, { desc = "Live grep (search in files)" })


-- ========================
-- PLUGIN: Harpoon (Quick File Navigation)
-- ========================

-- Add the current file to Harpoon's quick-access list with Leader+a
-- Think of it as "bookmarking" a file for fast switching
vim.keymap.set("n", "<leader>a", function()
    require("harpoon.mark").add_file()  -- Add current file to harpoon marks
end, { desc = "Harpoon: add file" })

-- Open the Harpoon quick menu with Ctrl+E
-- Shows a popup list of all your bookmarked files
vim.keymap.set("n", "<C-e>", function()
    require("harpoon.ui").toggle_quick_menu()  -- Toggle the harpoon file list
end, { desc = "Harpoon: toggle menu" })

-- Jump directly to harpoon file 1 through 5 using Leader+number
-- This is faster than opening the menu — instant jump to a specific file
vim.keymap.set("n", "<leader>1", function()
    require("harpoon.ui").nav_file(1)  -- Navigate to the 1st harpooned file
end, { desc = "Harpoon: go to file 1" })

vim.keymap.set("n", "<leader>2", function()
    require("harpoon.ui").nav_file(2)  -- Navigate to the 2nd harpooned file
end, { desc = "Harpoon: go to file 2" })

vim.keymap.set("n", "<leader>3", function()
    require("harpoon.ui").nav_file(3)  -- Navigate to the 3rd harpooned file
end, { desc = "Harpoon: go to file 3" })

vim.keymap.set("n", "<leader>4", function()
    require("harpoon.ui").nav_file(4)  -- Navigate to the 4th harpooned file
end, { desc = "Harpoon: go to file 4" })

vim.keymap.set("n", "<leader>5", function()
    require("harpoon.ui").nav_file(5)  -- Navigate to the 5th harpooned file
end, { desc = "Harpoon: go to file 5" })

-- Automatically clear all harpoon marks when you quit Neovim
-- Why: Keeps your harpoon list fresh for each session
-- Remove this autocommand if you want harpoon marks to persist between sessions
vim.api.nvim_create_autocmd("VimLeavePre", {     -- Listen for "Neovim is about to close" event
    callback = function()                          -- Run this function when the event fires
        require("harpoon.mark").clear_all()        -- Remove all harpoon file marks
    end,
})

-- ========================
-- WINDOW / SPLIT NAVIGATION
-- ========================

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom split" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top split" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })

-- ========================
-- LSP: Toggle virtual text (inline errors)
-- ========================
vim.keymap.set("n", "<leader>k", function()
    local current = vim.diagnostic.config().virtual_text
    vim.diagnostic.config({ virtual_text = not current })
end, { desc = "Toggle LSP virtual text" })

-- ========================
-- PLUGIN: Undotree (Undo History Visualizer)
-- ========================

-- Toggle the undo history tree with Leader+u
-- Undotree shows a visual graph of all your undo/redo states
-- You can go back to any previous version of your file, even after saving
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle undo tree" })
