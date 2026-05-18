{ ... }:
{
  programs.nixvim.plugins.toggleterm = {
    enable = true;
    settings = {
      open_mapping = "[[<C-t>]]";
      direction = "horizontal";
      size = 15;
      float_opts.border = "curved";
      shade_terminals = true;
      persist_mode = true;
    };
  };
}
