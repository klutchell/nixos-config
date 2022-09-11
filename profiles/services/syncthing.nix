{ config, pkgs, lib, ... }:
with lib;
{
  # https://nixos.wiki/wiki/Syncthing
  # https://search.nixos.org/options?channel=22.05&from=0&size=50&sort=relevance&type=packages&query=syncthing
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
  };

  users.users.syncthing.extraGroups = [ "users" ];
}
