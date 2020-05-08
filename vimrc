" vimrc
" ~/.vimrc

" syntax highlighting
syntax enable

" colorscheme
colorscheme nord

" no background; for terminal transparency
hi Normal guibg=NONE ctermbg=NONE

" set relative number lines
set number relativenumber

" set spell check to English
map <F5> :setlocal spell! spelllang=en_gb<CR>
