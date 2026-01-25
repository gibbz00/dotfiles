# Nixos QEMU setup:

## Installing Nix

Nix needs to be installed, with the 25.11 channel added:

```sh
nix-channel --add https://nixos.org/channels/nixos-25.05
```

## Building image

To build the qemu image:

```sh
nix-build '<nixpkgs/nixos>' -A vm -I nixpkgs=channel:nixos-25.11 -I nixos-config=./configuration.nix
```

## Running VM

To run the qemu image:

```sh
QEMU_KERNEL_PARAMS="console=ttyS0" QEMU_NET_OPTS="hostfwd=tcp:127.0.0.1:2222-:22" ./result/bin/run-nixos-vm -nographic; reset
```
