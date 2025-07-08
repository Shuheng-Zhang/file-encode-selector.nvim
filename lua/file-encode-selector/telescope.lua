local encode_selector = require("file-encode-selector")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

return function(opts)
	opts = opts or {}
	pickers
		.new(opts, {
			prompt_title = "Reopen with encoding",
			finder = finders.new_table({
				results = encode_selector.encodings,
				entry_maker = function(entry)
					return {
						value = entry,
						display = entry,
						ordinal = entry,
					}
				end,
			}),
			sorter = conf.generic_sorter(opts),
			attach_mappings = function(prompt_bufnr)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()
					encode_selector.reload_file_with_encoding(selection.value)
				end)
				return true
			end,
		})
		:find()

	pickers
		.new(opts, {
			prompt_title = "Save with encoding",
			finder = finders.new_table({
				results = encode_selector.encodings,
				entry_maker = function(entry)
					return {
						value = entry,
						display = entry,
						ordinal = entry,
					}
				end,
			}),
			sorter = conf.generic_sorter(opts),
			attach_mappings = function(prompt_bufnr)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()
					encode_selector.set_file_encoding(selection.value)
				end)
				return true
			end,
		})
		:find()
end
