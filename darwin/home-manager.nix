{ pkgs, inputs, self, primaryUser, ... }:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${primaryUser} = {
      imports = [
        ../home
        ../home/gui
      ];
      programs.zsh.shellAliases.nix-switch = "sudo darwin-rebuild switch --flake ~/.config/nix";
    };
    extraSpecialArgs = {
      inherit inputs self primaryUser;
    };
  };
}
