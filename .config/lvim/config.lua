-- Neovim (my default settings)
-- =========================================
require("user.neovim").config()


-- General
-- =========================================
lvim.log.level = "warn"
lvim.builtin.notify.active = true
lvim.format_on_save = false
lvim.colorscheme = "onedarker"
lvim.leader = "space"
lvim.keys.normal_mode[";"] = ":"

-- Customization
-- =========================================
-- Initialzing values (~/.local/repos/bloated-lvim-config for more)
-- =========================================
lvim.builtin.sell_your_soul_to_devil = { active = false, prada = false } -- if you want microsoft to abuse your soul
lvim.builtin.lastplace = { active = false } -- change to false if you are jumping to future
lvim.builtin.tabnine = { active = false } -- change to false if you don't like tabnine
lvim.builtin.persistence = { active = false } -- change to false if you don't want persistence
lvim.builtin.presence = { active = false } -- change to true if you want discord presence
lvim.builtin.orgmode = { active = false } -- change to true if you want orgmode.nvim
lvim.builtin.dap.active = false -- change this to enable/disable debugging
lvim.builtin.fancy_statusline = { active = false } -- enable/disable fancy statusline
lvim.builtin.fancy_wild_menu = { active = false } -- enable/disable cmp-cmdline
lvim.builtin.fancy_diff = { active = false } -- enable/disable fancier git diff
lvim.builtin.lua_dev = { active = false } -- change this to enable/disable folke/lua_dev
lvim.builtin.test_runner = { active = false } -- change this to enable/disable vim-test, ultest
lvim.builtin.cheat = { active = false } -- enable cheat.sh integration
lvim.builtin.sql_integration = { active = false } -- use sql integration
lvim.builtin.smooth_scroll = "cinnamon" -- for smoth scrolling, can be "cinnamon", "neoscroll" or ""
lvim.builtin.neoclip = { active = false, enable_persistent_history = false }
lvim.builtin.nonumber_unfocus = false -- diffrentiate between focused and non focused windows
lvim.builtin.custom_web_devicons = false -- install https://github.com/Nguyen-Hoang-Nam/mini-file-icons
lvim.builtin.harpoon = { active = false } -- use the harpoon plugin
lvim.builtin.remote_dev = { active = false } -- enable/disable remote development
lvim.builtin.cursorline = { active = false } -- use a bit fancier cursorline
lvim.builtin.motion_provider = "hop" -- change this to use different motion providers ( hop or lightspeed )
lvim.builtin.hlslens = { active = false } -- enable/disable hlslens
lvim.builtin.csv_support = false -- enable/disable csv support
lvim.builtin.sidebar = { active = false } -- enable/disable sidebar
lvim.builtin.async_tasks = { active = false } -- enable/disable async tasks
lvim.builtin.metals = {
  active = false, -- enable/disable nvim-metals for scala development
  fallbackScalaVersion = "2.13.7",
  serverVersion = "0.10.9+271-a8bb69f6-SNAPSHOT",
}
lvim.builtin.collaborative_editing = { active = false } -- enable/disable collaborative editing
lvim.builtin.file_browser = { active = false } -- enable/disable telescope file browser
lvim.builtin.sniprun = { active = false } -- enable/disable sniprun
lvim.builtin.tag_provider = "symbols-outline" -- change this to use different tag providers ( symbols-outline or vista )
lvim.builtin.editorconfig = { active = false } -- enable/disable editorconfig
lvim.builtin.global_statusline = false -- set true to use global statusline
lvim.builtin.dressing = { active = false } -- enable to override vim.ui.input and vim.ui.select with telescope
lvim.builtin.refactoring = { active = false } -- enable to use refactoring.nvim code_actions

-- Setting values for user
-- =========================================
local user = os.getenv "USER"
if user and user == "mokou" then
  lvim.builtin.dap.active = true
  lvim.builtin.csv_support = true
  lvim.builtin.sql_integration.active = true
  lvim.builtin.lastplace.active = true
  lvim.builtin.test_runner.active = true
  lvim.builtin.cheat.active = true
  lvim.builtin.neoclip.active = true
  lvim.builtin.sniprun.active = true
  lvim.builtin.cursorline.active = true
  lvim.builtin.hlslens.active = true
  lvim.builtin.async_tasks.active = false
end
-- Global Lunarvim
-- =========================================
lvim.lsp.diagnostics.virtual_text = false -- I don't like virtual_text


-- Sourcing other files
-- =========================================
if lvim.builtin.dap.active then
  require("user.dap").config()
end

require("user.null_ls").config()

-- Additional Plugins
-- =========================================
require("user.plugins").config()

-- Autocommands
-- =========================================
require("user.autocommands").config()

-- Additional keybindings
-- =========================================
require("user.keybindings").config()
