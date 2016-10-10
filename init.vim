" Plugin Setups
call plug#begin('~/.vim/plugged')
" ------------Pluggins Below ---------
Plug 'https://github.com/tpope/vim-commentary.git'
Plug 'https://github.com/tpope/vim-surround.git'
Plug 'https://github.com/scrooloose/syntastic.git'
Plug 'https://github.com/tpope/vim-fugitive.git'
" ------------Pluggins Above ---------
call plug#end()
" Basic setups 
set tabstop=4                   " An indentation every four columns
set softtabstop=4               " Let backspace delete indent
set shiftwidth=4
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set textwidth=80
set autoindent                  " Indent at the same level of the previous line
set ruler                   " Show the ruler
set showcmd
if filereadable("cscope.out")
	cscope add cscope.out
	set cscopetag				"make cscope as default tag
endif

" Enable syntax
syntax enable
filetype plugin on
" colorscheme desert

" Set path for recursive file searching
set path+=**

" Automatically write a file when leaving a modified buffer
set autowrite

" Since ^^^^ I save files constantly F**ck swp files
set noswapfile

" function! ClipboardYank()
"   call system('xclip -i -selection clipboard', @@)
" endfunction
" function! ClipboardPaste()
"   let @@ = system('xclip -o -selection clipboard')
" endfunction
" vnoremap <silent> y +:call ClipboardYank()<cr>

" Display the current mode
set showmode
" Highlight current line
set cursorline
" Highlight search terms
set hlsearch
" Show Invisible charcters
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set list
noremap <Leader>i :set list!<CR> " Toggle invisible chars

" toggle visual numbers
function! NumberToggle()
  if(&relativenumber == 1)
	set norelativenumber
	set nonumber
  else
	set relativenumber
	set number
  endif
endfunc

nnoremap <leader>nt :call NumberToggle()<CR>
" let mapleader="\ "
map <\> <leader>
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
