local M = {
	default = {
		encodings = {
			"utf-8",
			"iso-8859-1",
			"gb2312",
			"gbk",
			"gb18030",
			"big5",
			"euc-jp",
			"shift_jis",
		},
		notification = true,
	},
}

function M:merge_options(opts)
	if type(opts) == "table" and opts ~= {} then
		self.default = vim.tbl_deep_extend("force", self.default, opts)
	end

	return self.default
end

return M
