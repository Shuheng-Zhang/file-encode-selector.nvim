# file-encode-selector.nvim

File encoding selector plugin for neovim

## Installation

Install by using `lazy`:

```lua
return {
	"Shuheng-Zhang/file-encode-selector.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
	opts = {},
	keys = { -- set keymapings
		{ "<leader>fe", "<cmd>FileEncodeReload<cr>", desc = "Select encoding to reload file" },
		{ "<leader>fE", "<cmd>FileEncodeSave<cr>", desc = "Select encoding to save file" },
	},
}
```

## Usage

After the plugin installed, use these commands below:

`:FileEncodeReload` - Reload current buffer(file) with selected file encoding

`:FileEncodeSave` - Save current buffer(file) with selected file encoding
