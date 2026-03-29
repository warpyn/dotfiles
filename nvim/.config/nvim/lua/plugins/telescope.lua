return {
    "nvim-telescope/telescope.nvim", version = "*",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function ()

        -- keymaps
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
        vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find Help Tags" })
        vim.keymap.set("n", "<leader>fo", ":Telescope oldfiles<cr>", { desc = "Find Oldfiles", silent = true })
        vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Find Keymaps" })

        vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Go to Definition" })
        vim.keymap.set("n", "gO", builtin.lsp_document_symbols, { desc = "Go to Document Symbols" })
        vim.keymap.set("n", "grr", builtin.lsp_references, { desc = "Go to References" })

        local actions = require("telescope.actions")
        local telescope_config = require("telescope.config")
        local vimgrep_arguments = { unpack(telescope_config.values.vimgrep_arguments) }
        table.insert(vimgrep_arguments, "--hidden")
        table.insert(vimgrep_arguments, "--glob")
        table.insert(vimgrep_arguments, "!**/.git/*")

        require("telescope").setup({
            defaults = {
                sorting_strategy = "ascending",
                layout_config = {
                    prompt_position = "top"
                },
                vimgrep_arguments = vimgrep_arguments
            },
            pickers = {
                find_files = {
                    find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
                },
                buffers = {
                    mappings = {
                        n = {
                            ["dd"] = actions.delete_buffer + actions.move_to_top,
                        },
                        i = {
                            ["<C-d>"] = actions.delete_buffer + actions.move_to_top,
                        }
                    }
                }
            }
        })
        require("telescope").load_extension("fzf")

    end
}
