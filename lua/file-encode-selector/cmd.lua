local config = require("file-encode-selector.config")

local M = {
	mode = {
		RELOAD = "RELOAD",
		SAVE = "SAVE",
	},
}

function M:init(opts)
	M.config = config:merge_options(opts)
end

function M:load_cmd()
	local ok, m_telescope = pcall(require, "telescope")
	if ok then
		m_telescope.load_extension("file-encode-selector")
	end

	vim.api.nvim_create_user_command("FileEncodeReload", function()
		M.show_select_menu("Reopen with encoding", M.mode.RELOAD)
	end, {})
	vim.api.nvim_create_user_command("FileEncodeSave", function()
		M.show_select_menu("Save with encoding", M.mode.SAVE)
	end, {})
end

--- Reload file with selected encoding
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

	if M.config.notification then
		vim.notify("[file-encodde-selector] Reload file with encoding: " .. encoding, vim.log.levels.INFO)
	end
end

--- Save file with selected encoding
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

	if M.config.notification then
		vim.notify("[file-encodde-selector] Save file with encoding: " .. encoding, vim.log.levels.INFO)
	end
end

--- Show encoding select menu
--- @param title string menu title
--- @param mode string file operate mode
function M.show_select_menu(title, mode)
	vim.ui.select(M.config.encodings, {
		prompt = title .. ": ",
		format_item = function(item)
			return string.format("%-12s", item)
		end,
	}, function(choice)
		if choice then
			if mode == M.mode.RELOAD then
				M.reload_file_with_encoding(choice)
			elseif mode == M.mode.SAVE then
				M.set_file_encoding(choice)
			end
		end
	end)
end

return M
