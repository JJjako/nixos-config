{ lib, pkgs, ... }:

{
  # Automatically choose the correct bootloader based on firmware type
  boot.loader = if builtins.pathExists "/sys/firmware/efi" then {
    # ✅ EFI systems (e.g. your desktop)
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    grub.enable = false;
  } else {
    # 💻 Legacy BIOS systems (e.g. your laptop)
    grub.enable = true;
    grub.device = "/dev/sda";
  };

  # Recommended safety defaults
  boot.loader.timeout = 3;
  boot.loader.systemd-boot.editor = false;
}
