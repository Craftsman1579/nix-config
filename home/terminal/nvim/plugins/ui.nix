{ ... }:
{
  programs.nixvim.plugins = {
    web-devicons.enable = true;

    lualine.enable = true;

    bufferline.enable = true;

    indent-blankline.enable = true;

    which-key.enable = true;

    noice.enable = true;

    neo-tree = {
      enable = true;
      settings = {
        close_if_last_window = true;
        window.width = 30;
      };
    };

    telescope = {
      enable = true;
      extensions = {
        fzf-native.enable = true;
        project-nvim.enable = true;
      };
    };

    project-nvim = {
      enable = true;
      settings = {
        manual_mode = false;
        detection_methods = [ "pattern" "lsp" ];
        patterns = [ ".git" "flake.nix" "package.json" "Cargo.toml" ];
        show_hidden = false;
      };
    };
  };
}
