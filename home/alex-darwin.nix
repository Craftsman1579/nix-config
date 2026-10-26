{ inputs, pkgs, ... }:
let
  pkgsUnstable = import inputs.nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
in
{
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./terminal
    ./terminal/git-darwin.nix
    ./cli
    ./base.nix
  ];

  # pkgsUnstable fuer Submodule (z.B. nvim/copilot.nix), analog zu work.nix
  _module.args.pkgsUnstable = pkgsUnstable;

  # openscad-unstable: Manifold-Backend, im stable-Channel fuer darwin nicht gecacht
  # Binary heisst openscad-unstable, daher zusaetzlich als openscad verlinkt
  home.packages = [
    pkgsUnstable.openscad-unstable
    (pkgs.runCommand "openscad-alias" { } ''
      mkdir -p $out/bin
      ln -s ${pkgsUnstable.openscad-unstable}/bin/openscad-unstable $out/bin/openscad
    '')
  ];

  programs.nixvim.lsp.servers.nixd.config.settings.nixd.options = {
    darwin.expr = "(builtins.getFlake (toString ~/.config/nix)).darwinConfigurations.my-macbook.options";
    home_manager.expr = "(builtins.getFlake (toString ~/.config/nix)).darwinConfigurations.my-macbook.options.home-manager.users.type.getSubOptions []";
  };
}
