-- Automatically show diagnostic message for text cursor (no mouse) like in VS Code
vim.opt.updatetime = 250  -- how long (ms) before CursorHold triggers

vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, {
      focusable = false,          -- don’t steal focus
      border = "rounded",         -- nice rounded border
      source = "always",          -- show source (tsserver, cssls, etc)
      close_events = {           -- close popup when
        "CursorMoved",
        "InsertEnter",
        "BufLeave",
      },
    })
  end,
})
