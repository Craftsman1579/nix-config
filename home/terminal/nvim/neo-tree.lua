-- Neo-tree file explorer setup
local ok, neo_tree = pcall(require, 'neo-tree')
if not ok then return end

neo_tree.setup({
  filesystem = {
    filtered_items = {
      hide_dotfiles = false,
      hide_gitignored = false,
      hide_by_name = {
        'node_modules',
        '.git',
      },
    },
    follow_current_file = { enabled = true },
  },
  window = {
    width = 30,
    sidebar_padding = 1,
  },
  default_component_configs = {
    icon = {
      enable_default_extensions = true,
    },
  },
})
