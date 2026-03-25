return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    lazy = false,
    priority = 10,
    config = function()
        local theme = require("lualine.themes.auto")
        theme.normal.c.bg = "NONE"
        theme.inactive.c.bg = "NONE"
        require("lualine").setup({
            sections = {
                -- default sections setup is located at
                -- https://github.com/nvim-lualine/lualine.nvim
                lualine_a = {'mode'},
                lualine_b = {'filename', 'diff', 'diagnostics'},
                lualine_c = {'buffers'},
                lualine_x = {'branch'},
                lualine_y = {'filetype', 'progress'},
                lualine_z = {'location'}
            },
            options = {
                theme = theme,
            }
        })
    end
}
