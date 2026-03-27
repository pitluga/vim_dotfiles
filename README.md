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

Built-in shortcuts (when focused in the nvim-tree window):
* `P` - move cursor to parent directory
* `-` - change tree root to parent directory
* `o` or `<CR>` - open file / toggle directory
* `a` - create a new file or directory (end with `/` for directory)
* `d` - delete file or directory
* `r` - rename
* `x` - cut
* `c` - copy
* `p` - paste
* `R` - refresh the tree
* `H` - toggle hidden/dotfiles
* `I` - toggle gitignored files
* `g?` - show help with all keybindings

### Telescope (fuzzy finding)
* `\ff` - open the prompt to start searching for a file (fuzzy files)
* `\fb` - search open buffers (fuzzy buffers)
* `\be` - search open buffers (buffer explorer)
* `\fg` - live grep across files (fuzzy grep)
* `\fh` - search help tags (fuzzy help)

### Git
* `\dt` - toggle the diff view (diff toggle)

### Completions (blink.cmp)
* `<CR>` - accept the selected completion
* `<C-e>` - cancel the completion menu
* `<C-n>` or `<Tab>` - select next item
* `<C-p>` or `<S-Tab>` - select previous item
* `<C-space>` - manually trigger completion
* `<C-f>` - scroll documentation down
* `<C-b>` - scroll documentation up

### Code Navigation
* `gd` - go to definition
* `gr` - display all references
* `\gw` - git grep the word under the cursor (grep word)

## Random Stuff
* `\nh` - disable current highlights (no highlights)
* `\cc` - comment the current line or selected block (comment code)
