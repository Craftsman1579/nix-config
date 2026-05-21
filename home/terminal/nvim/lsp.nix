# LSP-Server + Fidget
{ ... }:

{
  programs.nixvim.plugins = {

    fidget.enable = true;

    lsp = {
      enable = true;
      servers = {
        ts_ls = {
          enable = true;
          settings.typescript.inlayHints = {
            includeInlayParameterNameHints = "all";
            includeInlayFunctionParameterTypeHints = true;
            includeInlayVariableTypeHints = true;
            includeInlayPropertyDeclarationTypeHints = true;
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

        bashls.enable = true;
        dockerls.enable = true;
        eslint.enable = true;
      };
    };
  };
}
