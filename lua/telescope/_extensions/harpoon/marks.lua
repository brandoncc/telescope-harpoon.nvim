local has_harpoon, harpoon = pcall(require, 'harpoon')
if not has_harpoon then
  error('This plugin requires ThePrimeagen/harpoon')
end

local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local previewers = require('telescope.previewers')
local sorters = require('telescope.sorters')
local harpoon_mark = require('harpoon.mark')

local default_options = {
  results_title = 'Harpoon Marks',
  sorter = sorters.get_fuzzy_file(),
  previewer = previewers.vim_buffer_cat.new {}
}

local function mark_is_empty(mark)
  return mark.filename == "(empty)" or mark.filename == ""
end

return function(opts)
  opts = opts or {}

  local config = harpoon.get_mark_config()
  local file_list = config.marks
  local items = {}

  for idx = 1, #file_list do
    local mark = harpoon_mark.get_marked_file(idx)
    if mark and not mark_is_empty(mark) then
      table.insert(
        items,
        string.format("%s:%d:%d", mark.filename, mark.row, mark.col)
      )
    end
  end

  opts.finder = finders.new_table(items)
  pickers.new(opts, default_options):find()
end
