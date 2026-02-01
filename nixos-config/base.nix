{
  flake-inputs,
  ...
}:
{
  imports = [
    flake-inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit flake-inputs;
    };
  };

  ## Nix settings and optimizations
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
