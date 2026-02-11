-- for highlight groups and transparency:
-- https://github.com/rose-pine/neovim/blob/main/lua/rose-pine.lua
-- for palette:
-- https://rosepinetheme.com/palette/ingredients/
-- useful command:
-- :TSHighlightCapturesUnderCursor

return {

	-- "rose-pine/neovim",
	-- name = "rose-pine",
	-- config = function ()
	--        require("rose-pine").setup({
	--            variant = "auto",
	--            enable = {
	--                terminal = true
	--            },
	--            styles = {
	--                bold = true,
	--                italic = true,
	--                transparency = true,
	--            },
	--            highlight_groups = {
	--                ["@string.documentation"] = { fg = "subtle" }
	--            }
	--        })
	--        vim.cmd.colorscheme "rose-pine"
	-- end

    "vague2k/vague.nvim",
    lazy = false,
    priority = 1000,
    config = function ()
        require("vague").setup({
            transparent = true,
            style = {
                keywords = "bold",
            },
            on_highlights = function (highlights, _)
                local transparency_highlights = {
                    StatusLine = { bg = "NONE" },
                    StatusLineNC = { bg = "NONE" },
                }
                for group, highlight in pairs(transparency_highlights) do
                    highlights[group] = highlight
                end
            end
        })
        vim.cmd("colorscheme vague")
    end

}
