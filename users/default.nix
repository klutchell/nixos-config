{ config, pkgs, lib, ... }:
with lib;
{
  imports = [
    ./kyle
  ];

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Make sure zsh is added to /etc/shells (required by sudo-prompt)
  programs.zsh.enable = true;

  # get completion for system packages (e.g. systemd).
  environment.pathsToLink = [ "/share/zsh" ];

  # https://nixos.wiki/wiki/Command_Shell
  users.defaultUserShell = pkgs.zsh;
}