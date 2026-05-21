{ ... }:
{
  programs.nixvim.plugins = {
    luasnip.enable = true;

    cmp = {
      enable = true;
      settings = {
        snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
        sources = [
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          { name = "buffer"; }
          { name = "path"; }
        ];
        mapping = {
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-e>"     = "cmp.mapping.abort()";
          "<CR>"      = "cmp.mapping.confirm({ select = true })";
          "<Tab>"     = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          "<S-Tab>"   = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
          "<C-d>"     = "cmp.mapping.scroll_docs(-4)";
          "<C-f>"     = "cmp.mapping.scroll_docs(4)";
        };
      };
    };
  };
}
