# Nixos QEMU setup:

## Building an image

Nix needs to first be installed, [with flakes enabled](https://nixos.wiki/wiki/Flakes).

To build the qemu image from `flake.nix`:

```sh
nix build .#nixosConfigurations.my-host.config.system.build.vm
```

## Running the VM

To run the qemu image:

```sh
QEMU_KERNEL_PARAMS="console=ttyS0" QEMU_NET_OPTS="hostfwd=tcp:127.0.0.1:2222-:22" ./result/bin/run-nixos-vm -nographic; reset
```
