# Vim8 Dotfiles

## Vim Setup

```bash
~$ ln -s ./vim ~/.vim
~$ ln -s ./vimrc ~/.vimrc
~$ vim +PlugInstall +UpdateRemotePlugins +qa

# install pyls for python code navigation
~$ python3 -m venv ~/.vim/tools/py
~$ ~/.vim/tools/py/bin/pip install python-language-server
```

## Neovim Setup

```bash
~$ ln -s /path/to/vim_dotfiles/nvim ~/.config/nvim
~$ nvim
# lazy.nvim will auto-install on first launch
```

## Updating Colorschemes

```
:PromptlineSnapshot airline ../dotfiles/promptline-<scheme>.sh
:TmuxlineSnapshot ~/.dotfiles/tmuxline-<scheme>.conf
```

## Shortcuts

These are the custom shortcuts I've set up and use everyday. In parens is the
mnemonic I use to remember them :D

### Testing
* `\rb` - run all the tests in the current file (run buffer)
* `\rf` - run the test under the cursor (run focused)
* `\rl` - run the last test, can do it from anywhere (run last)
* `\ra` - run all tests (run all)

### nvim-tree (file explorer)
* `\nt` - toggle viewing nvim-tree (nerd toggle)
* `\nf` - reveal the current file in nvim-tree (nerd find)

### Telescope (fuzzy finding)
* `\ff` - open the prompt to start searching for a file (fuzzy files)
* `\fb` - search open buffers (fuzzy buffers)
* `\fg` - live grep across files (fuzzy grep)
* `\fh` - search help tags (fuzzy help)

### Code Navigation
* `gd` - go to definition
* `gr` - display all references
* `\gw` - git grep the word under the cursor (grep word)

## Random Stuff
* `\nh` - disable current highlights (no highlights)
* `\cc` - comment the current line or selected block (comment code)
