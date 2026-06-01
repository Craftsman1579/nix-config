local M = {}

-- Minimal inline diagnostics using virtual text
local ns = vim.api.nvim_create_namespace('tiny_inline_diagnostic')

vim.diagnostic.config({ virtual_text = true, underline = true, signs = true })

return M
