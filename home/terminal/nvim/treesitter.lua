-- nvim-treesitter 0.10+ setup
-- Grammars are provided via nvim-treesitter.withPlugins (nix).
-- Highlight/indent are enabled automatically; no extra config required.

local ok, ts = pcall(require, 'nvim-treesitter')
if ok then
  -- Optionally point install_dir somewhere if needed; default is fine for runtime installs.
  ts.setup({})
end
