local M = {}

require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'typescript','tsx','javascript',
    'json','json5','yaml','toml',
    'html','css','scss','graphql',
    'lua','nix','bash','dockerfile',
    'markdown','regex','vim','vimdoc',
    'gitcommit','gitignore','diff','jsdoc'
  },
  highlight = { enable = true },
  indent = { enable = true },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
      },
    },
    move = {
      enable = true,
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
    },
  },
}

return M
