set nocompatible
syntax on

call plug#begin('~/.vim/plugged')

Plug '~/.vim/local-plugins/color-schemes'
Plug '~/.vim/local-plugins/language-mappings'

Plug 'benmills/vimux', { 'tag': '1.0.0' }
Plug 'ctrlpvim/ctrlp.vim', {'tag': '1.80'} " fuzzy finder
Plug 'fatih/vim-go', {'tag': 'v1.18'}
Plug 'janko-m/vim-test', {'tag': 'v2.1.0'}
Plug 'jlanzarotta/bufexplorer', {'tag': 'v7.4.19'}
Plug 'jtratner/vim-flavored-markdown', {'tag': 'v0.2'}
Plug 'pangloss/vim-javascript', {'tag': '1.2.5.1'}
Plug 'scrooloose/nerdtree', {'tag': '5.0.0'} " file tree
Plug 'tomtom/tcomment_vim', {'tag': '3.08.1'} " commentin code
Plug 'tpope/vim-fugitive', {'tag': 'v2.4'} " git
Plug 'tpope/vim-ragtag', {'tag': 'v2.0'} " HTML

Plug 'neoclide/coc.nvim', {'branch': 'release'} " autocomplete

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
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\}

" coc
" " Give more space for displaying messages.
set cmdheight=2
let g:coc_global_extensions = ['coc-python']
" CTRL+SPACE auto-complete
inoremap <silent><expr> <c-space> coc#refresh()
autocmd FileType python let b:coc_root_patterns = ['.git', 'envs']


" Better display for messages
"set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

" Use `lp` and `ln` for navigate diagnostics
nmap <silent> <leader>lp <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>ln <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> <leader>lt <Plug>(coc-type-definition)
nmap <silent> <leader>li <Plug>(coc-implementation)
nmap <silent> <leader>lf <Plug>(coc-references)

" Remap for rename current word
nmap <leader>lr <Plug>(coc-rename)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')


" Language Server
"let g:lsp_signs_enabled = 1
"let g:lsp_diagnostics_enabled = 1
"
"function! s:on_lsp_buffer_enabled() abort
"    setlocal omnifunc=lsp#complete
"    setlocal signcolumn=yes
"    nmap <buffer> gd <plug>(lsp-definition)
"    nmap <buffer> <f2> <plug>(lsp-rename)
"    " refer to doc to add more commands
"endfunction
"
"" jump to definition
"nnoremap <silent> gd :LspDefinition<CR>

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
