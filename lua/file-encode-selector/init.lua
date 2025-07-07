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
	keymap = "<leader>fe",
}

M.config = {}

function M.setup(options)
	M.config = vim.tbl_deep_extend("force", defaults, options or {})
end

--- Set file encoding with selected
--- @param encoding string supported encoding that selected
function M.set_encoding(encoding)
	if not encoding or encoding == "" then
		vim.notify("[file-encodde-selector] No encoding selected", vim.log.levels.ERROR)
		return
	end

	local buf = vim.api.nvim_get_current_buf()
	-- get current buffer modifiy state
	local modified = vim.api.nvim_get_option_value("modified", { buf = buf })

	-- save current view state
	local view = vim.fn.winsaveview()

	-- set encoding
	vim.cmd("set encoding=" .. encoding)
	vim.cmd("e! ++enc=" .. encoding)
	-- vim.cmd("set fileencoding=" .. encoding)

	-- restore view state
	vim.fn.winrestview(view)

	-- restore buffer modifiy state
	vim.api.nvim_set_option_value("modified", modified, { buf = buf })

	-- print("[file-encodde-selector] Set encoding to " .. encoding)
	vim.notify("[file-encodde-selector] Set encoding to: " .. encoding, vim.log.levels.INFO)
end

--- Show select menu for selecting file encoding
function M.show_select_menu()
	vim.ui.select(M.encodings, {
		prompt = "Select file encoding: ",
		format_item = function(item)
			return string.format("%-12s", item)
		end,
	}, function(choice)
		if choice then
			vim.notify("[file-encodde-selector] selected encoding: " .. choice)
			M.set_encoding(choice)
		end
	end)
end

return M
