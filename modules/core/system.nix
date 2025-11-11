{ pkgs, inputs, ... }:
{
  virtualisation.docker.enable = true;
  users.users.jw.extraGroups = [ "docker" ];

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
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.open = true;  # ✅ Use the new open-source NVIDIA kernel module


  nixpkgs = {
    overlays = [ inputs.nur.overlays.default ];
  };
  environment.variables = {
     USED_EDITOR = "subl";};
  environment.systemPackages = with pkgs; [
    ventoy
    jetbrains.pycharm-community
    docker
    prismlauncher
    quickemu
    texliveFull
    texstudio
    texmaker
    cameractrls
    p3x-onenote
    flatpak
    timer
    haskellPackages.timers
    python3
    python3Packages.jupyterlab
    python3Packages.networkx
    python3Packages.matplotlib
    teams-for-linux
    wtype
    virtualbox    
    appimage-run
    gcc
    wdisplays
    sublime4
    steamcmd
    steam
    pdf4qt
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
    wasistlos
    wget
    git
    blueman
   
  ]; 
nixpkgs.config.allowUnsupportedSystem = true;  
nixpkgs.config.permittedInsecurePackages = [
                "openssl-1.1.1w"
              
                "ventoy-1.1.05"
              ];
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "de_DE.UTF-8";
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "24.05";
environment.etc."polkit-1/rules.d/50-udisks.rules".text = ''
  polkit.addRule(function(action, subject) {
      if ((action.id == "org.freedesktop.udisks2.filesystem-mount" ||
           action.id == "org.freedesktop.udisks2.filesystem-unmount-others" ||
           action.id == "org.freedesktop.udisks2.format" ||
           action.id == "org.freedesktop.udisks2.eject-media") &&
          subject.isInGroup("wheel")) {
          return polkit.Result.YES;
      }
  });
'';


}
