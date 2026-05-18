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
      toggleterm.enable = true;
      neo-tree = {
        enable = true;
        settings = {  
          close_if_last_window = true;
          filesystem = {
            follow_current_file = {
              enabled = true;
              leave_dirs_open = true;
            };
          };
        }
      }
    };
  };
}
