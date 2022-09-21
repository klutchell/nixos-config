{ config, pkgs, lib, ... }:
with lib;
{
  # https://nixos.wiki/wiki/PulseAudio

  # hardware.pulseaudio.enable = true;
  # hardware.pulseaudio.support32Bit = true; 

  hardware.pulseaudio = {
    enable = true;
    # extraModules = [ pkgs.pulseaudio-modules-bt ];
    package = pkgs.pulseaudioFull;
    support32Bit = true;
  };

  environment.systemPackages = with pkgs; [
    pavucontrol
    pulseaudio
  ];

  hardware.bluetooth = {
    enable = true;
  };
}
