{ inputs, outputs, pkgs, ... }:
{
  imports = [
    /etc/qcp/nix/defaults.nix
    ./cli
    ./terminal
    ./base.nix
    inputs.nixvim.homeModules.nixvim
  ];

  home.packages = with pkgs; [
    glab
  ];

  home = {
    username = "coder";
    homeDirectory = "/home/coder";
  };

  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      nix-switch = "home-manager switch --flake ~/.config/home-manager#work --impure";
    };
    initContent = ''
      export EDITOR=nvim
      export VISUAL=nvim
      export FZF_BASE="${pkgs.fzf}/share/fzf"

      # kubectl shortcuts
      alias k=kubectl
      alias kgp='kubectl get pods'
      alias kgd='kubectl get deployments'
      alias kgs='kubectl get services'
      alias kgn='kubectl get nodes'
      alias kctx=kubectx
      alias kns=kubens
      alias gciv="glab ci view -w";
      # Pfeiltasten durchsuchen History nach Präfix
      source "${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh"
      bindkey '^[[A' history-substring-search-up
      bindkey '^[[B' history-substring-search-down

      alias qit-codeartifact-get-token='export QIT_CODEARTIFACT_TOKEN=$(aws codeartifact get-authorization-token --query authorizationToken --output text --domain qit --profile quanos-qit-dev-developer)'
      alias qit-ecr-dev-login-helm="aws ecr get-login-password --profile quanos-qit-dev-developer | helm registry login --username AWS --password-stdin 302263045125.dkr.ecr.eu-central-1.amazonaws.com"
      alias qit-ecr-production-login-helm="aws ecr get-login-password --profile quanos-qit-dev-developer | helm registry login --username AWS --password-stdin 872087213765.dkr.ecr.eu-central-1.amazonaws.com"
      qit-codeartifact-get-token
      qit-ecr-dev-login-helm &>/dev/null
      qit-ecr-production-login-helm &>/dev/null
      alias aws-login-all='for profile in $(aws configure list-profiles); do echo ">>> Logging in: $profile"; aws sso login --profile "$profile"; done'
      alias aws-all-developer='for profile in $(aws configure list-profiles | grep "developer$"); do echo ">>> Logging in: $profile"; aws sso login --profile "$profile"; done'
    '';
  };
  programs.bash = {
    enable = true;
  };

}
