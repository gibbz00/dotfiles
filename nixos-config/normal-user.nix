{
  userName,
  hashedPassword,
  extraGroups ? [ ],
}:
{ flake-inputs, ... }:
{
  home-manager.users.${userName} = import "${flake-inputs.self}/home-config/users/${userName}.nix";
  users.users.${userName} = {
    isNormalUser = true;
    initialHashedPassword = hashedPassword;
    inherit extraGroups;
  };
}
