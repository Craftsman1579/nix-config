local M = {}

require('telescope').setup{
  defaults = {
    file_ignore_patterns = { 'node_modules', '.git/', 'dist/', 'build/', '.nx/', 'coverage/' },
  }
}

-- Load fzf native if available
pcall(require('telescope').load_extension, 'fzf')

return M
