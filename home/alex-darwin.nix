{ inputs, ... }:
{
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./terminal
    ./terminal/git-darwin.nix
    ./cli
    ./base.nix
  ];

  programs.nixvim.lsp.servers.nixd.config.settings.nixd.options = {
    darwin.expr = "(builtins.getFlake (toString ~/.config/home-manager)).darwinConfigurations.my-macbook.options";
    home_manager.expr = "(builtins.getFlake (toString ~/.config/home-manager)).darwinConfigurations.my-macbook.options.home-manager.users.type.getSubOptions []";
  };
}
