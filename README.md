# Unified NixOS Bootstrap Flake

This flake provides a minimal base system that:

- Creates user `cai`
- Sets fish as the default shell
- Imports `./hardware-configuration.nix`
- Optionally imports `/etc/nixos/custom/configuration.nix` (when present)
- Installs this flake to `/etc/nixos`

## Direct install from GitHub

1. Apply from GitHub:

```bash
sudo nixos-rebuild switch --flake github:<owner>/<repo>#nixos
```

This first run bootstraps the system and installs this flake into `/etc/nixos`.

2. Add machine-specific hardware config in `/etc/nixos/hardware-configuration.nix`.

3. Optional custom config:

```bash
sudo mkdir -p /etc/nixos/custom
sudoedit /etc/nixos/custom/configuration.nix
```

4. Rebuild from local `/etc/nixos` copy:

```bash
sudo nixos-rebuild switch --flake /etc/nixos#nixos --impure
```

## Local checkout usage

```bash
git clone https://github.com/<owner>/<repo>.git /home/cai/nix-flake
sudo nixos-rebuild switch --flake /home/cai/nix-flake#nixos --impure
```
