{ pkgs, ... }:
let
  launchpad-control = pkgs.rustPlatform.buildRustPackage {
    pname = "launchpad-control";
    version = "0.1.0";
    src = /home/jw/shared/midi_qlc;  # oder ein fetchgit
    cargoLock.lockFile = /home/jw/shared/midi_qlc/Cargo.lock;
  };
in {
  home.packages = [ launchpad-control ];
}
