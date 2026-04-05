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
  systemd.settings.Manager = {
  DefaultTimeoutStopSec = "10s";
};
}