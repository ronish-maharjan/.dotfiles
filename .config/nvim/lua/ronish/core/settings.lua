-- ============================================
-- FILE: lua/ronish/core/settings.lua
-- PURPOSE: General Neovim settings and options
-- HOW TO EDIT: Change the values after `=` to customize.
--              For example, change `shiftwidth = 4` to `shiftwidth = 2`
--              if you prefer 2-space indentation.
--
-- NOTE: `vim.opt` is the Lua way to set Neovim options.
--       It replaces the old Vimscript `set` command.
--       Example: `vim.opt.number = true` is the same as `:set number`
-- ============================================


-- ========================
-- LINE NUMBERS
-- ========================

-- Show the current line number on the line your cursor is on
vim.opt.number = true

-- Show relative line numbers above and below the cursor
-- This makes it easy to jump lines using `5j` or `10k`
vim.opt.relativenumber = true


-- ========================
-- INDENTATION
-- ========================

-- Use spaces instead of tab characters when you press Tab
vim.opt.expandtab = true

-- Number of spaces used for each level of indentation (>> or <<)
vim.opt.shiftwidth = 4

-- Number of spaces that a Tab character displays as
vim.opt.tabstop = 4

-- Automatically indent new lines based on the code structure
-- For example, after an opening brace `{`, the next line indents automatically
vim.opt.smartindent = true


-- ========================
-- SEARCH
-- ========================

-- Don't keep search results highlighted after you're done searching
-- Press `/something` to search — matches highlight while typing but clear after pressing Enter
vim.opt.hlsearch = false

-- Show search matches in real-time as you type your search query
vim.opt.incsearch = true

-- Make search case-insensitive by default (e.g., "hello" matches "Hello")
vim.opt.ignorecase = true

-- If your search contains an uppercase letter, make it case-sensitive
-- This works together with `ignorecase` above
-- Example: "hello" matches "Hello", but "Hello" only matches "Hello"
vim.opt.smartcase = true

-- Briefly highlight the matching bracket/parenthesis when your cursor is on one
vim.opt.showmatch = true


-- ========================
-- FILES & BACKUP
-- ========================

-- Don't create backup files (files ending with ~)
-- Version control (git) is a better way to track changes
vim.opt.backup = false

-- Don't create a backup before overwriting a file
vim.opt.writebackup = false

-- Don't create swap files (.swp)
-- Swap files can be annoying and git handles recovery better
vim.opt.swapfile = false


-- ========================
-- UI (User Interface)
-- ========================

-- Don't wrap long lines to the next screen line
-- Instead, you scroll horizontally to see the rest of the line
vim.opt.wrap = false

-- Keep at least 8 lines visible above and below the cursor when scrolling
-- This prevents the cursor from reaching the very edge of the screen
vim.opt.scrolloff = 8

-- When splitting a window horizontally, put the new window below the current one
vim.opt.splitbelow = true

-- Enable 24-bit RGB colors in the terminal
-- Required for modern colorschemes like rose-pine to look correct
vim.opt.termguicolors = true

-- Always show the status line at the bottom (0=never, 1=only with splits, 2=always)
vim.opt.laststatus = 2

-- Show a vertical line at column 80 as a visual guide for line length
-- Helps you keep your code lines from getting too long
vim.opt.colorcolumn = "80"

-- Time in milliseconds Neovim waits before triggering certain events (like CursorHold)
-- Lower value (50ms) makes plugins feel more responsive
vim.opt.updatetime = 50


-- ========================
-- CLIPBOARD
-- ========================

-- Use the system clipboard for all yank (copy) and paste operations
-- This means you can copy text in Neovim and paste it in your browser and vice versa
vim.opt.clipboard = "unnamedplus"


-- ========================
-- MOUSE
-- ========================

-- Enable mouse support only in visual mode ("v")
-- "a" would enable it everywhere, "v" limits it to visual selections only
vim.opt.mouse = "v"


-- ========================
-- AUTOCOMMANDS
-- ========================

-- Briefly highlight text that you just yanked (copied)
-- This gives you visual feedback so you can see exactly what was copied
-- `higroup = 'IncSearch'` controls the highlight color (uses the IncSearch color)
-- `timeout = 100` means the highlight disappears after 100 milliseconds
vim.api.nvim_create_autocmd("TextYankPost", {  -- Listen for the "text was yanked" event
    callback = function()                       -- Run this function when the event fires
        vim.highlight.on_yank({                 -- Trigger the yank highlight
            higroup = "IncSearch",              -- Use the IncSearch highlight color
            timeout = 100,                      -- Highlight lasts for 100ms
        })
    end,
})
