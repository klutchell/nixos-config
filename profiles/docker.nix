{ config, pkgs, lib, ... }:
with lib;
{
  # https://nixos.wiki/wiki/Docker
  # https://search.nixos.org/options?channel=22.05&from=0&size=50&sort=relevance&type=packages&query=virtualisation.docker
  virtualisation.docker.enable = true;
}