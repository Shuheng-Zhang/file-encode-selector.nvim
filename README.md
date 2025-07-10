# file-encode-selector.nvim

File encoding selector plugin for neovim

## Installation

Install by using `lazy`:

```lua
return {
  "Shuheng-Zhang/file-encode-selector.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  lazy = true, -- (Default)lazy load, triggered when keys are pressed
  opts = {},
  keys = { -- set keymapings
	{ "<leader>fe", "<cmd>FileEncodeReload<cr>", desc = "Select encoding to reload file" },
	{ "<leader>fE", "<cmd>FileEncodeSave<cr>", desc = "Select encoding to save file" },
  },
}
```

## Default Configuration

Here is the default plugin Configuration, no need to copy that to you own plugin configuration.

```lua

{
  encodings = { -- default enabled file encodings
	"utf-8",
	"iso-8859-1",
	"gb2312",
	"gbk",
	"gb18030",
	"big5",
	"euc-jp",
    "shift_jis",
  },
  notification = true, -- toggle operated result via notification
}


```

## Usage

After the plugin loaded, use these commands below:

`:FileEncodeReload` - Reload current buffer(file) with selected file encoding

`:FileEncodeSave` - Save current buffer(file) with selected file encoding
