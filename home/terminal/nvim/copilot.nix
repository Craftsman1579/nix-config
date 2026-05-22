# Copilot: Inline-Suggestions + CopilotChat (Agent-Modus)
{ ... }:

{
  programs.nixvim.plugins = {

    copilot-lua = {
      enable = true;
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
      settings = {
        model = "claude-sonnet-4";

        tools = [ "buffer" "file" "glob" "grep" "gitdiff" "bash" "edit" "selection" ];
        trusted_tools = [ "buffer" "file" "glob" "grep" "gitdiff" "selection" ];

        window = {
          layout = "vertical";
          width = 0.4;
        };
      };
    };
  };
}
