return require("telescope").register_extension({
	setup = function(ext_config, telescope_config) end,
	exports = {
		file_encode_selector = require("file-encode-selector.telescope"),
	},
})
