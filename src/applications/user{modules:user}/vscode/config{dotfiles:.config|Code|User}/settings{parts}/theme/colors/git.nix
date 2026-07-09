{settings, ...}: let
  inherit (settings) palette;
in {
  "workbench.colorCustomizations" = {
    "gitDecoration.modifiedResourceForeground" = palette.yellow;
    "gitDecoration.addedResourceForeground" = palette.green;
    "gitDecoration.deletedResourceForeground" = palette.red;
    "gitDecoration.untrackedResourceForeground" = palette.aqua;
    "gitDecoration.ignoredResourceForeground" = palette.light-gray;
    "gitDecoration.renamedResourceForeground" = palette.aqua;

    "editorGutter.addedBackground" = palette.green;
    "editorGutter.modifiedBackground" = palette.yellow;
    "editorGutter.deletedBackground" = palette.red;

    "editorOverviewRuler.addedForeground" = "${palette.green}99";
    "editorOverviewRuler.modifiedForeground" = "${palette.yellow}99";
    "editorOverviewRuler.deletedForeground" = "${palette.red}99";
    "editorOverviewRuler.commonContentForeground" = "${palette.gray}99";
    "editorOverviewRuler.warningForeground" = palette.yellow;

    "diffEditor.insertedTextBackground" = "${palette.green}33";
    "diffEditor.removedTextBackground" = "${palette.red}33";

    "gitDecoration.stageModifiedResourceForeground" = palette.yellow;
    "gitDecoration.stageDeletedResourceForeground" = palette.red;
    "gitDecoration.conflictingResourceForeground" = palette.red;
  };
}
