# Lua-Konfiguration die nicht im NixVim-DSL ausgedrueckt werden kann:
#   - OSC 52 Clipboard (fuer Coder Remote-Container)
#   - LSP Keymaps via LspAttach (benoetigen Telescope-Referenz)
#   - DAP listeners (dapui open/close)
{ ... }:

{
  programs.nixvim.extraConfigLua = ''
    -- OSC 52 Clipboard (Remote-Container / Coder)
    vim.g.clipboard = {
      name = 'OSC 52',
      copy = {
        ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
        ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
      },
      paste = {
        ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
        ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
      },
    }

    -- LSP Keymaps (via LspAttach)
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

        if client and client.supports_method('textDocument/inlayHint') then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(
              not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }),
              { bufnr = bufnr }
            )
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

    -- DAP: listeners for dapui
    local dap = require('dap')
    local dapui = require('dapui')
    dap.listeners.before.attach.dapui_config = function() dapui.open() end
    dap.listeners.before.launch.dapui_config = function() dapui.open() end
    dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
    dap.listeners.before.event_exited.dapui_config = function() dapui.close() end
  '';
}
