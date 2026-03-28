{ lib, pkgs, config, ... }:

let
  hostname = config.networking.hostName or "";
in {
  boot.loader = {
    timeout = 3;
    systemd-boot.editor = false;

    # Desktop → EFI (systemd-boot)
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
}
