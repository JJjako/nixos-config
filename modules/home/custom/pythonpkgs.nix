{ pkgs, ... }:
{
  home.packages = with pkgs; [
   python3
    python3Packages.jupyterlab
    python3Packages.networkx
    python3Packages.matplotlib
    qlcplus
    
    ];
    }