{ self, config, lib, pkgs, ... }:
{
  environment = {

    systemPackages = with pkgs; [
      hadolint
      shellcheck
      nixpkgs-fmt
      thefuck
      yadm
      yq-go
      htop
      brave
      vscode
      logseq
      signal-desktop
      balena-cli
      awscli2
      saml2aws
      aws-google-auth
      k9s
      kubectl
      gnutls
      gnumake
      gcc
      xdg-utils
      unzip
      wget
      bind
      mkpasswd
      spotify
      zoom-us
      home-manager
      openssl
      neofetch
      vlc
    ];

    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
      # ".." = "cd ..";
    };

  };
}