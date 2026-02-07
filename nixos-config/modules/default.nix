{
  config,
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

  ## NTP and timezones
  # See: https://discourse.nixos.org/t/why-are-we-using-systemd-timesyncd-by-default/74052/22
  services.ntpd-rs.enable = true;
  services.automatic-timezoned.enable = true;

  ## System packages
  # TODO: default core packages are also pretty bloated IMO
  # environment.corePackages = [ ];
  environment.defaultPackages = [ ];
  programs = {
    nano.enable = false;
    git.enable = true;
  };

  ## Default user setup
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit flake-inputs;
      osConfig = config;
    };
  };

  ## Locale
  # Required for default home.language settings
  i18n.extraLocales = [
    "sv_SE.UTF-8/UTF-8"
    "en_DK.UTF-8/UTF-8"
  ];

  ## Nix base settings
  nix = {
    settings = {
      use-xdg-base-directories = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };

    ### GC and size optimizations
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
}
