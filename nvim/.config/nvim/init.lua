--- LEADER KEY ---
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

--- PLUGINS ---
vim.pack.add({
    "https://github.com/nvim-treesitter/nvim-treesitter",
    { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
    "https://github.com/nvim-mini/mini.icons",
    "https://github.com/ibhagwan/fzf-lua",
    "https://github.com/lewis6991/gitsigns.nvim",
    "https://github.com/stevearc/oil.nvim",
    "https://github.com/malewicz1337/oil-git.nvim",
    "https://github.com/folke/which-key.nvim",
    "https://github.com/benomahony/uv.nvim",
})

-- treesitter
require("nvim-treesitter").setup()
require("nvim-treesitter").install({ "lua", "python", "markdown", "markdown_inline", "cpp", "go" }):wait()
require("nvim-treesitter.install").update("all")
vim.api.nvim_create_autocmd("FileType", {
    -- syntax highlighting
    callback = function(args)
        local treesitter = require("nvim-treesitter")
        local lang = vim.treesitter.language.get_lang(args.match)
        if vim.list_contains(treesitter.get_installed(), lang) then
            vim.treesitter.start(args.buf)
        end
    end
})

-- completion
require("blink.cmp").setup({
    keymap = { preset = "super-tab" },
    appearance = { nerd_font_variant = "mono" },
    completion = { documentation = { auto_show = false } },
    signature = { enabled = true },
    sources = { default = { "lsp", "path", "snippets", "buffer" } },
    fuzzy = { implementation = "prefer_rust_with_warning" },
})

-- lsp and language servers
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
vim.diagnostic.config({ severity_sort = true, virtual_text = true })
vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities() })
vim.lsp.config("pyright", {
    root_markers = { "pyproject.toml", "requirements.txt", "pyrightconfig.json", "__init__.py", ".git", "setup.py", "setup.cfg", "Pipfile" },
    settings = { python = { pythonPath = vim.fn.exepath("python"), analysis = { typeCheckingMode = "basic", useLibraryCodeForTypes = true } } }
})
vim.lsp.config("lua_ls", {
    -- copied from https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls
    -- Make the server aware of Neovim runtime files like the "vim" global module
    on_init = function (client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if path ~= vim.fn.stdpath("config") and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc")) then return end
        end
        client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
            runtime = { version = "LuaJIT", path = { "lua/?.lua", "lua/?/init.lua", }, },
            workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } }
        })
    end,
    settings = { Lua = {} }
})

-- utilities
require("mini.icons").setup()
local fzf_lua = require("fzf-lua")
fzf_lua.setup({ files = { cwd_prompt = false } })
require("oil").setup({ view_options = { show_hidden = true } })
require("oil-git").setup()
require("which-key").setup({
    preset = "helix",
    spec = {{
        mode = { "n", "v" },
        { "<leader>f", group = "FZF"  },
        { "<leader>d", group = "Diagnostics"},
        { "<leader>gh", group = "Git Hunk"  }
    }}
})
require("uv").setup()

--- APPEARANCE ---
vim.pack.add({
    "https://github.com/xiyaowong/transparent.nvim",
    "https://github.com/vague2k/vague.nvim",
})
require("vague").setup({ transparent = true, style = { keywords = "bold" } })
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
M = {}
function M.git()
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
function M.active()
    -- handle cases where files are loaded using their absolute path
    local name_opt = (vim.fn.expand("%:~:.") == "" or vim.bo.buftype ~= "") and "%t" or vim.fn.expand("%:~:.")
    return table.concat({
        -- %-0{minwid}.{maxwid}{item}
        name_opt,
        " %r", -- readonly flag
        " %m", -- modified flag
        "%=", -- alignment separator
        vim.diagnostic.status(),
        M.git(), -- git info
        " %{&filetype}", -- filetype
        " %2p%%", -- vertical file progress percentage
        " %2l:%-2c " -- cursor line and column number
    })
end
function M.inactive() return " %t" end
local group = vim.api.nvim_create_augroup("Statusline", { clear = true })
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
    group = group,
    desc = "Activate statusline on focus",
    callback = function() vim.opt_local.statusline = "%!v:lua.M.active()" end
})
vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
    group = group,
    desc = "Activate statusline on unfocus",
    callback = function() vim.opt_local.statusline = "%!v:lua.M.inactive()" end
})

--- KEYMAPS ---
-- buffer management
vim.keymap.set("n", "<leader>h", ":bprev<cr>", { desc = "Prev Buffer", silent = true })
vim.keymap.set("n", "<leader>l", ":bnext<cr>", { desc = "Next Buffer", silent = true })
vim.keymap.set("n", "<leader>bd", ":bdelete<cr>", { desc = "Delete Buffer", silent = true })
-- navigation
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Center cursor after moving up half-page", noremap = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Center cursor after moving down half-page", noremap = true })
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })
-- text
vim.keymap.set({"n", "v"}, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>ch", ":s/\\[ \\]/[x]/<cr>", { desc = "Check box" })
-- fzf
vim.keymap.set("n", "<leader>ff", fzf_lua.files, { desc = "FZF Find Files" })
vim.keymap.set("n", "<leader>fg", fzf_lua.live_grep, { desc = "FZF Live Grep" })
vim.keymap.set("n", "<leader>fb", fzf_lua.buffers, { desc = "FZF Buffers" })
vim.keymap.set("n", "<leader>fk", fzf_lua.keymaps, { desc = "FZF Keymaps" })
vim.keymap.set("n", "<leader>fh", fzf_lua.help_tags, { desc = "FZF Help Tags" })
vim.keymap.set("n", "<leader>fr", fzf_lua.resume, { desc = "FZF Resume Last Query" })
vim.keymap.set("n", "<leader>fd", fzf_lua.diagnostics_document, { desc = "FZF Diagnostics Document" })
vim.keymap.set("n", "<leader>fD", fzf_lua.diagnostics_workspace, { desc = "FZF Diagnostics Workspace" })
-- lsp / diagnostics actions
vim.keymap.set("n", "gd", fzf_lua.lsp_definitions, { desc = "Go to definition" })
vim.keymap.set("n", "grr", fzf_lua.lsp_references, { desc = "Go to references" })
vim.keymap.set("n", "gra", fzf_lua.lsp_code_actions, { desc = "Go to code actions" })
vim.keymap.set("n", "go", fzf_lua.lsp_document_symbols, { desc = "Go to document symbols" })
vim.keymap.set("n", "gO", fzf_lua.lsp_workspace_symbols, { desc = "Go to workspace symbols" })
vim.keymap.set("n", "<leader>do", vim.diagnostic.open_float, { desc = "Open diagnostic message in a floating window" })
-- git management
vim.keymap.set("n", "<leader>gf", fzf_lua.git_files, { desc = "Git Files" })
vim.keymap.set("n", "<leader>gs", fzf_lua.git_status, { desc = "Git Status" })
vim.keymap.set("n", "<leader>gc", fzf_lua.git_commits, { desc = "Git Commits" })
vim.keymap.set("n", "<leader>ghs", ":Gitsigns stage_hunk<cr>", { desc = "Git Hunk: Stage", silent =  true })
vim.keymap.set("n", "<leader>ghr", ":Gitsigns reset_hunk<cr>", { desc = "Git Hunk: Reset", silent =  true })
vim.keymap.set("n", "<leader>ghp", ":Gitsigns preview_hunk<cr>", { desc = "Git Hunk: Preview", silent =  true })
-- ui
vim.keymap.set("n", "<Esc>", ":noh<cr>", { desc = "Remove search highlighting", noremap = true, silent = true })
vim.keymap.set("n", "<leader>e", ":Oil<cr>", { desc = "Oil File Explorer (parent directory)", silent = true })
