-- Working with multiple buffers
lvim.keys.normal_mode["<A-h>"] = "<C-w>h"
lvim.keys.normal_mode["<A-j>"] = "<C-w>j"
lvim.keys.normal_mode["<A-k>"] = "<C-w>k"
lvim.keys.normal_mode["<A-l>"] = "<C-w>l"
lvim.keys.normal_mode["f"] = ":Files<CR>"

vim.cmd([[
source $XDG_CONFIG_HOME/lvim/lua/mappings.vim
source $XDG_CONFIG_HOME/lvim/lua/autocmds.vim
]])
