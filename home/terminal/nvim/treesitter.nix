# Treesitter: Syntax-Highlighting, Indent, Textobjects
{ pkgs, ... }:

{
  programs.nixvim.plugins = {

    treesitter = {
      enable = true;
      settings = {
        highlight.enable = true;
        indent.enable = true;
      };
      grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        typescript tsx javascript
        json json5 yaml toml
        html css scss graphql
        lua nix bash dockerfile
        markdown markdown_inline regex
        vim vimdoc
        gitcommit gitignore diff jsdoc
      ];
    };
  };
}
