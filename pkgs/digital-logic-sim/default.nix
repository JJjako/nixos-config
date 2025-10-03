{ stdenv, lib }:

stdenv.mkDerivation {
  pname = "digital-logic-sim";
  version = "1.0";

  # auf den ganzen Ordner zeigen, nicht nur auf das Binary
  src = ./Digital-Logic-Sim-Linux;

  installPhase = ''
    mkdir -p $out/share/digital-logic-sim
    cp -r $src/* $out/share/digital-logic-sim/

    mkdir -p $out/bin
    ln -s $out/share/digital-logic-sim/Digital-Logic-Sim.x86_64 $out/bin/digital-logic-sim
  '';
}
