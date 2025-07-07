local M = {}

--- Supported file encodings
M.encodings = {
	"utf-8",
	"utf-16le",
	"utf-16be",
	"latin1",
	"iso-8859-1",
	"gb2312",
	"gbk",
	"gb18030",
	"big5",
	"cp936",
	"euc-jp",
	"shift_jis",
	"cp932",
}

local defaults = {
	encodings = M.encodings,
}

M.config = {}

function M.setup(options)
	M.config = vim.tbl_deep_extend("force", defaults, options or {})
end

--- reload file with selected encoding
--- @param encoding string supported encoding that selected
function M.reload_file_with_encoding(encoding)
	if not encoding or encoding == "" then
		vim.notify("[file-encodde-selector] No encoding selected", vim.log.levels.ERROR)
		return
	end

	local buf = vim.api.nvim_get_current_buf()
	local modified = vim.api.nvim_get_option_value("modified", { buf = buf })

	-- save current view state
	local view = vim.fn.winsaveview()

	-- set encoding
	vim.cmd("e! ++enc=" .. encoding)

	-- restore view state
	vim.fn.winrestview(view)

	-- restore buffer modifiy state
	vim.api.nvim_set_option_value("modified", modified, { buf = buf })

	vim.notify("[file-encodde-selector] Reload file with encoding: " .. encoding, vim.log.levels.INFO)
end

--- save file with selected encoding
--- @param encoding string supported encoding that selected
function M.set_file_encoding(encoding)
	if not encoding or encoding == "" then
		vim.notify("[file-encodde-selector] No encoding selected", vim.log.levels.ERROR)
		return
	end

	local buf = vim.api.nvim_get_current_buf()
	local modified = vim.api.nvim_get_option_value("modified", { buf = buf })

	-- save current view state
	local view = vim.fn.winsaveview()

	vim.cmd("set fileencoding=" .. encoding)
	vim.cmd("w")

	-- restore view state
	vim.fn.winrestview(view)

	-- restore buffer modifiy state
	vim.api.nvim_set_option_value("modified", modified, { buf = buf })

	vim.notify("[file-encodde-selector] Save file with encoding: " .. encoding, vim.log.levels.INFO)
end

function M.show_reload_select_menu()
	vim.ui.select(defaults.encodings, {
		prompt = "Select file encoding: ",
		format_item = function(item)
			return string.format("%-12s", item)
		end,
	}, function(choice)
		if choice then
			M.reload_file_with_encoding(choice)
		end
	end)
end

function M.show_save_select_menu()
	vim.ui.select(defaults.encodings, {
		prompt = "Select file encoding:",
		format_item = function(item)
			return string.format("%-12s", item)
		end,
	}, function(choice)
		if choice then
			M.set_file_encoding(choice)
		end
	end)
end

return M
