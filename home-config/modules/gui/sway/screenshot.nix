{ flake-inputs, pkgs, ... }:
{
  imports = [
    "${flake-inputs.self}/home-config/modules/tui/tmp.nix"
  ];

  home.packages = with pkgs; [
    grim
    jq
    libnotify
    slurp
    swappy
    wl-clipboard
  ];

  wayland.windowManager.sway.config.keybindings = {
    "$mod+s" = "exec --no-startup-id \"$XDG_CONFIG_HOME/sway/screenshot.sh\"";
  };

  xdg.configFile."sway/screenshot.sh" = {
    executable = true;
    text = ''
      #!/bin/sh

      # Touched up from: https://github.com/gibbz00/sway-rofi-screenshot

      # `list_geometry` returns the geometry of the focused of visible windows.
      # Arguments:
      #   $1: `focused` or `visible`
      #   $2: `with_description` or nothing
      function list_geometry () {
        [ "$2" = with_description ] && local append="\t\(.name)" || local append=
        swaymsg -t get_tree | jq -r '.. | (.nodes? // empty)[] | select(.'$1' and .pid) | "\(.rect.x),\(.rect.y) \(.rect.width)x\(.rect.height)'$append'"'
      }

      _choice=`rofi -dmenu -p 'Screenshot' << EOF
      Fullscreen
      Region
      Focused
      $(list_geometry visible with_description)
      EOF`

      _save_dir="$HOME/tmp/screenshots"
      mkdir -p -- "$_save_dir"
      _filename="$_save_dir/$(date +'%Y-%m-%d-%H%M%S_screenshot.png')"

      case $_choice in
          Fullscreen) grim "$_filename" ;;
          Region) grim -g "$(slurp)" "$_filename" ;;
          Focused) grim -g "$(list_geometry focused)" "$_filename" ;;
          "") notify-send "Screenshot" "Cancelled"; exit 0 ;;
          *) grim -g $(echo "$_choice" | cut -d '\t' -f1) "$_filename"
      esac

      _edit_choice="$(echo "Yes|No" \
        | rofi -dmenu -sep "|" -p 'Edit with Swappy?' -theme-str 'listview { scrollbar: false; }'
      )"
      case $_edit_choice in
          Yes) swappy -f "$_filename" -o "$_filename" ;;
          *) ;;
      esac

      wl-copy < "$_filename"
      notify-send "Screenshot" "File saved to <i>'$_filename'</i>, and copied to the clipboard." -i "$_filename"
    '';
  };
}
