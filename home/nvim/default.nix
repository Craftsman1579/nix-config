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
      prettier
      nixfmt
      typescript
      typescript-language-server
    ];
  };
}
