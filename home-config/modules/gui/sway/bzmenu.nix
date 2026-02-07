{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bzmenu
  ];

  wayland.windowManager.sway.config.keybindings = {
    "$mod+b" = "exec bzmenu --launcher rofi";
  };
}
