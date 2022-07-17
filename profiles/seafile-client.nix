{ config, pkgs, ... }:

let
  seafile_autostart = (pkgs.makeAutostartItem { name = "seafile"; package = pkgs.seafile-client; });
in
{
  config = {
    environment.systemPackages = [
      pkgs.seafile-client
      seafile_autostart
    ];
  };
}
