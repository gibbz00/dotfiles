{
  pkgs,
  flake-inputs,
  ...
}:
{
  imports = [
    flake-inputs.home-manager.nixosModules.home-manager
  ];

  ## Security
  security.sudo.wheelNeedsPassword = false;

  ## NTP
  # See: https://discourse.nixos.org/t/why-are-we-using-systemd-timesyncd-by-default/74052/22
  services.ntpd-rs.enable = true;

  ## System packages
  # TODO: default core packages are also pretty bloated IMO
  # environment.corePackages = [ ];
  environment.defaultPackages = [ ];
  environment.variables.EDITOR = "hx";
  environment.systemPackages = with pkgs; [
    git
    tree
    fd
    ripgrep
    helix
  ];

  ## Locale
  # Required for default home.language settings
  i18n.extraLocales = [
    "sv_SE.UTF-8/UTF-8"
    "en_DK.UTF-8/UTF-8"
  ];

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
