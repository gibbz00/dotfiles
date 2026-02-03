{ config, ... }:
{
  imports = [
    ./readline.nix
    ./helix.nix
  ];

  # TEMP: Interactive shell using bash,
  # requied for getting home.sessionVariables to work.
  programs.bash = {
    enable = true;
  };

  home.sessionVariables = {
    # TEMP: some terminals do not advertise true color support, even if it is supported
    COLORTERM = "truecolor";
  };

  home.language = {
    base = "en_US.UTF-8";
    measurement = "sv_SE.UTF-8";
    monetary = "sv_SE.UTF-8";
    numeric = "sv_SE.UTF-8";
    paper = "sv_SE.UTF-8";
    # Because en_SV isn't supported
    time = "en_DK.UTF-8";
  };

  # XDG base directory spec adherence
  xdg.enable = true;
  xdg.cacheHome = "${config.home.homeDirectory}/.local/cache";
  home.preferXdgDirectories = true;

  # XDG user directories
  xdg.userDirs = {
    enable = true;
    desktop = "desktop";
    documents = "documents";
    download = "downloads";
    music = "music";
    pictures = "pictures";
    publicShare = "public";
    templates = "templates";
    videos = "videos";
  };
}
