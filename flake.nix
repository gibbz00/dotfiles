{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    { self, nixpkgs, ... }:
    {
      nixosConfigurations.my-host = nixpkgs.lib.nixosSystem {
        modules = [
          ./configuration.nix
        ];
      };
    };
}
