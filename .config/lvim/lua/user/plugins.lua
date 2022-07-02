local M = {}

M.config = function()
  local neoclip_req = { "tami5/sqlite.lua", module = "sqlite" }
  if lvim.builtin.neoclip.enable_persistent_history == false then
    neoclip_req = {}
  end
  lvim.plugins = {
    {
      -- A really nice color scheme
      "rose-pine/neovim",
      as = "rose-pine",
      config = function()
        require("user.theme").rose_pine()
        vim.cmd [[colorscheme rose-pine]]
      end,
      cond = function()
        local _time = os.date "*t"
        return (_time.hour >= 1 and _time.hour < 9)
      end,
    },
    {
      -- Another awesome color scheme
      "abzcoding/tokyonight.nvim",
      branch = "feat/local",
      config = function()
        require("user.theme").tokyonight()
        vim.cmd [[colorscheme tokyonight]]
      end,
      cond = function()
        local _time = os.date "*t"
        return _time.hour >= 9 and _time.hour < 17
      end,
    },
    {
      -- Another color scheme
      "catppuccin/nvim",
      as = "catppuccin",
      config = function()
        require("user.theme").catppuccin()
        vim.cmd [[colorscheme catppuccin]]
      end,
      cond = function()
        local _time = os.date "*t"
        return (_time.hour >= 17 and _time.hour < 21)
      end,
    },
    {
      -- The last color scheme
      "rebelot/kanagawa.nvim",
      config = function()
        require("user.theme").kanagawa()
        vim.cmd [[colorscheme kanagawa]]
      end,
      cond = function()
        local _time = os.date "*t"
        return (_time.hour >= 21 and _time.hour < 24) or (_time.hour >= 0 and _time.hour < 1)
      end,
    },
    {
      -- Open the file at the last position
      "vladdoster/remember.nvim",
      config = function()
        require("remember").setup {}
      end,
      event = "BufWinEnter",
      disable = not lvim.builtin.lastplace.active,
    },
    {
      -- Allows you to search and mark todo comments easily
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("user.todo_comments").config()
      end,
      event = "BufRead",
    },
    {
      -- A vscode like quick fix window to show us problems with our code and make quick edits
      "folke/trouble.nvim",
      config = function()
        require("trouble").setup {
          auto_open = true,
          auto_close = true,
          padding = false,
          height = 10,
          use_diagnostic_signs = true,
        }
      end,
      cmd = "Trouble",
    },
    {
      "phaazon/hop.nvim",
      event = "BufRead",
      config = function()
        require("user.hop").config()
      end,
      -- disable = lvim.builtin.motion_provider ~= "hop",
    },
    {
      "lukas-reineke/indent-blankline.nvim",
      setup = function()
        vim.g.indent_blankline_char = "▏"
      end,
      config = function()
        require("user.indent_blankline").config()
      end,
      event = "BufRead",
    },
    {
      -- Dims inactive sections of code
      "folke/twilight.nvim",
      config = function()
        require("user.twilight").config()
      end,
      event = "BufRead",
    },
    {
      -- Makes neovims quick fix window better
      "kevinhwang91/nvim-bqf",
      config = function()
        require("user.bqf").config()
      end,
      event = "BufRead",
    },
    {
      -- This plugin provides a tui interface for dap
      "rcarriga/nvim-dap-ui",
      config = function()
        require("dapui").setup(require("user.dap-ui"))
      end,
      ft = { "python", "rust", "go" },
      event = "BufReadPost",
      requires = { "mfussenegger/nvim-dap" },
      disable = not lvim.builtin.dap.active,
    },
    {
      -- Extends vim's standard % operation and gives language specific methods
      -- Allows you to jump to endif from if statements
      "andymass/vim-matchup",
      event = "BufReadPost",
      config = function()
        vim.g.matchup_enabled = 1
        vim.g.matchup_surround_enabled = 1
        vim.g.matchup_matchparen_deferred = 1
        vim.g.matchup_matchparen_offscreen = { method = "popup" }
      end,
    },
    {
      -- Makes rust more epic
      "simrat39/rust-tools.nvim",
      config = function()
        require("user.rust_tools").config()
      end,
      ft = { "rust", "rs" },
    },
    {
      -- Allows you to create a descraction free environment for editing in vscode
      "folke/zen-mode.nvim",
      config = function()
        require("user.zen").config()
      end,
      event = "BufRead",
    },
    {
      "norcalli/nvim-colorizer.lua",
      config = function()
        require("colorizer").setup({ "*" }, {
          RGB = true, -- #RGB hex codes
          RRGGBB = true, -- #RRGGBB hex codes
          RRGGBBAA = true, -- #RRGGBBAA hex codes
          rgb_fn = true, -- CSS rgb() and rgba() functions
          hsl_fn = true, -- CSS hsl() and hsla() functions
          css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
          css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        })
      end,
    },
    {
      -- A much more powerful find and replace function
      "windwp/nvim-spectre",
      event = "BufRead",
      config = function()
        require("user.spectre").config()
      end,
    },
    {
      -- ALlows you to run your unit tests and stuff whenever you want
      "vim-test/vim-test",
      cmd = { "TestNearest", "TestFile", "TestSuite", "TestLast", "TestVisit" },
      config = function()
        require("user.vim_test").config()
      end,
      disable = not lvim.builtin.test_runner.active,
    },
    {
      "lervag/vimtex",
      ft = "tex",
    },
    {
      -- Like vim-test but is less cumbersome to configure
      "rcarriga/vim-ultest",
      cmd = { "Ultest", "UltestSummary", "UltestNearest" },
      wants = "vim-test",
      requires = { "vim-test/vim-test" },
      run = ":UpdateRemotePlugins",
      opt = true,
      event = { "BufEnter *_test.*,*_spec.*" },
      disable = not lvim.builtin.test_runner.active,
    },
    {
      -- Cheat sh integration for neovim
      "RishabhRD/nvim-cheat.sh",
      requires = "RishabhRD/popfix",
      config = function()
        vim.g.cheat_default_window_layout = "vertical_split"
      end,
      opt = true,
      cmd = { "Cheat", "CheatWithoutComments", "CheatList", "CheatListWithoutComments" },
      keys = "<leader>?",
      disable = not lvim.builtin.cheat.active,
    },
    {
      -- For people who forget about vim registers like me
      "AckslD/nvim-neoclip.lua",
      config = function()
        require("user.neoclip").config()
      end,
      opt = true,
      keys = "<leader>y",
      requires = neoclip_req,
      disable = not lvim.builtin.neoclip.active,
    },
    {
      -- Vim dadbod suite plugins make it easy to interact with databases with a nice tui interface and completion
      "kristijanhusak/vim-dadbod-completion",
      disable = not lvim.builtin.sql_integration.active,
    },
    {
      "kristijanhusak/vim-dadbod-ui",
      cmd = {
        "DBUIToggle",
        "DBUIAddConnection",
        "DBUI",
        "DBUIFindBuffer",
        "DBUIRenameBuffer",
      },
      requires = {
        {
          "tpope/vim-dadbod",
          opt = true,
        },
      },
      opt = true,
      disable = not lvim.builtin.sql_integration.active,
    },
    {
      -- Speed up vim start up time. This provides a more efficient method for generating autocommands
      "nathom/filetype.nvim",
      config = function()
        require("user.filetype").config()
      end,
    },
    {
      -- Gives you a preview of your telescope window
      "nvim-telescope/telescope-live-grep-raw.nvim",
    },
    -- Highlighting for log files
    { "mtdl9/vim-log-highlighting", ft = { "text", "log" } },
    {
      -- Underlines all occurrences of the word that your cursor is on
      "yamatsum/nvim-cursorline",
      opt = true,
      event = "BufWinEnter",
      disable = not lvim.builtin.cursorline.active,
    },
    {
      -- Gives you more information on matched instances when searching file
      "kevinhwang91/nvim-hlslens",
      config = function()
        require("user.hlslens").config()
      end,
      event = "BufReadPost",
      disable = not lvim.builtin.hlslens.active,
    },
    {
      -- Gives you vscode like suggestions with the lightbulb
      "kosayoda/nvim-lightbulb",
      config = function()
        vim.fn.sign_define(
          "LightBulbSign",
          { text = require("user.lsp_kind").icons.code_action, texthl = "DiagnosticInfo" }
        )
      end,
      event = "BufRead",
      ft = { "rust", "go", "typescript", "typescriptreact" },
    },
    {
      -- Formats csv files like an excel spreadsheet
      "chrisbra/csv.vim",
      ft = { "csv" },
      disable = not lvim.builtin.csv_support,
    },
    {
      -- Much like vscode has a .vscode folder, this creates a .tasks filee where we can specify commands to run and or build the file among others
      "skywind3000/asynctasks.vim",
      requires = {
        { "skywind3000/asyncrun.vim" },
      },
      setup = function()
        vim.cmd [[
          let g:asyncrun_open = 8
          let g:asynctask_template = '~/.config/lvim/task_template.ini'
          let g:asynctasks_extra_config = ['~/.config/lvim/tasks.ini']
        ]]
      end,
      event = "BufRead",
      disable = not lvim.builtin.async_tasks.active,
    },
    -- {
    --   -- Use telescope as a simple file browser
    --   "nvim-telescope/telescope-file-browser.nvim",
    --   disable = not lvim.builtin.file_browser.active,
    -- },
    -- {
    --   -- Shows lsp progress. Very eye candy
    --   "j-hui/fidget.nvim",
    --   config = function()
    --     require("user.fidget_spinner").config()
    --   end,
    -- },
    {
      -- Allows you to run snippets of code, intended for checking simple one liners
      "michaelb/sniprun",
      run = "bash ./install.sh",
      disable = not lvim.builtin.sniprun.active,
    },
    {
      -- Adds cmp completion to the command line
      "hrsh7th/cmp-cmdline",
      disable = not lvim.builtin.fancy_wild_menu.active,
    },
    {
      -- Allows you to very easily manage and view your keybindings in vim
      "gfeiyou/command-center.nvim",
      config = function()
        require("user.cc").config()
      end,
      requires = "nvim-telescope/telescope.nvim",
    },
  }
end

return M
