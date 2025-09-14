{ pkgs, lib, ... }:
{
  programs.dconf.enable = true;
  programs.zsh.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [ ];

  programs.steam.enable = lib.mkForce true;
  programs.steam.remotePlay.openFirewall = lib.mkForce true;
  programs.steam.dedicatedServer.openFirewall = lib.mkForce true;
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
  ];
  nixpkgs.config.allowUnfreePredicate = pkg:
    lib.elem (lib.getName pkg) [
      "steam"
      "steam-original"
      "steam-unwrapped"
      "steam-run"
    ];
}

