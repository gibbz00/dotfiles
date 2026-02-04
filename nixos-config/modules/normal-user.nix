{
  userName,
  hashedPassword,
  extraGroups ? [ ],
}:
{ flake-inputs, config, ... }:
{
  users.users.${userName} = {
    isNormalUser = true;
    initialHashedPassword = hashedPassword;
    inherit extraGroups;
  };

  home-manager.users.${userName} =
    { ... }:
    {
      imports = [
        "${flake-inputs.self}/home-config/hosts/${config.networking.hostName}/${userName}.nix"
      ];

      # Not set by default since stateVersion 20.09 (used impure builtins.getEnv).
      home.homeDirectory = "/home/${userName}";
      home.username = userName;
    };
}
