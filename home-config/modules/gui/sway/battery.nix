{ config, pkgs, ... }:
{
  wayland.windowManager.sway.config.startup = [
    { command = "exec \"$XDG_CONFIG_HOME/sway/battery.sh\""; }
  ];

  xdg.configFile."sway/battery.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      # Kill already running processes
      if [[ $(ps -fC 'grep' -N | grep 'battery.sh' | wc -l) -gt 1 ]]; then
        pkill -f --older 1 'battery.sh'
      fi

      while true; do
        battery_status="$(cat /sys/class/power_supply/BAT0/status)"
        battery_charge="$(cat /sys/class/power_supply/BAT0/capacity)"

        if [[ $battery_status == 'Discharging' && $battery_charge -le 10 ]]; then
          notify-send --urgency=critical "Battery running low: $battery_charge%"
        fi

        sleep 180
      done
    '';
  };
}
