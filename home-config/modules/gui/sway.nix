{ ... }:
{
  wayland.windowManager.sway = {
    enable = true;
    # Recommended by docs for passing user
    # environment when started from a TTY.
    systemd.variables = [ "--all" ];

    # XXX: just for experimentation
    config = {
      modifier = "Mod4";
      startup = [
        { command = "foot"; }
      ];
    };
  };
}
