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
      esphome

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

      # fonts
      nerd-fonts.fira-code
      nerd-fonts.fira-mono
    ];

  };
}
