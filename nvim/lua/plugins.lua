-- Plugin specifications for lazy.nvim
return {
  -- Color scheme (Lua-native gruvbox)
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        contrast = "hard",
      })
      vim.cmd("colorscheme gruvbox")
    end,
  },

  -- File explorer (nvim-tree - replaces NERDTree)
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<LocalLeader>nt", ":NvimTreeToggle<CR>", desc = "Toggle NvimTree", silent = true },
      { "<LocalLeader>nf", ":NvimTreeFindFile<CR>", desc = "Find in NvimTree", silent = true },
    },
    config = function()
      require("nvim-tree").setup({
        filters = {
          custom = { "\\.pyc$", "\\.o$", "\\.class$", "__pycache__" },
        },
        view = {
          width = 30,
        },
      })
    end,
  },

  -- Fuzzy finder (Telescope - replaces fzf)
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    keys = {
      { "<leader>ff", function() require("telescope.builtin").git_files() end, desc = "Find git files", silent = true },
      { "<leader>fb", function() require("telescope.builtin").buffers() end, desc = "Find buffers", silent = true },
      { "<leader>fg", function() require("telescope.builtin").live_grep() end, desc = "Live grep", silent = true },
      { "<leader>fh", function() require("telescope.builtin").help_tags() end, desc = "Help tags", silent = true },
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          previewer = false,
          layout_config = {
            prompt_position = "top",
          },
          sorting_strategy = "ascending",
        },
        pickers = {
          git_files = {
            previewer = false,
          },
          buffers = {
            previewer = false,
          },
        },
      })
      telescope.load_extension("fzf")
    end,
  },

  -- Treesitter (modern syntax highlighting - replaces vim-javascript, vim-flavored-markdown)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua",
          "vim",
          "vimdoc",
          "javascript",
          "typescript",
          "python",
          "go",
          "rust",
          "ruby",
          "markdown",
          "markdown_inline",
          "json",
          "yaml",
          "html",
          "css",
          "bash",
          "solidity",
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
      })
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

  -- Commenting (Comment.nvim - replaces tcomment)
  {
    "numToStr/Comment.nvim",
    keys = {
      { "<LocalLeader>cc", function() require("Comment.api").toggle.linewise.current() end, desc = "Toggle comment", silent = true },
      { "<LocalLeader>cc", "<Plug>(comment_toggle_linewise_visual)", desc = "Toggle comment", silent = true, mode = "v" },
    },
    config = function()
      require("Comment").setup()
    end,
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

  -- Status line (lualine - replaces vim-airline)
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "gruvbox",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { "filename" },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
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
