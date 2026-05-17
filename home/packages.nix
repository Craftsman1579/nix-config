{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      # dev tools
      curl
      vim
      tmux
      htop
      tree
      ripgrep
      gh
      zoxide
      lazygit

      # programming languages
      mise # node, deno, bun, rust, python, etc.
      vscode
      # misc
      nil
      biome
      nixfmt
      yt-dlp
      ffmpeg
      ollama
nixvim
      # fonts
      nerd-fonts.fira-code
      nerd-fonts.fira-mono
    ];
    
  programs.nixvim = {
    enable = true;

    colorschemes.catppuccin.enable = true;
    plugins.lualine.enable = true;
  };

  };
}
