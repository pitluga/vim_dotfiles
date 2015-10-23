" Activate rainbow parens
:RainbowParentheses

" Run all tests
map <silent> <LocalLeader>ra :wa<CR> :Make! test<CR> :Copen<CR>
" Run all tests in the current namespace (buffer)
map <silent> <LocalLeader>rb :wa<CR> :RunTests<CR>
" Run the test under the cursor (focused)
map <silent> <LocalLeader>rf :wa<CR> :.RunTests<CR>

function! s:connect_docker_repl()
  let port = system("docker inspect --format='{{(index (index .NetworkSettings.Ports \"58011/tcp\") 0).HostPort}}' $(basename $PWD)")
  let ip = substitute(system("docker-machine ip dev"), '\n\+$', '', '')

  execute "Connect nrepl://" . ip . ":" . port
endfunction

command! ConnectDockerRepl call s:connect_docker_repl()
