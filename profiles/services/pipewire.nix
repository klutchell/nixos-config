{ config, pkgs, lib, ... }:
with lib;
{
  # https://nixos.wiki/wiki/PipeWire
  # https://search.nixos.org/options?channel=unstable&from=0&size=50&sort=relevance&type=packages&query=services.pipewire

  # Remove sound.enable or turn it off if you had it set previously, it seems to cause conflicts with pipewire
  sound.enable = false;
  hardware.pulseaudio.enable = false;

  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  environment.systemPackages = with pkgs; [
    pavucontrol
  ];
}
