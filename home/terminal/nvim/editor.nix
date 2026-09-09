# Editor-Plugins: Telescope, Neo-tree, Formatting, Utilities
{ lib, ... }:

{
  programs.nixvim.plugins = {

    telescope = {
      enable = true;
      extensions.fzf-native.enable = true;
      settings.defaults.file_ignore_patterns = [
        "node_modules"
        ".git/"
        "dist/"
        "build/"
        ".nx/"
        "coverage/"
      ];
    };

    neo-tree = {
      enable = true;
      settings.filesystem.filtered_items = {
        hide_dotfiles = false;
        hide_gitignored = false;
        hide_by_name = [
          "node_modules"
          ".git"
        ];
      };
    };

    conform-nvim = {
      enable = true;
      settings = {
        formatters_by_ft =
          lib.genAttrs
            [
              "typescript"
              "javascript"
              "typescriptreact"
              "javascriptreact"
              "json"
              "html"
              "css"
              "graphql"
              "yaml"
              "markdown"
            ]
            (_: {
              __raw = "{ 'prettierd', 'prettier', stop_after_first = true }";
            })
          // {
            nix = [ "nixfmt" ];
          };
        format_on_save = {
          timeout_ms = 3000;
          lsp_format = "fallback";
        };
      };
    };

    nvim-autopairs.enable = true;
    nvim-surround.enable = true;
    tmux-navigator.enable = true;

    toggleterm = {
      enable = true;
      settings = {
        direction = "horizontal";
        open_mapping.__raw = "[[<C-t>]]";
        shell = "zsh";
        size.__raw = ''
          function(term)
            if term.direction == "horizontal" then
              return vim.o.lines * 0.3
            elseif term.direction == "vertical" then
              return vim.o.columns * 0.4
            end
          end
        '';
      };
    };

    illuminate.enable = true;
  };
}
