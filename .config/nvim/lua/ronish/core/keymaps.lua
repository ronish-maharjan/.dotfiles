-- Leader key set
vim.g.mapleader = " "

--- Utility keymaps
--vim.keymap.set("n","<C-n>","<cmd>Ex<CR>",{desc="open netrw"})
vim.keymap.set("n", "<C-n>", "<cmd>Oil<CR>", { desc = "Open oil" })
vim.keymap.set("n","<leader>r","<cmd>write| source %<CR>",{desc="Sourcing the config"})

--- Focusing the split window
vim.keymap.set("n","<C-h>","<C-w>h",{desc="focus to left window"})
vim.keymap.set("n","<C-l>","<C-w>l",{desc="focus to right window"})
vim.keymap.set("n","<C-j>","<C-w>j",{desc="focus to bottom window"})
vim.keymap.set("n","<C-k>","<C-w>k",{desc="focus to top window"})

--- My personal stuff 
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })
vim.keymap.set("v","<C-q>","<C-v>",{desc= "Use C-q for visual block"})
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Exit insert mode with Ctrl+C" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center cursor" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center cursor" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })

--- Plugins Bindings

--- Telescope binding
vim.keymap.set("n", "<C-p>", function()
    require("telescope.builtin").find_files()  -- Call Telescope's file finder function
end, { desc = "Find files using Telescope" })

vim.keymap.set("n", "<leader>fg", function()
    require("telescope.builtin").live_grep()  -- Call Telescope's live grep function
end, { desc = "Live grep (search in files)" })

--- Harpoon binding

---vim.keymap.set("n", "<leader>a", function()
---    require("harpoon.mark").add_file()  -- Add current file to harpoon marks
---end, { desc = "Harpoon: add file" })

-- Open the Harpoon quick menu with Ctrl+E
-- Shows a popup list of all your bookmarked files
---vim.keymap.set("n", "<C-e>", function()
---    require("harpoon.ui").toggle_quick_menu()  -- Toggle the harpoon file list
---end, { desc = "Harpoon: toggle menu" })

-- Jump directly to harpoon file 1 through 5 using Leader+number
-- This is faster than opening the menu — instant jump to a specific file
-- vim.keymap.set("n", "<leader>1", function()
--     require("harpoon.ui").nav_file(1)  -- Navigate to the 1st harpooned file
-- end, { desc = "Harpoon: go to file 1" })
-- 
-- vim.keymap.set("n", "<leader>2", function()
--     require("harpoon.ui").nav_file(2)  -- Navigate to the 2nd harpooned file
-- end, { desc = "Harpoon: go to file 2" })
-- 
-- vim.keymap.set("n", "<leader>3", function()
--     require("harpoon.ui").nav_file(3)  -- Navigate to the 3rd harpooned file
-- end, { desc = "Harpoon: go to file 3" })
-- 
-- vim.keymap.set("n", "<leader>4", function()
--     require("harpoon.ui").nav_file(4)  -- Navigate to the 4th harpooned file
-- end, { desc = "Harpoon: go to file 4" })
-- 
-- vim.keymap.set("n", "<leader>5", function()
--     require("harpoon.ui").nav_file(5)  -- Navigate to the 5th harpooned file
-- end, { desc = "Harpoon: go to file 5" })
-- 
-- -- Automatically clear all harpoon marks when you quit Neovim
-- vim.api.nvim_create_autocmd("VimLeavePre", {     -- Listen for "Neovim is about to close" event
--     callback = function()                          -- Run this function when the event fires
--         require("harpoon.mark").clear_all()        -- Remove all harpoon file marks
--     end,
-- })

--- Lsp Keymaps
vim.keymap.set("n", "<leader>k", function()
    local current = vim.diagnostic.config().virtual_text
    vim.diagnostic.config({ virtual_text = not current })
end, { desc = "Toggle LSP virtual text" })
vim.keymap.set("n", "<leader>o", vim.diagnostic.open_float, opts)

-- Undo Tree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle undo tree" })
