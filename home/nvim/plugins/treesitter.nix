{ ... }:
{
  programs.nixvim.plugins.treesitter = {
    enable = true;
    settings = {
      highlight.enable = true;
      indent.enable = true;
      ensure_installed = [
        "typescript"
        "tsx"
        "javascript"
        "json"
        "yaml"
        "graphql"
        "nix"
        "lua"
        "markdown"
        "bash"
        "dockerfile"
        "toml"
        "css"
        "html"
      ];
    };
  };
}
