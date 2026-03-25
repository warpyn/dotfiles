-- for highlight groups and transparency:
-- https://github.com/rose-pine/neovim/blob/main/lua/rose-pine.lua
-- for palette:
-- https://rosepinetheme.com/palette/ingredients/
-- useful command:
-- :TSHighlightCapturesUnderCursor

return {

    priority = 100,

	-- "rose-pine/neovim",
	-- name = "rose-pine",
	-- config = function ()
	--        require("rose-pine").setup({
	--           variant = "auto",
	--           enable = {
	--               terminal = true
	--           },
	--           styles = {
	--               bold = true,
	--               italic = true,
	--               transparency = true,
	--           },
	--           highlight_groups = {
	--               ["@string.documentation"] = { fg = "subtle" }
	--           }
	--        })
	--        vim.cmd.colorscheme "rose-pine"
	-- end

    "vague2k/vague.nvim",
    lazy = false,
    config = function ()
        require("vague").setup({
            transparent = true,
            style = {
                keywords = "bold",
            },
        })
        vim.cmd("colorscheme vague")
    end

    -- "mellow-theme/mellow.nvim",
    -- lazy = false,
    -- config = function ()
    --     vim.g.mellow_transparent = true
    --     vim.cmd("colorscheme mellow")
    -- end

}
