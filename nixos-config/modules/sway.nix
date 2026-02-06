{ ... }:
{
  # Don't like a "security" module that requires a javascript engine just for
  # defining its rules. `rtkit` in audio.nix uses polkit regardless, not much
  # that can be done.
  security.polkit.enable = true;
  security.pam.services.swaylock = { };

  # XDG portals, remaining configured in home
  environment.pathsToLink = [
    "/share/xdg-desktop-portal"
    "/share/applications"
  ];
}
