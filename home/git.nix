{ primaryUser, ... }:
{
  programs.git = {
    enable = true;
    userName = "alex"; # TODO replace
    userEmail = "baumgaertner.al@gmail.com"; # TODO replace

    lfs.enable = true;

    ignores = [ "**/.DS_STORE" ];

    extraConfig = {
      github = {
        user = primaryUser;
      };
      init = {
        defaultBranch = "main";
      };
    };
  };
}
