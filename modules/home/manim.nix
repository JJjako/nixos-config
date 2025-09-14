{ pkgs ? import <nixpkgs> {} }:

let
  python = pkgs.python311;

  manimEnv = python.withPackages (ps: with ps; [
    numpy
    manim
    manimgl
    manim-slides
    pip
  ]);
in

pkgs.stdenv.mkDerivation {
  pname = "manim-env";
  version = "1.0";

  buildInputs = [
    manimEnv
    pkgs.gcc.libcxx
    pkgs.pkg-config
    pkgs.cairo
    pkgs.pango
    pkgs.ffmpeg
  ];

  # Optional: Set up a shellHook for interactive environments
  shellHook = ''
    echo "Welcome to the global Manim environment!"
    echo "Python: $(python --version)"
    echo "Numpy: $(python -c 'import numpy; print(numpy.__version__)')"
    echo "Manim: $(python -c 'import manim; print(manim.__version__)')"
    echo "Manim Slides: $(python -c 'import manim_slides; print(manim_slides.__version__)')"
  '';

  # Optional: Make it installable system-wide
  meta = with pkgs.lib; {
    description = "Global Manim environment with ManimGL and Manim Slides";
    license = licenses.mit;
  };
}
