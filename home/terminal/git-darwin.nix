{ ... }:
{
  programs.git = {
    enable = true;
    lfs.enable = true;

    # macBook personal setup
    userName = "Alex";  # Ersetzen mit deinem echten Namen
    userEmail = "alex@example.com";  # Deine persönliche Email

    aliases = {
      co = "checkout";
      br = "branch";
      st = "status";
      re = "rebase";
      amend = "commit --amend --no-edit";
      undo = "reset --soft HEAD~1";
    };

    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;
      rebase.autoStash = true;
    };
  };
}
