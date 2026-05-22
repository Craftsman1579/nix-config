{ inputs, outputs, pkgs, ... }:
{
  imports = [
    /etc/qcp/nix/defaults.nix
    ./cli
    ./terminal
    ./base.nix
    inputs.nixvim.homeModules.nixvim
  ];

  home = {
    username = "coder";
    homeDirectory = "/home/coder";
  };

  programs.home-manager.enable = true;

  programs.zsh.shellAliases = {
    nix-switch = "home-manager switch --flake ~/.config/home-manager#work --impure";
  };

  programs.bash = {
    enable = true;
  };

}
