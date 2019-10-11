set nocompatible
syntax on

if &shell == "/usr/bin/sudosh"
  set shell=/bin/bash
endif

call plug#begin('~/.config/nvim/plugged')

Plug '~/.config/nvim/local-plugins/color-schemes'
Plug '~/.config/nvim/local-plugins/language-mappings'

Plug 'benekastah/neomake', {'commit': 'c15d51ea9f622b8bce469a18833a6ac64f6a1193'}
Plug 'benmills/vimux', { 'tag': '1.0.0' }
Plug 'ctrlpvim/ctrlp.vim', {'tag': '1.80'}
Plug 'fatih/vim-go', {'tag': 'v1.18'}
Plug 'janko-m/vim-test', {'tag': 'v2.1.0'}
Plug 'jlanzarotta/bufexplorer', {'tag': 'v7.4.19'}
Plug 'jtratner/vim-flavored-markdown', {'tag': 'v0.2'}
Plug 'pangloss/vim-javascript', {'tag': '1.2.5.1'}
Plug 'scrooloose/nerdtree', {'tag': '5.0.0'}
Plug 'scrooloose/syntastic', { 'tag': '3.9.0' }
Plug 'tomtom/tcomment_vim', {'tag': '3.08.1'}
Plug 'tpope/vim-endwise', {'tag': 'v1.2', 'for': ['ruby']}
Plug 'tpope/vim-fugitive', {'tag': 'v2.4'}
Plug 'tpope/vim-ragtag', {'tag': 'v2.0'}
Plug 'tpope/vim-rails', {'tag': 'v5.4'}
Plug 'vim-ruby/vim-ruby', {'tag': 'stable-20160928'}

call plug#end()

set hlsearch
set number
set showmatch
set incsearch
set background=dark
set hidden
set backspace=indent,eol,start
set ruler
set wrap
set dir=/tmp//
set scrolloff=5
set nofoldenable
" allow CMD+C to copy
set mouse=

set textwidth=0 nosmartindent tabstop=2 shiftwidth=2 softtabstop=2 expandtab

set ignorecase
set smartcase

set wildignore+=*.pyc,*.o,*.class

let g:ctrlp_custom_ignore = 'node_modules\|_build\|deps\|elm-stuff'

let html_use_css=1
let html_number_lines=0
let html_no_pre=1

let g:rubycomplete_buffer_loading = 1

let g:no_html_toolbar = 'yes'

let NERDTreeIgnore=['\.pyc$', '\.o$', '\.class$', '__pycache__']

let g:ctrlp_match_window = "top,order:ttb"

let g:ctrlp_prompt_mappings = {
  \ 'PrtSelectMove("j")':   ['<c-n>', '<down>'],
  \ 'PrtSelectMove("k")':   ['<c-p>','<c-k>', '<up>'],
  \ 'PrtHistory(-1)':       ['<c-j>'],
  \ 'PrtHistory(1)':        ['<c-k>'],
\ }

let test#strategy = "vimux"

function! ClearTransform(cmd) abort
    return 'clear;' .a:cmd
endfunction

let g:test#custom_transformations = {'clear': function('ClearTransform')}
let g:test#transformation = 'clear'
let test#python#runner = 'pytest'
let test#python#pytest#executable = '.venv/bin/python3 -m pytest'
let test#python#pytest#file_pattern = '^\(test_.*\|.*_test\)\.py$'

nnoremap <silent> <leader>rf :wa<CR> :TestNearest<CR>
nnoremap <silent> <leader>rb :wa<CR> :TestFile<CR>
nnoremap <silent> <leader>ra :wa<CR> :TestSuite<CR>
nnoremap <silent> <leader>rl :wa<CR> :TestLast<CR>

" Map :W to :w to save frustrations
:command W w

let g:neoterm_position = "vertical"
let g:neoterm_size = "100"

" ESC exits terminal
tnoremap <Esc> <C-\><C-n>

nnoremap <silent> <leader>tc :call neoterm#clear()<CR>
nnoremap <silent> <leader>td :call neoterm#close()<CR>

let g:go_highlight_trailing_whitespace_error = 0

autocmd FileType php setlocal tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType tex setlocal textwidth=78
autocmd Filetype go setlocal noexpandtab
autocmd FileType rust setlocal tabstop=4 shiftwidth=4 softtabstop=4
autocmd BufNewFile,BufRead *.txt setlocal textwidth=78
autocmd BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown

imap <C-L> <SPACE>=><SPACE>
if executable("starscope")
  map <silent> <LocalLeader>rt :!starscope -e ctags && starscope -e cscope<CR>
else
  map <silent> <LocalLeader>rt :!ctags -R --exclude=".git" --exclude="log" --exclude="tmp" --exclude="db" --exclude="pkg" --exclude="deps" --exclude="_build" --extra=+f .<CR>
endif
map <silent> <LocalLeader>nt :NERDTreeToggle<CR>
map <silent> <LocalLeader>nf :NERDTreeFind<CR>
map <silent> <leader>ff :CtrlP<CR>
map <silent> <leader>fb :CtrlPBuffer<CR>
map <silent> <leader>fr :CtrlPClearCache<CR>
map <silent> <LocalLeader>nh :nohls<CR>
map <silent> <LocalLeader>bd :bufdo :bd<CR>
map <silent> <LocalLeader>cc :TComment<CR>

nnoremap <silent> k gk
nnoremap <silent> j gj
nnoremap <silent> Y y$

autocmd BufNewFile,BufRead *.txt setlocal spell spelllang=en_us
autocmd FileType tex setlocal spell spelllang=en_us

if &t_Co == 256
  colorscheme jellybeans
endif

autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd BufRead,InsertLeave * match ExtraWhitespace /\s\+$/

highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
map <silent> <LocalLeader>ws :highlight clear ExtraWhitespace<CR>

set laststatus=2

set statusline=
set statusline+=%<\                       " cut at start
set statusline+=%2*[%n%H%M%R%W]%*\        " buffer number, and flags
set statusline+=%-40f\                    " relative path

set statusline+=%=                        " seperate between right- and left-aligned
set statusline+=%1*%y%*%*\                " file type
set statusline+=%10(L(%l/%L)%)\           " line
set statusline+=%2(C(%v/125)%)\           " column
set statusline+=%P                        " percentage of file

set undodir=~/.config/nvim/undodir
set undofile
set undoreload=10000

" Syntastic settings
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_aggregate_errors = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_ruby_rubocop_exe = 'RUBYLIB=lib rubocop'
let g:syntastic_python_checkers = ['pylint', 'mypy']
let g:syntastic_python_pylint_exe = 'PYTHONPATH=. .venv/bin/pylint'
let g:syntastic_python_mypy_exe = 'PYTHONPATH=. .venv/bin/mypy'

function! GitGrepWord()
  cgetexpr system("git grep -n '" . expand("<cword>") . "'")
  cwin
  echo 'Number of matches: ' . len(getqflist())
endfunction
command! -nargs=0 GitGrepWord :call GitGrepWord()
nnoremap <silent> <Leader>gw :GitGrepWord<CR>

" cscope settings
set cscopetag " CTRL+] searches scope.out in addition to ctags

" add any database in current directory
if filereadable("cscope.out")
    cs add cscope.out
endif

" CTRL+\ => find (c)allers of function under cursor
map <C-\> :cs find c <C-R>=expand("<cword>")<CR><CR>
