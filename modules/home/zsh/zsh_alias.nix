{ ... }:
{
  programs.zsh = {
    shellAliases = {
      # Utils
      disktree = "ncdu";
      picon = "ssh -i /home/jw/.ssh/id_robotpi 'wro@192.168.178.194'";
      ping = "gping";
      sn = "gnome-text-editor";
      u = "update";
      c = "clear";
      cd = "z";
      tt = "gtrash put";
      cat = "bat";
      diff = "delta --diff-so-fancy --side-by-side";
      less = "bat";
      copy = "wl-copy";
      f = "superfile";
      py = "python";
      ipy = "ipython";
      icat = "kitten icat";
      dsize = "du -hs";
      pdf = "tdf";
      open = "xdg-open";
      space = "ncdu";
      man = "batman";

      l = "eza --icons -a --group-directories-first -1 --no-user --long"; # EZA_ICON_SPACING=2
      tree = "eza --icons --tree --group-directories-first";

      # Nixos
      cdnix = "cd ~/nixos-config && codium ~/nixos-config";
      ns = "nom-shell --run zsh";
      nsp = "nom-shell --run zsh -p";
      nd = "nom develop --command zsh";
      nb = "nom build";
      nc = "nh-notify nh clean all --keep 5";
      nft = "nh-notify nh os test";
      nrs = "nh-notify nh os switch";
      nfu = "nh-notify nh os switch --update";
      nsearch = "nh search";

      # python
      piv = "python -m venv .venv";
      psv = "source .venv/bin/activate";
    };
  };
}
