{ lib, pkgs, ... }:

{
  # Automatic bootloader selection
  boot.loader = {
    timeout = 3;
    systemd-boot.editor = false;

    # Conditional enable flags
    systemd-boot.enable = lib.mkIf (builtins.pathExists "/sys/firmware/efi") true;
    efi.canTouchEfiVariables = lib.mkIf (builtins.pathExists "/sys/firmware/efi") true;

    grub.enable = lib.mkIf (!(builtins.pathExists "/sys/firmware/efi")) true;
    grub.device = lib.mkIf (!(builtins.pathExists "/sys/firmware/efi")) "/dev/sda";
  };
}
