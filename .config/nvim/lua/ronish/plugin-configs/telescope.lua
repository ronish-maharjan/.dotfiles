-- ============================================
-- FILE: lua/ronish/plugin-configs/telescope.lua
-- PURPOSE: Configure Telescope fuzzy finder
-- HOW TO EDIT: Change settings in the `defaults`, `pickers`,
--              or `extensions` sections below.
--
-- WHAT IS TELESCOPE?
--   Telescope is a highly extensible fuzzy finder for Neovim.
--   "Fuzzy finding" means you type a few characters and it finds
--   matches even if they're not exact — it looks for PATTERNS.
--
--   Example: Typing "kmp" would match "keymaps.lua" because
--   the letters k, m, p appear in that order in the file name.
--
--   Telescope can search for:
--     • Files in your project     (find_files)
--     • Text inside files         (live_grep)
--     • Open buffers              (buffers)
--     • Help documentation        (help_tags)
--     • Git commits               (git_commits)
--     • Keybindings               (keymaps)
--     • LSP symbols               (lsp_document_symbols)
--     • And MUCH more!
--
-- HOW TELESCOPE LOOKS:
--   When you open Telescope, you see a popup with two panels:
--
--   ┌─────────────────────────────────────────────────────┐
--   │  > your search query here                           │  ← Prompt (you type here)
--   ├──────────────────────────┬──────────────────────────┤
--   │  search_result_1.lua    │                           │
--   │  search_result_2.js     │   Preview of the          │
--   │  search_result_3.tsx    │   highlighted file         │
--   │  search_result_4.py     │   contents shown here      │
--   │                         │                           │
--   └──────────────────────────┴──────────────────────────┘
--     ↑ Results list              ↑ Preview window
--
-- EXTERNAL DEPENDENCIES:
--   • ripgrep (rg)  → Required for live_grep (text search across files)
--     Install: brew install ripgrep (Mac) / sudo apt install ripgrep (Ubuntu)
--   • fd            → Optional but faster alternative for find_files
--     Install: brew install fd (Mac) / sudo apt install fd-find (Ubuntu)
--
-- KEYBINDINGS (defined in keymaps.lua):
--   • Ctrl+P      → Find files by name in your project
--   • <leader>fg  → Search for text inside all files (live grep)
--
-- KEYBINDINGS INSIDE TELESCOPE (when the popup is open):
--   INSERT MODE (while typing in the search bar):
--     • Ctrl+j     → Move to next result (down)
--     • Ctrl+k     → Move to previous result (up)
--     • Ctrl+q     → Send all results to the quickfix list
--     • Ctrl+c     → Close Telescope
--     • Enter      → Open the selected file
--     • Ctrl+x     → Open the selected file in a horizontal split
--     • Ctrl+v     → Open the selected file in a vertical split
--     • Ctrl+u     → Scroll preview UP
--     • Ctrl+d     → Scroll preview DOWN
--   NORMAL MODE (press Esc first to enter normal mode inside Telescope):
--     • j / k      → Move up/down through results
--     • q / Esc    → Close Telescope
--     • Enter      → Open the selected file
-- ============================================


-- Require the telescope module
local telescope = require("telescope")

-- Require the built-in actions module
-- Actions are functions that define what happens when you press keys inside Telescope
local actions = require("telescope.actions")


-- Call telescope's setup function to configure it
telescope.setup({

    -- ========================
    -- DEFAULTS (Apply to ALL Telescope pickers)
    -- ========================
    --
    -- A "picker" is a specific search mode (find_files, live_grep, buffers, etc.)
    -- Settings here apply to every picker unless overridden in the `pickers` section below

    defaults = {

        disable_devicons = true,
        preview=false,
        -- The prompt prefix shown before your search query
        -- This is the little symbol at the start of the search bar
        -- Default is "🔍 " but a simple "> " is cleaner and works in any terminal
        prompt_prefix = "> ",

        -- The symbol shown next to the currently selected result
        -- This helps you see which result is highlighted
        selection_caret = " > ",

        -- Where to display the search results relative to the prompt
        -- "bottom" means results appear below the search bar (most common)
        -- "top" means results appear above the search bar
        sorting_strategy = "ascending",

        -- How the Telescope popup window is laid out
        -- "horizontal" = results on left, preview on right (side by side)
        -- "vertical"   = results on top, preview on bottom (stacked)
        -- "center"     = centered floating window
        layout_strategy = "horizontal",

        -- Fine-tune the layout dimensions
        layout_config = {

            -- Use 80% of the screen width for the Telescope popup
            -- Decrease for a smaller popup, increase for a larger one
            width = 0.8,

            -- Use 80% of the screen height for the Telescope popup
            height = 0.8,

            -- How wide the preview panel is (as a fraction of the popup width)
            -- 0.5 means the preview takes up half the popup
            -- Increase this if you want a bigger preview window
            preview_width = 0.5,

            -- Position the prompt (search bar) at the top of the popup
            -- "top" = search bar at the top, "bottom" = search bar at the bottom
            prompt_position = "top",
        },

        -- Patterns to EXCLUDE from search results
        -- These files and folders will NEVER show up in Telescope
        -- Add any large or auto-generated directories you want to ignore
        file_ignore_patterns = {
            "node_modules",    -- JavaScript dependencies folder (huge, auto-generated)
            ".git/",           -- Git internal folder (you don't need to search git objects)
            "dist/",           -- Build output folder (auto-generated)
            "build/",          -- Another common build output folder
            "%.lock",          -- Lock files like package-lock.json, yarn.lock (auto-generated)
        },

        -- ========================
        -- KEY MAPPINGS INSIDE TELESCOPE
        -- ========================
        --
        -- These keybindings ONLY work when the Telescope popup is open
        -- They are separate from your normal Neovim keybindings

        mappings = {

            -- INSERT MODE MAPPINGS (when you're typing in the search bar)
            i = {

                -- Move DOWN through the results list with Ctrl+J
                -- (like pressing the down arrow, but keeps your fingers on home row)
                ["<C-j>"] = actions.move_selection_next,

                -- Move UP through the results list with Ctrl+K
                -- (like pressing the up arrow, but keeps your fingers on home row)
                ["<C-k>"] = actions.move_selection_previous,

                -- Close Telescope with Ctrl+C (same as Escape)
                ["<C-c>"] = actions.close,

                -- Send ALL search results to the quickfix list with Ctrl+Q
                -- The quickfix list is a built-in Neovim feature for navigating a list of locations
                -- Useful when you want to go through ALL matches one by one
                ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,

                -- Scroll the PREVIEW window up with Ctrl+U
                ["<C-u>"] = actions.preview_scrolling_up,

                -- Scroll the PREVIEW window down with Ctrl+D
                ["<C-d>"] = actions.preview_scrolling_down,
            },

            -- NORMAL MODE MAPPINGS (press Escape first to enter normal mode inside Telescope)
            n = {

                -- Close Telescope with q (quick exit without pressing Escape twice)
                ["q"] = actions.close,

                -- Move DOWN through results with j (standard Vim navigation)
                ["j"] = actions.move_selection_next,

                -- Move UP through results with k (standard Vim navigation)
                ["k"] = actions.move_selection_previous,
            },
        },
    },

    -- ========================
    -- PICKERS (Settings for specific search modes)
    -- ========================
    --
    -- Each picker can override the defaults above
    -- This lets you customize behavior for different search types

    pickers = {

        -- Settings specifically for the file finder (Ctrl+P)
        find_files = {

            -- Show hidden files (dotfiles like .gitignore, .env)
            -- These are files starting with a dot that are normally hidden
            hidden = true,

            -- Theme for this picker
            -- "dropdown" = compact popup that drops down from the top
            -- Remove this line to use the default horizontal layout
            -- Other themes: "cursor" (small popup at cursor), "ivy" (bottom panel)
            -- theme = "dropdown",
        },

        -- Settings specifically for the text search (leader+fg)
        live_grep = {

            -- Additional arguments passed to ripgrep (the search tool)
            -- "--hidden" tells ripgrep to also search inside hidden (dot) files
            additional_args = function()
                return { "--hidden" }    -- Search hidden files too
            end,
        },

        -- Settings specifically for the buffer list
        -- (not mapped by default, but you can use `:Telescope buffers`)
        buffers = {

            -- Sort buffers by most recently used (last used = first in list)
            sort_mru = true,

            -- Show an option to delete buffers from the list
            -- Press Ctrl+D in the buffer picker to close a buffer
            mappings = {
                i = {
                    ["<C-d>"] = actions.delete_buffer,  -- Close a buffer with Ctrl+D
                },
            },
        },
    },

    -- ========================
    -- EXTENSIONS (Additional Telescope plugins)
    -- ========================
    --
    -- Extensions add extra search capabilities to Telescope
    -- You need to install them as separate plugins in plugins/init.lua
    -- Then register them here
    --
    -- Popular extensions:
    --   • telescope-fzf-native.nvim → Faster fuzzy matching using C
    --   • telescope-file-browser.nvim → Full file browser inside Telescope
    --   • telescope-ui-select.nvim → Use Telescope for Neovim's built-in select UI
    --
    -- For now, we have no extensions installed, but the section is here
    -- ready for you to add them later

    extensions = {
        -- Add extension configs here when you install them
        -- Example:
        -- fzf = {
        --     fuzzy = true,
        --     override_generic_sorter = true,
        --     override_file_sorter = true,
        -- },
    },
})
