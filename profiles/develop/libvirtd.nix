{ config, pkgs, lib, ... }:
with lib;
{
  # https://nixos.wiki/wiki/Libvirt
  # https://search.nixos.org/options?channel=unstable&from=0&size=50&sort=relevance&type=packages&query=virtualisation.libvirtd
  virtualisation.libvirtd = {
    enable = true;
    allowedBridges = [ "all" ];
    qemu.ovmf.enable = true;
    qemu.ovmf.packages = [ pkgs.OVMFFull.fd ];
  };
}