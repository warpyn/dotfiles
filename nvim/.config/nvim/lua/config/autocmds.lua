-- make conceal characters transparent regardless of colorscheme
vim.api.nvim_set_hl(0, "Conceal", { bg = "none", fg = "none" })
