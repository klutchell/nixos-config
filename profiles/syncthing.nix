{ config, pkgs, lib, ... }:
with lib;
{
  # https://nixos.wiki/wiki/Syncthing
  services.syncthing = {
    enable = true;
    user = "kyle";
    dataDir = "/home/kyle/.syncthing";    # Default folder for new synced folders
    configDir = "/home/kyle/.config/syncthing";   # Folder for Syncthing's settings and keys
  };
}
