-- ============================================
-- FILE: lua/ronish/plugin-configs/colors.lua
-- PURPOSE: Configure the Rose Pine colorscheme
-- HOW TO EDIT: Change the `variant` to switch themes,
--              or toggle the boolean options to customize the look.
--
-- WHAT IS A COLORSCHEME?
--   A colorscheme controls how EVERYTHING looks in Neovim:
--   • Syntax highlighting (keywords, strings, functions, etc.)
--   • Background color
--   • Status line colors
--   • Popup menu colors
--   • Error/warning highlight colors
--
-- WHAT IS ROSE PINE?
--   Rose Pine is a beautiful, soft colorscheme with muted pastel colors.
--   It's easy on the eyes for long coding sessions.
--   Website: https://rosepinetheme.com
--   It comes with 3 variants:
--     • "main"  → Dark theme with warm tones (default)
--     • "moon"  → Dark theme with cooler, blue-ish tones
--     • "dawn"  → Light theme with warm tones
--
-- KEYBINDINGS: None — this is purely visual configuration.
-- ============================================


-- Call rose-pine's setup function to configure it BEFORE activating the theme
-- setup() must come BEFORE vim.cmd.colorscheme() or the settings won't apply
require("rose-pine").setup({

    -- Choose which variant of Rose Pine to use
    -- Options: "auto" (follows system dark/light mode), "main", "moon", "dawn"
    -- Try changing this to "moon" or "dawn" to see different looks!
    variant = "auto",

    -- Choose which variant to use when your system is in dark mode
    -- Only matters if `variant` above is set to "auto"
    dark_variant = "main",

    -- Make the bold text styling more noticeable
    -- When true, bold syntax elements (like keywords) appear bolder
    bold_ints = true,

    -- Use italic styling for certain syntax elements (like comments and keywords)
    -- Set to false if your terminal font doesn't support italics
    italic = false,

    -- Make the background fully transparent
    -- When true, Neovim uses your terminal's background color instead of the theme's
    -- This is great if you have a custom terminal background or wallpaper
    -- Set to true if you want to see your terminal background through Neovim
    transparent = false,

    -- Customize specific highlight groups (advanced)
    -- This table lets you override individual colors in the theme
    -- Each function receives the `colors` table containing all Rose Pine colors
    highlight_groups = {

        -- Make the color column (the vertical line at column 80) semi-transparent
        -- `colors.highlight_low` is a subtle Rose Pine color
        -- `blend = 20` means 20% visible, 80% transparent (0 = invisible, 100 = solid)
        ColorColumn = {
            bg = require("rose-pine.palette").highlight_low,  -- Use the subtle highlight color
            blend = 20,                                        -- Make it mostly transparent
        },

        -- Make the cursor line background semi-transparent
        -- This is the horizontal line that highlights which line your cursor is on
        CursorLine = {
            bg = require("rose-pine.palette").highlight_low,  -- Use the subtle highlight color
            blend = 20,                                        -- Make it mostly transparent
        },
    },
})


-- ========================
-- ACTIVATE THE COLORSCHEME
-- ========================

-- This line actually APPLIES the colorscheme to Neovim
-- `vim.cmd.colorscheme("rose-pine")` is the Lua equivalent of typing `:colorscheme rose-pine`
-- IMPORTANT: This must come AFTER the setup() call above
-- If you want to try a different colorscheme entirely, change "rose-pine" to another installed theme
vim.cmd.colorscheme("rose-pine")
