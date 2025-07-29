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
	--                italic = false,
	--                transparency = true,
	--            },
	--            highlight_groups = {
	--                ["@string.documentation"] = { fg = "subtle" }
	--            }
	--        })
	--        vim.cmd.colorscheme "rose-pine"
	-- end

    "vague2k/vague.nvim",
    config = function ()
        require("vague").setup({
            transparent = true,
            on_highlights = function (highlights, groups)
                local transparency_highlights = {
                    FloatBorder = { bg = "NONE" },
                    FloatTitle = { bg = "NONE" },
                    Folded = { bg = "NONE" },
                    NormalFloat = { bg = "NONE" },
                    Normal = { bg = "NONE" },
                    NormalNC = { bg = "NONE" },
                    Pmenu = { bg = "NONE" },
                    PmenuKind = { bg = "NONE" },
                    SignColumn = { bg = "NONE" },
                    StatusLine = { bg = "NONE" },
                    StatusLineNC = { bg = "NONE" },
                    TabLine = { bg = "NONE" },
                    TabLineFill = { bg = "NONE" },
                    TabLineSel = { bg = "NONE" },
                    WhichKeyFloat = { bg = "NONE" },
                    WhichKeyNormal = { bg = "NONE" },
                    TreesitterContext = { bg = "NONE" },
                    TreesitterContextLineNumber = { bg = "NONE" },

                    BlinkCmpGhostText = { bg = "NONE" },  -- ghost text in completion
                    BlinkCmpLabel = { bg = "NONE" }, -- label for completion items
                    BlinkCmpLabelDeprecated = { bg = "NONE" },  -- deprecated label in completion
                    BlinkCmpLabelMatch = { bg = "NONE" }, -- matched label in completion items
                    BlinkCmpMenu = { bg = "NONE" }, -- menu for completion items
                    BlinkCmpKind = { bg = "NONE" }
                }
                for group, highlight in pairs(transparency_highlights) do
                    highlights[group] = highlight
                end
            end
        })
        vim.cmd.colorscheme "vague"
    end

}
