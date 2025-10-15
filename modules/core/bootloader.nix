{ pkgs, ... }:

{
  boot.loader.grub.enable = false;
  boot.loader.grub.device = "/dev/sda"; # only relevant if grub.enable = true
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
