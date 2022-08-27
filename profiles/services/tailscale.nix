{ ... }:
{
  # https://github.com/NixOS/nixpkgs/blob/master/pkgs/servers/tailscale/default.nix
  services.tailscale.enable = true;
  networking.firewall.checkReversePath = "loose";
}