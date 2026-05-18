{ pkgs, ... }:
{
  imports = [
    ./options.nix
    ./keymaps.nix
    ./plugins
  ];

  programs.nixvim = {
    enable = true;

    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    extraPackages = with pkgs; [
      nodePackages.prettier
      nixfmt-rfc-style
      typescript
      nodePackages.typescript-language-server
    ];
  };
}
