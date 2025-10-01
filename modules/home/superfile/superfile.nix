{ pkgs, ... }:

{
  home.packages = with pkgs; [
    superfile
  ];

  xdg.configFile."superfile/config.toml".text = ''
    [settings]
    image_preview = true
    preview_width = 40
    # Du kannst hier noch weitere Superfile-Einstellungen hinzufügen
  '';
}
