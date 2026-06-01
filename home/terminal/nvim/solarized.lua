local M = {}

-- Configure solarized theme if available
pcall(function()
  require('solarized').setup()
  vim.cmd('colorscheme solarized')
end)

return M
