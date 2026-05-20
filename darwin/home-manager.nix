{ pkgs, inputs, self, primaryUser, ... }:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${primaryUser} = {
      imports = [
        ../home
        ../home/ollama.nix
      ];
    };
    extraSpecialArgs = {
      inherit inputs self primaryUser;
    };
  };
}
