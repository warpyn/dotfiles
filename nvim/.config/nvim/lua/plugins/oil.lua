return {
    "malewicz1337/oil-git.nvim",
    lazy = false,
    dependencies = {
        "stevearc/oil.nvim",
        "nvim-tree/nvim-web-devicons"
    },
    config = function ()
        require("oil").setup({
            view_options = {
                show_hidden = true,
            }
        })
        vim.keymap.set("n", "<leader>e", ":Oil<cr>", { desc = "Oil File Explorer (Open parent directory)", silent = true })
    end
}
