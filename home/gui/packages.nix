{ pkgs, ... }:
{
  home.packages = with pkgs; [
    vscode
    esphome
    yt-dlp
    ffmpeg
  ];
}
