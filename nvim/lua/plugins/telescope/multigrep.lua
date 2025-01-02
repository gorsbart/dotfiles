local pickers = require("telescope.pickers")
local conf = require("telescope.config").values
local make_entry = require("telescope.make_entry")
local finders = require("telescope.finders")
local M = {}
local live_multigrep = function (opts)
  opts = opts or {}
  opts.cwd = opts.cwd or vim.uv.cwd()
  local finder = finders.new_async_job {
    command_generator = function (prompt)
      if not prompt or prompt == "" then
        return nil
      end
      local piecies = vim.split(prompt, "  ")
      local args = { "rg" }
      if piecies[1] then
        table.insert(args, "-e")
        table.insert(args, piecies[1])
      end

      if piecies[2] then
        table.insert(args, "-g")
        table.insert(args, piecies[2])
      end

      return vim.tbl_flatten {
        args,
        { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" },
      }
    end,
    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = opts.cwd,
  }
  pickers.new(opts, {
    debounce = 100,
    prompt_title = "Multi Grep",
    finder = finder,
    previewser = conf.grep_previewer(opts),
    sorter = require("telescope.sorters").empty(),
  }):find()
end

M.setup = function ()
    vim.keymap.set('n', '<leader>si', function ()
      live_multigrep()
    end, { desc = '[S]earch [I]n files'})
end

M.live_multigrep = function (opts)
  live_multigrep(opts)
end

return M
