local M = {}
local cmd = require("file-encode-selector.cmd")

function M.setup(opts)
	cmd:init(opts)
	cmd:load_cmd()
end

return M
