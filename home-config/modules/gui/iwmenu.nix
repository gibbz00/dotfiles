{ pkgs, ... }:
{
  home.packages = with pkgs; [
    iwmenu
  ];

  wayland.windowManager.sway.config.keybindings = {
    "$mod+n" = "exec iwmenu --launcher rofi";
  };
}
