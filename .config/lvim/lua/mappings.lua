-- Working with multiple buffers
lvim.keys.normal_mode["<A-h>"] = "<C-w>h"
lvim.keys.normal_mode["<A-j>"] = "<C-w>j"
lvim.keys.normal_mode["<A-k>"] = "<C-w>k"
lvim.keys.normal_mode["<A-l>"] = "<C-w>l"

vim.cmd([[
source $XDG_CONFIG_HOME/lvim/lua/mappings.vim
]])
