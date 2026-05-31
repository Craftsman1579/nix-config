{ ... }:

{
  programs.nixvim.keymaps = [
    { mode = "n"; key = "<Esc>"; action = "<cmd>nohlsearch<CR>"; }
    { mode = "n"; key = "<leader>q"; action.__raw = "vim.diagnostic.setloclist"; options.desc = "Diagnostic Quickfix"; }
    { mode = "t"; key = "<Esc><Esc>"; action = "<C-\\><C-n>"; options.desc = "Terminal verlassen"; }

    { mode = "n"; key = "<C-h>"; action = "<C-w><C-h>"; options.desc = "Fenster links"; }
    { mode = "n"; key = "<C-l>"; action = "<C-w><C-l>"; options.desc = "Fenster rechts"; }
    { mode = "n"; key = "<C-j>"; action = "<C-w><C-j>"; options.desc = "Fenster unten"; }
    { mode = "n"; key = "<C-k>"; action = "<C-w><C-k>"; options.desc = "Fenster oben"; }

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
    { mode = "n"; key = "<leader>fp"; action = "<cmd>Telescope projects<CR>"; options.desc = "Find Projects"; }

    {
      mode = "n";
      key = "<leader>cf";
      action.__raw = "function() require('conform').format({ async = true, lsp_format = 'fallback' }) end";
      options.desc = "Code Format";
    }

    { mode = "n"; key = "<leader>dc"; action.__raw = "function() require('dap').continue() end"; options.desc = "Debug Continue"; }
    { mode = "n"; key = "<leader>db"; action.__raw = "function() require('dap').toggle_breakpoint() end"; options.desc = "Debug Breakpoint"; }
    {
      mode = "n";
      key = "<leader>dB";
      action.__raw = "function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end";
      options.desc = "Debug Conditional Breakpoint";
    }
    { mode = "n"; key = "<leader>di"; action.__raw = "function() require('dap').step_into() end"; options.desc = "Debug Step Into"; }
    { mode = "n"; key = "<leader>do"; action.__raw = "function() require('dap').step_over() end"; options.desc = "Debug Step Over"; }
    { mode = "n"; key = "<leader>dO"; action.__raw = "function() require('dap').step_out() end"; options.desc = "Debug Step Out"; }
    { mode = "n"; key = "<leader>dr"; action.__raw = "function() require('dap').restart() end"; options.desc = "Debug Restart"; }
    { mode = "n"; key = "<leader>dt"; action.__raw = "function() require('dap').terminate() end"; options.desc = "Debug Terminate"; }
    { mode = "n"; key = "<leader>du"; action.__raw = "function() require('dapui').toggle() end"; options.desc = "Debug UI Toggle"; }
    { mode = [ "n" "v" ]; key = "<leader>de"; action.__raw = "function() require('dapui').eval() end"; options.desc = "Debug Eval"; }

    { mode = "n"; key = "<leader>gd"; action = "<cmd>DiffviewOpen<CR>"; options.desc = "Git Diffview"; }
    { mode = "n"; key = "<leader>gh"; action = "<cmd>DiffviewFileHistory %<CR>"; options.desc = "Git File History"; }

    { mode = "n"; key = "<leader>xx"; action = "<cmd>Trouble diagnostics toggle<CR>"; options.desc = "Diagnostics (Trouble)"; }
    { mode = "n"; key = "<leader>xX"; action = "<cmd>Trouble diagnostics toggle filter.buf=0<CR>"; options.desc = "Buffer Diagnostics"; }

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
