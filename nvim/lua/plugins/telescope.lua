return {
	'nvim-telescope/telescope.nvim', 
	tag = '0.1.8', 
	dependencies = { 'nvim-lua/plenary.nvim', 'nvim-treesitter/nvim-treesitter' },
	config = function () 

		-- telescope

		local builtin = require('telescope.builtin')

		vim.keymap.set('n', '<C-j>', builtin.find_files, {})
		vim.keymap.set('n', '<C-k>', builtin.git_files, {})
        vim.keymap.set('n', '<C-h>', builtin.live_grep, {})
		vim.keymap.set('n', '<leader>gg', function ()
			builtin.grep_string({ search = vim.fn.input("Grep > ") });
		end)
		vim.keymap.set('n', '<C-l>', builtin.marks, {})
	end


}
