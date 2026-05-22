{ ... }:
{
  home = {
    stateVersion = "25.05";
    # create .hushlogin file to suppress login messages
    file.".hushlogin".text = "";
  };
}

