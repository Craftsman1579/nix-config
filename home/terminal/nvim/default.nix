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
      withRuby = true;
      withPython3 = true;

      extraPackages = with pkgs; [
        fzf
        ripgrep
        fd

        vim-language-server
        lua-language-server
        nixd
      ];

      extraConfig = config.programs.vim.extraConfig; # read original vim config file for common options
      # initLua: base + keymaps (concatenated; top-level Lua)
      initLua = (builtins.readFile ./base.lua) + "\n" + (builtins.readFile ./keymaps.lua);

      plugins =
        with pkgs.vimPlugins;
        [
          {
            plugin = nvim-lspconfig;
            type = "lua";
            config = builtins.readFile ./lsp-config.lua;
          }

          {
            plugin = tiny-inline-diagnostic-nvim;
            type = "lua";
            config = builtins.readFile ./tiny-inline-diagnostic.lua;
          }

          # DAP plugins removed

          {
            plugin = nvim-cmp;
            type = "lua";
            config = builtins.readFile ./cmp.lua;
          }

          { plugin = cmp-nvim-lsp; type = "lua"; }
          { plugin = luasnip; type = "lua"; }
          { plugin = friendly-snippets; type = "lua"; }

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
            config = builtins.readFile ./treesitter.lua;
          }

          {
            plugin = telescope-nvim;
            type = "lua";
            config = builtins.readFile ./telescope.lua;
          }
          {
            plugin = telescope-fzf-native-nvim;
            type = "lua";
            config = "require('telescope').load_extension('fzf')";
          }

          { plugin = vim-nix; type = "lua"; }

          { plugin = nvim-web-devicons; type = "lua"; }

          {
            plugin = neo-tree-nvim;
            type = "lua";
            config = builtins.readFile ./neo-tree.lua;
          }

          {
            plugin = nvim-solarized-lua;
            type = "lua";
            config = builtins.readFile ./solarized.lua;
          }

          {
            plugin = which-key-nvim;
            type = "lua";
            config = builtins.readFile ./which-key.lua;
          }

          {
            plugin = twilight-nvim;
            type = "lua";
            config = builtins.readFile ./twilight.lua;
          }

          { plugin = vim-tmux-navigator; type = "lua"; }
        ];
    };
  };
}
