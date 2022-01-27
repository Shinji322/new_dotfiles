-- .__         .__   __   .__                   
-- |__|  ____  |__|_/  |_ |  |   __ __ _____    
-- |  | /    \ |  |\   __\|  |  |  |  \\__  \   
-- |  ||   |  \|  | |  |  |  |__|  |  / / __ \_ 
-- |__||___|  /|__| |__|/\|____/|____/ (____  / 
--          \/          \/                  \/  
-- # My Personal configs for neovim #

-- {{ Leader Key }}
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '

-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.cmd [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]]


local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager
  use 'ludovicchabant/vim-gutentags' -- Automatic tags management
  -- UI to select things (files, grep results, open buffers...)
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use 'itchyny/lightline.vim' -- Fancier statusline
  -- Add indentation guides even on blank lines
  use 'lukas-reineke/indent-blankline.nvim'
  -- Add git related info in the signs columns and popups
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use 'nvim-treesitter/nvim-treesitter'
  -- Additional textobjects for treesitter
  use 'nvim-treesitter/nvim-treesitter-textobjects'

  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip' -- Snippets plugin

-- File Management
  use 'vimwiki/vimwiki'
  use 'ptzz/lf.vim'
  use 'voldikss/vim-floaterm'
  use 'jiangmiao/auto-pairs'
  use 'ryanoasis/vim-devicons'
  use 'preservim/nerdtree'

-- {{ LSP }}
  use 'williamboman/nvim-lsp-installer' -- Adds back :LspInstall
  use 'onsails/lspkind-nvim'

-- <leader>g
  use 'junegunn/goyo.vim'
  use 'junegunn/limelight.vim'

--  use { 'rrethy/vim-hexokinase', setup = 'make hexokinase' }
  use 'PotatoesMaster/i3-vim-syntax'

-- Basic stuff
  use 'tpope/vim-fugitive' -- Git commands in nvim
  use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
  use 'tpope/vim-commentary' -- "gc" to comment visual regions/lines
  use 'tpope/vim-surround'
  use 'liuchengxu/vim-which-key'
  use 'easymotion/vim-easymotion'
  use 'junegunn/fzf.vim'

end)




-- _ __                  __,              
-- ( /  )         o      (    _/_     /) /)
--  /--< __,  (  ,  _,    `.  /  , , // // 
-- /___/(_/(_/_)_(_(__  (___)(__(_/_//_//_ 
--                                 /) /)   
--                                (/ (/    
-- {{ Basic Stuff }}

vim.cmd([[
set title
set clipboard+=unnamedplus
set guioptions+=a
set number relativenumber
set nocompatible
set expandtab
set encoding=UTF-8
filetype plugin on
syntax on

set tabstop=4 softtabstop=4
set shiftwidth=4
set noswapfile
set undodir=~/.cache/nvim/undodir
set undofile
set timeoutlen=300

" search related things
set hlsearch
set incsearch
set ignorecase
set smartcase

" autocenter document
autocmd InsertEnter * norm zz

" Fix indenting visual block
vmap < <gv
vmap > >gv

" Other
set mouse=a
]])



--   __    __, _ __      /      _,                                  _                
--  ( /   (   ( /  )    /      / |      _/_                        //   _/_o         
--   /     `.  /--'    /      /--|  , , /  __ _, __ _ _ _    ,_   // _  / ,  __ _ _  
-- (/___/(___)/       /     _/   |_(_/_(__(_)(__(_)/ / / /__/|_)_(/_(/_(__(_(_)/ / /_
--                                                          /|                       
--                                                         (/                        
-- {{ LSP / Autocompletion }}


vim.opt.completeopt = { "menu", "menuone", "noselect" }
local lspkind = require "lspkind"
lspkind.init()

local cmp = require "cmp"

cmp.setup {
  mapping = {
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping.close(),
    ["<c-y>"] = cmp.mapping(
      cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      },
      { "i", "c" }
    ),

    ["<c-space>"] = cmp.mapping {
      i = cmp.mapping.complete(),
      c = function(
        _ --[[fallback]]
      )
        if cmp.visible() then
          if not cmp.confirm { select = true } then
            return
          end
        else
          cmp.complete()
        end
      end,
    },

    -- ["<tab>"] = cmp.mapping {
    --   i = cmp.config.disable,
    --   c = function(fallback)
    --     fallback()
    --   end,
    -- },

    -- Testing
    ["<c-q>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },

    -- If you want tab completion :'(
    --  First you have to just promise to read `:help ins-completion`.
    --
    -- ["<Tab>"] = function(fallback)
    --   if cmp.visible() then
    --     cmp.select_next_item()
    --   else
    --     fallback()
    --   end
    -- end,
    -- ["<S-Tab>"] = function(fallback)
    --   if cmp.visible() then
    --     cmp.select_prev_item()
    --   else
    --     fallback()
    --   end
    -- end,
  },

  -- Youtube:
  --    the order of your sources matter (by default). That gives them priority
  --    you can configure:
  --        keyword_length
  --        priority
  --        max_item_count
  --        (more?)
  sources = {
    { name = "gh_issues" },
    -- { name = "tn" },

    -- Youtube: Could enable this only for lua, but nvim_lua handles that already.
    { name = "nvim_lua" },

    { name = "nvim_lsp" },
    { name = "path" },
    { name = "luasnip" },
    { name = "buffer", keyword_length = 3 },
  },

  sorting = {
    -- TODO: Would be cool to add stuff like "See variable names before method names" in rust, or something like that.
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,

      -- copied from cmp-under, but I don't think I need the plugin for this.
      -- I might add some more of my own.
      function(entry1, entry2)
        local _, entry1_under = entry1.completion_item.label:find "^_+"
        local _, entry2_under = entry2.completion_item.label:find "^_+"
        entry1_under = entry1_under or 0
        entry2_under = entry2_under or 0
        if entry1_under > entry2_under then
          return false
        elseif entry1_under < entry2_under then
          return true
        end
      end,

      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },

  -- Youtube: mention that you need a separate snippets plugin
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },

  formatting = {
    -- Youtube: How to set up nice formatting for your sources.
    format = lspkind.cmp_format {
      with_text = true,
      menu = {
        buffer = "[buf]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[api]",
        path = "[path]",
        luasnip = "[snip]",
        gh_issues = "[issues]",
        tn = "[TabNine]",
      },
    },
  },

  experimental = {
    -- I like the new menu better! Nice work hrsh7th
    native_menu = false,

    -- Let's play with this for a day or two
    ghost_text = false,
  },
}

local lsp_installer = require("nvim-lsp-installer")

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
    local opts = {}

    -- (optional) Customize the options passed to the server
    -- if server.name == "tsserver" then
    --     opts.root_dir = function() ... end
    -- end

    -- This setup() function is exactly the same as lspconfig's setup function.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(opts)
end)

-- _ __                            
-- ( /  )o          /o              
--  /--<,  _ _   __/,  _ _   _,  (  
-- /___/(_/ / /_(_/_(_/ / /_(_)_/_)_
--                          /|     
--                         (/      
-- {{ Bindings }}

-- {{{ Basic stuff }}}
vim.cmd([[
nnoremap ; :
vnoremap ; :

" Aliases
cnoreabbrev W w
cnoreabbrev Q qall
cnoreabbrev q qall
cnoreabbrev wq wqall
]])
-- {{{ lf }}} 
vim.api.nvim_set_keymap("n", "<leader>f", ":Lf<CR>", { noremap = true })
-- {{{ Goyo }}} 
vim.api.nvim_set_keymap("n", "<leader>g", ":Goyo", { noremap = true })
-- {{{ Vim Surround }}}
vim.api.nvim_set_keymap("n", "<leader>wh", "yss =", { silent = true }) -- Vimwiki heading
vim.api.nvim_set_keymap("n", "<leader>whh", "yss ==", { silent = true }) -- Vimwiki subheading
-- {{{ FZF }}}
vim.api.nvim_set_keymap("n", "<leader>ss", ":Files<CR>",  { silent = false }) 
vim.api.nvim_set_keymap("n", "<leader>sm", ":Maps<CR>",  { silent = false }) 
-- {{{ Easymotion }}}
vim.cmd([[
nmap s <Plug>(easymotion-bd-f)
nmap S <Plug>(easymotion-overwin-f2)
]])
-- {{{ Which Key }}}
vim.cmd([[
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
]])

-- {{{ Shortcuts for navigating multiple windows }}}
vim.api.nvim_set_keymap("n", "<A-h>", "<C-w>h", { silent = true })
vim.api.nvim_set_keymap("n", "<A-j>", "<C-w>j", { silent = true })
vim.api.nvim_set_keymap("n", "<A-k>", "<C-w>k", { silent = true })
vim.api.nvim_set_keymap("n", "<A-l>", "<C-w>l", { silent = true })
vim.api.nvim_set_keymap("n", "<C-n>", ":NERDTreeToggle<CR>", { silent = true })



--  _ __  _                    ,___                    
-- ( /  )//        o          /   /         /)o        
--  /--'// , , _, ,  _ _     /    __ _ _   //,  _,  (  
-- /   (/_(_/_(_)_(_/ / /_  (___/(_)/ / /_//_(_(_)_/_)_
--             /|                        /)     /|     
--            (/                        (/     (/      
-- {{ Specific Plugin Configs }}


vim.g.lightline = {
	colorscheme = 'darcula',
}

vim.g.Easymotion_smartcase = 1

vim.cmd([[
" Goyo
source $XDG_CONFIG_HOME/nvim/plugin-configs/goyo.vim

" telescope 
source $XDG_CONFIG_HOME/nvim/plugin-configs/telescope.vim

" Which Key 
" source $XDG_CONFIG_HOME/nvim/plugin-configs/vim-which-key.vim
]])
