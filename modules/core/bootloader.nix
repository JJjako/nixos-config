{ lib, pkgs, config, ... }:

let
  hostname = config.networking.hostName or "";
in {
  boot.loader = {
    timeout = 3;
    systemd-boot.editor = false;

    # Desktop → EFI (systemd-boot)
    systemd-boot.enable = lib.mkIf (hostname == "desktop") true;
    efi.canTouchEfiVariables = lib.mkIf (hostname == "desktop") true;

    # Laptop → BIOS (grub)
    grub.enable = lib.mkIf (hostname == "laptop") true;
    grub.device = lib.mkIf (hostname == "laptop") "/dev/sda";
  };
}
