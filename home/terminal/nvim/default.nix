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
      # Use initLua (newer option name) to provide the base Lua config
      initLua = ''
${builtins.readFile ./base.lua}
'';

      plugins =
        with pkgs.vimPlugins;
        let
          toLua = str: "lua << EOF\n${str}\nEOF\n";
          toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
        in
        [
          {
            plugin = nvim-lspconfig;
            type = "lua";
            config = toLuaFile ./lsp-config.lua;
          }

          {
            plugin = tiny-inline-diagnostic-nvim;
            type = "lua";
            config = toLuaFile ./tiny-inline-diagnostic.lua;
          }

          # DAP plugins removed

          {
            plugin = nvim-cmp;
            type = "lua";
            config = toLuaFile ./cmp.lua;
          }

          { plugin = cmp-nvim-lsp; type = "lua"; }

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
            type = "lua";
            config = toLuaFile ./treesitter.lua;
          }

          {
            plugin = telescope-nvim;
            type = "lua";
            config = toLuaFile ./telescope.lua;
          }
          {
            plugin = telescope-fzf-native-nvim;
            type = "lua";
            config = toLua "require('telescope').load_extension('fzf')";
          }

          { plugin = vim-nix; type = "lua"; }

          {
            plugin = nvim-solarized-lua;
            type = "lua";
            config = toLuaFile ./solarized.lua;
          }

          {
            plugin = which-key-nvim;
            type = "lua";
            config = toLuaFile ./which-key.lua;
          }

          {
            plugin = twilight-nvim;
            type = "lua";
            config = toLuaFile ./twilight.lua;
          }
        ];
    };
  };
}
