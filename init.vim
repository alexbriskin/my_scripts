" Plug-in Setups
call plug#begin('~/.vim/plugged')
" ------------Plug-ins Below ---------
Plug 'https://github.com/tpope/vim-commentary.git'
Plug 'https://github.com/tpope/vim-surround.git'
Plug 'https://github.com/scrooloose/syntastic.git'
Plug 'https://github.com/tpope/vim-fugitive.git'
" ------------Plug-ins Above ---------
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
colorscheme elflord
filetype plugin on

" Set path for recursive file searching
set path+=**

" Automatically write a file when leaving a modified buffer
set autowrite

" Since ^^^^ I save files constantly F**ck swp files
set noswapfile

" Display the current mode
set showmode
" Highlight current line
set cursorline
" Highlight search terms
set hlsearch

" Show Invisible characters
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set list
noremap <Leader>i :set list!<CR> " Toggle invisible chars
noremap <Leader>rc :edit ~/.config/nvim/init.vim<CR> " Toggle invisible chars

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

" Leader set to SPACE
map <space> <leader>

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" jump to rc file
nnoremap <leader> rc :edit $MYVIMRC

" search visual selection
vnoremap // y/<C-R>"<CR>

" Terminal mode
tnoremap <Esc> <C-\><C-n>

" jj to escape insert mode
inoremap jj <esc>
