set nocompatible
syntax on

call plug#begin('~/.vim/plugged')

Plug '~/.vim/local-plugins/color-schemes'
Plug '~/.vim/local-plugins/language-mappings'

Plug 'benmills/vimux', { 'tag': '1.0.0' }
Plug 'dense-analysis/ale', {'tag': 'v2.6.0'} " linting and fixing
Plug 'fatih/vim-go', {'tag': 'v1.18'}
Plug 'janko-m/vim-test', {'sha': '71ba2f81fc32a2b404f1d13ac60beaeb436ad40b'}
Plug 'jlanzarotta/bufexplorer', {'tag': 'v7.4.19'}
Plug 'jtratner/vim-flavored-markdown', {'tag': 'v0.2'}
Plug 'pangloss/vim-javascript', {'tag': '1.2.5.1'}
Plug 'scrooloose/nerdtree', {'tag': '5.0.0'} " file tree
Plug 'tomtom/tcomment_vim', {'tag': '3.08.1'} " commentin code
Plug 'tpope/vim-fugitive', {'tag': 'v2.4'} " git
Plug 'tpope/vim-ragtag', {'tag': 'v2.0'} " HTML
Plug 'arcticicestudio/nord-vim'
Plug 'vim-airline/vim-airline', {'sha': '8608270bd39e9aa31bbdb8cd22b2ba776037feb6'}
Plug 'vim-airline/vim-airline-themes', {'sha': 'e1b0d9f86cf89e84b15c459683fd72730e51a054'}
Plug 'edkolev/tmuxline.vim', {'sha': '7001ab359f2bc699b7000c297a0d9e9a897b70cf'}
Plug 'edkolev/promptline.vim', {'sha': '106418570a0ecc33b35439e24b051be34f829b94'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

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

" fzf
let g:fzf_preview_window = [] " disable preview window
map <silent> <leader>ff :GFiles<CR>
map <silent> <leader>fb :Buffers<CR>

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

colorscheme nord
let g:airline_theme='nord'

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
" let g:ale_completion_enabled = 1 * this is kind of helpful, but needs tuning
let g:ale_fixers = {
\ '*': ['remove_trailing_lines', 'trim_whitespace'],
\}
let g:ale_linters = {
\ 'python': ['pylint', 'mypy', 'pyls'],
\}
let g:ale_python_black_executable = $HOME . '/.vim/tools/py/bin/black'
let g:ale_python_pyls_executable = $HOME . '/.vim/tools/py/bin/pyls'
let g:ale_python_isort_executable = $HOME . '/.vim/tools/py/bin/isort'
let g:ale_python_pyls_config = {
\  'pyls': {
\    'plugins': {
\      'pycodestyle': { 'enabled': v:false },
\    }
\  },
\}
nnoremap <silent> gd :ALEGoToDefinition<CR>
nnoremap <silent> gr :ALEFindReferences<CR>
set omnifunc=ale#completion#OmniFunc

function! GitGrepWord()
  cgetexpr system("git grep -n '" . expand("<cword>") . "'")
  cwin
  echo 'Number of matches: ' . len(getqflist())
endfunction
command! -nargs=0 GitGrepWord :call GitGrepWord()
nnoremap <silent> <Leader>gw :GitGrepWord<CR>

" allow project-specific dotfiles
set exrc
set secure
