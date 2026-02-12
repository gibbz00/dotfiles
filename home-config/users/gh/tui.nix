{ pkgs, ... }:
{
  imports = [
    ../../modules/tui/git.nix
  ];

  programs.git.includes = [
    {
      condition = "gitdir:~/projects/leissner/";
      contents = {
        init.defaultBranch = "master";
        user = {
          email = "gh@leissner.se";
          name = "Gabriel Hansson";
        };
      };
    }
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
    openconnect
    vpn-slice

    (writeShellScriptBin "lvpn" ''
      if [ $1 == "--no-split" ]; then
        sudo openconnect vpn1.leissner.se --authgroup lda-asa --user gh
      else
        _slice_command='vpn-slice {webmail1,jira,confluence,src,gate}.leissner.se'
        sudo openconnect vpn1.leissner.se --authgroup lda-asa --user gh -s "$_slice_command"
      fi
    '')
    (writeShellScriptBin "lproxy" ''
      if [ $1 == "on" ]; then
          export http_proxy="http://192.168.1.1:80"
          export https_proxy="http://192.168.1.1:80"
          export ftp_proxy="http://192.168.1.1:80"
      fi

      if [ $1 == "off" ]; then
          unset http_proxy
          unset https_proxy
          unset ftp_proxy
      fi
    '')
    (writeShellScriptBin "lvvv" ''
      curl --proxy "" http://vvv.leissner.se/open-gh
    '')
  ];
}
