if exists('g:loaded_encode_selector') | finish | endif
let g:loaded_encode_selector = 1

lua << EOF
local ok, encode = pcall(require, 'file-encode-selector')
if not ok then
  vim.notify("Failed to load file-encode-selector: " .. encode, vim.log.levels.ERROR)
  return
end

-- create plugin command
vim.api.nvim_create_user_command('FileEncodeReload', encode.show_reload_select_menu, {})
vim.api.nvim_create_user_command('FileEncodeSave', encode.show_save_select_menu, {})
EOF
