{ ... }:
{
  # Remember to add any user the "podman" group for non-sudo socket access *if the podman socket is enabled*.
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      defaultNetwork.settings = {
        dns_enabled = true;
      };
      autoPrune = {
        enable = true;
        flags = [ "--all" ];
      };
    };
  };
}
