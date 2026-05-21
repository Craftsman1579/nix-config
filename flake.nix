{
  description = "My system configuration";
  inputs = {
    # monorepo w/ recipes ("derivations")
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # manages configs
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # system-level software and settings (macOS)
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    # neovim configuration
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      darwin,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      # TODO: replace with your username
      primaryUser = "alex";
    in
    {
      # build darwin flake using:
      # $ darwin-rebuild build --flake .#<name>
      darwinConfigurations."my-macbook" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./darwin
          ./hosts/my-macbook/configuration.nix
        ];
        specialArgs = { inherit inputs self primaryUser; };
      };

      # standalone home-manager for work machine
      # $ home-manager switch --flake .#work
      homeConfigurations."work" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-linux;
        extraSpecialArgs = { inherit inputs self; primaryUser = "coder"; };
        modules = [ ./home/work.nix ];
      };

    };
}
