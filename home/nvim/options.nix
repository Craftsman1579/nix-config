{ ... }:
{
  programs.nixvim = {
    colorschemes.catppuccin = {
      enable = true;
      settings.flavour = "mocha";
    };

    opts = {
      # Line numbers
      number = true;
      relativenumber = true;
      signcolumn = "yes";
      cursorline = true;
      scrolloff = 8;
      sidescrolloff = 8;

      # Indentation
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      smartindent = true;

      # Layout
      wrap = false;
      termguicolors = true;
      splitright = true;
      splitbelow = true;

      # Search
      ignorecase = true;
      smartcase = true;
      hlsearch = true;
      incsearch = true;

      # Performance
      updatetime = 100;
      timeoutlen = 300;

      # Persistent undo
      undofile = true;
    };
  };
}
