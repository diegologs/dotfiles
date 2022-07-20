
local status_ok, lightspeed = pcall(require, "lightspeed")
if not status_ok then
  return
end

vim.cmd [[ highlight LightspeedLabel guifg=#87D7FF ]]
vim.cmd [[ highlight LightspeedLabelDistant guifg=#FFAFD7 ]]
vim.cmd [[ highlight LightspeedShortcut guifg=#000000 guibg=#87D7FF ]]
