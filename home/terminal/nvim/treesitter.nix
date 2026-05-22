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

    treesitter-textobjects = {
      enable = true;
      settings = {
        select = {
          enable = true;
          lookahead = true;
          keymaps = {
            "af" = "@function.outer";
            "if" = "@function.inner";
            "ac" = "@class.outer";
            "ic" = "@class.inner";
            "aa" = "@parameter.outer";
            "ia" = "@parameter.inner";
          };
        };
        move = {
          enable = true;
          goto_next_start = {
            "]m" = "@function.outer";
            "]]" = "@class.outer";
          };
          goto_previous_start = {
            "[m" = "@function.outer";
            "[[" = "@class.outer";
          };
        };
      };
    };
  };
}
