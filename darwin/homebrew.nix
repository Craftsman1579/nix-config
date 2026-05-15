{ ... }:
{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      upgrade = true;
      cleanup = "zap";
    };

    caskArgs.no_quarantine = true;
    global.brewfile = true;

    # homebrew is best for GUI apps
    # nixpkgs is best for CLI tools
    casks = [
      # OS enhancements
      #"aerospace"
      #"cleanshot"
      #"hiddenbar"
      #"raycast"
      #"betterdisplay"

      # dev
      "visual-studio-code"

      # other
      "brave-browser"
    ];
    brews = [
      "docker"
      "colima"
    ];
    taps = [
      "nikitabobko/tap"
    ];
  };
}
