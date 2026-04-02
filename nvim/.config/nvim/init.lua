--- LEADER KEY ---
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
--- PLUGINS ---
-- treesitter
vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })
require("nvim-treesitter").setup()
require("nvim-treesitter").install({ "lua", "python", "markdown", "markdown_inline", "cpp", "go" })
require("nvim-treesitter.install").update("all")
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "<filetype>" },
  callback = function() vim.treesitter.start() end,
})
-- completion
vim.pack.add({ { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") } })
require("blink.cmp").setup({
    keymap = { preset = "super-tab" },
    appearance = { nerd_font_variant = "mono" },
    completion = { documentation = { auto_show = false } },
    signature = { enabled = true },
    sources = { default = { "lsp", "path", "snippets", "buffer" } },
    fuzzy = { implementation = "prefer_rust_with_warning" },
})
-- lsp and language servers
vim.pack.add({
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
})
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "pyright",
        "jsonls",
        "marksman",
        "tinymist",
        "gopls",
    },
    automatic_enable = true,
})
vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities() })
vim.lsp.config("pyright", {
    root_markers = { "pyproject.toml", "requirements.txt", "pyrightconfig.json", "__init__.py", ".git", "setup.py", "setup.cfg", "Pipfile" },
    settings = {
        python = {
            pythonPath = vim.fn.exepath("python"),
            analysis = { typeCheckingMode = "basic", useLibraryCodeForTypes = true }
        }
    }
})
vim.lsp.config("lua_ls", {
    -- copied from https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls
    -- for the "vim" global module
    on_init = function (client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if
                path ~= vim.fn.stdpath("config")
                ---@diagnostic disable-next-line: undefined-field
                and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
            then
                return
            end
        end
        client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
            -- Make the server aware of Neovim runtime files
            runtime = { version = "LuaJIT", path = { "lua/?.lua", "lua/?/init.lua", }, },
            workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } }
        })
    end,
    settings = { Lua = {} }
})
vim.diagnostic.config({ severity_sort = true, virtual_text = true })
vim.keymap.set("n", "<leader>do", vim.diagnostic.open_float, { desc = "Open diagnostic message in a floating window" })
-- fuzzy finder 
vim.pack.add({
    "https://github.com/nvim-mini/mini.icons",
    "https://github.com/ibhagwan/fzf-lua",
})
require("mini.icons").setup()
require("fzf-lua").setup({ files = { cwd_prompt = false } })
local fzf_lua = require("fzf-lua")
vim.keymap.set("n", "<leader>ff", fzf_lua.files, { desc = "FZF Find Files" })
vim.keymap.set("n", "<leader>fg", fzf_lua.live_grep, { desc = "FZF Live Grep" })
vim.keymap.set("n", "<leader>fb", fzf_lua.buffers, { desc = "FZF Buffers" })
vim.keymap.set("n", "<leader>fh", fzf_lua.help_tags, { desc = "FZF Help Tags" })
vim.keymap.set("n", "<leader>fd", fzf_lua.diagnostics_document, { desc = "FZF Diagnostics Document" })
vim.keymap.set("n", "<leader>fD", fzf_lua.diagnostics_workspace, { desc = "FZF Diagnostics Workspace" })
-- git signs
vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })
vim.keymap.set("n", "<leader>ghs", ":Gitsigns stage_hunk<cr>", { desc = "Git Hunk: Stage", silent =  true })
vim.keymap.set("n", "<leader>ghr", ":Gitsigns reset_hunk<cr>", { desc = "Git Hunk: Reset", silent =  true })
vim.keymap.set("n", "<leader>ghp", ":Gitsigns preview_hunk<cr>", { desc = "Git Hunk: Preview", silent =  true })
-- oil
vim.pack.add({
    "https://github.com/stevearc/oil.nvim",
    "https://github.com/malewicz1337/oil-git.nvim",
})
require("oil").setup({ view_options = { show_hidden = true } })
vim.keymap.set("n", "<leader>e", ":Oil<cr>", { desc = "Oil File Explorer (parent directory)", silent = true })
-- which-key
vim.pack.add({ "https://github.com/folke/which-key.nvim" })
require("which-key").setup({
    preset = "helix",
    spec = {
        {
            mode = { "n", "v" },
            { "<leader>f", group = "FZF"  },
            { "<leader>d", group = "Diagnostics"},
            { "<leader>gh", group = "Git Hunk"  }
        }
    }
})
-- uv
vim.pack.add({ "https://github.com/benomahony/uv.nvim" })
require("uv").setup()
-- appearance
vim.pack.add({
    "https://github.com/vague2k/vague.nvim",
    "https://github.com/xiyaowong/transparent.nvim",
})
require("vague").setup({
    transparent = true,
    style = { keywords = "bold" },
})
vim.cmd("colorscheme vague")
require("transparent").setup()

--- OPTIONS ---
-- statuscolumn (sign column, line numbers, fold column)
vim.opt.number = true
vim.opt.signcolumn = "yes"
vim.opt.statuscolumn = "%s%l  " -- disable fold column and directly add spaces to status column for padding
-- indentation
vim.opt.tabstop = 4 -- display tabs to this length in spaces
vim.opt.softtabstop = 4 -- pressing <tab> and <backspace> moves the cursor by this many spaces
vim.opt.shiftwidth = 4 -- indent width to this length in spaces
vim.opt.expandtab = true -- expand tabs to spaces
vim.opt.autoindent = true
vim.opt.smartindent = true
-- search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- split windows
vim.opt.splitbelow = true
vim.opt.splitright = true
-- appearance
vim.opt.cursorline = false
vim.opt.termguicolors = true
vim.opt.fillchars = { eob = " " } -- disables the "~" displayed at the bottom of a window
vim.opt.winborder = "rounded"
vim.opt.scrolloff = 10
vim.opt.wrap = false
vim.opt.conceallevel = 0
-- file handling
vim.opt.swapfile = false
vim.opt.autoread = true

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
function StatusLineActive()
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
function StatusLineInactive()
    return " %t"
end
local group = vim.api.nvim_create_augroup("Statusline", { clear = true })
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
    group = group,
    desc = "Activate statusline on focus",
    callback = function()
        vim.opt_local.statusline = "%!v:lua.StatusLineActive()"
    end
})
vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
    group = group,
    desc = "Activate statusline on unfocus",
    callback = function()
        vim.opt_local.statusline = "%!v:lua.StatusLineInactive()"
    end
})

--- KEYMAPS ---
-- buffer management
vim.keymap.set('n', '<leader>h', ':bprev<cr>', { desc = 'Prev Buffer', silent = true })
vim.keymap.set('n', '<leader>l', ':bnext<cr>', { desc = 'Next Buffer', silent = true })
vim.keymap.set('n', '<leader>bd', ':bdelete<cr>', { desc = 'Delete Buffer', silent = true })
-- movement
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Center cursor after moving up half-page', noremap = true })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Center cursor after moving down half-page', noremap = true })
vim.keymap.set('v', '<', '<gv', { desc = 'Indent left and reselect' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right and reselect' })
-- text management
vim.keymap.set({'n', 'v'}, '<leader>y', '"+y', { desc = 'Yank to system clipboard' })
vim.keymap.set('n', '<leader>ch', ":s/\\[ \\]/[x]/<cr>", { desc = "Check box" })
