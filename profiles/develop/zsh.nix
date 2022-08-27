{ config, pkgs, lib, ... }:
with lib;
{
  # Make sure zsh is added to /etc/shells (required by sudo-prompt)
  programs.zsh.enable = true;

  # get completion for system packages (e.g. systemd).
  environment.pathsToLink = [ "/share/zsh" ];

  # https://nixos.wiki/wiki/Command_Shell
  users.defaultUserShell = pkgs.zsh;
}