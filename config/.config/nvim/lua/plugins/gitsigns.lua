return {
  "lewis6991/gitsigns.nvim",
  tag = "v1.0.2",
  config = function ()
      require('gitsigns').setup{
        on_attach = function(bufnr)
          local gitsigns = require('gitsigns')

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then
              vim.cmd.normal({']c', bang = true})
            else
              gitsigns.nav_hunk('next')
            end
          end)

          map('n', '[c', function()
            if vim.wo.diff then
              vim.cmd.normal({'[c', bang = true})
            else
              gitsigns.nav_hunk('prev')
            end
          end)

          -- Actions

          map('n', '<leader>hs', gitsigns.stage_hunk, { desc = "Git change [H]unk [S]tage" })
          map('n', '<leader>hr', gitsigns.reset_hunk, { desc = "Git change [H]unk [R]eset" })
          map('v', '<leader>hs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = "Git change [H]unk [S]tage" })
          map('v', '<leader>hr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = "Git change [H]unk [R]eset" })
          map('n', '<leader>hS', gitsigns.stage_buffer, { desc = "Git change all [H]unks in the [B]uffer" })
          map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = "Git change [H]unk stage [U]ndo" })
          map('n', '<leader>hR', gitsigns.reset_buffer, { desc = "Git change [R]eset all [H]unks in buffer" })
          map('n', '<leader>hp', gitsigns.preview_hunk, { desc = "Git change [H]unk [P]review" })
          map('n', '<leader>hb', function() gitsigns.blame_line{full=true} end, { desc = "Git change [B]lame and see changes" })
          map('n', '<leader>hB', function() gitsigns.blame() end, { desc = "Git change [H]unk full [B]lame" })
          map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = "Git change [T]oggle [B]lame" })
          map('n', '<leader>hd', gitsigns.diffthis, { desc = "Git change [H]unk [D]iff" })
          map('n', '<leader>hD', function() gitsigns.diffthis('~') end, { desc = "Git change [H]unk all [D]iff" })
          map('n', '<leader>td', gitsigns.toggle_deleted, { desc = "Git change [T]oggle [D]eleted" })

          -- Text object
          map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end
      }
  end
}
