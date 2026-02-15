{ config, ... }:
{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;

      format = "\($jobs \)\($nix_shell \)$username:$hostname \\[$directory\\]\( $git_state\)\( $git_branch\) \\$ ";

      username = {
        format = "[$user](purple)";
        show_always = true;
      };

      hostname = {
        format = "[$hostname](dimmed white)";
        ssh_only = false;
        trim_at = "";
      };

      directory = {
        format = "[$path](bold white)";
        truncation_length = 0;
        truncate_to_repo = false;
      };

      git_branch = {
        format = "$branch";
      };

      git_state = {
        format = "[$state( $progress_current/$progress_total)](yellow)";
        rebase = "rebasing";
        merge = "merging";
        revert = "reverting";
        cherry_pick = "cherry-picking";
        bisect = "bisecting";
        am = "am";
        am_or_rebase = "am/rebase";
      };

      jobs = {
        format = "\\[$number\\]+";
        number_threshold = 1;
      };

      nix_shell = {
        format = "[\\[$name\\]](bright-blue)";
      };
    };
  };
}
