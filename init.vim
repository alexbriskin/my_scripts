" Plug-in Setups
call plug#begin('~/.vim/plugged')
" ------------Plug-ins Below ---------
Plug 'https://github.com/tpope/vim-commentary.git'
Plug 'https://github.com/tpope/vim-surround.git'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/vim-airline/vim-airline.git'
" ------------Plug-ins Above ---------
call plug#end()

" Basic setups 
set tabstop=4					" An indentation every four columns
set softtabstop=4				" Let backspace delete indent
set shiftwidth=4
set ignorecase					" Case insensitive search
set smartcase					" Case sensitive when uc present
set textwidth=0
set wrapmargin=0
set nowrap						" No wrap at the end of the line
set autoindent					" Indent at the same level of the previous line
set ruler						" Show the ruler
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

" search visual selection
vnoremap // y/<C-R>"<CR>

" Terminal mode
tnoremap <Esc> <C-\><C-n>

" jj to escape insert mode
inoremap jj <esc>

nnoremap Y y$<CR>

" Remap some movements to be in cemter of the screen
nnoremap {{ {{zz
nnoremap }} }}zz
nnoremap [[ [[zz
nnoremap ]] ]]zz
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz
nnoremap j jzz
nnoremap k kzz
nnoremap <Leader>[ ?{<CR>:noh<CR>
nnoremap <Leader>] /}<CR>:noh<CR>
nnoremap <C-D> <C-D>zz
nnoremap <C-U> <C-U>zz

" Vim airline specific configurations
if !empty(glob("/home/developer/.vim/plugged/vim-airline/"))
	let g:airline_left_sep = '▶'
	let g:airline_right_sep = '◀'
	let g:airline_whitespace_disabled = 1
	" let g:airline_section_y="%{strlen(&fenc)>0?&fenc:''}%{strlen(&ff)>0?'['.&ff.']':''}%{airline#extensions#whitespace#check()}"
	let g:airline_section_warning=""
endif
