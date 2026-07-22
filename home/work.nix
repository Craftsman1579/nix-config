{
  inputs,
  outputs,
  pkgs,
  lib,
  ...
}:
let
  # claude-code altert im stable-Channel zu schnell, deshalb aus unstable
  pkgsUnstable = import inputs.nixpkgs-unstable {
    system = pkgs.system;
    config.allowUnfree = true;
  };

  # EKS ~/.kube/config-aws ist read-only und liegt in einem nicht-schreibbaren Verzeichnis,
  # daher kann kubectl dort den current-context (Lock-Datei) nicht schreiben.
  # Loesung: schreibbare Kopie in ~/.kube-rw/config, die sich beim Shell-Start aus der
  # taeglich aktualisierten Quelle erneuert wenn diese neuer ist, unter Erhalt des gewaehlten Contexts.
  kubeconfigInit = ''
    if [ "$HOME/.kube/config-aws" -nt "$HOME/.kube-rw/config" ]; then
      mkdir -p "$HOME/.kube-rw"
      _ctx=$(KUBECONFIG="$HOME/.kube-rw/config" kubectl config current-context 2>/dev/null)
      cp "$HOME/.kube/config-aws" "$HOME/.kube-rw/config"
      chmod 600 "$HOME/.kube-rw/config"
      [ -n "$_ctx" ] && KUBECONFIG="$HOME/.kube-rw/config" kubectl config use-context "$_ctx" >/dev/null 2>&1
      unset _ctx
    fi
    export KUBECONFIG="$HOME/.kube-rw/config"
  '';
in
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
    codex
    gemini-cli
  ] ++ [ pkgsUnstable.claude-code ];

  nixpkgs.config.allowUnfree = true;

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
      export NIX_CONFIG="experimental-features = nix-command flakes"
      ${kubeconfigInit}

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
      # qit-ecr-dev-login-helm &>/dev/null
      # qit-ecr-production-login-helm &>/dev/null
      alias aws-login-all='for profile in $(aws configure list-profiles); do echo ">>> Logging in: $profile"; aws sso login --profile "$profile"; done'
      alias aws-all-developer='for profile in $(aws configure list-profiles | grep "developer$"); do echo ">>> Logging in: $profile"; aws sso login --profile "$profile"; done'
    '';
  };
  programs.bash = {
    enable = true;
    # ueberschreibt den kaputten KUBECONFIG-Wert aus /etc/qcp/nix/nix.d/infotwin.nix
    sessionVariables.KUBECONFIG = lib.mkForce "$HOME/.kube-rw/config";
    initExtra = kubeconfigInit;
  };

}
