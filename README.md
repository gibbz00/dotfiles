# Gibbz's NixOS dotfiles

## Stack

### System

- `iwd` for wireless network management.
- `ntpd-rs` for NTP management.
- `openssh.nix` module enables Fail2ban
- `docker.nix` module with aggressive auto pruning enabled
- `stylix.nix` module for system-level themeing

#### Other Notes

- `wheelNeedsPassword` is set to `false` in the `base.nix` module, take care when adding new users.

### Home

### TUI

- XDG base directory specification adherence (on a best effort basis).
- XDG user directories (all in lowercase).
- `readline` with vi-mode and responsive completion settings.
- `bash` with immediate history settings.
- `fzf` enabled using `fd` as backend.
- `zoxide` for directory jumping (using `fzf` for interactive select).
- `yazi` with a shell-wrapper mapped to `yy` (integrated in turn with `fd`, `ripgrep`, `zoxide` and `fzf`).
- `tmp.nix` module for enabling a `$HOME/tmp` that gets cleaned on boot, similar to `/tmp`.

### GUI

- `sway` with `swaylock`. Sway is autostarted directly from TTY login, no extra login manager required.
- `foot` terminal running in server mode.
- `rofi` application, exit, emoji, clipboard, screenshot, and network launchers
- `stylix.nix` module for home-level themeing, in addition to icon set (Tela Gray), font, and wallpaper selection.
- fonts: noto family (+ color emoji and CJK), nerdfonts-symbols-only

## Setup

### Switching from a already flake enabled NixOS host

`selected-host` needs to match one of the hosts listed in the `flake.nix`. Flake can be fetched remotely:

```sh
sudo nixos-rebuild switch --flake github:owner/repo#selected-host
```

Or if already present in the system:

```sh
# in directory where flake.nix is located
sudo nixos-rebuild switch --flake .
```

### Running them inside QEMU

QEMU and nix needs to first be installed on the host, the latter one with [with flakes enabled](https://nixos.wiki/wiki/Flakes).

To build a QEMU image for a `selected-host` configuration in `flake.nix`:

```sh
nix build .#nixosConfigurations.selected-host.config.system.build.vm
```

The built VM image can then be started (replacing 'selected-host') with:

```sh
QEMU_KERNEL_PARAMS="console=ttyS0" ./result/bin/run-selected-host-vm -nographic; reset
```

Make sure to remove `-nographic` for all things GUI.
