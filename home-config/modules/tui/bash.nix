{ config, ... }:
{
  home.shell.enableBashIntegration = true;
  programs.bash = {
    enable = true;

    # putting this directly bashrcExtra prevents the history file from being created
    historyFile = "${config.xdg.stateHome}/bash/history";

    bashrcExtra = ''
      # Save and reload the history after each command finishes
      export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
      export HISTSIZE=90000
      export HISTCONTROL=ignoredups:erasedups

      # user:host [directory] git-branch $
      # Generated with https://scriptim.github.io/bash-prompt-generator/
      PS1=' \[\e[0;38;5;134m\]\u\[\e[0;2m\]:\[\e[0;2m\]\h \[\e[0m\][\[\e[0;1m\]\w\[\e[0m\]]\[\e[0;3m\]$(git branch 2>/dev/null | grep '"'"'^*'"'"' | colrm 1 2) \[\e[0m\]$ \[\e[0m\]'

      # References
      # https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
      # https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html
      set -o notify
      shopt -s cdable_vars
      shopt -s checkhash
      shopt -s cmdhist
      shopt -s direxpand
      shopt -s extglob
      shopt -s dotglob
      shopt -s histappend

      # Shopt GNU Readline specific integration
      shopt -s histverify
      shopt -s no_empty_cmd_completion

      ## Coreutils ##
      alias ls='ls -1Ah --color=auto'
      alias mkdir='mkdir -pv'
      alias mv='mv -iv'
      alias cp='cp -iv'
      alias grep='grep --color=auto'
      alias tree="tree --gitignore -I '.git'"
      alias dd="dd status=progress"
      alias rsync='rsync -v --progress'
      alias less='less --use-color'

      # Git
      alias ga='git add'
      alias gaa='git add -A'
      alias gb='git rebase'
      alias gc='git clone'
      alias gcp='git cherry-pick'
      alias gd='git diff'
      alias gds='git diff --staged'
      alias gdss='git diff --staged --stat'
      alias gf='git fetch'
      alias gi="git commit"
      alias gif='git commit --file "${config.xdg.userDirs.documents}/git_messages/COMMIT_EDITMSG"'
      alias gk='git checkout'
      alias gl='git log'
      alias glo='git log --oneline'
      alias gr='git restore'
      alias grs='git restore --staged'
      alias gs='git stash'
      alias gsw='git switch'
      alias gt='git status'
      alias gu='git push'
      alias gw='git whatchanged -p --abbrev-commit --pretty=medium'

      # Docker
      alias dps='docker ps'
      alias dit='docker exec -it'

      # Cargo
      alias cr='cargo run'
      alias ct='cargo test'
    '';
  };
}
