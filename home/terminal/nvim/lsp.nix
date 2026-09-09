# Native LSP-Konfiguration + Keymaps
{ inputs, pkgs, ... }:

{
  programs.nixvim = {
    plugins = {
      fidget.enable = true;
      helm.enable = true;
      lspconfig.enable = true;
    };

    autoGroups.eslint-fix.clear = true;

    lsp = {
      onAttach = ''
        local builtin = require('telescope.builtin')
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buf = bufnr, desc = 'LSP: ' .. desc })
        end

        map('gd', builtin.lsp_definitions, 'Goto Definition')
        map('gr', builtin.lsp_references, 'Goto References')
        map('gI', builtin.lsp_implementations, 'Goto Implementation')
        map('<leader>cs', builtin.lsp_document_symbols, 'Code Symbols')
        map('<leader>cS', builtin.lsp_dynamic_workspace_symbols, 'Workspace Symbols')
        map('<leader>cr', vim.lsp.buf.rename, 'Code Rename')
        map('<leader>ca', vim.lsp.buf.code_action, 'Code Action')
        map('K', vim.lsp.buf.hover, 'Hover Documentation')
        map('gD', vim.lsp.buf.declaration, 'Goto Declaration')

        if client:supports_method('textDocument/inlayHint') then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(
              not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }),
              { bufnr = bufnr }
            )
          end, 'Toggle Inlay Hints')
        end

        if client.name == 'eslint' then
          vim.api.nvim_clear_autocmds({ group = 'eslint-fix', buf = bufnr })
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = 'eslint-fix',
            buf = bufnr,
            callback = function()
              if #vim.lsp.get_clients({ bufnr = bufnr, name = 'eslint' }) > 0 then
                vim.cmd.LspEslintFixAll()
              end
            end,
          })
        end
      '';

      servers = {
        "*".config.capabilities.__raw = "require('blink.cmp').get_lsp_capabilities()";

        vtsls = {
          enable = true;
          config.settings.typescript = {
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
              autoImportFileExcludePatterns = [
                "node_modules/**"
                ".nx/**"
              ];
            };
          };
        };

        # ESLint als separater Server (nutzt deine eslint.config.mjs)
        eslint = {
          enable = true;
          config.settings.run = "onSave";
        };

        jsonls = {
          enable = true;
          config.settings.json.validate.enable = true;
        };

        yamlls = {
          enable = true;
          config.settings.yaml = {
            schemas = {
              "https://json.schemastore.org/github-workflow.json" = "/.github/workflows/*";
              "https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json" =
                "docker-compose*.yml";
              "https://json.schemastore.org/kustomization.json" = "kustomization.yaml";
              "https://json.schemastore.org/helmfile.json" = "helmfile.yaml";
            };
            keyOrdering = false;
          };
        };

        graphql = {
          enable = true;
          config.filetypes = [
            "graphql"
            "typescriptreact"
            "javascriptreact"
          ];
        };

        helm_ls = {
          enable = true;
          config.settings."helm-ls".yamlls.path = "yaml-language-server";
        };

        lua_ls = {
          enable = true;
          config.settings.Lua = {
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
          config.settings.nixd = {
            formatting.command = [ "nixfmt" ];
            nixpkgs.expr = "import ${inputs.nixpkgs} { system = \"${pkgs.stdenv.hostPlatform.system}\"; }";
          };
        };

        bashls.enable = true;
        dockerls.enable = true;
      };
    };
  };
}
