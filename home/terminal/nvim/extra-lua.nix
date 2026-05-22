# Lua-Konfiguration die nicht im NixVim-DSL ausgedrueckt werden kann:
#   - OSC 52 Clipboard (fuer Coder Remote-Container)
#   - LSP Keymaps via LspAttach (benoetigen Telescope-Referenz)
#   - DAP Adapter + Konfigurationen (Node.js / TypeScript)
{ ... }:

let
  d = "$";
in
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
        map('<leader>D', builtin.lsp_type_definitions, 'Type Definition')
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

    -- DAP: Node.js / TypeScript Debug-Adapter (vscode-js-debug)
    local dap = require('dap')

    dap.adapters['pwa-node'] = {
      type = 'server',
      host = 'localhost',
      port = '${d}{port}',
      executable = {
        command = vim.g.js_debug_cmd or 'js-debug',
        args = { '${d}{port}' },
      },
    }

    dap.configurations.typescript = {
      {
        type = 'pwa-node', request = 'launch',
        name = 'Launch File (ts-node)',
        program = '${d}{file}', cwd = '${d}{workspaceFolder}',
        runtimeExecutable = 'npx', runtimeArgs = { 'ts-node' },
        sourceMaps = true,
        resolveSourceMapLocations = { '${d}{workspaceFolder}/**', '!**/node_modules/**' },
      },
      {
        type = 'pwa-node', request = 'launch',
        name = 'Launch NestJS (Debug)',
        runtimeExecutable = 'npx',
        runtimeArgs = { 'nest', 'start', '--debug', '--watch' },
        cwd = '${d}{workspaceFolder}', sourceMaps = true,
        resolveSourceMapLocations = { '${d}{workspaceFolder}/**', '!**/node_modules/**' },
        console = 'integratedTerminal',
      },
      {
        type = 'pwa-node', request = 'attach',
        name = 'Attach to Process',
        processId = require('dap.utils').pick_process,
        cwd = '${d}{workspaceFolder}', sourceMaps = true,
      },
      {
        type = 'pwa-node', request = 'attach',
        name = 'Attach Gateway (:9229)',
        port = 9229, cwd = '${d}{workspaceFolder}', sourceMaps = true,
        resolveSourceMapLocations = { '${d}{workspaceFolder}/**', '!**/node_modules/**' },
      },
      {
        type = 'pwa-node', request = 'attach',
        name = 'Attach Service (:9230)',
        port = 9230, cwd = '${d}{workspaceFolder}', sourceMaps = true,
        resolveSourceMapLocations = { '${d}{workspaceFolder}/**', '!**/node_modules/**' },
      },
      {
        type = 'pwa-node', request = 'launch',
        name = 'Debug Jest Tests',
        runtimeExecutable = 'node',
        runtimeArgs = { './node_modules/.bin/jest', '--runInBand', '--no-coverage' },
        cwd = '${d}{workspaceFolder}', console = 'integratedTerminal', sourceMaps = true,
      },
    }

    dap.configurations.javascript = dap.configurations.typescript

    dap.listeners.before.attach.dapui_config = function() require('dapui').open() end
    dap.listeners.before.launch.dapui_config = function() require('dapui').open() end
    dap.listeners.before.event_terminated.dapui_config = function() require('dapui').close() end
    dap.listeners.before.event_exited.dapui_config = function() require('dapui').close() end
  '';
}
