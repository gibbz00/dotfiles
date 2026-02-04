{ ... }:
{
  wayland.windowManager.sway = {
    enable = true;
    # Recommended by docs for passing user
    # environment when started from a TTY.
    systemd.variables = [ "--all" ];
  };
}
