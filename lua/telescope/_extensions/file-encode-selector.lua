return require("telescope").register_extension({
	exports = {
		file_encode_selector = require("file-encode-selector.telescope"),
	},
})
