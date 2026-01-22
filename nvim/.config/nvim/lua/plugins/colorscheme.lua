-- for highlight groups and transparency:
-- https://github.com/rose-pine/neovim/blob/main/lua/rose-pine.lua
-- for palette:
-- https://rosepinetheme.com/palette/ingredients/
-- useful command:
-- :TSHighlightCapturesUnderCursor

return {

	"rose-pine/neovim",
	name = "rose-pine",
	config = function ()
	       require("rose-pine").setup({
	           variant = "auto",
	           enable = {
	               terminal = true
	           },
	           styles = {
	               bold = true,
	               italic = true,
	               transparency = true,
	           },
	           highlight_groups = {
	               ["@string.documentation"] = { fg = "subtle" }
	           }
	       })
	       vim.cmd.colorscheme "rose-pine"
	end

    -- "vague2k/vague.nvim",
    -- config = function ()
    --     require("vague").setup({
    --         transparent = true,
    --         on_highlights = function (highlights, groups)
    --             local transparency_highlights = {
    --                 FloatBorder = { bg = "NONE" },
    --                 FloatTitle = { bg = "NONE" },
    --                 Folded = { bg = "NONE" },
    --                 NormalFloat = { bg = "NONE" },
    --                 Normal = { bg = "NONE" },
    --                 NormalNC = { bg = "NONE" },
    --                 Pmenu = { bg = "NONE" },
    --                 PmenuKind = { bg = "NONE" },
    --                 SignColumn = { bg = "NONE" },
    --                 StatusLine = { bg = "NONE" },
    --                 StatusLineNC = { bg = "NONE" },
    --                 TabLine = { bg = "NONE" },
    --                 TabLineFill = { bg = "NONE" },
    --                 TabLineSel = { bg = "NONE" },
    --                 WhichKeyFloat = { bg = "NONE" },
    --                 WhichKeyNormal = { bg = "NONE" },
    --                 TreesitterContext = { bg = "NONE" },
    --                 TreesitterContextLineNumber = { bg = "NONE" },
    --                 BlinkCmpGhostText = { bg = "NONE" },  -- ghost text in completion
    --                 BlinkCmpLabel = { bg = "NONE" }, -- label for completion items
    --                 BlinkCmpLabelDeprecated = { bg = "NONE" },  -- deprecated label in completion
    --                 BlinkCmpLabelMatch = { bg = "NONE" }, -- matched label in completion items
    --                 BlinkCmpMenu = { bg = "NONE" }, -- menu for completion items
    --                 BlinkCmpKind = { bg = "NONE" }
    --             }
    --             for group, highlight in pairs(transparency_highlights) do
    --                 highlights[group] = highlight
    --             end
    --         end
    --     })
    --     vim.cmd.colorscheme "vague"
    -- end

    -- "catppuccin/nvim",
    -- name = "catppuccin",
    -- priority = 1000,
    -- config = function ()
    --    require("catppuccin").setup({
    --         flavour = "auto", -- latte, frappe, macchiato, mocha
    --         transparent_background = true, -- disables setting the background color.
    --         float = {
    --             transparent = true, -- enable transparent floating windows
    --             solid = false, -- use solid styling for floating windows, see |winborder|
    --         },
    --         show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
    --         term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
    --         dim_inactive = {
    --             enabled = false, -- dims the background color of inactive window
    --             shade = "dark",
    --             percentage = 0.15, -- percentage of the shade to apply to the inactive window
    --         },
    --         styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
    --             comments = { "italic" }, -- Change the style of comments
    --             conditionals = { "italic" },
    --         },
    --         default_integrations = true,
    --         auto_integrations = true,
    --         integrations = {
    --             gitsigns = true,
    --             nvimtree = true,
    --             treesitter = true,
    --         },
    --     })
    --     -- setup must be called before loading
    --     vim.cmd.colorscheme "catppuccin"
    -- end

}
