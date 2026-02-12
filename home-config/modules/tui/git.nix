{ ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "gibbz00";
        email = "gabrielhansson00@gmail.com";
      };
      init = {
        defaultBranch = "main";
      };
      branch = {
        autoSetupRebase = "always";
      };
      safe = {
        directory = "*";
      };
      pull = {
        rebase = true;
        ff = "only";
      };
      rebase = {
        updateRefs = true;
      };
      rerere = {
        enabled = true;
      };
      push = {
        default = "current";
      };
    };
  };
}
