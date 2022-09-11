{ self, config, lib, pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      hadolint
      shellcheck
      thefuck
      yadm
      yq-go
      k9s
      kubectl
      gnutls
      gnumake
      gcc
      xdg-utils
      unzip
      wget
      bind
    ];
  };
}
