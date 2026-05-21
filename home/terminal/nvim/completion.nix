# Completion: nvim-cmp + LuaSnip + friendly-snippets
{ ... }:

{
  programs.nixvim.plugins = {

    friendly-snippets.enable = true;

    luasnip = {
      enable = true;
      fromVscode = [ { } ]; # laedt friendly-snippets
    };

    cmp = {
      enable = true;
      settings = {
        snippet.expand.__raw =
          "function(args) require('luasnip').lsp_expand(args.body) end";

        completion.completeopt = "menu,menuone,noinsert";

        mapping = {
          "<C-n>".__raw = "cmp.mapping.select_next_item()";
          "<C-p>".__raw = "cmp.mapping.select_prev_item()";
          "<C-b>".__raw = "cmp.mapping.scroll_docs(-4)";
          "<C-f>".__raw = "cmp.mapping.scroll_docs(4)";
          "<C-y>".__raw = "cmp.mapping.confirm({ select = true })";
          "<C-Space>".__raw = "cmp.mapping.complete()";

          "<Tab>".__raw = ''
            cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif require('luasnip').expand_or_locally_jumpable() then
                require('luasnip').expand_or_jump()
              else
                fallback()
              end
            end, { 'i', 's' })
          '';

          "<S-Tab>".__raw = ''
            cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif require('luasnip').locally_jumpable(-1) then
                require('luasnip').jump(-1)
              else
                fallback()
              end
            end, { 'i', 's' })
          '';
        };

        sources = [
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          { name = "buffer"; }
          { name = "path"; }
        ];
      };
    };
  };
}
