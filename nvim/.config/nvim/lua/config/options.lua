-- statuscolumn (sign column, line numbers, fold column)
vim.opt.number = true
vim.opt.signcolumn = "yes"
vim.opt.statuscolumn = "%s%l  " -- disable fold column and directly add spaces to status column for padding

-- statusline
function GetGitInfo()
    local git_info = vim.b.gitsigns_status_dict
    if not git_info then
        return ""
    else
        local added   = git_info.added and (" +" .. git_info.added) or ""
        local changed = git_info.changed and (" ~" .. git_info.changed) or ""
        local removed = git_info.removed and (" -" .. git_info.removed) or ""
        if git_info.added == 0 then added = "" end
        if git_info.changed == 0 then changed = "" end
        if git_info.removed == 0 then removed = "" end
        local head = " " .. git_info.head
        return table.concat({ added, changed, removed, head })
    end
end
function MyStatusLine()
    local statusline_opts = {
        -- %-0{minwid}.{maxwid}{item}
        " %r", -- readonly flag
        " %m", -- modified flag
        "%=", -- alignment separator
        GetGitInfo(), -- git info
        " %{&filetype}", -- filetype
        " %2p%%", -- vertical file progress percentage
        " %2l:%-2c " -- cursor line and column number
    }
    local rest = table.concat(statusline_opts, "")
    -- handle cases where files are loaded using their absolute path
    if vim.fn.expand("%:~:.") == "" or vim.bo.buftype ~= "" then
        return "%t" .. rest
    end
    return vim.fn.expand("%:~:.") .. rest
end
vim.opt.statusline = "%!v:lua.MyStatusLine()"

-- indentation
-- https://neovim.io/doc/user/indent.html
vim.opt.tabstop = 4 -- display tabs to this length in spaces
vim.opt.softtabstop = 4 -- pressing <tab> and <backspace> moves the cursor by this many spaces
vim.opt.shiftwidth = 4 -- indent width to this length in spaces
vim.opt.expandtab = true -- expand tabs to spaces
vim.opt.autoindent = true
vim.opt.smartindent = true

-- search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true -- if there is mixed case in a search, be case-sensitive

-- split windows
vim.opt.splitbelow = true
vim.opt.splitright = true

-- appearance
vim.opt.cursorline = true -- highlight cursorline
vim.opt.termguicolors = true -- true terminal color
vim.opt.fillchars = { eob = ' ' } -- disables the '~' displayed at the bottom of a window
vim.opt.winborder = "rounded" -- native popup window settings
vim.opt.scrolloff = 10 -- number of lines before window top/bottom before scrolling activates
vim.opt.wrap = false

-- conceal level
-- 0    Text is shown normally
-- 1    Each block of concealed text is replaced with one character.  If the syntax item does not have a custom replacement character defined, the character defined in 'listchars' is used.
-- 2    Concealed text is completely hidden unless it has a custom replacement character defined.
-- 3    Concealed text is completely hidden.
vim.opt.conceallevel = 0
-- make conceal characters transparent regardless of colorscheme
vim.api.nvim_set_hl(0, "Conceal", { bg = "none", fg = "none" })

-- file handling
vim.opt.swapfile = false -- Don't create swap files
vim.opt.autoread = true -- Auto reload files changed outside vim
