{ pkgs, ... }:
{
  # TEMP:
  systemd.services.docker.environment = {
    HTTP_PROXY = "http://192.168.1.1:80";
    HTTPS_PROXY = "http://192.168.1.1:80";
  };

  environment.systemPackages = with pkgs; [
    docker-compose
  ];

  # Remember to add any user the "docker" group for non-sudo socket access.
  virtualisation.docker = {
    enable = true;
    autoPrune = {
      enable = true;
      flags = [ "--all" ];
    };
  };
}
