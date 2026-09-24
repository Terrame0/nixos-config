args @ {
  lib,
  sundry,
  pkgs,
  root-vfs,
  ...
}: {
  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };
  programs.nushell = {
    enable = true;
    environmentVariables = {
      LS_COLORS = "rs=0:fi=0:di=36:ln=34:mh=36:pi=33:so=35:bd=33:cd=33:or=31:mi=31:su=31:sg=33:ca=31:tw=36:ow=36:st=36:ex=32";
    };
    settings = lib.pipe root-vfs.src.shell.nushell.config [
      (sundry.vfs.dir.filter (path: file: sundry.vfs.path.get.ext path == "nix"))
      (sundry.vfs.dir.collapse (path: file: file.expr args))
      sundry.attrs.merge.recursive.no-collision
    ];
    plugins = with pkgs.nushellPlugins; [
      formats
      gstat
      polars
      skim
      # units # -- broken
    ];
  };
}
