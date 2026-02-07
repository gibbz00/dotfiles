{ ... }:
{
  services.fnott = {
    enable = true;
    settings = {
      main = {
        selection-helper = "rofi -sep '\0' -dmenu";
        selection-helper-uses-null-separator = true;
      };
    };
  };
  wayland.windowManager.sway.config.keybindings = {
    "$mod+BackSpace" = "exec fnottctl dismiss";
    "$mod+Colon" = "exec fnottctl actions";
  };
}
