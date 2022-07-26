{ config, pkgs, lib, ... }:
with lib;
{
  # https://nixos.org/manual/nixos/stable/index.html#sec-user-management
  users.users.kyle = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
      "networkmanager"
    ];
    initialPassword = "changeme";
    shell = pkgs.zsh;
  };

  nix.settings = {
    trusted-users = [ "kyle" ];
  };
}
