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
    openssl_3

    # dev tools
    nil
    biome
    nixfmt
  ];
}
