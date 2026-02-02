# Gibbz's NixOS dotfiles

## Stack

### System

- `iwd` for wireless network management.
- `ntpd-rs` for NTP management.
- `openssh.nix` module enables Fail2ban
- `docker.nix` module with aggressive auto pruning enabled

#### Other Notes

- `wheelNeedsPassword` is set to `false` in the `base.nix` module, take care when adding new users.

### Home

- Adherence to the XDG Base Directory Specification on a best effort basis.

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

The built VM image can then be started with:

```sh
QEMU_KERNEL_PARAMS="console=ttyS0" QEMU_NET_OPTS="hostfwd=tcp:127.0.0.1:2222-:22" ./result/bin/run-nixos-vm -nographic; reset
```
