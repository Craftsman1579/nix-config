{ pkgs, ... }:
{
  programs.nixvim = {
    plugins = {
      dap = {
        enable = true;
        extensions = {
          dap-ui.enable = true;
          dap-virtual-text.enable = true;
        };
      };
    };

    extraPackages = with pkgs; [
      vscode-js-debug
    ];

    extraConfigLua = ''
      -- JS/TS Debug Adapter
      local dap = require("dap")
      local dapui = require("dapui")

      -- Adapter konfigurieren
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "$''${port}",
        executable = {
          command = "node",
          args = {
            "$''${pkgs.vscode-js-debug}/lib/vscode-js-debug/js-debug/src/dapDebugServer.js",
            "$''${port}",
          },
        },
      }

      -- Konfigurationen für node & typescript
      for _, language in ipairs({ "typescript", "javascript" }) do
        dap.configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "$''${file}",
            cwd = "$''${workspaceFolder}",
            sourceMaps = true,
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach to process",
            processId = require("dap.utils").pick_process,
            cwd = "$''${workspaceFolder}",
            sourceMaps = true,
          },
        }
      end

      -- UI automatisch öffnen/schließen
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
    '';
  };
}
