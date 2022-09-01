{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    balena-cli
  ];
}