{ flake-inputs, config, ... }:
{
  imports = [
    flake-inputs.agenix.homeManagerModules.default
  ];

  age.identityPaths = [ "/home/${config.home.username}/.ssh/id_ed25519" ];
}
