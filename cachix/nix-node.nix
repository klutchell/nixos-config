
{
  nix = {
    settings.substituters = [
      "https://nix-node.cachix.org"
    ];
    settings.trusted-public-keys = [
      "nix-node.cachix.org-1:2YOHGtGxa8VrFiWAkYnYlcoQ0sSu+AqCniSfNagzm60="
    ];
  };
}
