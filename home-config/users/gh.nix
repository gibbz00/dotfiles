{ pkgs, ... }:
{
  imports = [
    ../tui
    (import ../tui/git.nix {
      userName = "Gabriel Hansson";
      userEmail = "gh@leissner.se";
      defaultBranch = "master";
    })
  ];

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."*" = {
      setEnv = {
        TERM = "xterm-256color";
      };
    };
    extraConfig = ''
      Host rick
        Hostname 192.168.1.1
        Port 7042

      Host skutt
        Match host skutt exec "timeout 0.1 nc -z 192.168.99.44 222 >/dev/null 2>&1"
          HostName 192.168.99.44
          Port 222
        Match host skutt exec "timeout 0.1 nc -z 192.168.1.1 7026 >/dev/null 2>&1"
          Hostname 192.168.1.1
          Port 7026

      Host src.leissner.se
        Match host src.leissner.se exec "timeout 0.1 nc -z gate4.leissner.se 1122 >/dev/null 2>&1"
          HostName gate4.leissner.se
          Port 1122
    '';
  };

  home.packages = with pkgs; [
    docker-compose
  ];

  home.stateVersion = "25.11";
}
