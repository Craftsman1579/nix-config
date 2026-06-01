-- Extra Lua bits from extra-lua.nix: OSC52 clipboard, LspAttach keymaps, DAP listeners

-- OSC52 Clipboard (minimal implementation placeholder)
pcall(function()
  vim.g.clipboard = {
    name = 'OSC 52',
    copy = {
      ['+'] = function(data) return require('vim.ui.clipboard.osc52').copy('+') end,
      ['*'] = function(data) return require('vim.ui.clipboard.osc52').copy('*') end,
    },
    paste = {
      ['+'] = function() return require('vim.ui.clipboard.osc52').paste('+') end,
      ['*'] = function() return require('vim.ui.clipboard.osc52').paste('*') end,
    },
  }
end)

-- LSP attach maps (this duplicates on_attach in lsp-config.lua but kept for completeness)
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local bufnr = ev.buf
    local builtin = require('telescope.builtin')
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
    end

    map('gd', builtin.lsp_definitions, 'Goto Definition')
    map('gr', builtin.lsp_references, 'Goto References')
    map('gI', builtin.lsp_implementations, 'Goto Implementation')
    map('<leader>cs', builtin.lsp_document_symbols, 'Code Symbols')
    map('<leader>cS', builtin.lsp_dynamic_workspace_symbols, 'Workspace Symbols')
    map('<leader>cr', vim.lsp.buf.rename, 'Code Rename')
    map('<leader>ca', vim.lsp.buf.code_action, 'Code Action')
    map('K', vim.lsp.buf.hover, 'Hover Documentation')
    map('gD', vim.lsp.buf.declaration, 'Goto Declaration')

    if client and client.supports_method and client.supports_method('textDocument/inlayHint') then
      map('<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
      end, 'Toggle Inlay Hints')
    end

    if client and client.name == 'eslint' then
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = bufnr,
        callback = function() vim.cmd('silent! EslintFixAll') end,
      })
    end
  end,
})

-- DAP listeners for dapui
pcall(function()
  local dap = require('dap')
  local dapui = require('dapui')
  dap.listeners.before.attach.dapui_config = function() dapui.open() end
  dap.listeners.before.launch.dapui_config = function() dapui.open() end
  dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
  dap.listeners.before.event_exited.dapui_config = function() dapui.close() end
end)
