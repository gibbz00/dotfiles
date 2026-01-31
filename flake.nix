{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }:
    {
      nixosConfigurations =
        let
          host = "evolve";
          user = "gibbz";
          system = "x86_64-linux";
        in
        {
          ${host} = nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [
              ./sys/${host}.nix

              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.${user} = import ./home/${user}.nix;
                };
              }
            ];
          };
        };
    };
}
