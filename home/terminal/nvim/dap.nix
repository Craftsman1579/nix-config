# DAP: Debugging - Adapter + Konfigurationen fuer Node.js / TypeScript
# Adapter im DSL, listeners bleiben in extra-lua.nix
{ pkgs, config, ... }:

let
  inherit (config.programs.nixvim.plugins.dap) configurations;
in
{
  programs.nixvim.plugins = {
    dap = {
      enable = true;

      adapters.servers.pwa-node = {
        host = "localhost";
        port = "\${port}";
        executable = {
          command = "${pkgs.vscode-js-debug}/bin/js-debug";
          args = [ "\${port}" ];
        };
      };

      configurations = {
        typescript = [
          {
            type = "pwa-node";
            request = "launch";
            name = "Launch File (ts-node)";
            program = "\${file}";
            cwd = "\${workspaceFolder}";
            runtimeExecutable = "npx";
            runtimeArgs = [ "ts-node" ];
            sourceMaps = true;
            resolveSourceMapLocations = [
              "\${workspaceFolder}/**"
              "!**/node_modules/**"
            ];
          }
          {
            type = "pwa-node";
            request = "launch";
            name = "Launch NestJS (Debug)";
            runtimeExecutable = "npx";
            runtimeArgs = [ "nest" "start" "--debug" "--watch" ];
            cwd = "\${workspaceFolder}";
            sourceMaps = true;
            resolveSourceMapLocations = [
              "\${workspaceFolder}/**"
              "!**/node_modules/**"
            ];
            console = "integratedTerminal";
          }
          {
            type = "pwa-node";
            request = "attach";
            name = "Attach to Process";
            processId.__raw = "require('dap.utils').pick_process";
            cwd = "\${workspaceFolder}";
            sourceMaps = true;
          }
          {
            type = "pwa-node";
            request = "attach";
            name = "Attach Gateway (:9229)";
            port = 9229;
            cwd = "\${workspaceFolder}";
            sourceMaps = true;
            resolveSourceMapLocations = [
              "\${workspaceFolder}/**"
              "!**/node_modules/**"
            ];
          }
          {
            type = "pwa-node";
            request = "attach";
            name = "Attach Service (:9230)";
            port = 9230;
            cwd = "\${workspaceFolder}";
            sourceMaps = true;
            resolveSourceMapLocations = [
              "\${workspaceFolder}/**"
              "!**/node_modules/**"
            ];
          }
          {
            type = "pwa-node";
            request = "launch";
            name = "Debug Jest Tests";
            runtimeExecutable = "node";
            runtimeArgs = [
              "./node_modules/.bin/jest"
              "--runInBand"
              "--no-coverage"
            ];
            cwd = "\${workspaceFolder}";
            console = "integratedTerminal";
            sourceMaps = true;
          }
        ];
        javascript = configurations.typescript;
      };
    };

    dap-ui.enable = true;
    dap-virtual-text.enable = true;
  };
}
