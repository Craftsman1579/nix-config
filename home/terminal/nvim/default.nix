{ ... }:
{
  imports = [
    ./base.nix
    ./keymaps.nix
    ./editor.nix
    ./ui.nix
    ./treesitter.nix
    ./lsp.nix
    ./completion.nix
    ./git.nix
    ./dap.nix
    ./copilot.nix
    ./extra-lua.nix
  ];
}
