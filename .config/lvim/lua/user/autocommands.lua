local M = {}

M.config = function()
  -- Autocommands
  if lvim.builtin.nonumber_unfocus then
    vim.cmd [[
" don't show line number in unfocued window
augroup WindFocus
    autocmd!
    autocmd WinEnter * set relativenumber number cursorline
    autocmd WinLeave * set norelativenumber nonumber nocursorline
augroup END
  ]]
  end

  vim.cmd [[
" disable syntax highlighting in big files
function! DisableSyntaxTreesitter()
    echo("Big file, disabling syntax, treesitter and folding")
    if exists(':TSBufDisable')
        exec 'TSBufDisable autotag'
        exec 'TSBufDisable highlight'
    endif

    set foldmethod=manual
    syntax clear
    syntax off
    filetype off
    set noundofile
    set noswapfile
    set noloadplugins
    set lazyredraw
endfunction

augroup BigFileDisable
    autocmd!
    autocmd BufReadPre,FileReadPre * if getfsize(expand("%")) > 1024 * 1024 | exec DisableSyntaxTreesitter() | endif
augroup END
  ]]

  if lvim.builtin.sql_integration.active then
    -- Add vim-dadbod-completion in sql files
    vim.cmd [[
    augroup DadbodSql
      au!
      autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer { sources = { { name = 'vim-dadbod-completion' } } }
    augroup END
    ]]
  end

  local codelens_viewer = "lua require('nvim-lightbulb').update_lightbulb()"
  -- local user = os.getenv "USER"
  -- if user and user == "abz" then
  --   codelens_viewer = "lua require('user.codelens').show_line_sign()"
  -- end

  -- I might need to remove the quotation marks around "command"
  vim.api.nvim_create_autocmd(
    { "CursorHold" },
    {
      pattern = "*.rs,*.go,*.ts,*.tsx",
      command = codelens_viewer
    }
  )
  -- Terminal
  vim.api.nvim_create_autocmd(
    { "TermOpen" },
    {
      pattern = "term://*",
      command = "lua require('user.keybindings').set_terminal_keymaps()"
    }
  )
  -- dashboard
  vim.api.nvim_create_autocmd(
    { "FileType" },
    {
      pattern = "alpha",
      command = "nnoremap <silent> <buffer> q :q<CR>"
    }
  )
  vim.api.nvim_create_autocmd(
    { "FileType" },
    {
      pattern = {"*.c", "*.cpp"},
      command = "nnoremap <leader>H <Cmd>ClangdSwitchSourceHeader<CR>"
    }
  )
  vim.api.nvim_create_autocmd(
    { "FileType" },
    {
      pattern = "*.go",
      command = "nnoremap <leader>H <cmd>lua require('lvim.core.terminal')._exec_toggle({cmd='go vet .;read',count=2,direction='float'})<CR>"
    }
  )
  vim.api.nvim_create_autocmd(
    { "FileType" },
    {
      pattern = "*.rs",
      command = "nnoremap <leader>H <cmd>lua require('lvim.core.terminal')._exec_toggle({cmd='cargo clippy;read',count=2,direction='float'})<CR>"
    }
  )
  vim.api.nvim_create_autocmd({"FileType"}, {pattern="*.rs", command="nnoremap <leader>lm <Cmd>RustExpandMacro<CR>"})
  vim.api.nvim_create_autocmd({"FileType"}, {pattern="*.rs", command="nnoremap <leader>lH <Cmd>RustToggleInlayHints<CR>"})
  vim.api.nvim_create_autocmd({"FileType"}, {pattern="*.rs", command="nnoremap <leader>le <Cmd>RustRunnables<CR>"})
  vim.api.nvim_create_autocmd({"FileType"}, {pattern="*.rs", command="nnoremap <leader>lh <Cmd>RustHoverActions<CR>"})
  vim.api.nvim_create_autocmd({"FileType"}, {pattern="*.rs", command="nnoremap <leader>lc <Cmd>RustOpenCargo<CR>"})

  vim.api.nvim_create_autocmd(
    {"FileType"},
    {
      pattern= {".ts", ".tsx"},
      command = "nnoremap <leader>lA <Cmd>TSLspImportAll<CR>"
    }
  )
  vim.api.nvim_create_autocmd(
    {"FileType"},
    {
      pattern= {".ts", ".tsx"},
      command = "nnoremap <leader>lR <Cmd>TSLspRenameFile<CR>"
    }
  )
  vim.api.nvim_create_autocmd(
    {"FileType"},
    {
      pattern= {".ts", ".tsx"},
      command = "nnoremap <leader>lO <Cmd>TSLspOrganize<CR>"
    }
  )

  -- uncomment the following if you want to show diagnostics on hover
  -- { "CursorHold", "*", "lua vim.diagnostic.open_float(0,{scope='line'})" },
  -- }
end

M.make_run = function()
  return {
    -- c, cpp
    {
      "Filetype",
      "c,cpp",
      "nnoremap <leader>m <cmd>lua require('lvim.core.terminal')._exec_toggle({cmd='make ;read',count=2,direction='float'})<CR>",
    },
    {
      "Filetype",
      "c,cpp",
      "nnoremap <leader>r <cmd>lua require('lvim.core.terminal')._exec_toggle({cmd='make run;read',count=3,direction='float'})<CR>",
    },

    -- go
    {
      "Filetype",
      "go",
      "nnoremap <leader>m <cmd>lua require('lvim.core.terminal')._exec_toggle({cmd='go build -v .;read',count=2,direction='float'})<CR>",
    },
    {
      "Filetype",
      "go",
      "nnoremap <leader>r <cmd>lua require('lvim.core.terminal')._exec_toggle({cmd='go run .;read',count=3,direction='float'})<CR>",
    },

    -- python
    {
      "Filetype",
      "python",
      "nnoremap <leader>r <cmd>lua require('lvim.core.terminal')._exec_toggle({cmd='python "
        .. vim.fn.expand "%"
        .. ";read',count=2,direction='float'})<CR>",
    },
    {
      "Filetype",
      "python",
      "nnoremap <leader>m <cmd>lua require('lvim.core.terminal')._exec_toggle({cmd='echo \"compile :pepelaugh:\";read',count=2,direction='float'})<CR>",
    },

    -- rust
    {
      "Filetype",
      "rust",
      "nnoremap <leader>m <cmd>lua require('lvim.core.terminal')._exec_toggle({cmd='cargo build;read',count=2,direction='float'})<CR>",
    },
    {
      "Filetype",
      "rust",
      "nnoremap <leader>r <cmd>lua require('rust-tools.runnables').runnables()<CR>",
    },

    -- toml
    { "FileType", "toml", "lua require('cmp').setup.buffer { sources = { { name = 'crates' } } }" },

    -- markdown
    {
      "FileType",
      "markdown",
      "setlocal spell"
    }
  }
end

return M
