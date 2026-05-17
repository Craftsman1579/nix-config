{ ... }: {
  programs.nixvim = {
    enable = true;

    opts = {
      number = true;
      relativenumber = true;
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
    };

    plugins = {
      treesitter.enable = true;
      telescope.enable = true;
      lualine.enable = true;
      web-devicons.enable = true;
    };
  };
}
