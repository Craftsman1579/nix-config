{ inputs, config, ... }:
{
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./terminal
    ./cli
    ./base.nix
  ];
}
