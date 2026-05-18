{ ... }:
{
  programs.nixvim.plugins = {
    # Automatische Klammern & HTML-Tags
    nvim-autopairs.enable = true;
    ts-autotag.enable = true;

    # Kommentare (gcc / gc)
    comment.enable = true;

    # Surround (ys / cs / ds)
    surround.enable = true;

    # Besseres % matching
    vim-matchup.enable = true;

    # Projekt-weites Suchen & Ersetzen (<leader>S)
    spectre.enable = true;

    # Automatisches Formatieren beim Speichern
    conform-nvim = {
      enable = true;
      settings = {
        format_on_save = {
          lsp_fallback = true;
          timeout_ms = 500;
        };
        formatters_by_ft = {
          typescript      = [ "prettier" ];
          typescriptreact = [ "prettier" ];
          javascript      = [ "prettier" ];
          json            = [ "prettier" ];
          yaml            = [ "prettier" ];
          graphql         = [ "prettier" ];
          nix             = [ "nixfmt" ];
          markdown        = [ "prettier" ];
        };
      };
    };
  };
}
