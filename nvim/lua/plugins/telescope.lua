return {
	'nvim-telescope/telescope.nvim', 
	tag = '0.1.8', 
	dependencies = { 'nvim-lua/plenary.nvim', 'nvim-treesitter/nvim-treesitter' },
	config = function () 

		-- telescope

		local builtin = require('telescope.builtin')

		vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch for [F]iles'})
		vim.keymap.set('n', '<leader>sg', builtin.git_files, { desc = '[S]earch for [G]it files'})
    vim.keymap.set('n', '<leader>si', builtin.live_grep, { desc = '[S]earch [I]n files'})
    vim.keymap.set('v', '<leader>si', builtin.grep_string, { desc = '[S]earch selection [I]n files'})
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps'})
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Search opened buffers'})
		vim.keymap.set('n', '<leader>gg', function ()
			builtin.grep_string({ search = vim.fn.input("Grep > ") });
		end)
    vim.keymap.set('n', '<leader>sm', builtin.marks, { desc = '[S]earch [M]arks'})
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp'})

    vim.keymap.set('n', '<leader>st', function ()
      builtin.find_files({ cwd = "~/Downloads" })
    end, {desc = "Search Test"})

	end



}
