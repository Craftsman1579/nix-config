require('telescope').setup{
  defaults = {
    file_ignore_patterns = { 'node_modules', '.git/', 'dist/', 'build/', '.nx/', 'coverage/' },
  }
}

pcall(require('telescope').load_extension, 'fzf')
