# Nix Config

Nix-flake für macOS (nix-darwin) und Linux (standalone home-manager),
mit geteilter home-manager Config für beide Rechner.

## Nutzung

```bash
# macOS (MacBook)
darwin-rebuild switch --flake .#my-macbook

# Linux (Arbeitsrechner)
home-manager switch --flake .#work
```

## Struktur

```
├── flake.nix              # Inputs + Outputs (darwin + home-manager standalone)
├── darwin/                # macOS-spezifisch
│   ├── default.nix         # system config
│   ├── home-manager.nix    # home-manager integration + ollama
│   ├── homebrew.nix        # GUI apps via homebrew
│   └── settings.nix        # macOS defaults (finder, dock, touch id)
├── home/                  # shared home-manager (beide Rechner)
│   ├── default.nix         # shared core + nixvim
│   ├── packages.nix        # CLI tools
│   ├── git.nix             # git config
│   ├── shell.nix           # zsh + starship
│   ├── mise.nix            # dev runtimes (node, bun, rust, deno, uv)
│   ├── fonts.nix           # nerd fonts
│   ├── nvim/               # neovim config (nixvim)
│   ├── ollama.nix          # ollama launchd (nur macOS)
│   └── work.nix            # work-spezifisch + /etc/qcp/nix/defaults.nix
└── hosts/
    └── my-macbook/
        └── configuration.nix  # hostname
```

## Wichtige Dateien

| Datei | Zweck |
|-------|-------|
| `home/packages.nix` | CLI tools (curl, tmux, ripgrep, mise, k9s, …) |
| `darwin/homebrew.nix` | GUI apps (brave-browser, docker, …) |
| `home/nvim/` | Neovim config (wird auf beiden Rechnern geteilt) |
| `home/work.nix` | Overrides für den Arbeitsrechner |

## Customization

- **Pakete hinzufügen:** `home/packages.nix`
- **GUI Apps:** `darwin/homebrew.nix`
- **Neovim:** `home/nvim/`
- **Host-spezifisch:** `hosts/<name>/configuration.nix`
