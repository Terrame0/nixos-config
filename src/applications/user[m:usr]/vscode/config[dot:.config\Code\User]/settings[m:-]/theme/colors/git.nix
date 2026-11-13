{
  design-tokens,
  sundry,
  ...
}: let
  palette = builtins.mapAttrs (_: color: sundry.str.slice [7] color) design-tokens.palette;
in {
  "workbench.colorCustomizations" = {
    "diffEditor.insertedTextBackground" = "${palette.green}33";
    "diffEditor.removedTextBackground" = "${palette.red}33";
    "diffEditor.unchangedRegionBackground" = palette.neutral-1000;

    "editorGutter.addedBackground" = palette.green;
    "editorGutter.background" = palette.neutral-1000;
    "editorGutter.deletedBackground" = palette.red;
    "editorGutter.modifiedBackground" = palette.yellow;

    "editorOverviewRuler.addedForeground" = "${palette.green}99";
    "editorOverviewRuler.border" = palette.neutral-800;
    "editorOverviewRuler.commonContentForeground" = "${palette.neutral-400}99";
    "editorOverviewRuler.deletedForeground" = "${palette.red}99";
    "editorOverviewRuler.errorForeground" = palette.red;
    "editorOverviewRuler.findMatchForeground" = "${palette.blue}99";
    "editorOverviewRuler.modifiedForeground" = "${palette.yellow}99";
    "editorOverviewRuler.warningForeground" = palette.yellow;

    "gitDecoration.addedResourceForeground" = palette.green;
    "gitDecoration.conflictingResourceForeground" = palette.red;
    "gitDecoration.deletedResourceForeground" = palette.red;
    "gitDecoration.ignoredResourceForeground" = palette.neutral-200;
    "gitDecoration.modifiedResourceForeground" = palette.yellow;
    "gitDecoration.renamedResourceForeground" = palette.aqua;
    "gitDecoration.stageDeletedResourceForeground" = palette.red;
    "gitDecoration.stageModifiedResourceForeground" = palette.yellow;
    "gitDecoration.untrackedResourceForeground" = palette.aqua;
  };
}
