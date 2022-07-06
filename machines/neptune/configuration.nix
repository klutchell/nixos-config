# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

with lib;
{
  imports = [
    ../../profiles/pantheon.nix
    ../../profiles/syncthing.nix
    ../../profiles/avahi.nix
  ];

  networking.hostName = "neptune"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.layout = "us";
  #services.xserver.xkbOptions = {
  #  "eurosign:e";
  #  "caps:escape" # map caps to escape.
  #};

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # get completion for system packages (e.g. systemd).
  environment.pathsToLink = [ "/share/zsh" ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  virtualisation.docker.enable = true;

  users.users.kyle = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "networkmanager" ];
    initialPassword = "changeme";
    shell = pkgs.zsh;
  };

  # https://nixos.wiki/wiki/Command_Shell
  users.defaultUserShell = pkgs.zsh;

  # allow insecure install of balenaEtcher
  nixpkgs.config.permittedInsecurePackages = [
    "electron-12.2.3"
  ];

  nixpkgs.config.allowUnfree = true;

  # https://github.com/NixOS/nixpkgs/blob/master/pkgs/servers/tailscale/default.nix
  services.tailscale.enable = true;
  networking.firewall.checkReversePath = "loose";

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

  # https://nixos.wiki/wiki/Flakes
  nix = {
    package = pkgs.nixFlakes; # or versioned attributes like nixVersions.nix_2_8
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    gc.automatic = true;
    gc.dates = "03:15";
  };

}
