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
      closeIfLastWindow = true;
      window.width = 30;
    };

    telescope = {
      enable = true;
      extensions.fzf-native.enable = true;
    };
  };
}
