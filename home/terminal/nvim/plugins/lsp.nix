{ ... }:
{
  programs.nixvim.plugins.lsp = {
    enable = true;
    servers = {
      # TypeScript / JavaScript
      ts_ls.enable = true;

      # GraphQL
      graphql.enable = true;

      # Nix
      nixd.enable = true;

      # YAML (Kubernetes, Kustomize)
      yamlls = {
        enable = true;
        settings.yaml = {
          schemas = {
            "https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json" = "/*.k8s.yaml";
            "https://json.schemastore.org/kustomization" = "kustomization.yaml";
          };
          schemaStore.enable = true;
        };
      };

      # Helm
      helm_ls.enable = true;

      # Docker
      dockerls.enable = true;

      # Lua (nvim config)
      lua_ls.enable = true;
    };
  };
}
