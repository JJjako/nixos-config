{ ... }:
{
  security.rtkit.enable = true;
  security.pam.services.swaylock = { };
  security.pam.services.hyprlock = { };
  security.sudo = {
    enable = true;
    wheelNeedsPassword = false; # <– anyone in wheel can sudo without a password
  };
}
