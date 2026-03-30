return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
            highlight = { enable = true },
            indent = { enable = true },
            ensure_installed = {
                "lua",
                "python",
                "markdown",
                "markdown_inline",
                "cpp",
                "go",
            },
            auto_install = false,
        })
    end
}
