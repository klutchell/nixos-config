{ config, pkgs, lib, ... }:
with lib;
{
  # allow insecure install of balenaEtcher
  nixpkgs.config.permittedInsecurePackages = [
    "electron-12.2.3"
  ];

  environment.systemPackages = with pkgs; [
    etcher
  ];
}