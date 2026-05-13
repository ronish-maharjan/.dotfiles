return {
    {
        "nvim-telescope/telescope.nvim",
        version = "*",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },

        config = function()
            local telescope = require("telescope")
            local actions = require("telescope.actions")

            telescope.setup({
                defaults = {

                    prompt_prefix = "> ",
                    selection_caret = " > ",
                    sorting_strategy = "ascending",
                    layout_strategy = "horizontal",

                    -- 🚫 completely disable preview
                    previewer = false,

                    layout_config = {
                        width = 0.5,
                        height = 0.5,

                        preview_width = 0,
                        prompt_position = "top",
                    },

                    file_ignore_patterns = {
                        "node_modules",
                        ".git/",
                        "dist/",
                        "build/",
                        "%.lock",
                    },
                    mappings = {
                        i = {
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                            ["<C-c>"] = actions.close,
                            ["<C-q>"] = actions.send_to_qflist,
                        },

                        n = {
                            ["q"] = actions.close,
                            ["j"] = actions.move_selection_next,
                            ["k"] = actions.move_selection_previous,
                        },
                    },
                },

                pickers = {
                    find_files = {
                        hidden = true, -- Ensures hidden files show up in find_files
                    },
                },
            })
        end,
    },
}
