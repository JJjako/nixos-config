{ pkgs, ... }:
{
  boot.loader.grub.enable = false;
  boot.loader.grub.device = "dev/sda";
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.supportedFilesystems = [ "fat" ];
}
