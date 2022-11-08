{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    cryptomator
  ];
}