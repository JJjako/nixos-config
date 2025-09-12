# modules/home/packages/gui.nix
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wdisplays
    kanshi # optional
  ];
}

