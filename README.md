# Gibbz's NixOS dotfiles

## Switching from a flake enabled NixOS host

`my-host` needs to match one of the hosts in this repo's `flake.nix`.

```sh
sudo nixos-rebuild switch --flake github:owner/repo#my-host
```


## Running them inside QEMU

QEMU and nix needs to first be installed on the host, the latter one with [with flakes enabled](https://nixos.wiki/wiki/Flakes).

To build a QEMU image for a `my-host` configuration in `flake.nix`:

```sh
nix build .#nixosConfigurations.my-host.config.system.build.vm
```

The built VM image can then be started with:

```sh
QEMU_KERNEL_PARAMS="console=ttyS0" QEMU_NET_OPTS="hostfwd=tcp:127.0.0.1:2222-:22" ./result/bin/run-nixos-vm -nographic; reset
```
