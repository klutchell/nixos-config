{ config, pkgs, lib, ... }:
with lib;
{
  # https://nixos.org/manual/nixos/stable/index.html#chap-pantheon
  # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/services/x11/desktop-managers/pantheon.nix
  services.xserver.desktopManager.pantheon.enable = true;
  environment.pantheon.excludePackages = [
    # pkgs.pantheon.elementary-calculator
    pkgs.pantheon.elementary-calendar
    # pkgs.pantheon.elementary-camera
    pkgs.pantheon.elementary-code
    # pkgs.pantheon.elementary-files
    pkgs.pantheon.elementary-mail
    pkgs.pantheon.elementary-music
    pkgs.pantheon.elementary-photos
    # pkgs.pantheon.elementary-screenshot
    pkgs.pantheon.elementary-tasks
    # pkgs.pantheon.elementary-terminal
    pkgs.pantheon.elementary-videos
    pkgs.pantheon.epiphany
  ];

  environment.systemPackages = with pkgs; [
    pantheon.pantheon-agent-polkit
  ];
}