set nu
syntax on
set ts=4
set shiftwidth=4
set ff=unix
set viminfo='1000,<500
" set expandtab
" set autoindent

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

set tags+=~/.vim/tags.dvf9918.kernel
set tags+=~/.vim/tags.dvf9918.usr
set tags+=~/.vim/tags.osip
set tags+=~/.vim/tags.exosip
set tags+=~/.vim/tags.actress
