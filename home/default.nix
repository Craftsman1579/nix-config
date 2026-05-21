{ inputs, primaryUser, ... }:
{
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./terminal
    ./cli
  ];

  home = {
    username = primaryUser;
    stateVersion = "25.05";
    sessionVariables = {
      # shared environment variables
    };

    # create .hushlogin file to suppress login messages
    file.".hushlogin".text = "";
  };
}
