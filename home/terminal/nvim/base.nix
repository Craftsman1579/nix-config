# Basis-Konfiguration: enable, opts, globals, colorscheme, autocmds
{ pkgs, inputs, ... }:

{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    nixpkgs.source = inputs.nixpkgs;

    # Externe Tools fuer Neovims PATH
    # LSP-Server werden automatisch von plugins.lsp.servers.* bereitgestellt
    extraPackages = with pkgs; [
      prettierd
      nixfmt
      vscode-js-debug
      ripgrep
      fd
    ];

    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    opts = {
      number = true;
      relativenumber = true;
      mouse = "a";
      showmode = false;
      clipboard = "unnamedplus";
      breakindent = true;
      undofile = true;
      ignorecase = true;
      smartcase = true;
      signcolumn = "yes";
      updatetime = 250;
      timeoutlen = 300;
      splitright = true;
      splitbelow = true;
      list = true;
      listchars = {
        tab = "» ";
        trail = "·";
        nbsp = "␣";
      };
      inccommand = "split";
      cursorline = true;
      scrolloff = 10;
      hlsearch = true;
      termguicolors = true;
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      smartindent = true;
      wrap = false;
     };

     autoGroups.highlight-yank.clear = true;

     colorschemes.monokai-pro = {
       enable = true;
       autoLoad = true;
       callSetup = true;
       settings = {
         transparent_background = false;
         terminal_colors = true;
         devicons = true;
         filter = "pro";
       };
     };

    autoCmd = [
      {
        event = "TextYankPost";
        group = "highlight-yank";
        callback.__raw = "function() vim.highlight.on_yank() end";
      }
    ];
  };
}
