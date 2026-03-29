{ username, ... }:
{
  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "de";
        #options = "grp:alt_shift_toggle";
      };
    };
    displayManager.autoLogin = {
      enable = true;
      user = "${username}";
    };
    libinput = {
      enable = true;
    };
  };
  systemd.extraConfig = "DefaultTimeoutStopSec=10s";
}