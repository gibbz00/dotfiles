{ ... }:
{
  services.fnott.enable = true;
  wayland.windowManager.sway.config.keybindings = {
    "$mod+BackSpace" = "exec fnottctl dismiss";
    "$mod+Colon" = "exec context actions";
  };
}
