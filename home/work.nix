{ inputs, pkgs, primaryUser, ... }:
{
  imports = [
    ./default.nix
    inputs.nixvim.homeModules.nixvim
    /etc/qcp/nix/defaults.nix
  ];

  home = {
    username = primaryUser;
    homeDirectory = "/home/${primaryUser}";
    stateVersion = "25.05";
  };

  programs.zsh.shellAliases = {
    nix-switch = "home-manager switch --flake ~/.config/nix";
  };
}
