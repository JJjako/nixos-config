{ pkgs, ... }:

{
  home.packages = with pkgs; [ superfile ];

  xdg.configFile."superfile/config.toml".text = ''
    [settings]
    image_preview = true
    preview_width = 40

    [settings.preview]
    image_quality = 100
  '';
}
