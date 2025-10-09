{ config, pkgs, ... }:
let
  efi = builtins.pathExists "/sys/firmware/efi";
in
{
  boot.loader = if efi then {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  } else {
    grub.enable = true;
    grub.device = "/dev/sda";
  };
}
