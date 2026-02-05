-- Plugin specifications for lazy.nvim
return {
  -- Color scheme
  {
    "morhetz/gruvbox",
    lazy = false,
    priority = 1000,
  },

  -- File explorer (NERDTree)
  {
    "preservim/nerdtree",
    keys = {
      { "<LocalLeader>nt", ":NERDTreeToggle<CR>", desc = "Toggle NERDTree", silent = true },
      { "<LocalLeader>nf", ":NERDTreeFind<CR>", desc = "Find in NERDTree", silent = true },
    },
    init = function()
      vim.g.NERDTreeIgnore = { "\\.pyc$", "\\.o$", "\\.class$", "__pycache__" }
    end,
  },

  -- Fuzzy finder (fzf)
  {
    "junegunn/fzf",
    build = function()
      vim.fn["fzf#install"]()
    end,
  },
  {
    "junegunn/fzf.vim",
    dependencies = { "junegunn/fzf" },
    keys = {
      { "<leader>ff", ":GFiles<CR>", desc = "Fuzzy find files", silent = true },
      { "<leader>fb", ":Buffers<CR>", desc = "Fuzzy find buffers", silent = true },
    },
    init = function()
      vim.g.fzf_preview_window = {}
    end,
  },

  -- Testing
  {
    "preservim/vimux",
  },
  {
    "vim-test/vim-test",
    dependencies = { "preservim/vimux" },
    keys = {
      { "<leader>rf", ":wa<CR>:TestNearest<CR>", desc = "Run nearest test", silent = true },
      { "<leader>rb", ":wa<CR>:TestFile<CR>", desc = "Run test file", silent = true },
      { "<leader>ra", ":wa<CR>:TestSuite<CR>", desc = "Run all tests", silent = true },
      { "<leader>rl", ":wa<CR>:TestLast<CR>", desc = "Run last test", silent = true },
    },
    init = function()
      vim.g["test#strategy"] = "vimux"
      vim.g["test#preserve_screen"] = 0
      vim.g["test#python#runner"] = "pytest"
      vim.g["test#python#pytest#executable"] = ".venv/bin/pytest"
      vim.g["test#python#pytest#file_pattern"] = "^\\(test_.*\\|.*_test\\)\\.py$"
    end,
  },

  -- Buffer explorer
  {
    "jlanzarotta/bufexplorer",
  },

  -- Markdown
  {
    "jtratner/vim-flavored-markdown",
  },

  -- JavaScript
  {
    "pangloss/vim-javascript",
    ft = "javascript",
  },

  -- Commenting
  {
    "tomtom/tcomment_vim",
    keys = {
      { "<LocalLeader>cc", ":TComment<CR>", desc = "Toggle comment", silent = true },
      { "<LocalLeader>cc", ":TComment<CR>", desc = "Toggle comment", silent = true, mode = "v" },
    },
  },

  -- Git
  {
    "tpope/vim-fugitive",
  },

  -- HTML
  {
    "tpope/vim-ragtag",
  },

  -- Go
  {
    "fatih/vim-go",
    ft = "go",
    init = function()
      vim.g.go_highlight_trailing_whitespace_error = 0
    end,
  },

  -- Status line
  {
    "vim-airline/vim-airline",
    dependencies = { "vim-airline/vim-airline-themes" },
    init = function()
      vim.g.airline_theme = "gruvbox"
    end,
  },
  {
    "vim-airline/vim-airline-themes",
  },

  -- Tmux integration
  {
    "edkolev/tmuxline.vim",
  },
  {
    "edkolev/promptline.vim",
  },

  -- Linting and LSP (ALE)
  {
    "dense-analysis/ale",
    config = function()
      vim.g.ale_sign_column_always = 1
      vim.g.ale_linters_explicit = 1
      vim.g.ale_lint_on_text_changed = 1
      vim.g.ale_fix_on_save = 1

      -- Helper function to find Python executable
      local function find_python_executable(exec_name)
        local project_root = vim.fn["ale#python#FindProjectRoot"](vim.fn.bufnr(""))
        if project_root ~= "" then
          local local_exec = project_root .. "/.venv/bin/" .. exec_name
          if vim.fn.executable(local_exec) == 1 then
            return local_exec
          end
        end
        return vim.fn.expand("~/.vim/tools/py/bin/") .. exec_name
      end

      -- Set Python tool paths
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "python",
        callback = function()
          vim.g.ale_python_ruff_executable = find_python_executable("ruff")
          vim.g.ale_python_ruff_format_executable = find_python_executable("ruff")
        end,
      })

      -- Fixers
      vim.g.ale_fixers = {
        ["*"] = { "remove_trailing_lines", "trim_whitespace" },
        python = { "ruff" },
        solidity = { "forge" },
      }

      -- Linters
      vim.g.ale_linters = {
        python = { "ruff", "ty" },
        solidity = { "forge_lsp" },
      }

      -- Define ty linter
      vim.fn["ale#linter#Define"]("python", {
        name = "ty",
        lsp = "stdio",
        executable = function(buffer)
          return find_python_executable("ty")
        end,
        command = "%e server",
        project_root = vim.fn["ale#python#FindProjectRoot"],
      })

      -- Helper function for forge project root
      local function get_forge_project_root(buffer)
        local foundry_file = vim.fn["ale#path#FindNearestFile"](buffer, "foundry.toml")
        if foundry_file ~= "" then
          return vim.fn.fnamemodify(foundry_file, ":h")
        end
        return ""
      end

      -- Helper function for forge executable
      local function get_forge_executable(buffer)
        local project_root = get_forge_project_root(buffer)
        if project_root ~= "" then
          local forge_path = project_root .. "/.foundry/bin/forge"
          if vim.fn.executable(forge_path) == 1 then
            return forge_path
          end
        end
        return "forge"
      end

      -- Define forge LSP linter
      vim.fn["ale#linter#Define"]("solidity", {
        name = "forge_lsp",
        lsp = "stdio",
        executable = get_forge_executable,
        command = "%e lsp",
        project_root = get_forge_project_root,
      })

      -- LSP keymaps
      vim.keymap.set("n", "gd", ":ALEGoToDefinition<CR>", { silent = true })
      vim.keymap.set("n", "gr", ":ALEFindReferences<CR>", { silent = true })

      -- Omni function
      vim.opt.omnifunc = "ale#completion#OmniFunc"
    end,
  },
}
