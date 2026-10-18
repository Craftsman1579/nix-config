{ inputs, pkgs, ... }:
{
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./terminal
    ./terminal/git-darwin.nix
    ./cli
    ./base.nix
  ];

  # pkgsUnstable fuer Submodule (z.B. nvim/copilot.nix), analog zu work.nix
  _module.args.pkgsUnstable = import inputs.nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };

  programs.nixvim.lsp.servers.nixd.config.settings.nixd.options = {
    darwin.expr = "(builtins.getFlake (toString ~/.config/nix)).darwinConfigurations.my-macbook.options";
    home_manager.expr = "(builtins.getFlake (toString ~/.config/nix)).darwinConfigurations.my-macbook.options.home-manager.users.type.getSubOptions []";
  };
}
