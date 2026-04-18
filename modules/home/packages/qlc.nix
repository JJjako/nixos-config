{ pkgs, ... }:
{
  home.packages = with pkgs; [
  haskellPackages.launchpad-control
  ];}
