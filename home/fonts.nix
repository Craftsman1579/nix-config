{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Nerd Font für nvim Icons (lualine, neo-tree etc.)
    nerd-fonts.jetbrains-mono
  ];
}
