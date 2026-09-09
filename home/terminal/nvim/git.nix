# Git: Gitsigns
{ ... }:

{
  programs.nixvim.plugins = {

    gitsigns = {
      enable = true;
      settings = {
        signs = {
          add.text = "▎";
          change.text = "▎";
          delete.text = "";
          topdelete.text = "";
          changedelete.text = "▎";
        };
        on_attach.__raw = ''
          function(bufnr)
            local gs = require('gitsigns')
            local map = function(mode, l, r, desc)
              vim.keymap.set(mode, l, r, { buf = bufnr, desc = desc })
            end
            map('n', ']h', function() gs.nav_hunk('next') end, 'Next Hunk')
            map('n', '[h', function() gs.nav_hunk('prev') end, 'Previous Hunk')
            map('n', '<leader>gp', gs.preview_hunk, 'Git Preview Hunk')
            map('n', '<leader>gs', gs.stage_hunk, 'Git Stage Hunk')
            map('n', '<leader>gr', gs.reset_hunk, 'Git Reset Hunk')
            map('n', '<leader>gb', gs.blame_line, 'Git Blame Line')
          end
        '';
      };
    };
  };
}
