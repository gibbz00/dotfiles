{ pkgs, config, ... }:
{
  imports = [
    ./readline.nix
    ./helix.nix
  ];

  # Interactive shell using bash,
  programs.bash = {
    enable = true;
  };
  xdg.configFile."bash/bashrc".text = ''
    # user:host [directory] git-branch $
    # Generated with https://scriptim.github.io/bash-prompt-generator/
    PS1='\[\e[0;38;5;134m\]\u\[\e[0;2m\]:\[\e[0;2m\]\h \[\e[0m\][\[\e[0;1m\]\w\[\e[0m\]]\[\e[0;3m\]$(git branch 2>/dev/null | grep '"'"'^*'"'"' | colrm 1 2) \[\e[0m\]$ \[\e[0m\]'
  '';

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
}
