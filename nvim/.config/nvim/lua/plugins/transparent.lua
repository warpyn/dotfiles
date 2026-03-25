return {
    "xiyaowong/transparent.nvim",
    lazy = false,
    priority = 5,
    config = function ()
        require("transparent").setup({
            extra_groups = {
                "NormalFloat"
            },
        })
        -- require("transparent").clear_prefix("Snacks")
        require("transparent").clear_prefix("BlinkCmp")
        vim.cmd("TransparentEnable")
    end
}
