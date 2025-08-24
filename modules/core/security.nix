{ ... }:
{
  security.rtkit.enable = true;
  security.sudo.enable = false;
  security.pam.services.swaylock = { };
  security.pam.services.hyprlock = { };
}
