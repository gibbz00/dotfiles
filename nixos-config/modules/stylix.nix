{ flake-inputs, pkgs, ... }:
{
  imports = [
    flake-inputs.stylix.nixosModules.stylix
  ];

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/ayu-dark.yaml";
  };
}
