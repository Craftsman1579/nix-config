{ pkgs, inputs, ... }:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.alex = {
      imports = [
        ../home/alex-darwin.nix
      ];
      programs.zsh.shellAliases.nix-switch = "sudo darwin-rebuild switch --flake ~/.config/nix";
    };
  };
}
