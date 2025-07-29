-- make conceal characters transparent regardless of colorscheme
vim.api.nvim_set_hl(0, "Conceal", { bg = "none", fg = "none" })

-- transparent lualine
vim.schedule(function()
    vim.cmd("highlight lualine_c_normal guibg=NONE")
    vim.cmd("highlight lualine_c_inactive guibg=NONE")
end)
