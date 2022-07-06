{ config, pkgs, lib, ... }:
with lib;
{
  # https://nixos.wiki/wiki/Command_Shell
  users.defaultUserShell = pkgs.zsh;

  # https://nixos.org/manual/nixos/stable/index.html#sec-user-management
  users.users.kyle = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "networkmanager" ];
    initialPassword = "changeme";
    shell = pkgs.zsh;
  };
}