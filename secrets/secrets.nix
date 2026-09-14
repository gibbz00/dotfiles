let
  gh = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBCQDB2rkBcR9BPd8eQw8fzfjFpQlF+AXSGRdZjQajno";

  users = [
    gh
  ];

  systems = [
  ];
in
{
  "eduroam.age".publicKeys = users ++ systems;
}
