local has_harpoon, harpoon = pcall(require, 'harpoon')
if not has_harpoon then
  error('This plugin requires ThePrimeagen/harpoon')
end

local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local previewers = require('telescope.previewers')
local sorters = require('telescope.sorters')

local default_options = {
  results_title = 'Harpoon Marks',
  sorter = sorters.get_fuzzy_file(),
  previewer = previewers.vim_buffer_cat.new {}
}

return function(opts)
  opts = opts or {}
  opts.finder = finders.new_table(harpoon.get_mark_config().marks)

  pickers.new(opts, default_options):find()
end
