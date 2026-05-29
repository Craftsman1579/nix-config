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
          
          # InlayHints: Typ-Informationen im Editor anzeigen
          settings.typescript.inlayHints = {
            includeInlayParameterNameHints = "all";        # Parameternamen
            includeInlayFunctionParameterTypeHints = true;  # Funktions-Param-Typen
            includeInlayVariableTypeHints = true;           # Variablen-Typen
            includeInlayPropertyDeclarationTypeHints = true; # Property-Typen
            includeInlayFunctionReturnTypeHints = true;     # Return-Typen
            includeInlayEnumMemberValueHints = true;        # Enum-Werte
          };

          # Code-Analyse & Diagnostik
          settings.typescript = {
            # Vorschläge & Auto-Fix
            suggest = {
              autoImports = true;
              completeFunctionCalls = true;
              completeJSDocs = true;
            };
            
            # Null/Undefined-Checking
            tsserver.maxTsServerMemory = 3072;  # RAM für TS-Server (MB)
            
            # Diagnostik-Filter
            reportAssignmentType = true;
            reportIncompatibleMethodOverride = true;
            reportIncompatibleVariableOverride = true;
          };

          # JS/JSX-Dateien auch prüfen
          settings.javascript.inlayHints = {
            includeInlayParameterNameHints = "all";
            includeInlayFunctionParameterTypeHints = true;
            includeInlayVariableTypeHints = true;
          };
        };

        # ESLint als separater Server (nutzt deine eslint.config.mjs)
        eslint = {
          enable = true;
          settings.run = "onSave";
          settings.validate = [ "javascript" "javascriptreact" "typescript" "typescriptreact" ];
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
      };
    };
  };
}
