{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    sway-contrib.inactive-windows-transparency
  ];

  wayland.windowManager.sway.config =
    let
      exec = "exec \"$XDG_CONFIG_HOME/sway/opacity-toggle.sh\"";
    in
    {
      startup = [ { command = exec; } ];
      keybindings = {
        "$mod+Shift+o" = exec;
      };
    };

  xdg.configFile."sway/opacity-toggle.sh" = {
    executable = true;
    text = ''
      #!/bin/sh
      pid=$(pgrep -u ${config.home.username} --full "inactive-windows-transparency.py")
      if test $pid
      then
        kill $pid
      else
        exec inactive-windows-transparency.py  --focused 0.95 --opacity 0.92
      fi
    '';
  };
}
