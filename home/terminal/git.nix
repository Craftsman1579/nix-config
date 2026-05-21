{ primaryUser, ... }:
{
  programs.git = {
    enable = true;

    lfs.enable = true;

    ignores = [ "**/.DS_STORE" ];

    settings = {
      user = {
        name = "alex"; # TODO replace
        email = "baumgaertner.al@gmail.com"; # TODO replace
      };
      github = {
        user = primaryUser;
      };
      init = {
        defaultBranch = "main";
      };
    };
  };
}
