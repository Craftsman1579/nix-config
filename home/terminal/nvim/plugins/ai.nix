{ ... }:
{
  programs.nixvim.plugins.avante = {
    enable = true;
    settings = {
      provider = "ollama";
      providers.ollama = {
        __inherited_from = "openai";
        endpoint = "http://127.0.0.1:11434/v1";
        model = "qwen2.5-coder:14b";
        api_key_name = "";
      };
      behaviour = {
        auto_suggestions = false;
        auto_set_highlight_group = true;
        auto_set_keymaps = true;
        auto_apply_diff_after_generation = false;
      };
      windows = {
        position = "right";
        width = 35;
        sidebar_header.rounded = true;
      };
    };
  };

  # render-markdown wird von avante für die Sidebar gebraucht
  programs.nixvim.plugins.render-markdown = {
    enable = true;
    settings.file_types = [ "markdown" "Avante" ];
  };
}
