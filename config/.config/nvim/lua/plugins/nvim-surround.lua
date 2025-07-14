return {
    "kylechui/nvim-surround",
    version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
          keymaps = {
            insert = "<C-z>",
            insert_line = "<CS-z>",
            normal = "yz",
            normal_cur = "yzz",
            normal_line = "yZ",
            normal_cur_line = "yZZ",
            visual = "Z",
            visual_line = "gZ",
            delete = "dz",
            change = "cz",
            change_line = "cZ",
          },
          move_cursor = "sticky",
        })
    end
}
