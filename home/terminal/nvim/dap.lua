local M = {}

local dap = require('dap')

-- Default pwa-node adapter. If you want to use the vscode-js-debug from Nix,
-- inject the path from Nix into this file or into the Nix string that wraps this file.
dap.adapters.pwa_node = {
  type = 'server',
  host = 'localhost',
  port = '${port}', -- placeholder if you want to replace via Nix string
}

-- Example configurations for typescript/javascript
dap.configurations.typescript = {
  {
    type = 'pwa-node', request = 'launch', name = 'Launch File (ts-node)',
    program = '${file}', cwd = '${workspaceFolder}', runtimeExecutable = 'npx',
    runtimeArgs = { 'ts-node' }, sourceMaps = true,
    resolveSourceMapLocations = { '${workspaceFolder}/**', '!**/node_modules/**' },
  },
  {
    type = 'pwa-node', request = 'launch', name = 'Launch NestJS (Debug)',
    runtimeExecutable = 'npx', runtimeArgs = { 'nest', 'start', '--debug', '--watch' },
    cwd = '${workspaceFolder}', sourceMaps = true, console = 'integratedTerminal',
  },
  {
    type = 'pwa-node', request = 'attach', name = 'Attach to Process',
    processId = require('dap.utils').pick_process, cwd = '${workspaceFolder}', sourceMaps = true,
  },
  {
    type = 'pwa-node', request = 'attach', name = 'Attach Gateway (:9229)', port = 9229,
    cwd = '${workspaceFolder}', sourceMaps = true, resolveSourceMapLocations = { '${workspaceFolder}/**', '!**/node_modules/**' },
  },
  {
    type = 'pwa-node', request = 'attach', name = 'Attach Service (:9230)', port = 9230,
    cwd = '${workspaceFolder}', sourceMaps = true, resolveSourceMapLocations = { '${workspaceFolder}/**', '!**/node_modules/**' },
  },
  {
    type = 'pwa-node', request = 'launch', name = 'Debug Jest Tests',
    runtimeExecutable = 'node', runtimeArgs = { './node_modules/.bin/jest', '--runInBand', '--no-coverage' },
    cwd = '${workspaceFolder}', console = 'integratedTerminal', sourceMaps = true,
  }
}

return M
