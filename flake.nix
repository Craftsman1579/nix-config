{
  description = "My system configuration";
  inputs = {
    # monorepo w/ recipes ("derivations")
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    # manages configs
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # system-level software and settings (macOS)
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    # neovim configuration
    nixvim = {
      url = "github:nix-community/nixvim/nixos-26.05";
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
      inherit (self) outputs;

      forAllSystems = nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
      ];
      forAllDarwinSystems = darwin.lib.genAttrs [
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      formatters = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);
      darwinFormatters = forAllDarwinSystems (system: darwin.legacyPackages.${system}.nixfmt-rfc-style);
    in
    {
      # The nix formatter for this flake. See https://github.com/NixOS/nixfmt. Use with 'nix fmt'
      formatter = nixpkgs.lib.mergeAttrsList [
        formatters
        darwinFormatters
      ];
      # build darwin flake using:
      # $ darwin-rebuild build --flake .#<name>
      darwinConfigurations."my-macbook" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./darwin
          inputs.home-manager.darwinModules.home-manager
        ];
        specialArgs = { inherit inputs; };
      };

      # standalone home-manager for work machine
      # $ home-manager switch --flake .#work
      homeConfigurations = {
        "work" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-linux;
          extraSpecialArgs = {
            inherit inputs outputs;
          };
          modules = [ ./home/work.nix ];
        };
      };

    };
}
