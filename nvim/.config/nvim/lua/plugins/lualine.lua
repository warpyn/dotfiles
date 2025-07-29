return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    lazy = false,
    config = function()
        require("lualine").setup({
            -- default setup located at https://github.com/nvim-lualine/lualine.nvim
            sections = {
                lualine_a = {'mode'},
                lualine_b = {'filename', 'diff', 'diagnostics'},
                lualine_c = {'buffers'},
                lualine_x = {'branch'},
                lualine_y = {'filetype', 'progress'},
                lualine_z = {'location'}
            }
        })
    end
}
