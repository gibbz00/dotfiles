{ pkgs, ... }:
{
  systemd.user.services.tmp = {
    Unit = {
      Description = "Manage a /tmp under $HOME";
    };
    Service = {
      ExecStart = "/bin/sh -c '${pkgs.coreutils}/bin/rm -rf $HOME/tmp; ${pkgs.coreutils}/bin/mkdir $HOME/tmp'";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
