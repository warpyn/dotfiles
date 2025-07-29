return {
    "neovim/nvim-lspconfig",
    version = "*",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "saghen/blink.cmp"
    },
    config = function()

        -- setup mason and install lsp servers
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "pyright",
                "jsonls",
                "marksman",
                "tinymist",
                "clangd",
            },
            automatic_enable = true,
        })

        -- lsp completion integration
        local capabilities = require('blink.cmp').get_lsp_capabilities()
        vim.lsp.config('*', { capabilities = capabilities })

        -- lsp diagnostics
        vim.diagnostic.config({
            severity_sort = true,
            virtual_text = true
        })

        -- pyright lsp
        vim.lsp.config('pyright', {
            root_markers = {
                "__init__.py",
                "pyproject.toml",
                "setup.py",
                "setup.cfg",
                "requirements.txt",
                "Pipfile",
                "pyrightconfig.json",
                ".git"
            },
            settings = {
                python = {
                    pythonPath = vim.fn.exepath("python")
                }
            }
        })

        -- lua_ls lsp
        -- copied from https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls
        -- for the 'vim' global module
        vim.lsp.config('lua_ls', {
          on_init = function(client)
            if client.workspace_folders then
              local path = client.workspace_folders[1].name
              if
                path ~= vim.fn.stdpath('config')
                ---@diagnostic disable-next-line: undefined-field
                and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
              then
                return
              end
            end
            client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
              runtime = {
                version = 'LuaJIT',
                path = {
                  'lua/?.lua',
                  'lua/?/init.lua',
                },
              },
              -- Make the server aware of Neovim runtime files
              workspace = {
                checkThirdParty = false,
                library = {
                  vim.env.VIMRUNTIME
                }
              }
            })
          end,
          settings = {
            Lua = {}
          }
        })

        -- c++
        vim.api.nvim_set_hl(0, '@lsp.type.comment.cpp', {})

    end
}
