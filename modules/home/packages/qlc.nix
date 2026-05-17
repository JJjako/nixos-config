{ pkgs, ... }:
{
  home.packages = with pkgs; [
alsa-lib 
pkg-config

arduino #for arduino
];
}
