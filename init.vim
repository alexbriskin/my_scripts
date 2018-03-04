" Plug-in Setups
if filereadable(glob('~/.config/nvim/autoload/plug.vim'))
	call plug#begin('~/.config/nvim/plugged')
	" ------------Plug-ins Below ---------
	Plug 'https://github.com/tpope/vim-commentary.git'
	Plug 'https://github.com/tpope/vim-surround.git'
	Plug 'https://github.com/tpope/vim-fugitive.git'
	Plug 'https://github.com/vim-airline/vim-airline.git'
	Plug 'https://github.com/hari-rangarajan/CCTree.git'
	Plug 'https://github.com/ronakg/quickr-cscope.vim.git'
	Plug 'https://github.com/stefandtw/quickfix-reflector.vim.git'
	Plug 'https://github.com/Valloric/YouCompleteMe.git'
	Plug 'https://github.com/w0rp/ale.git'
	" ------------Plug-ins Above ---------
	call plug#end()
else
	echo "No vim plug - Please see suggestion below:"
	echo "\tcurl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \\"
	echo "\thttps://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
endif " No vim Plug

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
set backspace=indent,eol,start
set splitright

" vim-airline support
set t_Co=4096
set laststatus=2

" Thanks to Damien Conway
highlight ColorColumn ctermbg=red
call matchadd('ColorColumn', '\%80v', 100)

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
noremap <Leader>l :set list!<CR> " Toggle invisible chars
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
  autocmd FileType c,cpp setlocal expandtab sw=2 cino=(0,:N0,t0 ts=4
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") |
	\exe "normal! g'\"" | endif
endif

" search visual selection
vnoremap // y/<C-R>"<CR>

" Terminal mode
" tnoremap <Esc> <C-\><C-n>

" jj to escape insert mode
inoremap jj <esc>

nnoremap Y y$<CR>

" Remap some movements to be in cemter of the screen
" nnoremap {{ {{zz
" nnoremap }} }}zz
" nnoremap [[ [[zz
" nnoremap ]] ]]zz
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz
nnoremap j jzz
nnoremap k kzz
nnoremap <C-D> <C-D>zz
nnoremap <C-U> <C-U>zz

" remap copy/paste to system buffer
vnoremap <Leader>c "+y
vnoremap <Leader>v "+p
vnoremap <Leader>V "+P
nnoremap <Leader>c "+y
nnoremap <Leader>v "+p
nnoremap <Leader>V "+P

" delete buffers
nnoremap <leader>d :bdelete<cr>

" Vim airline specific configurations
if !empty(glob("~/.config/nvim/plugged/vim-airline/"))
	let g:airline_left_sep = '▶'
	let g:airline_right_sep = '◀'
	let g:airline_whitespace_disabled = 1
	" let g:airline_section_y="%{strlen(&fenc)>0?&fenc:''}%{strlen(&ff)>0?'['.&ff.']':''}%{airline#extensions#whitespace#check()}"
	let g:airline_section_warning=""
endif


if !empty(glob("~/.config/nvim/plugged/ale/"))
	let g:ale_set_loclist = 1
	let g:ale_set_quickfix = 0
	let g:ale_echo_msg_error_str = 'E'
	let g:ale_echo_msg_warning_str = 'W'
	let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
	nmap <silent> <C-k> <Plug>(ale_previous_wrap)
	nmap <silent> <C-j> <Plug>(ale_next_wrap)
	let g:ale_linters = {'c': 'all'}
endif

" command mode arrows
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>

au BufRead,BufNewFile *.h set filetype=c

if has('nvim')
	nnoremap <Leader>m :Man 2 <C-R><C-W> <CR>
	let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 0
	tnoremap <Esc> <C-\><C-n>
endif
