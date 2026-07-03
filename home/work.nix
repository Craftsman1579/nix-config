{
  inputs,
  outputs,
  pkgs,
  lib,
  ...
}:
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
    claude-code
    codex
    gemini-cli
  ];

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
      export KUBECONFIG=~/.kube-rw/config

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

      # AWS config merge: mounted ~/.aws/config + eigene ~/.aws/config.local
      if [ -f ~/.aws/config.local ]; then
        cat ~/.aws/config ~/.aws/config.local > /tmp/aws-config-merged
        export AWS_CONFIG_FILE=/tmp/aws-config-merged
      fi
    '';
  };
  programs.bash = {
    enable = true;
  };

  home.file.".aws/config.local" = {
    text = ''
      # Remote-Profile: identisch zu den gemounteten Profilen, aber mit sso_use_device_code = true
      # Nutzung: aws sso login --profile <name>-remote

      [profile quanos-qit-sandbox-developer-remote]
      sso_session = quanos-qit-sandbox-developer
      sso_account_id = 982534397439
      sso_role_name = QITSandboxDeveloper
      region = eu-central-1
      sso_use_device_code = true

      [profile quanos-qit-sandbox-sys-admin-remote]
      sso_session = quanos-qit-sandbox-sys-admin
      sso_account_id = 982534397439
      sso_role_name = QITSandboxSysAdmin
      region = eu-central-1
      sso_use_device_code = true

      [profile quanos-qit-dev-developer-remote]
      sso_session = quanos-qit-dev-developer
      sso_account_id = 302263045125
      sso_role_name = QITDevDeveloper
      region = eu-central-1
      sso_use_device_code = true

      [profile quanos-qit-dev-sys-admin-remote]
      sso_session = quanos-qit-dev-sys-admin
      sso_account_id = 302263045125
      sso_role_name = QITDevSysAdmin
      region = eu-central-1
      sso_use_device_code = true

      [profile quanos-qit-staging-developer-remote]
      sso_session = quanos-qit-staging-developer
      sso_account_id = 429838966792
      sso_role_name = QITStagingDeveloper
      region = eu-central-1
      sso_use_device_code = true

      [profile quanos-qit-staging-sys-admin-remote]
      sso_session = quanos-qit-staging-sys-admin
      sso_account_id = 429838966792
      sso_role_name = QITStagingSysAdmin
      region = eu-central-1
      sso_use_device_code = true

      [profile quanos-qit-prod-developer-remote]
      sso_session = quanos-qit-prod-developer
      sso_account_id = 872087213765
      sso_role_name = QITProductionDeveloper
      region = eu-central-1
      sso_use_device_code = true

      [profile quanos-qit-prod-sys-admin-remote]
      sso_session = quanos-qit-prod-sys-admin
      sso_account_id = 872087213765
      sso_role_name = QITProductionSysAdmin
      region = eu-central-1
      sso_use_device_code = true
    '';
  };

  home.activation.kubeRwLink = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p $HOME/.kube-rw
    # schreibbare config-Datei (für current-context) nur anlegen wenn noch nicht vorhanden
    if [ ! -f $HOME/.kube-rw/config ]; then
      echo 'apiVersion: v1\nkind: Config\ncurrent-context: ""\nclusters: []\ncontexts: []\nusers: []' > $HOME/.kube-rw/config
    fi
    # symlink auf die eigentliche AWS-Config
    ln -sf $HOME/.kube/config $HOME/.kube-rw/config-aws
  '';

}
