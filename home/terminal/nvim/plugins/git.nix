{ pkgs, ... }:
{
  programs.nixvim.extraPackages = [ pkgs.lazygit ];

  programs.nixvim.plugins.lazygit.enable = true;

  programs.nixvim.plugins.gitsigns = {
    enable = true;
    settings = {
      signs = {
        add.text          = "│";
        change.text       = "│";
        delete.text       = "_";
        topdelete.text    = "‾";
        changedelete.text = "~";
      };
      current_line_blame = true;
    };
  };
}
