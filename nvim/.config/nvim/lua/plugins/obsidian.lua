return {
    "obsidian-nvim/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    opts = {
        workspaces = {
            {
                name = "personal",
                path = "~/chrysalis/pkm",
            },
        },
        log_level = vim.log.levels.INFO,
        completion = {
            nvim_cmp = false,
            blink = true,
            min_chars = 2,
        },
        picker = {
            name = "snacks.pick"
        },
        disable_frontmatter = true,
        legacy_commands = false
    }
}
