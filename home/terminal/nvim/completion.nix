# Completion: blink.cmp + LuaSnip + friendly-snippets
{ ... }:

{
  programs.nixvim.plugins = {

    friendly-snippets.enable = true;

    luasnip = {
      enable = true;
      fromVscode = [ { } ];
    };

    blink-cmp = {
      enable = true;
      settings = {
        keymap = {
          preset = "super-tab";
          "<C-n>" = [
            "select_next"
            "fallback"
          ];
          "<C-p>" = [
            "select_prev"
            "fallback"
          ];
          "<C-b>" = [
            "scroll_documentation_up"
            "fallback"
          ];
          "<C-f>" = [
            "scroll_documentation_down"
            "fallback"
          ];
          "<C-y>" = [
            "select_and_accept"
            "fallback"
          ];
          "<C-Space>" = [
            "show"
            "fallback"
          ];
        };

        completion = {
          documentation = {
            auto_show = true;
            auto_show_delay_ms = 200;
          };
          ghost_text.enabled = true;
        };

        snippets.preset = "luasnip";

        sources = {
          default = [
            "lsp"
            "snippets"
            "buffer"
            "path"
          ];
          providers = {
            buffer.score_offset = -2;
          };
        };

        fuzzy.implementation = "prefer_rust_with_warning";

        signature.enabled = true;
      };
    };
  };
}
