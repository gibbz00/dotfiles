{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
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
          modules = [
            (import ./disko-config/simple.nix { diskName = "/dev/nvme0n1"; })
            (import ./nixos-config/hosts { hostName = "evolve"; })
          ];

          specialArgs.flake-inputs = inputs;
        };

        evolve-server = nixpkgs.lib.nixosSystem {
          modules = [
            (import ./disko-config/simple.nix { diskName = "/dev/sda"; })
            (import ./nixos-config/hosts { hostName = "evolve-server"; })
          ];

          specialArgs.flake-inputs = inputs;
        };
      };
    };
}
