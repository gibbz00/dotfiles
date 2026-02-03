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
    };
  };

  # Forces bash to be more compliant to the XDG base directory specification.
  # (Inspired by: https://hiphish.github.io/blog/2020/12/27/making-bash-xdg-compliant/)
  environment.interactiveShellInit = ''
    _rc=''${XDG_CONFIG_HOME:-$HOME/.config}/bash/bashrc
    test -r $_rc && . $_rc
  '';
  environment.loginShellInit = ''
    _profile=''${XDG_CONFIG_HOME:-$HOME/.config}/bash/bash_profile
    test -r $_profile && . $_profile
  '';

  ## Locale
  # Required for default home.language settings
  i18n.extraLocales = [
    "sv_SE.UTF-8/UTF-8"
    "en_DK.UTF-8/UTF-8"
  ];

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
