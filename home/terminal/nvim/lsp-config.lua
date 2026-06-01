-- LSP configuration (converted from nixvim lsp configuration)
local M = {}

local lspconfig = require('lspconfig')

-- Helper to attach common keymaps when LSP attaches
local on_attach = function(client, bufnr)
  local builtin = require('telescope.builtin')
  local function map(keys, func, desc, mode)
    mode = mode or 'n'
    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = 'LSP: ' .. (desc or '') })
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

  if client and client.supports_method and client.supports_method('textDocument/inlayHint') then
    map('<leader>th', function()
      if vim.lsp.inlay_hint then
        local enabled = vim.lsp.inlay_hint.is_enabled and vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
        vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
      end
    end, 'Toggle Inlay Hints')
  end

  if client and client.name == 'eslint' then
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      callback = function() vim.cmd('silent! EslintFixAll') end,
    })
  end
end

-- Server configurations
-- Note: Ensure the servers are installed on PATH (Nix: provide via extraPackages / home.packages)

-- typescript (vtsls)
lspconfig.vtsls.setup{
  on_attach = on_attach,
  settings = {
    typescript = {
      inlayHints = {
        parameterNames = { enabled = 'all' },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
      preferences = {
        includePackageJsonAutoImports = 'on',
        autoImportFileExcludePatterns = { 'node_modules/**', '.nx/**' },
      },
    },
  },
}

-- eslint
lspconfig.eslint.setup{
  on_attach = on_attach,
  settings = { run = 'onSave'; validate = { 'javascript','javascriptreact','typescript','typescriptreact' } },
}

-- jsonls
lspconfig.jsonls.setup{ on_attach = on_attach }

-- yamlls
lspconfig.yamlls.setup{ on_attach = on_attach }

-- graphql
lspconfig.graphql.setup{ on_attach = on_attach }

-- helm_ls
lspconfig.helm_ls.setup{ on_attach = on_attach }

-- lua_ls
lspconfig.lua_ls.setup{
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
      telemetry = { enable = false },
    }
  }
}

-- nix language server (nixd)
lspconfig.nixd.setup{
  on_attach = on_attach,
  settings = {
    formatting = { command = { 'nixfmt' } },
  }
}

-- Generic servers
lspconfig.bashls.setup{ on_attach = on_attach }
lspconfig.dockerls.setup{ on_attach = on_attach }

return M
