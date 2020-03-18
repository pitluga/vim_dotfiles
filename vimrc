set nocompatible
syntax on

call plug#begin('~/.vim/plugged')

Plug '~/.vim/local-plugins/color-schemes'
Plug '~/.vim/local-plugins/language-mappings'

Plug 'benmills/vimux', { 'tag': '1.0.0' }
Plug 'ctrlpvim/ctrlp.vim', {'tag': '1.80'} " fuzzy finder
Plug 'dense-analysis/ale', {'tag': 'v2.6.0'} " linting and fixing
Plug 'fatih/vim-go', {'tag': 'v1.18'}
Plug 'janko-m/vim-test', {'tag': 'v2.1.0'}
Plug 'jlanzarotta/bufexplorer', {'tag': 'v7.4.19'}
Plug 'jtratner/vim-flavored-markdown', {'tag': 'v0.2'}
Plug 'pangloss/vim-javascript', {'tag': '1.2.5.1'}
Plug 'scrooloose/nerdtree', {'tag': '5.0.0'} " file tree
Plug 'tomtom/tcomment_vim', {'tag': '3.08.1'} " commentin code
Plug 'tpope/vim-fugitive', {'tag': 'v2.4'} " git
Plug 'tpope/vim-ragtag', {'tag': 'v2.0'} " HTML

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
set ignorecase
set smartcase
set wildignore+=*.pyc,*.o,*.class

set textwidth=0 nosmartindent tabstop=2 shiftwidth=2 softtabstop=2 expandtab
autocmd FileType php setlocal tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType tex setlocal textwidth=78
autocmd Filetype go setlocal noexpandtab
autocmd FileType rust setlocal tabstop=4 shiftwidth=4 softtabstop=4
autocmd BufNewFile,BufRead *.txt setlocal textwidth=78
autocmd BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown

let html_use_css=1
let html_number_lines=0
let html_no_pre=1
let g:no_html_toolbar = 'yes'

let g:rubycomplete_buffer_loading = 1

" NERDTree
let NERDTreeIgnore=['\.pyc$', '\.o$', '\.class$', '__pycache__']
map <silent> <LocalLeader>nt :NERDTreeToggle<CR>
map <silent> <LocalLeader>nf :NERDTreeFind<CR>

" ctrlp
let g:ctrlp_custom_ignore = 'node_modules\|_build\|deps\|elm-stuff|envs/default'
let g:ctrlp_match_window = "top,order:ttb"
let g:ctrlp_prompt_mappings = {
  \ 'PrtSelectMove("j")':   ['<c-n>', '<down>'],
  \ 'PrtSelectMove("k")':   ['<c-p>','<c-k>', '<up>'],
  \ 'PrtHistory(-1)':       ['<c-j>'],
  \ 'PrtHistory(1)':        ['<c-k>'],
\ }
map <silent> <leader>ff :CtrlP<CR>
map <silent> <leader>fb :CtrlPBuffer<CR>
map <silent> <leader>fr :CtrlPClearCache<CR>

" vim-test
let g:test#strategy = "vimux"
let g:test#preserve_screen = 0
let g:test#python#runner = 'pytest'
let g:test#python#pytest#executable = 'envs/default/bin/python -m pytest'
let g:test#python#pytest#file_pattern = '^\(test_.*\|.*_test\)\.py$'

nnoremap <silent> <leader>rf :wa<CR> :TestNearest<CR>
nnoremap <silent> <leader>rb :wa<CR> :TestFile<CR>
nnoremap <silent> <leader>ra :wa<CR> :TestSuite<CR>
nnoremap <silent> <leader>rl :wa<CR> :TestLast<CR>

" Map :W to :w to save frustrations
:command W w
" j and k move the wraps
nnoremap <silent> k gk
nnoremap <silent> j gj
" cap Y acts like other caps
nnoremap <silent> Y y$

" vim-go
let g:go_highlight_trailing_whitespace_error = 0

" ruby
imap <C-L> <SPACE>=><SPACE>
map <silent> <LocalLeader>rt :!ctags -R --exclude=".git" --exclude="log" --exclude="tmp" --exclude="db" --exclude="pkg" --exclude="deps" --exclude="_build" --extra=+f .<CR>
map <silent> <LocalLeader>nh :nohls<CR>
map <silent> <LocalLeader>bd :bufdo :bd<CR>
map <silent> <LocalLeader>cc :TComment<CR>

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

" Auto complete
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

" ALE
let g:ale_sign_column_always = 1
let g:ale_linters_explicit = 1
let g:ale_lint_on_text_changed = 1
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\ '*': ['remove_trailing_lines', 'trim_whitespace'],
\}
let g:ale_linters = {
\ 'python': ['pylint', 'mypy', 'pyls'],
\}
let g:ale_python_pyls_executable = $HOME . '/.vim/tools/py/bin/pyls'
let g:ale_python_pyls_config = {
\  'pyls': {
\    'plugins': {
\      'pycodestyle': { 'enabled': v:false },
\    }
\  },
\}
nnoremap <silent> gd :ALEGoToDefinition<CR>
nnoremap <silent> gr :ALEFindReferences<CR>

function! GitGrepWord()
  cgetexpr system("git grep -n '" . expand("<cword>") . "'")
  cwin
  echo 'Number of matches: ' . len(getqflist())
endfunction
command! -nargs=0 GitGrepWord :call GitGrepWord()
nnoremap <silent> <Leader>gw :GitGrepWord<CR>

" cscope settings

" add any database in current directory
if filereadable("cscope.out")
    cs add cscope.out
endif

" CTRL+\ => find (c)allers of function under cursor
map <C-\> :cs find c <C-R>=expand("<cword>")<CR><CR>
