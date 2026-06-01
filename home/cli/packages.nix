{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # core tools
    curl
    fzf
    htop
    tree
    ripgrep
    gh
    lazygit
    opencode
    k9s

    openclaw
    # dev tools
    nil
    biome
    nixfmt
  ];
}
