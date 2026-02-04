{ ... }:
{
  programs.readline = {
    enable = true;
    extraConfig = ''
      # Based on the tips in https://wiki.archlinux.org/title/Readline
      # all bindings can be shown with $ bind -v
      set bell-style none

      ## Vi-mode ##
      set editing-mode vi
      set show-mode-in-prompt on

      $if term=linux
              set vi-ins-mode-string \1\e[?0c\2
              set vi-cmd-mode-string \1\e[?8c\2
      $else
              set vi-ins-mode-string \1\e[6 q\2
              set vi-cmd-mode-string \1\e[2 q\2
      $endif

      # Up-down history searches to match current input
      $if mode=vi
          set keymap vi-command
              "\e[A": history-search-backward
              "\e[B": history-search-forward
              j: history-search-forward
              k: history-search-backward
          set keymap vi-insert
              "\e[A": history-search-backward
              "\e[B": history-search-forward
      $endif

      # https://unix.stackexchange.com/questions/104094/is-there-any-way-to-enable-ctrll-to-clear-screen-when-set-o-vi-is-set
      $if mode=vi
          set keymap vi-command
              Control-l: clear-screen
          set keymap vi-insert
              Control-l: clear-screen
      $endif

      set echo-control-characters off

      # Expand alias with <CTRL+SPACE>
      "\C-\ ": alias-expand-line

      # traverse completed suggestions with '<TAB>'
      "\t": menu-complete

      set completion-ignore-case
      set show-all-if-ambiguous on

      set colored-stats On
      set colored-completion-prefix On
      set menu-complete-display-prefix On
    '';
  };
}
