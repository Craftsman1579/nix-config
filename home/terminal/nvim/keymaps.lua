-- Keymaps (executed as top-level Lua in init.lua)
local map = vim.keymap.set

-- Clear search highlight
map('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear hlsearch' })

map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Diagnostic Quickfix' })
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Terminal leave' })

map('n', '<S-h>', '<cmd>bprevious<CR>', { desc = 'Previous buffer' })
map('n', '<S-l>', '<cmd>bnext<CR>', { desc = 'Next buffer' })
map('n', '<leader>bd', '<cmd>bdelete<CR>', { desc = 'Close buffer' })

-- Neo-tree (file explorer)
map('n', '<leader>e', '<cmd>Neotree filesystem toggle<CR>', { desc = 'File Explorer toggle' })
map('n', '<leader>E', '<cmd>Neotree focus<CR>', { desc = 'File Explorer focus' })
map('n', '<leader>t', "<Cmd>exe v:count1 . 'ToggleTerm'<CR>", { desc = 'Terminal toggle' })

map('n', '<leader>ff', '<cmd>Telescope find_files<CR>', { desc = 'Find Files' })
map('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', { desc = 'Find Grep' })
map('n', '<leader>fw', '<cmd>Telescope grep_string<CR>', { desc = 'Find Word' })
map('n', '<leader>fd', '<cmd>Telescope diagnostics<CR>', { desc = 'Find Diagnostics' })
map('n', '<leader>fr', '<cmd>Telescope resume<CR>', { desc = 'Find Resume' })
map('n', '<leader>fo', '<cmd>Telescope oldfiles<CR>', { desc = 'Find Recent Files' })
map('n', '<leader>fb', '<cmd>Telescope buffers<CR>', { desc = 'Find Buffers' })
map('n', '<leader>/', '<cmd>Telescope current_buffer_fuzzy_find<CR>', { desc = 'Fuzzy in Buffer' })
map('n', '<leader>fG', '<cmd>Telescope git_files<CR>', { desc = 'Find Git Files' })
map('n', '<leader>ft', '<cmd>TodoTelescope<CR>', { desc = 'Find Todo' })
map('n', '<leader>fp', '<cmd>Telescope projects<CR>', { desc = 'Find Projects' })

map('n', '<leader>cf', function() require('conform').format({ async = true, lsp_format = 'fallback' }) end, { desc = 'Code Format' })

-- DAP keymaps (only effective if DAP is loaded; otherwise ignored)
map('n', '<leader>dc', function() pcall(function() require('dap').continue() end) end, { desc = 'Debug Continue' })
map('n', '<leader>db', function() pcall(function() require('dap').toggle_breakpoint() end) end, { desc = 'Debug Breakpoint' })
map('n', '<leader>di', function() pcall(function() require('dap').step_into() end) end, { desc = 'Debug Step Into' })
map('n', '<leader>do', function() pcall(function() require('dap').step_over() end) end, { desc = 'Debug Step Over' })
map('n', '<leader>dO', function() pcall(function() require('dap').step_out() end) end, { desc = 'Debug Step Out' })
map('n', '<leader>dr', function() pcall(function() require('dap').restart() end) end, { desc = 'Debug Restart' })
map('n', '<leader>dt', function() pcall(function() require('dap').terminate() end) end, { desc = 'Debug Terminate' })
map('n', '<leader>du', function() pcall(function() require('dapui').toggle() end) end, { desc = 'Debug UI Toggle' })
map({'n','v'}, '<leader>de', function() pcall(function() require('dapui').eval() end) end, { desc = 'Debug Eval' })

map('n', '<leader>gd', '<cmd>DiffviewOpen<CR>', { desc = 'Git Diffview' })
map('n', '<leader>gh', '<cmd>DiffviewFileHistory %<CR>', { desc = 'Git File History' })

map('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<CR>', { desc = 'Diagnostics (Trouble)' })
map('n', '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<CR>', { desc = 'Buffer Diagnostics' })

-- Copilot Chat keymaps
map({'n','v'}, '<leader>aa', '<cmd>CopilotChatToggle<CR>', { desc = 'AI Chat Toggle' })
map('v', '<leader>ae', '<cmd>CopilotChatExplain<CR>', { desc = 'AI Explain' })
map('v', '<leader>ar', '<cmd>CopilotChatReview<CR>', { desc = 'AI Review' })
map('v', '<leader>af', '<cmd>CopilotChatFix<CR>', { desc = 'AI Fix' })
map('v', '<leader>at', '<cmd>CopilotChatTests<CR>', { desc = 'AI Tests' })

map({'n','v'}, '<leader>aq', function()
  local input = vim.fn.input('Copilot: ')
  if input ~= '' then vim.cmd('CopilotChat ' .. input) end
end, { desc = 'AI Quick Chat' })
