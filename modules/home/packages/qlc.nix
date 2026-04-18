{ pkgs, inputs, ... }:
let
  launchpad-control = pkgs.rustPlatform.buildRustPackage {
    pname = "launchpad-control";
    version = "0.1.0";
    src = inputs.midi-qlc-src;
    cargoLock.lockFile = "${inputs.midi-qlc-src}/Cargo.lock";
    buildInputs = with pkgs; [ alsa-lib ];
    nativeBuildInputs = with pkgs; [ pkg-config ];
  };
in {
  home.packages = [ launchpad-control ];
}
