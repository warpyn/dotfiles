return {
    "williamboman/mason-lspconfig.nvim",
    version = "*",
    dependencies = {
        "neovim/nvim-lspconfig",
        "williamboman/mason.nvim",
        "saghen/blink.cmp"
    },
    config = function()

        -- setup mason and install language servers
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

        -- lsp diagnostics
        vim.diagnostic.config({ severity_sort = true, virtual_text = true })
        vim.keymap.set("n", "<leader>do", vim.diagnostic.open_float, { desc = "Open diagnostic message in a floating window" })

        -- lsp completion integration
        local capabilities = require("blink.cmp").get_lsp_capabilities()
        vim.lsp.config("*", { capabilities = capabilities })

        -- pyright lsp
        vim.lsp.config("pyright", {
            root_markers = { "pyproject.toml", "requirements.txt", "pyrightconfig.json", "__init__.py", ".git", "setup.py", "setup.cfg", "Pipfile" },
            settings = {
                python = {
                    pythonPath = vim.fn.exepath("python"),
                    analysis = { typeCheckingMode = "basic", useLibraryCodeForTypes = true }
                }
            }
        })

        -- lua_ls lsp
        -- copied from https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls
        -- for the "vim" global module
        vim.lsp.config("lua_ls", {
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

    end
}
