{ pkgs, ... }:
{
  # Ollama als LaunchAgent (startet automatisch beim Login)
  launchd.agents.ollama = {
    enable = false;
    config = {
      Label = "org.ollama.ollama";
      ProgramArguments = [
        "${pkgs.ollama}/bin/ollama"
        "serve"
      ];
      RunAtLoad = true;
      KeepAlive = true;
      StandardOutPath = "/tmp/ollama.log";
      StandardErrorPath = "/tmp/ollama.log";
      EnvironmentVariables = {
        OLLAMA_HOST = "127.0.0.1:11434";
      };
    };
  };
}
