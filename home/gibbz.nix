{
  config,
  pkgs,
  extraArgs,
  ...
}:
{
  home.packages = with pkgs; [
    cowsay
  ];

  home.stateVersion = extraArgs.stateVersion;
}
