{settings, ...}: let
  inherit (settings) palette;
in {
  "workbench.colorCustomizations" = {
    "diffEditor.insertedTextBackground" = "${palette.green}33";
    "diffEditor.removedTextBackground" = "${palette.red}33";
    "diffEditor.unchangedRegionBackground" = palette.black;

    "editorGutter.addedBackground" = palette.green;
    "editorGutter.background" = palette.black;
    "editorGutter.deletedBackground" = palette.red;
    "editorGutter.modifiedBackground" = palette.yellow;

    "editorOverviewRuler.addedForeground" = "${palette.green}99";
    "editorOverviewRuler.border" = palette.dark-gray;
    "editorOverviewRuler.commonContentForeground" = "${palette.gray}99";
    "editorOverviewRuler.deletedForeground" = "${palette.red}99";
    "editorOverviewRuler.errorForeground" = palette.red;
    "editorOverviewRuler.findMatchForeground" = "${palette.blue}99";
    "editorOverviewRuler.modifiedForeground" = "${palette.yellow}99";
    "editorOverviewRuler.warningForeground" = palette.yellow;

    "gitDecoration.addedResourceForeground" = palette.green;
    "gitDecoration.conflictingResourceForeground" = palette.red;
    "gitDecoration.deletedResourceForeground" = palette.red;
    "gitDecoration.ignoredResourceForeground" = palette.light-gray;
    "gitDecoration.modifiedResourceForeground" = palette.yellow;
    "gitDecoration.renamedResourceForeground" = palette.aqua;
    "gitDecoration.stageDeletedResourceForeground" = palette.red;
    "gitDecoration.stageModifiedResourceForeground" = palette.yellow;
    "gitDecoration.untrackedResourceForeground" = palette.aqua;
  };
}
