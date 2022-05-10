lvim.plugins = {
  {"tpope/vim-surround"},
  {"vimwiki/vimwiki"},
  {"ptzz/lf.vim"},
  {"easymotion/vim-easymotion"},
  {"ap/vim-css-color"},
  {"tpope/vim-repeat"},
  {"tpope/vim-commentary"},
  {"junegunn/fzf"},
  {"junegunn/fzf.vim"},
  {"dhruvasagar/vim-table-mode"},
  {
    "nvim-orgmode/orgmode",
    config = function()
        require('orgmode').setup{}
    end
  }
}
