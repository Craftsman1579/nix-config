# LSP-Server + Fidget
{ ... }:

{
  programs.nixvim.plugins = {

    fidget.enable = true;

    lsp = {
      enable = true;
      servers = {
        vtsls = {
          enable = true;
          settings.typescript = {
            inlayHints = {
              parameterNames.enabled = "all";
              parameterTypes.enabled = true;
              variableTypes.enabled = true;
              propertyDeclarationTypes.enabled = true;
              functionLikeReturnTypes.enabled = true;
              enumMemberValues.enabled = true;
            };
            preferences = {
              includePackageJsonAutoImports = "on";
              autoImportFileExcludePatterns = [ "node_modules/**" ".nx/**" ];
            };
          };
        };

        jsonls = {
          enable = true;
          settings.json.validate.enable = true;
        };

        yamlls = {
          enable = true;
          settings.yaml = {
            schemas = {
              "https://json.schemastore.org/github-workflow.json" = "/.github/workflows/*";
              "https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json" = "docker-compose*.yml";
              "https://json.schemastore.org/kustomization.json" = "kustomization.yaml";
              "https://json.schemastore.org/helmfile.json" = "helmfile.yaml";
            };
            keyOrdering = false;
          };
        };

        graphql = {
          enable = true;
          filetypes = [ "graphql" "typescriptreact" "javascriptreact" ];
        };

        helm_ls = {
          enable = true;
          settings."helm-ls".yamlls.path = "yaml-language-server";
        };

        lua_ls = {
          enable = true;
          settings.Lua = {
            runtime.version = "LuaJIT";
            workspace = {
              checkThirdParty = false;
              library.__raw = "{ vim.env.VIMRUNTIME }";
            };
            telemetry.enable = false;
          };
        };

        nixd = {
          enable = true;
          settings = {
            formatting.command = [ "nixfmt" ];
            nixpkgs.expr = "import <nixpkgs> { }";
            options = {
            nixos.expr = "(builtins.getFlake (toString ~/.config/nix)).nixosConfigurations.my-macbook.options";
            home_manager.expr = "(builtins.getFlake (toString ~/.config/nix)).homeConfigurations.alex.options";
            };
          };
        };

        bashls.enable = true;
        dockerls.enable = true;

      };
    };
  };
}
