{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      ...
    }:
    {
      nixosConfigurations = {
        evolve = nixpkgs.lib.nixosSystem {
          # TEMP: later part of hardware confiuration
          system = "x86_64-linux";
          modules = [
            ./nixos-config/hosts/evolve.nix
          ];

          specialArgs.flake-inputs = inputs;
        };

        evolve-server = nixpkgs.lib.nixosSystem {
          # TEMP: later part of hardware confiuration
          system = "x86_64-linux";
          modules = [
            ./nixos-config/hosts/evolve-server.nix
          ];

          specialArgs.flake-inputs = inputs;
        };
      };
    };
}
