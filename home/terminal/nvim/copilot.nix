# Copilot: Inline-Suggestions + CopilotChat (Agent-Modus)
{ pkgsUnstable, ... }:

{
  programs.nixvim.plugins = {

    copilot-lua = {
      enable = true;
      # nixpkgs 26.05 pinnt 2.0.4, dessen Tag upstream verschoben wurde -> hash mismatch
      package = pkgsUnstable.vimPlugins.copilot-lua;
      settings = {
        suggestion = {
          enabled = true;
          auto_trigger = true;
          keymap = {
            accept = "<M-l>";
            next = "<M-]>";
            prev = "<M-[>";
            dismiss = "<C-]>";
          };
        };
        panel.enabled = true;
        filetypes = {
          yaml = true;
          markdown = true;
          "." = false;
        };
      };
    };

    copilot-chat = {
      enable = true;
      # muss aus derselben Quelle kommen: stable CopilotChat haengt via
      # dependencies an copilot.lua 2.0.4 und zieht den kaputten Hash wieder herein
      package = pkgsUnstable.vimPlugins.CopilotChat-nvim;
      settings = {
        tools = [
          "buffer"
          "file"
          "glob"
          "grep"
          "gitdiff"
          "bash"
          "edit"
          "selection"
        ];
        trusted_tools = [
          "buffer"
          "file"
          "glob"
          "grep"
          "gitdiff"
          "selection"
        ];

        window = {
          layout = "vertical";
          width = 0.4;
        };
      };
    };
  };
}
