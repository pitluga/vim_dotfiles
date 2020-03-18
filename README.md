# Vim8 Dotfiles

```bash
~$ ln -s ./vim ~/.vim
~$ ln -s ./vimrc ~/.vimrc
~$ vim +PlugInstall +UpdateRemotePlugins +qa

# install pyls for python code navigation
~$ python3 -m venv ~/.vim/tools/py
~$ ~/.vim/tools/py/bin/pip install python-language-server
```

## Shortcuts

These are the custom shortcuts I've set up and use everyday. In parens is the
mnemonic I use to remember them :D

### Testing
* `\rb` - run all the tests in the current file (run buffer)
* `\rf` - run the test under the cursor (run focused)
* `\rl` - run the last test, can do it from anywhere (run last)

### NERDTree (file explorer)
* `\nt` - toggle viewing NERDTree (nerd toggle)
* `\nf` - reveal the current file in NERDTree (nerd find)

### Contror-P (fuzzy finding files)
* `\ff` - open the prompt to start searching for a file (fuzzy files)
* `\fb` - search open buffers (fuzzy buffers)
* `\fr` - clear the file cache (fuzzy refresh)

### Buffer Explorer (currently open files)
* `\be` - open buffer explorer

### Code Navigation
* `gd` - go to definition
* `gr` - display all references
* `\gw` - git grep the word under the cursor (grep word)

## Random Stuff
* `\nh` - disable current highlights (no highlights)
* `\cc` - comment the current line or selected block (comment code)
