return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.8',
  -- branch = 'master',
	dependencies = { 'nvim-lua/plenary.nvim', 'nvim-treesitter/nvim-treesitter' },
	config = function ()

		-- telescope

		local builtin = require('telescope.builtin')
    require('telescope').setup {
      defaults = {
        -- layout_strategy = 'center';
        layout_strategy = 'vertical';
        layout_config = {
          width = 0.9,
          height = 0.97,
          preview_height = 0.7,
          -- height = 0.3,
          -- mirror = true,
          -- anchor = 'N',
        },
      },
      pickers = {
        find_files = {
          mappings = {
            i = {
              ["C-s"] =  function (prompt_bufnr)
                print("This function ran after another action. Prompt_bufnr: " .. prompt_bufnr)
                builtin.live_grep({ cwd = prompt_bufnr })
              end
            }
          },
        }
      }
    }

		vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch for [F]iles'})
		vim.keymap.set('n', '<leader>s"', builtin.registers, { desc = '[S]earch for Registers'})
		vim.keymap.set('n', '<leader>sg', builtin.git_files, { desc = '[S]earch for [G]it files'})
    vim.keymap.set('n', '<leader>si', builtin.live_grep, { desc = '[S]earch [I]n files'})
    vim.keymap.set('v', '<leader>si', builtin.grep_string, { desc = '[S]earch selection [I]n files'})
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps'})
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Search opened buffers'})
    vim.keymap.set('n', '<leader>sm', builtin.marks, { desc = '[S]earch [M]arks'})
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp'})

    vim.keymap.set('n', '<leader>sgb', builtin.git_branches, { desc = '[S]earch [G]it [B]ranches'})
    vim.keymap.set('n', '<leader>sgc', builtin.git_commits, { desc = '[S]earch [G]it [C]ommits'})
    vim.keymap.set('n', '<leader>sgh', builtin.git_bcommits, { desc = '[S]earch [G]it [H]istory of file'})


    vim.keymap.set('n', '<leader>sd', function ()
      builtin.find_files({
        find_command = { "fd", "--type", "directory", "--hidden", "--exclude", ".git/*" },
    })    end, {desc = "[S]earch [D]irectories"} )

    -- Currently not working as expected
    -- vim.keymap.set('v', '<leader>sgh', builtin.git_bcommits_range, { desc = '[S]earch [G]it [H]istory of highlighted part'})
	end


}
