{
  flake-inputs,
  ...
}:
{
  imports = [
    flake-inputs.home-manager.nixosModules.home-manager
  ];

  # See: https://discourse.nixos.org/t/why-are-we-using-systemd-timesyncd-by-default/74052/22
  services.ntpd-rs.enable = true;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit flake-inputs;
    };
  };

  ## Nix base settings
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  ### Nix store GC and size optimizations
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
}
