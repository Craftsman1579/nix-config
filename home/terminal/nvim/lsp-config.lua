-- LSP configuration using vim.lsp.config (nvim-lspconfig v3+ replacement)
-- Servers are configured via vim.lsp.config.<name> = { ... } and enabled with vim.lsp.enable({...}).

-- Helper to attach common keymaps when LSP attaches
local on_attach = function(client, bufnr)
  local builtin_ok, builtin = pcall(require, 'telescope.builtin')
  local function map(keys, func, desc, mode)
    mode = mode or 'n'
    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = 'LSP: ' .. (desc or '') })
  end

  if builtin_ok then
    map('gd', builtin.lsp_definitions, 'Goto Definition')
    map('gr', builtin.lsp_references, 'Goto References')
    map('gI', builtin.lsp_implementations, 'Goto Implementation')
    map('<leader>cs', builtin.lsp_document_symbols, 'Code Symbols')
    map('<leader>cS', builtin.lsp_dynamic_workspace_symbols, 'Workspace Symbols')
  end
  map('<leader>cr', vim.lsp.buf.rename, 'Code Rename')
  map('<leader>ca', vim.lsp.buf.code_action, 'Code Action')
  map('K', vim.lsp.buf.hover, 'Hover Documentation')
  map('gD', vim.lsp.buf.declaration, 'Goto Declaration')

  if client and client:supports_method('textDocument/inlayHint') then
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

-- Register the on_attach for all LSP clients via LspAttach autocmd
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('user-lsp-attach', { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    on_attach(client, args.buf)
  end,
})

-- Server configurations (vim.lsp.config)
-- Ensure the server binaries are available on PATH (Nix: provide via extraPackages / home.packages).

vim.lsp.config.vtsls = {
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

vim.lsp.config.eslint = {
  settings = { run = 'onSave'; validate = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' } },
}

vim.lsp.config.jsonls = {}
vim.lsp.config.yamlls = {}
vim.lsp.config.graphql = {}
vim.lsp.config['helm_ls'] = {}
vim.lsp.config['lua_ls'] = {
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
      telemetry = { enable = false },
    },
  },
}
vim.lsp.config.nixd = {
  settings = {
    formatting = { command = { 'nixfmt' } },
  },
}
vim.lsp.config.bashls = {}
vim.lsp.config.dockerls = {}

-- Enable the servers we want active
vim.lsp.enable({
  'vtsls',
  'eslint',
  'jsonls',
  'yamlls',
  'graphql',
  'helm_ls',
  'lua_ls',
  'nixd',
  'bashls',
  'dockerls',
})
