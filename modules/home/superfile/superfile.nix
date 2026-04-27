{ pkgs, inputs, ... }:
let
  system = pkgs.stdenv.hostPlatform.system;
  superfile = inputs.superfile.packages.${system}.default;
in
{
  home.packages = [ superfile ];

  xdg.configFile."superfile/config.toml".text = ''
    [settings]
    image_preview = true
    preview_width = 40

    [settings.preview]
    image_quality = 70
  '';
}
