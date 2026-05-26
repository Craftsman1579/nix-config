{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    mouse = true;
    escapeTime = 0;
    prefix = "C-a";
    plugins = with pkgs.tmuxPlugins; [
      catppuccin
    ];
    extraConfig = ''
      set -g @catppuccin_flavor 'frappe'
      # Allow Ctrl+a to pass through to nested tmux or shell
      bind C-a send-prefix
    '';
  };
}
