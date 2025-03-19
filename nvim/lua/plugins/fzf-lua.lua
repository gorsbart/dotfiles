return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  -- dependencies = { "echasnovski/mini.icons" },
	config = function ()


		local fzf_lua = require('fzf-lua')
    fzf_lua.setup({
      previewers = {
        builtin = {
          extensions = {
            -- neovim terminal only supports `viu` block output
            ["png"] = { "chafa", "-f", "symbols" }, --TODO improve it as there is a snack for that https://github.com/folke/snacks.nvim/blob/main/docs/image.md
            ["jpg"] = { "chafa", "-f", "symbols" },
          }
        }
      },
    })

		vim.keymap.set('n', '<leader>sf', fzf_lua.files, { desc = '[S]earch for [F]iles'})
		vim.keymap.set('n', '<leader>s"', fzf_lua.registers, { desc = '[S]earch for Registers'})
		vim.keymap.set('n', '<leader>sg', fzf_lua.git_files, { desc = '[S]earch for [G]it files'})
    vim.keymap.set('n', '<leader>si', fzf_lua.live_grep_native, { desc = '[S]earch [I]n files'})
    vim.keymap.set('v', '<leader>si', fzf_lua.live_grep_native, { desc = '[S]earch selection [I]n files'})
    vim.keymap.set('n', '<leader>sk', fzf_lua.keymaps, { desc = '[S]earch [K]eymaps'})
    vim.keymap.set('n', '<leader>sr', fzf_lua.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader><leader>', fzf_lua.buffers, { desc = 'Search opened buffers'})
    vim.keymap.set('n', '<leader>sm', fzf_lua.marks, { desc = '[S]earch [M]arks'})
    vim.keymap.set('n', '<leader>sh', fzf_lua.helptags, { desc = '[S]earch [H]elp'})
    vim.keymap.set('n', '<leader>s.', fzf_lua.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)'})
    vim.keymap.set('n', '<leader>sw', fzf_lua.grep_cword, { desc = '[S]earch current [W]ord'})
    vim.keymap.set('n', '<leader>sW', fzf_lua.grep_cWORD, { desc = '[S]earch current [W]ORD'})
    vim.keymap.set('n', '<leader>sdd', fzf_lua.diagnostics_document, { desc = '[S]earch [D]iagnostics in document' })
    vim.keymap.set('n', '<leader>sdw', fzf_lua.diagnostics_workspace, { desc = '[S]earch [D]iagnostics in workspace' })

    vim.keymap.set('n', '<leader>sgb', fzf_lua.git_branches, { desc = '[S]earch [G]it [B]ranches'})
    vim.keymap.set('n', '<leader>sgc', fzf_lua.git_commits, { desc = '[S]earch [G]it [C]ommits'})
    vim.keymap.set('n', '<leader>sgh', fzf_lua.git_bcommits, { desc = '[S]earch [G]it [H]istory of file'})


    vim.keymap.set('n', '<leader>sD', fzf_lua.files, {desc = "[S]earch [D]irectories"} )

    vim.keymap.set('n', '<leader>/', fzf_lua.lgrep_curbuf, { desc = '[/] Fuzzily search in current buffer' })


    -- Currently not working as expected
    -- vim.keymap.set('v', '<leader>sgh', fzf_lua.git_bcommits_range, { desc = '[S]earch [G]it [H]istory of highlighted part'})
	end
}
