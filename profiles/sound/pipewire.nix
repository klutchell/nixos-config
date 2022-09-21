{ config, pkgs, lib, ... }:
with lib;
{
  # https://nixos.wiki/wiki/PipeWire
  # https://search.nixos.org/options?channel=unstable&from=0&size=50&sort=relevance&type=packages&query=services.pipewire

  # Remove sound.enable or turn it off if you had it set previously, it seems to cause conflicts with pipewire
  # sound.enable = true;
  # hardware.pulseaudio.enable = false;
  hardware.pulseaudio.enable = lib.mkForce false;

  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
    media-session.enable = false;
    wireplumber.enable = true;
  };

  environment.systemPackages = with pkgs; [
    pavucontrol
    pulseaudio
  ];

  # environment.etc = {
  #   "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
  #     bluez_monitor.properties = {
  #       ["bluez5.enable-sbc-xq"] = true,
  #       ["bluez5.enable-msbc"] = true,
  #       ["bluez5.enable-hw-volume"] = true,
  #       ["bluez5.headset-roles"] = "[ hsp_hs hfp_hf hfp_ag ]",
  #       ["bluez5.codecs"] = "[ sbc sbc_xq aac ldac ]"
  #     }
  #   '';
  # };

  hardware.bluetooth = {
    enable = true;
  };
}
