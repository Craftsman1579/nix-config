{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./settings.nix
    ./home-manager.nix
    inputs.home-manager.darwinModules.home-manager
  ];

  # nix config
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      # disabled due to https://github.com/NixOS/nix/issues/7273
      # auto-optimise-store = true;
    };
    enable = false; # using determinate installer
  };

  nixpkgs.config.allowUnfree = true;

  # macOS-specific settings
  system.primaryUser = "alex";
  users.users.alex = {
    home = "/Users/alex";
    shell = pkgs.zsh;
  };
  environment = {
    pathsToLink = [ "/Applications" ];
  };
}
