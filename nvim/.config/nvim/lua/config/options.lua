-- line numbers
vim.opt.number = true

-- line wrap
vim.opt.wrap = false

-- tabs
vim.opt.tabstop = 4 -- display tabs to this length in spaces
vim.opt.softtabstop = 4 -- pressing <tab> and <backspace> moves the cursor by this many spaces
vim.opt.shiftwidth = 4 -- indent width to this length in spaces
vim.opt.expandtab = true -- expand tabs to spaces

-- indentation
-- https://neovim.io/doc/user/indent.html
vim.opt.smartindent = true
vim.opt.autoindent = true

-- search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true -- if there is mixed case in a search, be case-sensitive

-- split windows
vim.opt.splitbelow = true
vim.opt.splitright = true

---- appearance ----
vim.opt.cursorline = true -- highlight cursorline
vim.opt.termguicolors = true -- true terminal color
vim.opt.fillchars = { eob = ' ' } -- disables the '~' displayed at the bottom of a window
vim.opt.winborder = "rounded" -- native popup window settings

-- conceal level
-- 0    Text is shown normally
-- 1    Each block of concealed text is replaced with one character.  If the syntax item does not have a custom replacement character defined, the character defined in 'listchars' is used.
-- 2    Concealed text is completely hidden unless it has a custom replacement character defined.
-- 3    Concealed text is completely hidden.
vim.opt.conceallevel = 1

-- number of lines before window top/bottom before scrolling activates
vim.opt.scrolloff = 10

---- file handling
vim.opt.swapfile = false -- Don't create swap files
vim.opt.autoread = true -- Auto reload files changed outside vim
