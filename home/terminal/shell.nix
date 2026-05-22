_: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      la = "ls -la";
      ".." = "cd ..";
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd" "z" ];
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      character = {
        success_symbol = "[λ](bold green)";
        error_symbol = "[λ](bold red)";
      };
    };
  };
}
