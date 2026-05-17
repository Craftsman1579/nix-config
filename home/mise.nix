{ ... }:
{
  programs.mise = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      experimental = true;
      verbose = false;
      auto_install = true;
    };

    globalConfig = {
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
