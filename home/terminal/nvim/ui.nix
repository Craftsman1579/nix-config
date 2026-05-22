# UI: Statusleiste, Icons, Einrueckungslinien, Diagnostics, Which-Key
{ ... }:

{
  programs.nixvim.plugins = {

    web-devicons.enable = true;

    which-key = {
      enable = true;
      settings.spec = [
        { __unkeyed-1 = "<leader>s"; group = "Search"; }
        { __unkeyed-1 = "<leader>c"; group = "Code"; }
        { __unkeyed-1 = "<leader>d"; group = "Debug"; }
        { __unkeyed-1 = "<leader>g"; group = "Git"; }
        { __unkeyed-1 = "<leader>b"; group = "Buffer"; }
        { __unkeyed-1 = "<leader>t"; group = "Toggle"; }
        { __unkeyed-1 = "<leader>a"; group = "AI (Copilot)"; }
        { __unkeyed-1 = "<leader>x"; group = "Diagnostics"; }
      ];
    };

    lualine = {
      enable = true;
      settings = {
        options = {
          theme = "catppuccin";
          component_separators = { left = ""; right = ""; };
          section_separators = { left = ""; right = ""; };
        };
        sections = {
          lualine_a = [ "mode" ];
          lualine_b = [ "branch" "diff" "diagnostics" ];
          lualine_c = [ { __unkeyed-1 = "filename"; path = 1; } ];
          lualine_x = [ "encoding" "fileformat" "filetype" ];
          lualine_y = [ "progress" ];
          lualine_z = [ "location" ];
        };
      };
    };

    indent-blankline = {
      enable = true;
      settings = {
        indent.char = "│";
        scope.enabled = true;
      };
    };

    todo-comments.enable = true;
    trouble.enable = true;

    noice.enable = false;
  };
}
