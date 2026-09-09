# Gemeinsamer Kontext für Agents

## Einstieg und Orientierung

- Der Einstieg in die Entwicklungsumgebung ist `/home/coder/dev` (`~/dev`).
- Lies zuerst `~/dev/AGENTS.md` und folge dessen Routing zum passenden Repository. Beachte dort die jeweiligen `AGENTS.md` und Projektkonventionen.
- `~/dev` enthält mehrere Projekte. Führe Projektbefehle im passenden Repository aus.

## Entwicklungsumgebung und Werkzeuge

- Du arbeitest in einem Dev-Container mit einer Nix-/Home-Manager-Konfiguration unter `~/.config/home-manager`.
- Verwende zuerst die bereits verfügbaren Werkzeuge und die im Projekt definierten Skripte. Wenn das Projekt eine Nix-Entwicklungsumgebung bereitstellt, nutze diese über `nix develop`.
- Stelle zusätzlich benötigte Werkzeuge für einmalige Aufgaben temporär mit `nix shell` bereit, zum Beispiel: `nix shell nixpkgs#jq -c jq --version`. Nutze nach Möglichkeit die im Projekt gepinnten Nix-Inputs.
- Installiere keine globalen npm-Pakete und füge keine npm-Abhängigkeiten zu einem Projekt oder zu `~/dev` hinzu, nur um ein temporäres Agent-Werkzeug auszuführen. Vermeide dafür auch spontane Paketdownloads über `npx` oder `npm exec`; bevorzuge `nix shell`.
- Temporäre Werkzeuge gehören nicht dauerhaft in die Home-Manager-Konfiguration. Dauerhafte Änderungen an der Entwicklungsumgebung müssen Teil der Aufgabe sein.
- Benötigt das Projekt selbst eine neue Abhängigkeit, verwende seinen vorhandenen Paketmanager und das bestehende Lockfile-Verfahren. Diese Regel verhindert keine notwendigen Projektabhängigkeiten.

## Programmieren und Abhängigkeiten

- Bevorzuge die Standardbibliothek der Sprache, eingebaute Plattform-APIs sowie bereits vorhandene Framework-Funktionen und Projektabhängigkeiten.
- Nutze bestehende Hilfsfunktionen und Muster im Repository, bevor du eine zusätzliche Bibliothek oder eigene Abstraktion einführst.
- Ergänze neue Abhängigkeiten nur, wenn sie einen konkreten Vorteil für die Aufgabe bieten und vorhandene Mittel nicht sinnvoll ausreichen. Begründe die Ergänzung kurz.
- Bevorzuge einfache, idiomatische Lösungen und die üblichen Standardeinstellungen. Vermeide unnötige Sonderlösungen und zusätzliche Konfiguration.
- Prüfe Änderungen mit den passenden vorhandenen Tests, Lint- und Formatierungsbefehlen des Projekts.
