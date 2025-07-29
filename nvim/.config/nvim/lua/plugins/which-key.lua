return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        preset = "helix",
        spec = {
            {
                mode = { "n", "v" },
                { "<leader>f", group = "File/Find"  },
                { "<leader>b", group = "Buffer"     },
                { "<leader>s", group = "Search"     },
                { "<leader>d", group = "Diagnostics"},
                { "<leader>g", group = "Git"        },
                { "<leader>gh", group = "Git Hunk"  }
            },
        },
    },
}
