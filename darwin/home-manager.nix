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
    };
    extraSpecialArgs = {
      inherit inputs self primaryUser;
    };
  };
}
