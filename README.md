# Gibbz's NixOS dotfiles

## Features

### System - NixOS

- `iwd` for wireless network management.
- `ntpd-rs` for NTP management and `automatic-timezoned` for timezone selection.
- `openssh.nix` module enables Fail2ban
- `docker.nix` module with aggressive auto pruning enabled
- `stylix.nix` module for system-level themeing

#### Other Notes

- `wheelNeedsPassword` is set to `false` in the `nixos-config/modules/default.nix`, take care when adding new users belonging to wheel.

### Home - Home Manager

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

- `sway` with `swaylock`.
  - Sway is autostarted directly from TTY login, no extra login manager required.
  - Window focus is conveyed by toggleable inactive window transparency.
  - Includes an xdg-portal ready for screen recording.
- `foot` terminal running in server mode.
- `rofi` application, exit, emoji, clipboard, screenshot, network and bluetooth launchers
- `stylix.nix` module for home-level themeing, in addition to icon set (Tela Gray), font, and wallpaper selection.
- fonts: noto family (+ color emoji and CJK), nerdfonts-symbols-only

## Setup

`selected-conf` placeholder needs to match one of the `nixosConfigurations` listed in the `flake.nix`, ex. `evolve`.

All hosts running commands are expected to have [flakes enabled](https://nixos.wiki/wiki/Flakes). Verify this by running `nix flake`.

### Running them inside QEMU

To build the VM image:

```sh
nix build .#nixosConfigurations.selected-conf.config.system.build.vm
```

To then run it with QEMU:

```sh
QEMU_KERNEL_PARAMS="console=ttyS0" ./result/bin/run-selected-host-vm -nographic; reset
```

Make sure to remove `-nographic` for all things GUI.

### Remote install with `nixos-anywhere` and a live usb.

Based on: https://github.com/nix-community/nixos-anywhere/blob/main/docs/howtos/no-os.md

#### Preparing the remote

1. Boot from live usb
2. Make connect to LAN (ex. with `nmtui` for Wifi).
3. Get IP address with `ip addr`.
4. Set a password for the `nixos` user with `passwd`.
5. Make sure that the `flake.nix`'s `diskName` is the same as the disk name reported by `lsblk`.
6. Finally:

```sh
_os_config='evolve' # which nixosconfigurations in flake.nix to use
_remote_ip="..." # from ip addr on remote
nix run github:nix-community/nixos-anywhere -- \
  --flake ".#$_os_config" \
  --target-host "nixos@$_remote_ip" \
  # omit if a hardware configuration already exists
  --generate-hardware-config nixos-generate-config "./nixos-config/hosts/$_os_config/hardware.nix"
```

You may want to commit any newly generated hardware configurations (`hardware.nix`) to git.

### From an existing NixOS host

Rebuild switch from a remote flake:

```sh
sudo nixos-rebuild switch --flake github:gibbz00/dotfiles#selected-conf
```

Or if already present locally:

```sh
# in directory where flake.nix is located
sudo nixos-rebuild switch --flake .#selected-conf
```

## Todo

### Unclutter Home (XDG Base Directory Specification Adherence)

* `bash`: https://savannah.gnu.org/support/?108134
* `firefox`: https://bugzilla.mozilla.org/show_bug.cgi?id=2005167
* `gtk3`: https://github.com/nix-community/stylix/pull/1142
