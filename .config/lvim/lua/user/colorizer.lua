local M = {}

M.config = function()
  local status_ok, colorizer = pcall(require, "colorizer")
  if not status_ok then
    return
  end

  colorizer.setup({ "*" }, {
    RGB = true, -- ***REMOVED***RGB hex codes
    RRGGBB = true, -- ***REMOVED***RRGGBB hex codes
    RRGGBBAA = true, -- ***REMOVED***RRGGBBAA hex codes
    rgb_fn = true, -- CSS rgb() and rgba() functions
    hsl_fn = true, -- CSS hsl() and hsla() functions
    css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
  })
end

return M
