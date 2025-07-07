if exists('g:loaded_encode_selector') | finish | endif
let g:loaded_encode_selector = 1

lua << EOF
local encode = require('file-encode-selector')
-- create plugin command
vim.api.nvim_create_user_command('FileEncodeSelect', encode.show_menu, {})
EOF

" Set default key mapping
nnoremap <silent> <leader>fe :FileEncodeSelect<CR>
