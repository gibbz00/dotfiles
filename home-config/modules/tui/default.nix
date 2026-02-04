{ pkgs, config, ... }:
{
  imports = [
    ./readline.nix
    ./bash.nix
    ./helix.nix
  ];

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
    download = "downloads";
    documents = "documents";
    music = "${config.xdg.userDirs.documents}/music";
    pictures = "${config.xdg.userDirs.documents}/pictures";
    publicShare = "${config.xdg.userDirs.documents}/public";
    templates = "${config.xdg.userDirs.documents}/templates";
    videos = "${config.xdg.userDirs.documents}/videos";
    # WORKAROUND: firefox attempting to create a desktop directory
    desktop = "${config.home.homeDirectory}";
  };

  ## Base Programs
  home.packages = with pkgs; [
    ouch
    fd
    ripgrep
    tree
    ## Diagnostics
    btop
    mtr
    pciutils
    strace
    usbutils
  ];

  programs.zoxide.enable = true;
  programs.fzf = {
    enable = true;
    fileWidgetCommand = "fd --type f --hidden --follow --exclude .git";
    changeDirWidgetCommand = "fd --type d --hidden --follow --exclude .git";
  };
  programs.yazi = {
    enable = true;
    settings = {
      mgr = {
        show_hidden = true;
      };
    };
  };
}
