# Git: Gitsigns, Fugitive, Diffview
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
              vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
            end
            map('n', ']h', gs.next_hunk, 'Next Hunk')
            map('n', '[h', gs.prev_hunk, 'Previous Hunk')
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
