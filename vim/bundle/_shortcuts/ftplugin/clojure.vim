" Activate rainbow parens
:RainbowParentheses

" Run all tests
map <silent> <LocalLeader>ra :wa<CR> :Make! test<CR> :Copen<CR>
" Run all tests in the current namespace (buffer)
map <silent> <LocalLeader>rb :wa<CR> :RunTests<CR>
" Run the test under the cursor (focused)
map <silent> <LocalLeader>rf :wa<CR> :.RunTests<CR>
