{
  pkgs,
  primaryUser,
  ...
}:
{
  networking.hostName = "my-macbook";

  homebrew.casks = [
    # "slack"
  ];

  home-manager.useGlobalPkgs = true;    # ← neu
  home-manager.useUserPackages = true;  # ← neu

  home-manager.users.${primaryUser} = {
    home.stateVersion = "24.05";        # ← neu
    home.packages = with pkgs; [
      graphite-cli
      glab
    ];
  };
}