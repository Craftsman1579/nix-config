{ ... }:
{
  programs.git = {
    enable = true;
    lfs.enable = true;

    settings = {
      user = {
        name = "Alex";
        email = "alex@example.com";
      };
      alias = {
        co = "checkout";
        br = "branch";
        st = "status";
        re = "rebase";
        amend = "commit --amend --no-edit";
        undo = "reset --soft HEAD~1";
      };
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;
      rebase.autoStash = true;
    };
  };
}
