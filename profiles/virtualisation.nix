{ config, pkgs, lib, ... }:
with lib;
{
  # https://nixos.wiki/wiki/Docker
  virtualisation.docker.enable = true;
}