{ config, pkgs, ... }:

let
  seafile_autostart = (pkgs.makeAutostartItem { name = "seafile"; package = pkgs.seafile-client; });
in
{
  environment.systemPackages = with pkgs; [
    seafile-client
    seafile_autostart
  ];
}
