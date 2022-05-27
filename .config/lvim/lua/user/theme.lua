local M = {}

M.tokyonight = function()
  vim.g.tokyonight_dev = true
  vim.g.tokyonight_style = "storm"
  vim.g.tokyonight_sidebars = {
    "qf",
    "vista_kind",
    "terminal",
    "packer",
    "spectre_panel",
    "NeogitStatus",
    "help",
  }
  vim.g.tokyonight_cterm_colors = false
  vim.g.tokyonight_terminal_colors = true
  vim.g.tokyonight_italic_comments = false
  vim.g.tokyonight_italic_keywords = true
  vim.g.tokyonight_italic_functions = false
  vim.g.tokyonight_italic_variables = false
  vim.g.tokyonight_transparent = lvim.transparent_window
  vim.g.tokyonight_hide_inactive_statusline = true
  vim.g.tokyonight_dark_sidebar = true
  vim.g.tokyonight_dim_inactive = true
  vim.g.tokyonight_global_status = true
  vim.g.tokyonight_dark_float = true
  vim.g.tokyonight_colors = { git = { change = "***REMOVED***6183bb", add = "***REMOVED***449dab", delete = "***REMOVED***f7768e", conflict = "***REMOVED***bb7a61" } }
  local _time = os.date "*t"
  if _time.hour < 8 then
    vim.g.tokyonight_style = "night"
  end
end

M.rose_pine = function()
  require("rose-pine").setup {
    ---@usage 'main'|'moon'
    dark_variant = "main",
    bold_vert_split = false,
    dim_nc_background = lvim.builtin.global_statusline,
    disable_background = lvim.transparent_window,
    disable_float_background = true,
    disable_italics = true,
    ---@usage string hex value or named color from rosepinetheme.com/palette
    groups = {
      border = "highlight_med",
      comment = "muted",
      link = "iris",
      punctuation = "subtle",

      error = "love",
      hint = "iris",
      info = "foam",
      warn = "gold",

      headings = {
        h1 = "iris",
        h2 = "foam",
        h3 = "rose",
        h4 = "gold",
        h5 = "pine",
        h6 = "foam",
      },
    },
    highlight_groups = {
      Boolean = { fg = "love" },
    },
  }
end

M.catppuccin = function()
  local catppuccin = require "catppuccin"
  catppuccin.setup {
    transparent_background = lvim.transparent_window,
    term_colors = false,
    styles = {
      comments = "NONE",
      functions = "NONE",
      keywords = "italic",
      strings = "NONE",
      variables = "NONE",
    },
    integrations = {
      treesitter = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = "italic",
          hints = "italic",
          warnings = "italic",
          information = "italic",
        },
        underlines = {
          errors = "underline",
          hints = "underline",
          warnings = "underline",
          information = "underline",
        },
      },
      lsp_trouble = true,
      cmp = true,
      lsp_saga = false,
      gitgutter = false,
      gitsigns = true,
      telescope = true,
      nvimtree = {
        enabled = true,
        show_root = false,
        transparent_panel = lvim.transparent_window,
      },
      which_key = true,
      indent_blankline = {
        enabled = true,
        colored_indent_levels = false,
      },
      dashboard = true,
      neogit = false,
      vim_sneak = false,
      fern = false,
      barbar = false,
      bufferline = true,
      markdown = true,
      lightspeed = lvim.builtin.motion_provider == "lightspeed",
      ts_rainbow = false,
      hop = lvim.builtin.motion_provider == "hop",
      notify = true,
      telekasten = true,
      symbols_outline = true,
    },
  }
end

M.kanagawa = function()
  local kanagawa = require "kanagawa"
  kanagawa.setup {
    undercurl = true, -- enable undercurls
    commentStyle = "NONE",
    functionStyle = "NONE",
    keywordStyle = "italic",
    statementStyle = "italic",
    typeStyle = "NONE",
    variablebuiltinStyle = "italic",
    specialReturn = true, -- special highlight for the return keyword
    specialException = true, -- special highlight for exception handling keywords
    dimInactive = lvim.builtin.global_statusline, -- dim inactive window `:h hl-NormalNC`
    globalStatus = lvim.builtin.global_statusline, -- adjust window separators highlight for laststatus=3
    transparent = lvim.transparent_window,
    colors = { sumiInk1b = "***REMOVED***1b1b23" },
    overrides = {
      diffRemoved = { fg = "***REMOVED***E46876" },
    },
  }
end

M.colors = {
  tokyonight_colors = {
    none = "NONE",
    bg_dark = "***REMOVED***1f2335",
    bg_alt = "***REMOVED***1f2335",
    bg = "***REMOVED***1a1b26",
    bg_br = "***REMOVED***292e42",
    terminal_black = "***REMOVED***414868",
    fg = "***REMOVED***c0caf5",
    fg_dark = "***REMOVED***a9b1d6",
    fg_gutter = "***REMOVED***3b4261",
    dark3 = "***REMOVED***545c7e",
    comment = "***REMOVED***565f89",
    dark5 = "***REMOVED***737aa2",
    blue0 = "***REMOVED***3d59a1",
    blue = "***REMOVED***7aa2f7",
    cyan = "***REMOVED***7dcfff",
    blue1 = "***REMOVED***2ac3de",
    blue2 = "***REMOVED***0db9d7",
    blue5 = "***REMOVED***89ddff",
    blue6 = "***REMOVED***B4F9F8",
    blue7 = "***REMOVED***394b70",
    violet = "***REMOVED***bb9af7",
    magenta = "***REMOVED***bb9af7",
    magenta2 = "***REMOVED***ff007c",
    purple = "***REMOVED***9d7cd8",
    orange = "***REMOVED***ff9e64",
    yellow = "***REMOVED***e0af68",
    green = "***REMOVED***9ece6a",
    green1 = "***REMOVED***73daca",
    green2 = "***REMOVED***41a6b5",
    teal = "***REMOVED***1abc9c",
    red = "***REMOVED***f7768e",
    red1 = "***REMOVED***db4b4b",
    -- git = { change = "***REMOVED***6183bb", add = "***REMOVED***449dab", delete = "***REMOVED***914c54", conflict = "***REMOVED***bb7a61" },
    git = { change = "***REMOVED***6183bb", add = "***REMOVED***449dab", delete = "***REMOVED***f7768e", conflict = "***REMOVED***bb7a61" },
    gitSigns = { add = "***REMOVED***164846", change = "***REMOVED***394b70", delete = "***REMOVED***823c41" },
  },

  rose_pine_colors = {
    none = "NONE",
    bg = "***REMOVED***2a273f",
    fg = "***REMOVED***e0def4",
    fg_gutter = "***REMOVED***3b4261",
    black = "***REMOVED***393b44",
    gray = "***REMOVED***2a2e36",
    red = "***REMOVED***eb6f92",
    green = "***REMOVED***97c374",
    yellow = "***REMOVED***f6c177",
    blue = "***REMOVED***9ccfd8",
    magenta = "***REMOVED***c4a7e7",
    cyan = "***REMOVED***9ccfd8",
    white = "***REMOVED***dfdfe0",
    orange = "***REMOVED***ea9a97",
    pink = "***REMOVED***D67AD2",
    black_br = "***REMOVED***7f8c98",
    red_br = "***REMOVED***e06c75",
    green_br = "***REMOVED***58cd8b",
    yellow_br = "***REMOVED***FFE37E",
    bg_br = "***REMOVED***393552",
    blue_br = "***REMOVED***84CEE4",
    violet = "***REMOVED***B8A1E3",
    cyan_br = "***REMOVED***59F0FF",
    white_br = "***REMOVED***FDEBC3",
    orange_br = "***REMOVED***F6A878",
    pink_br = "***REMOVED***DF97DB",
    comment = "***REMOVED***526175",
    bg_alt = "***REMOVED***191724",
    git = {
      add = "***REMOVED***84Cee4",
      change = "***REMOVED***c4a7e7",
      delete = "***REMOVED***eb6f92",
      conflict = "***REMOVED***f6c177",
    },
  },

  catppuccin_colors = {
    rosewater = "***REMOVED***F5E0DC",
    flamingo = "***REMOVED***F2CDCD",
    violet = "***REMOVED***DDB6F2",
    pink = "***REMOVED***F5C2E7",
    red = "***REMOVED***F28FAD",
    maroon = "***REMOVED***E8A2AF",
    orange = "***REMOVED***F8BD96",
    yellow = "***REMOVED***FAE3B0",
    green = "***REMOVED***ABE9B3",
    blue = "***REMOVED***96CDFB",
    cyan = "***REMOVED***89DCEB",
    teal = "***REMOVED***B5E8E0",
    lavender = "***REMOVED***C9CBFF",
    white = "***REMOVED***D9E0EE",
    gray2 = "***REMOVED***C3BAC6",
    gray1 = "***REMOVED***988BA2",
    gray0 = "***REMOVED***6E6C7E",
    black4 = "***REMOVED***575268",
    bg_br = "***REMOVED***302D41",
    bg = "***REMOVED***1A1826",
    bg_alt = "***REMOVED***1E1E2E",
    fg = "***REMOVED***D9E0EE",
    black = "***REMOVED***1A1826",
    git = {
      add = "***REMOVED***ABE9B3",
      change = "***REMOVED***96CDFB",
      delete = "***REMOVED***F28FAD",
      conflict = "***REMOVED***FAE3B0",
    },
  },

  kanagawa_colors = {
    bg = "***REMOVED***16161D",
    bg_alt = "***REMOVED***1F1F28",
    bg_br = "***REMOVED***363646",
    fg = "***REMOVED***DCD7BA",
    red = "***REMOVED***E46876",
    orange = "***REMOVED***FFA066",
    yellow = "***REMOVED***DCA561",
    blue = "***REMOVED***7FB4CA",
    cyan = "***REMOVED***658594",
    violet = "***REMOVED***957FB8",
    magenta = "***REMOVED***938AA9",
    green = "***REMOVED***76946A",
    git = {
      add = "***REMOVED***76946A",
      conflict = "***REMOVED***252535",
      delete = "***REMOVED***C34043",
      change = "***REMOVED***DCA561",
    },
  },
}

M.current_colors = function()
  local colors = M.colors.tokyonight_colors
  local _time = os.date "*t"
  if _time.hour >= 1 and _time.hour < 9 then
    colors = M.colors.rose_pine_colors
  elseif _time.hour >= 9 and _time.hour < 17 then
    colors = M.colors.tokyonight_colors
  elseif _time.hour >= 17 and _time.hour < 21 then
    colors = M.colors.catppuccin_colors
  elseif (_time.hour >= 21 and _time.hour < 24) or (_time.hour >= 0 and _time.hour < 1) then
    colors = M.colors.kanagawa_colors
  end
  return colors
end

M.hi_colors = function()
  local colors = {
    bg = "***REMOVED***16161D",
    bg_alt = "***REMOVED***1F1F28",
    fg = "***REMOVED***DCD7BA",
    green = "***REMOVED***76946A",
    red = "***REMOVED***E46876",
  }
  local color_binds = {
    bg = { group = "NormalFloat", property = "background" },
    bg_alt = { group = "Cursor", property = "foreground" },
    fg = { group = "Cursor", property = "background" },
    green = { group = "diffAdded", property = "foreground" },
    red = { group = "diffRemoved", property = "foreground" },
  }
  local function get_hl_by_name(name)
    local ret = vim.api.nvim_get_hl_by_name(name.group, true)
    return string.format("***REMOVED***%06x", ret[name.property])
  end
  for k, v in pairs(color_binds) do
    local found, color = pcall(get_hl_by_name, v)
    if found then
      colors[k] = color
    end
  end
  return colors
end

M.telescope_theme = function()
  local function set_bg(group, bg)
    vim.cmd("hi " .. group .. " guibg=" .. bg)
  end

  local function set_fg_bg(group, fg, bg)
    vim.cmd("hi " .. group .. " guifg=" .. fg .. " guibg=" .. bg)
  end

  local colors = M.hi_colors()
  -- set_fg_bg("WinSeparator", colors.bg, "None")
  set_fg_bg("NormalFloat", colors.fg, colors.bg)
  set_fg_bg("FloatBorder", colors.fg, colors.bg)
  set_fg_bg("TelescopeBorder", colors.bg_alt, colors.bg)
  set_fg_bg("TelescopePromptBorder", colors.bg, colors.bg)
  set_fg_bg("TelescopePromptNormal", colors.fg, colors.bg_alt)
  set_fg_bg("TelescopePromptPrefix", colors.red, colors.bg)
  set_bg("TelescopeNormal", colors.bg)
  set_fg_bg("TelescopePreviewTitle", colors.bg, colors.green)
  set_fg_bg("LvimInfoHeader", colors.bg, colors.green)
  set_fg_bg("LvimInfoIdentifier", colors.red, colors.bg_alt)
  set_fg_bg("TelescopePromptTitle", colors.bg, colors.red)
  set_fg_bg("TelescopeResultsTitle", colors.bg, colors.bg)
  set_fg_bg("TelescopeResultsBorder", colors.bg, colors.bg)
  set_bg("TelescopeSelection", colors.bg_alt)
end

return M
