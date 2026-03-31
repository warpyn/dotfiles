return {
    "lewis6991/gitsigns.nvim",
    version = "*",
    config = function ()
        vim.keymap.set("n", "<leader>ghs", ":Gitsigns stage_hunk<cr>", { desc = "Git Hunk: Stage", silent =  true })
        vim.keymap.set("n", "<leader>ghr", ":Gitsigns reset_hunk<cr>", { desc = "Git Hunk: Reset", silent =  true })
        vim.keymap.set("n", "<leader>ghp", ":Gitsigns preview_hunk<cr>", { desc = "Git Hunk: Preview", silent =  true })
    end
}
