-- Neovim configuration
-- Converted from vimrc, maintaining keyboard shortcuts

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set leader keys before lazy
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- Load plugins
require("lazy").setup("plugins")

-- General Options
vim.opt.compatible = false
vim.cmd("syntax on")
vim.opt.hlsearch = true
vim.opt.number = true
vim.opt.showmatch = true
vim.opt.incsearch = true
vim.opt.background = "dark"
vim.opt.hidden = true
vim.opt.backspace = "indent,eol,start"
vim.opt.ruler = true
vim.opt.wrap = true
vim.opt.directory = "/tmp//"
vim.opt.scrolloff = 5
vim.opt.foldenable = false
vim.opt.mouse = ""
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wildignore:append({ "*.pyc", "*.o", "*.class" })

-- Indentation defaults
vim.opt.textwidth = 0
vim.opt.smartindent = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

-- Filetype-specific settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "php",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  callback = function()
    vim.opt_local.textwidth = 78
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.opt_local.expandtab = false
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "ruby",
  callback = function()
    vim.opt_local.iskeyword:append("?")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "yaml",
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "solidity",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.sol",
  callback = function()
    vim.opt_local.filetype = "solidity"
  end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.txt",
  callback = function()
    vim.opt_local.textwidth = 78
  end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.md", "*.markdown" },
  callback = function()
    vim.opt_local.filetype = "ghmarkdown"
  end,
})

-- HTML settings
vim.g.html_use_css = 1
vim.g.html_number_lines = 0
vim.g.html_no_pre = 1
vim.g.no_html_toolbar = "yes"

-- Ruby
vim.g.rubycomplete_buffer_loading = 1

-- Keymaps

-- Map :W to :w
vim.api.nvim_create_user_command("W", "w", {})

-- j and k move through wrapped lines
vim.keymap.set("n", "k", "gk", { silent = true })
vim.keymap.set("n", "j", "gj", { silent = true })

-- Y yanks to end of line (like C and D)
vim.keymap.set("n", "Y", "y$", { silent = true })

-- Ruby hash rocket
vim.keymap.set("i", "<C-L>", " => ")

-- Generate ctags
vim.keymap.set("n", "<LocalLeader>rt", ':!ctags -R --exclude=".git" --exclude="log" --exclude="tmp" --exclude="db" --exclude="pkg" --exclude="deps" --exclude="_build" --extra=+f .<CR>', { silent = true })

-- Clear search highlights
vim.keymap.set("n", "<LocalLeader>nh", ":nohls<CR>", { silent = true })

-- Close all buffers
vim.keymap.set("n", "<LocalLeader>bd", ":bufdo :bd<CR>", { silent = true })

-- Spell checking
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.txt",
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_us"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_us"
  end,
})

-- Colorscheme (set after plugins load)
vim.cmd("colorscheme gruvbox")

-- Whitespace highlighting
vim.api.nvim_create_autocmd("InsertEnter", {
  pattern = "*",
  callback = function()
    vim.fn.matchadd("ExtraWhitespace", [[\s\+\%#\@<!$]])
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "InsertLeave" }, {
  pattern = "*",
  callback = function()
    vim.fn.matchadd("ExtraWhitespace", [[\s\+$]])
  end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "ExtraWhitespace", { ctermbg = "red", bg = "red" })
  end,
})

vim.api.nvim_set_hl(0, "ExtraWhitespace", { ctermbg = "red", bg = "red" })

vim.keymap.set("n", "<LocalLeader>ws", ":highlight clear ExtraWhitespace<CR>", { silent = true })

-- Status line
vim.opt.laststatus = 2

-- Undo settings
vim.opt.undodir = vim.fn.expand("~/.config/nvim/undodir")
vim.opt.undofile = true
vim.opt.undoreload = 10000

-- Auto complete popup navigation
vim.keymap.set("i", "<Tab>", function()
  return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>"
end, { expr = true })

vim.keymap.set("i", "<S-Tab>", function()
  return vim.fn.pumvisible() == 1 and "<C-p>" or "<S-Tab>"
end, { expr = true })

vim.keymap.set("i", "<CR>", function()
  return vim.fn.pumvisible() == 1 and "<C-y>" or "<CR>"
end, { expr = true })

-- GitGrep function
vim.api.nvim_create_user_command("GitGrepWord", function()
  local word = vim.fn.expand("<cword>")
  vim.fn.setqflist({}, " ", { title = "GitGrep: " .. word, lines = vim.fn.systemlist("git grep -n '" .. word .. "'") })
  vim.cmd("copen")
  print("Number of matches: " .. #vim.fn.getqflist())
end, {})

vim.keymap.set("n", "<Leader>gw", ":GitGrepWord<CR>", { silent = true })

-- Allow project-specific configs
vim.opt.exrc = true
vim.opt.secure = true
