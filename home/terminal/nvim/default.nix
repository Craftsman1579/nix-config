{ config,
  lib,
  pkgs,
  ...
}:
let
  all_files_in_module = builtins.attrNames (builtins.readDir ./.);
  is_lsp_config_file = f: ((lib.strings.hasPrefix "lsp-config-" f) && (lib.strings.hasSuffix ".nix" f));
  lsp_nix_files = builtins.map (f: ./${f}) ((builtins.filter is_lsp_config_file) all_files_in_module);
in
{
  imports = lsp_nix_files;

  config = {
    programs.neovim = {
      enable = lib.mkDefault true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      extraPackages = with pkgs; [
        fzf
        ripgrep
        fd

        vim-language-server
        lua-language-server
        nixd
      ];

      extraConfig = config.programs.vim.extraConfig; # read original vim config file for common options
      extraLuaConfig = builtins.readFile ./base.lua;

      plugins =
        with pkgs.vimPlugins;
        let
          toLua = str: "lua << EOF\n${str}\nEOF\n";
          toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
        in
        [
          {
            plugin = nvim-lspconfig;
            config = toLuaFile ./lsp-config.lua;
          }

          {
            plugin = tiny-inline-diagnostic-nvim;
            config = toLuaFile ./tiny-inline-diagnostic.lua;
          }

          {
            plugin = nvim-dap;
            config = toLuaFile ./dap.lua;
          }

          {
            plugin = nvim-dap-virtual-text;
            config = toLuaFile ./dap-virtual-text.lua;
          }

          {
            plugin = nvim-cmp;
            config = toLuaFile ./cmp.lua;
          }

          cmp-nvim-lsp
          cmp-dap

          {
            plugin = (
              nvim-treesitter.withPlugins (p: [
                p.tree-sitter-regex
                p.tree-sitter-json
                p.tree-sitter-yaml
                p.tree-sitter-toml
                p.tree-sitter-markdown

                p.tree-sitter-nix
                p.tree-sitter-bash
                p.tree-sitter-lua

                p.tree-sitter-vim
              ])
            );
            config = toLuaFile ./treesitter.lua;
          }

          {
            plugin = telescope-nvim;
            config = toLuaFile ./telescope.lua;
          }
          {
            plugin = telescope-dap-nvim;
            config = toLua "require('telescope').load_extension('dap')";
          }
          {
            plugin = telescope-fzf-native-nvim;
            config = toLua "require('telescope').load_extension('fzf')";
          }

          vim-nix

          {
            plugin = nvim-solarized-lua;
            config = toLuaFile ./solarized.lua;
          }

          {
            plugin = which-key-nvim;
            config = toLuaFile ./which-key.lua;
          }

          {
            plugin = twilight-nvim;
            config = toLuaFile ./twilight.lua;
          }
        ];
    };
  };
}
