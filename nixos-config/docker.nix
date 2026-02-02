{ ... }:
{
  # Remember to add any user the "docker" group for non-sudo socket access.
  virtualisation.docker = {
    enable = true;
    autoPrune = {
      enable = true;
      flags = [ "--all" ];
    };
  };
}
