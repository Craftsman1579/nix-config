# DAP: Debugging - Adapter + Konfigurationen fuer Node.js / TypeScript
# Die komplexen DAP-Configs (mit ${port} etc.) sind in extra-lua.nix
{ ... }:

{
  programs.nixvim.plugins = {
    dap.enable = true;
    dap-ui.enable = true;
    dap-virtual-text.enable = true;
  };
}
