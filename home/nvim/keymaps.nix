{ ... }:
{
  programs.nixvim.keymaps = [
    # ── Basics ────────────────────────────────────────────────────────────
    { mode = "n"; key = "<Esc>"; action = "<cmd>nohlsearch<CR>"; options.desc = "Clear search highlight"; }
    { mode = "n"; key = "<leader>w"; action = "<cmd>w<CR>"; options.desc = "Save file"; }
    { mode = "n"; key = "<leader>q"; action = "<cmd>q<CR>"; options.desc = "Quit"; }
    { mode = "n"; key = "<leader>Q"; action = "<cmd>qa!<CR>"; options.desc = "Quit all"; }

    # Better up/down (respects line wrap)
    { mode = ["n" "x"]; key = "j"; action = "v:count == 0 ? 'gj' : 'j'"; options = { expr = true; silent = true; }; }
    { mode = ["n" "x"]; key = "k"; action = "v:count == 0 ? 'gk' : 'k'"; options = { expr = true; silent = true; }; }

    # ── Windows ───────────────────────────────────────────────────────────
    { mode = "n"; key = "<C-h>"; action = "<C-w>h"; options.desc = "Go to left window"; }
    { mode = "n"; key = "<C-j>"; action = "<C-w>j"; options.desc = "Go to lower window"; }
    { mode = "n"; key = "<C-k>"; action = "<C-w>k"; options.desc = "Go to upper window"; }
    { mode = "n"; key = "<C-l>"; action = "<C-w>l"; options.desc = "Go to right window"; }
    { mode = "n"; key = "<C-Up>"; action = "<cmd>resize +2<CR>"; options.desc = "Increase window height"; }
    { mode = "n"; key = "<C-Down>"; action = "<cmd>resize -2<CR>"; options.desc = "Decrease window height"; }
    { mode = "n"; key = "<C-Left>"; action = "<cmd>vertical resize -2<CR>"; options.desc = "Decrease window width"; }
    { mode = "n"; key = "<C-Right>"; action = "<cmd>vertical resize +2<CR>"; options.desc = "Increase window width"; }
    { mode = "n"; key = "<leader>sv"; action = "<cmd>vsplit<CR>"; options.desc = "Split vertical"; }
    { mode = "n"; key = "<leader>sh"; action = "<cmd>split<CR>"; options.desc = "Split horizontal"; }
    { mode = "n"; key = "<leader>sc"; action = "<cmd>close<CR>"; options.desc = "Close split"; }

    # ── Buffers ───────────────────────────────────────────────────────────
    { mode = "n"; key = "<S-h>"; action = "<cmd>bprevious<CR>"; options.desc = "Previous buffer"; }
    { mode = "n"; key = "<S-l>"; action = "<cmd>bnext<CR>"; options.desc = "Next buffer"; }
   { mode = "n"; key = "<leader>bd"; action = "<cmd>bdelete<CR>"; options.desc = "Delete buffer"; }

    # ── Editing ───────────────────────────────────────────────────────────
    { mode = "v"; key = "<"; action = "<gv"; options.desc = "Indent left"; }
    { mode = "v"; key = ">"; action = ">gv"; options.desc = "Indent right"; }
    { mode = "n"; key = "<A-j>"; action = "<cmd>m .+1<CR>=="; options.desc = "Move line down"; }
    { mode = "n"; key = "<A-k>"; action = "<cmd>m .-2<CR>=="; options.desc = "Move line up"; }
    { mode = "v"; key = "<A-j>"; action = ":m '>+1<CR>gv=gv"; options.desc = "Move selection down"; }
    { mode = "v"; key = "<A-k>"; action = ":m '<-2<CR>gv=gv"; options.desc = "Move selection up"; }
    { mode = "v"; key = "p"; action = "\"_dP"; options.desc = "Paste without yanking"; }

    # ── Telescope ─────────────────────────────────────────────────────────
    { mode = "n"; key = "<leader>ff"; action = "<cmd>Telescope find_files<CR>"; options.desc = "Find files"; }
    { mode = "n"; key = "<leader>fg"; action = "<cmd>Telescope live_grep<CR>"; options.desc = "Live grep"; }
    { mode = "n"; key = "<leader>fb"; action = "<cmd>Telescope buffers<CR>"; options.desc = "Find buffers"; }
    { mode = "n"; key = "<leader>fh"; action = "<cmd>Telescope help_tags<CR>"; options.desc = "Help tags"; }
    { mode = "n"; key = "<leader>fr"; action = "<cmd>Telescope oldfiles<CR>"; options.desc = "Recent files"; }
    { mode = "n"; key = "<leader>fd"; action = "<cmd>Telescope diagnostics<CR>"; options.desc = "Diagnostics"; }
    { mode = "n"; key = "<leader>fs"; action = "<cmd>Telescope lsp_document_symbols<CR>"; options.desc = "Document symbols"; }
    { mode = "n"; key = "<leader>fw"; action = "<cmd>Telescope lsp_workspace_symbols<CR>"; options.desc = "Workspace symbols"; }

    # ── File explorer ─────────────────────────────────────────────────────
    { mode = "n"; key = "<leader>e"; action = "<cmd>Neotree toggle<CR>"; options.desc = "Toggle file explorer"; }
    { mode = "n"; key = "<leader>E"; action = "<cmd>Neotree reveal<CR>"; options.desc = "Reveal in explorer"; }

    # ── LSP ───────────────────────────────────────────────────────────────
    { mode = "n"; key = "K"; action = "<cmd>lua vim.lsp.buf.hover()<CR>"; options.desc = "Hover docs"; }
    { mode = "n"; key = "gd"; action = "<cmd>lua vim.lsp.buf.definition()<CR>"; options.desc = "Go to definition"; }
    { mode = "n"; key = "gD"; action = "<cmd>lua vim.lsp.buf.declaration()<CR>"; options.desc = "Go to declaration"; }
    { mode = "n"; key = "gr"; action = "<cmd>lua vim.lsp.buf.references()<CR>"; options.desc = "References"; }
    { mode = "n"; key = "gi"; action = "<cmd>lua vim.lsp.buf.implementation()<CR>"; options.desc = "Go to implementation"; }
    { mode = "n"; key = "<leader>ca"; action = "<cmd>lua vim.lsp.buf.code_action()<CR>"; options.desc = "Code action"; }
    { mode = "n"; key = "<leader>rn"; action = "<cmd>lua vim.lsp.buf.rename()<CR>"; options.desc = "Rename symbol"; }
    { mode = ["n" "v"]; key = "<leader>cf"; action = "<cmd>lua vim.lsp.buf.format({ async = true })<CR>"; options.desc = "Format"; }
    { mode = "n"; key = "[d"; action = "<cmd>lua vim.diagnostic.goto_prev()<CR>"; options.desc = "Previous diagnostic"; }
    { mode = "n"; key = "]d"; action = "<cmd>lua vim.diagnostic.goto_next()<CR>"; options.desc = "Next diagnostic"; }

    # ── Git ───────────────────────────────────────────────────────────────
    { mode = "n"; key = "<leader>gg"; action = "<cmd>LazyGit<CR>"; options.desc = "LazyGit"; }

    { mode = "n"; key = "<leader>gs"; action = "<cmd>Gitsigns stage_hunk<CR>"; options.desc = "Stage hunk"; }
    { mode = "n"; key = "<leader>gr"; action = "<cmd>Gitsigns reset_hunk<CR>"; options.desc = "Reset hunk"; }
    { mode = "n"; key = "<leader>gp"; action = "<cmd>Gitsigns preview_hunk<CR>"; options.desc = "Preview hunk"; }
    { mode = "n"; key = "<leader>gb"; action = "<cmd>Gitsigns blame_line<CR>"; options.desc = "Blame line"; }
    { mode = "n"; key = "]h"; action = "<cmd>Gitsigns next_hunk<CR>"; options.desc = "Next hunk"; }
    { mode = "n"; key = "[h"; action = "<cmd>Gitsigns prev_hunk<CR>"; options.desc = "Previous hunk"; }

    # ── Terminal (toggleterm) ─────────────────────────────────────────────
    { mode = "n"; key = "<C-t>"; action = "<cmd>ToggleTerm<CR>"; options.desc = "Toggle terminal"; }
    { mode = "t"; key = "<C-t>"; action = "<cmd>ToggleTerm<CR>"; options.desc = "Toggle terminal"; }
    { mode = "n"; key = "<leader>t1"; action = "<cmd>ToggleTerm 1<CR>"; options.desc = "Terminal 1"; }
    { mode = "n"; key = "<leader>t2"; action = "<cmd>ToggleTerm 2<CR>"; options.desc = "Terminal 2"; }
    { mode = "n"; key = "<leader>t3"; action = "<cmd>ToggleTerm 3<CR>"; options.desc = "Terminal 3"; }
    { mode = "n"; key = "<leader>tf"; action = "<cmd>ToggleTerm direction=float<CR>"; options.desc = "Float terminal"; }
    { mode = "n"; key = "<leader>tv"; action = "<cmd>ToggleTerm direction=vertical<CR>"; options.desc = "Vertical terminal"; }
    { mode = "t"; key = "<Esc>"; action = "<C-\\><C-n>"; options.desc = "Exit terminal mode"; }
  ];
}
