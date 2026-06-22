{ ... }:

{
  programs.nixvim.keymaps = [
    { mode = "n"; key = "<Esc>"; action = "<cmd>nohlsearch<CR>"; }
    { mode = "n"; key = "<leader>q"; action.__raw = "vim.diagnostic.setloclist"; options.desc = "Diagnostic Quickfix"; }
    { mode = "t"; key = "<Esc><Esc>"; action = "<C-\\><C-n>"; options.desc = "Terminal verlassen"; }

    { mode = "n"; key = "<S-h>"; action = "<cmd>bprevious<CR>"; options.desc = "Vorheriger Buffer"; }
    { mode = "n"; key = "<S-l>"; action = "<cmd>bnext<CR>"; options.desc = "Naechster Buffer"; }
    { mode = "n"; key = "<leader>bd"; action = "<cmd>bdelete<CR>"; options.desc = "Buffer schliessen"; }

    { mode = "n"; key = "<leader>e"; action = "<cmd>Neotree toggle<CR>"; options.desc = "File Explorer toggle"; }
    { mode = "n"; key = "<leader>E"; action = "<cmd>Neotree focus<CR>"; options.desc = "File Explorer focus"; }
    { mode = "n"; key = "<leader>t"; action = "<Cmd>exe v:count1 . 'ToggleTerm'<CR>"; options.desc = "Terminal toggle"; }

    { mode = "n"; key = "<leader>ff"; action = "<cmd>Telescope find_files<CR>"; options.desc = "Find Files"; }
    { mode = "n"; key = "<leader>fg"; action = "<cmd>Telescope live_grep<CR>"; options.desc = "Find Grep"; }
    { mode = "n"; key = "<leader>fw"; action = "<cmd>Telescope grep_string<CR>"; options.desc = "Find Word"; }
    { mode = "n"; key = "<leader>fd"; action = "<cmd>Telescope diagnostics<CR>"; options.desc = "Find Diagnostics"; }
    { mode = "n"; key = "<leader>fr"; action = "<cmd>Telescope resume<CR>"; options.desc = "Find Resume"; }
    { mode = "n"; key = "<leader>fo"; action = "<cmd>Telescope oldfiles<CR>"; options.desc = "Find Recent Files"; }
    { mode = "n"; key = "<leader>fb"; action = "<cmd>Telescope buffers<CR>"; options.desc = "Find Buffers"; }
    { mode = "n"; key = "<leader>/"; action = "<cmd>Telescope current_buffer_fuzzy_find<CR>"; options.desc = "Fuzzy in Buffer"; }
    { mode = "n"; key = "<leader>fG"; action = "<cmd>Telescope git_files<CR>"; options.desc = "Find Git Files"; }
    { mode = "n"; key = "<leader>ft"; action = "<cmd>TodoTelescope<CR>"; options.desc = "Find Todo"; }

    {
      mode = "n";
      key = "<leader>cf";
      action.__raw = "function() require('conform').format({ async = true, lsp_format = 'fallback' }) end";
      options.desc = "Code Format";
    }

    { mode = [ "n" "v" ]; key = "<leader>aa"; action = "<cmd>CopilotChatToggle<CR>"; options.desc = "AI Chat Toggle"; }
    { mode = "v"; key = "<leader>ae"; action = "<cmd>CopilotChatExplain<CR>"; options.desc = "AI Explain"; }
    { mode = "v"; key = "<leader>ar"; action = "<cmd>CopilotChatReview<CR>"; options.desc = "AI Review"; }
    { mode = "v"; key = "<leader>af"; action = "<cmd>CopilotChatFix<CR>"; options.desc = "AI Fix"; }
    { mode = "v"; key = "<leader>at"; action = "<cmd>CopilotChatTests<CR>"; options.desc = "AI Tests"; }
    {
      mode = [ "n" "v" ];
      key = "<leader>aq";
      action.__raw = ''
        function()
          local input = vim.fn.input("Copilot: ")
          if input ~= "" then vim.cmd("CopilotChat " .. input) end
        end
      '';
      options.desc = "AI Quick Chat";
    }
  ];
}
