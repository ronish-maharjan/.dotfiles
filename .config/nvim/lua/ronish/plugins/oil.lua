return {
    {
        'stevearc/oil.nvim',
        cmd="Oil",
        opts = {
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
        },
        lazy = false,
    }
}
