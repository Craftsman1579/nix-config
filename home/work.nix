{ pkgs, primaryUser, ... }:
{
  imports = [
    ./default.nix
    /etc/qcp/nix/defaults.nix
  ];

  home = {
    username = primaryUser;
    homeDirectory = "/home/${primaryUser}";
    stateVersion = "25.05";
    packages = with pkgs; [
      home-manager
    ];
  };

  programs.zsh.shellAliases = {
    nix-switch = "nix run home-manager/master -- switch --flake ~/.config/nix-config#work --impure";
  };
}
