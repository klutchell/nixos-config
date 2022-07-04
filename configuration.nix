# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # <home-manager/nixos>
      ./cachix.nix
      # home-manager.nixosModule
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices = {
    root = {
      device = "/dev/nvme0n1p2";
      preLVM = true;
    };
  };

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

  environment.sessionVariables.TERMINAL = [ "elementary-terminal" ];

  # services.xserver.desktopManager.gnome.enable = true;
  # services.xserver.displayManager.gdm.enable = true;
  # services.gnome.core-utilities.enable = false;

  # Configure keymap in X11
  services.xserver.layout = "us";
  #services.xserver.xkbOptions = {
  #  "eurosign:e";
  #  "caps:escape" # map caps to escape.
  #};

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  nixpkgs.config.allowUnfree = true;

  virtualisation.docker.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kyle = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "networkmanager" ]; # Enable ‘sudo’ for the user. 
    #  packages = with pkgs; [
    #    brave
    #    vscode
    #    logseq
    #    signal-desktop
    #    etcher
    #    balena-cli
    # ];
  };

  # allow insecure install of balenaEtcher
  nixpkgs.config.permittedInsecurePackages = [
    "electron-12.2.3"
  ];

  # home-manager.users.kyle = {
  #   /* Here goes your home-manager config, eg home.packages = [ pkgs.foo ]; */
  # };

  # By default, Home Manager uses a private pkgs instance that is configured via the home-manager.users.<name>.nixpkgs options.
  # To instead use the global pkgs that is configured via the system level nixpkgs options, set `home-manager.useGlobalPkgs = true;`
  # This saves an extra Nixpkgs evaluation, adds consistency, and removes the dependency on NIX_PATH, which is otherwise used for importing Nixpkgs.
  # home-manager.useGlobalPkgs = true;

  nix.registry."node".to = {
    type = "github";
    owner = "andyrichardson";
    repo = "nix-node";
  };

  # https://nixos.wiki/wiki/Command_Shell
  users.defaultUserShell = pkgs.zsh;

  # https://nixos.wiki/wiki/Zsh

  # https://nixos.wiki/wiki/Syncthing
  services = {
    syncthing = {
        enable = true;
        user = "kyle";
        dataDir = "/home/kyle/Syncthing";    # Default folder for new synced folders
        configDir = "/home/kyle/.config/syncthing";   # Folder for Syncthing's settings and keys
    };
  };

  services.tailscale.enable = true;
  networking.firewall.checkReversePath = "loose";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    gnome-console
    # git
    # gnupg
    openssl
    # pinentry-gnome
    pinentry-gtk2
    # pkgs.gnome3.gnome-tweaks
    (let 
      my-python-packages = python-packages: with python-packages; [ 
        # pandas
        # requests
        #other python packages you want
      ];
      python-with-my-packages = python3.withPackages my-python-packages;
    in
    python-with-my-packages)
    gnumake
    gcc
    binutils
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  #   pinentryFlavor = "gnome3";
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true; # does not work with flakes

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
