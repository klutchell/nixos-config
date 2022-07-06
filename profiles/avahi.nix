{ config, pkgs, lib, ... }:
with lib;
{
  services.avahi.enable = true;
  services.avahi.nssmdns = false; # Use my settings from below
  # settings from avahi-daemon.nix where mdns_minimal is replaced with mdns4
  # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/config/nsswitch.nix
  # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/services/networking/avahi-daemon.nix
  system.nssModules = with pkgs.lib; optional (!config.services.avahi.nssmdns) pkgs.nssmdns;
  system.nssDatabases.hosts = with pkgs.lib; optionals (!config.services.avahi.nssmdns) (mkMerge [
    (mkBefore [ "mdns4 mdns [NOTFOUND=return]" ]) # before resolve
    (mkAfter [ "mdns4" ]) # after dns
  ]);
}