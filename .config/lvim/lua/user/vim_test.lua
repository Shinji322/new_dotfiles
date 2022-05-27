local M = {}

M.config = function()
  vim.cmd [[
          function! ToggleTermStrategy(cmd) abort
            call luaeval("require('toggleterm').exec(_A[1])", [a:cmd])
          endfunction
          let g:test***REMOVED***custom_strategies = {'toggleterm': function('ToggleTermStrategy')}
        ]]
  vim.g["test***REMOVED***strategy"] = "toggleterm"
end

return M
