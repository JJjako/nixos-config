{ pkgs, inputs, ... }:
{
  # imports = [ inputs.nix-gaming.nixosModules.default ];
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [
        "https://nix-community.cachix.org"
        "https://nix-gaming.cachix.org"
        "https://hyprland.cachix.org"
        "https://ghostty.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
      ];
    };
  };
  nixpkgs = {
    overlays = [ inputs.nur.overlays.default ];
  };

  environment.systemPackages = with pkgs; [
    wtype
    virtualbox    
    appimage-run
    gcc
    wdisplays
    sublime4
    steamcmd
    steam
    rustlings
    google-chrome
    netflix
    qlcplus
    spotify
    myfitnesspal
    elmPackages.nodejs
    drawio
    firefox
    rustup
    whatsie
    wget
    git
    blueman
  ];
  nixpkgs.config.permittedInsecurePackages = [
                "openssl-1.1.1w"
              ];
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "de_DE.UTF-8";
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "24.05";
}
