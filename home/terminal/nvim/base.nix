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
      nodejs
      nodePackages.typescript
      nodePackages.typescript-language-server
      prettierd
      nixfmt
      vscode-js-debug
      ripgrep
      fd
    ];

    globals = {
      mapleader = " ";
      maplocalleader = " ";
      # Pfad zum js-debug Binary - wird in extra-lua.nix fuer DAP genutzt
      js_debug_cmd = "${pkgs.vscode-js-debug}/bin/js-debug";
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
      completeopt = "menu,menuone,noselect";
       tabstop = 2;
       shiftwidth = 2;
       expandtab = true;
       smartindent = true;
       wrap = false;
     };

     autoGroups.highlight-yank.clear = true;

     colorschemes.catppuccin = {
       enable = true;
       autoLoad = true;
       callSetup = true;
       settings = {
         flavour = "macchiato";
         transparent_background = false;
         integrations = {
           cmp = true;
           gitsigns = true;
           telescope = true;
           treesitter = true;
           which_key = true;
           indent_blankline = { enabled = true; };
           lualine = true;
           trouble = true;
           noice = true;
           flash = true;
           illuminate = true;
         };
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
