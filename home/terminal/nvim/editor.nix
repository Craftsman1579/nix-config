# Editor-Plugins: Telescope, Neo-tree, Formatting, Utilities
{ ... }:

{
  programs.nixvim.plugins = {

    telescope = {
      enable = true;
      extensions.fzf-native.enable = true;
      settings.defaults.file_ignore_patterns = [
        "node_modules" ".git/" "dist/" "build/" ".nx/" "coverage/"
      ];
    };

    neo-tree = {
      enable = true;
      settings.filesystem.filtered_items = {
        hide_dotfiles = false;
        hide_gitignored = false;
        hide_by_name = [ "node_modules" ".git" ];
      };
    };

    conform-nvim = {
      enable = true;
      settings = {
        formatters_by_ft = {
          typescript.__raw = "{ 'prettierd', 'prettier', stop_after_first = true }";
          javascript.__raw = "{ 'prettierd', 'prettier', stop_after_first = true }";
          typescriptreact.__raw = "{ 'prettierd', 'prettier', stop_after_first = true }";
          javascriptreact.__raw = "{ 'prettierd', 'prettier', stop_after_first = true }";
          json.__raw = "{ 'prettierd', 'prettier', stop_after_first = true }";
          html.__raw = "{ 'prettierd', 'prettier', stop_after_first = true }";
          css.__raw = "{ 'prettierd', 'prettier', stop_after_first = true }";
          graphql.__raw = "{ 'prettierd', 'prettier', stop_after_first = true }";
          yaml.__raw = "{ 'prettierd', 'prettier', stop_after_first = true }";
          markdown.__raw = "{ 'prettierd', 'prettier', stop_after_first = true }";
          nix = [ "nixfmt" ];
        };
        format_on_save = {
          timeout_ms = 3000;
          lsp_format = "fallback";
        };
      };
    };

    comment.enable = true;
    nvim-autopairs.enable = true;
    vim-surround.enable = true;
    vim-sleuth.enable = true;
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

    flash.enable = true;

    illuminate.enable = true;

    ufo = {
      enable = true;
      settings = {
        fold_virt_text_titles = true;
        enable_get_cursor_colline = true;
      };
    };

    project-nvim = {
      enable = true;
      settings = {
        detection_methods = [ "pattern" ];
        patterns = [ ".git" "package.json" ];
        sync_with_buffer = true;
      };
    };
  };
}
