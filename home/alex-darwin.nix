{ inputs, config, ... }:
{
  imports = [
    ./terminal
    ./terminal/git-darwin.nix
    ./cli
    ./base.nix
  ];
}
