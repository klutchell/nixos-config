{ config, lib, suites, ... }:

{
  imports = suites.workstation;

  networking.hostName = "neptune"; # Define your hostname.

  networking.networkmanager.enable = true;
  
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices = {
    root = {
      device = "/dev/nvme0n1p2";
      preLVM = true;
    };
  };

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/ca2d12f1-e153-40f6-aea4-04b153b55d53";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/4F93-748E";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/08b70eff-2823-4179-8f3a-0337771c6394"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp57s0u1u2.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp58s0.useDHCP = lib.mkDefault true;

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # udev 250 doesn't reliably reinitialize devices after restart
  # https://github.com/NixOS/nixpkgs/issues/180175
  systemd.services.systemd-udevd.restartIfChanged = false;
  systemd.network.wait-online.anyInterface = true;
}
