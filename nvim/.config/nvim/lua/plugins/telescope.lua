return {
    "nvim-telescope/telescope.nvim", version = "*",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function ()
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

        -- keymaps
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
        vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
    end
}
