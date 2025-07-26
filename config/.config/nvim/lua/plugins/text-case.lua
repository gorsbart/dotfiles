return {
  "gorsbart/text-case.nvim",
  lazy = false,
  config = function()
    require("textcase").setup({})
    vim.keymap.set("n", "co_",function() require('textcase').current_word('to_snake_case') end, { desc = "[C][O]erce to snake_case" })
    vim.keymap.set("n", "co-",function() require('textcase').current_word('to_dash_case') end, { desc = "[C][O]erce to dash-case" })
    vim.keymap.set("n", "con",function() require('textcase').current_word('to_constant_case') end, { desc = "[C][O]erce to CONSTANT_CASE" })
    vim.keymap.set("n", "co.",function() require('textcase').current_word('to_dot_case') end, { desc = "[C][O]erce to dot.case" })
    vim.keymap.set("n", "co,",function() require('textcase').current_word('to_comma_case') end, { desc = "[C][O]erce to comma,case" })
    vim.keymap.set("n", "cos",function() require('textcase').current_word('to_phrase_case') end, { desc = "[C][O]erce to Sentence case" })
    vim.keymap.set("n", "coc",function() require('textcase').current_word('to_camel_case') end, { desc = "[C][O]erce to camelCase" })
    vim.keymap.set("n", "cop",function() require('textcase').current_word('to_pascal_case') end, { desc = "[C][O]erce to PascalCase" })
    vim.keymap.set("n", "cot",function() require('textcase').current_word('to_title_case') end, { desc = "[C][O]erce to Title Case" })
    vim.keymap.set("n", "cof",function() require('textcase').current_word('to_path_case') end, { desc = "[C][O]erce to path/case" })

    vim.keymap.set("v", "co_",function() require('textcase').operator('to_snake_case') end, { desc = "[C][O]erce to snake_case" })
    vim.keymap.set("v", "co-",function() require('textcase').operator('to_dash_case') end, { desc = "[C][O]erce to dash-case" })
    vim.keymap.set("v", "con",function() require('textcase').operator('to_constant_case') end, { desc = "[C][O]erce to CONSTANT_CASE" })
    vim.keymap.set("v", "co.",function() require('textcase').operator('to_dot_case') end, { desc = "[C][O]erce to dot.case" })
    vim.keymap.set("v", "co,",function() require('textcase').operator('to_comma_case') end, { desc = "[C][O]erce to comma,case" })
    vim.keymap.set("v", "cos",function() require('textcase').operator('to_phrase_case') end, { desc = "[C][O]erce to Sentence case" })
    vim.keymap.set("v", "coc",function() require('textcase').operator('to_camel_case') end, { desc = "[C][O]erce to camelCase" })
    vim.keymap.set("v", "cop",function() require('textcase').operator('to_pascal_case') end, { desc = "[C][O]erce to PascalCase" })
    vim.keymap.set("v", "cot",function() require('textcase').operator('to_title_case') end, { desc = "[C][O]erce to Title Case" })
    vim.keymap.set("v", "cof",function() require('textcase').operator('to_path_case') end, { desc = "[C][O]erce to path/case" })

  end,
}
