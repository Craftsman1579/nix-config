{ ... }:
{
  programs.mise = {
    enable = true;
    enableZshIntegration = true;

    globalConfig = {
      settings = {
        experimental = true;
        verbose = false;
        auto_install = true;
      };
      tools = {
        node = "lts";
        bun = "latest";
        deno = "latest";
        uv = "latest";
        rust = "stable";
      };
      env = {
        MISE_NODE_COREPACK = "true";
      };
    };
  };
}
