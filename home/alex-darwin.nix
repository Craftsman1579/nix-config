{ inputs, config, ... }:
{
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./terminal
    ./terminal/git-darwin.nix
    ./cli
    ./base.nix
  ];
}
