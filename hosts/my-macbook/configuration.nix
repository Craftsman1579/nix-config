{
  pkgs,
  primaryUser,
  ...
}:
{
  networking.hostName = "my-macbook";

  # host-specific homebrew casks
  homebrew.casks = [
    # "slack"
  ];

  # host-specific home-manager configuration
  home-manager.users.${primaryUser} = {
    home.packages = with pkgs; [
      graphite-cli
      glab
    ];
    programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      la = "ls -la";
      ".." = "cd ..";
      "nix-switch" = "sudo darwin-rebuild switch --flake ~/.config/nix";
    };
  };

  };
}
