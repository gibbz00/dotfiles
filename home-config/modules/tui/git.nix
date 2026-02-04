{
  userName,
  userEmail,
  defaultBranch ? "main",
}:
{ ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = userName;
        email = userEmail;
      };
      init = {
        inherit defaultBranch;
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
