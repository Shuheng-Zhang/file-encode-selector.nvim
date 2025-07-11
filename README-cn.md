# file-encode-selector.nvim

为 `Neovim` 开发的文件编码配置选择器

## 安装

使用 `lazy` 安装:

```lua
return {
  "Shuheng-Zhang/file-encode-selector.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  lazy = true, -- (默认选项) 当配置了下面的按键映射后, 只有使用按键触发后才会加载插件
  opts = {},
  keys = { -- 配置按键映射
	{ "<leader>fe", "<cmd>FileEncodeReload<cr>", desc = "Select encoding to reload file" },
	{ "<leader>fE", "<cmd>FileEncodeSave<cr>", desc = "Select encoding to save file" },
  },
}
```

## 默认配置

以下内容是插件的默认配置, 使用者无需复制到配置文件

```lua

{
  encodings = { -- 默认启用的文件编码
	"utf-8",
	"iso-8859-1",
	"gb2312",
	"gbk",
	"gb18030",
	"big5",
	"euc-jp",
    "shift_jis",
  },
  notification = true, -- 是否显示操作结果通知
}


```

## 使用方法

插件加载后, 在 `命令模式(Command Mode)` 下可使用以下指令:

`:FileEncodeReload` - 使用选定的文件编码重新加载文件

`:FileEncodeSave` - 使用选定的文件编码保存文件
