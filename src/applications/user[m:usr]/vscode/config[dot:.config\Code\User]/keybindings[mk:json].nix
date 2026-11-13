{...}: [
  {
    key = "f5";
    command = "workbench.action.tasks.runTask";
    args = "run";
    when = "editorTextFocus";
  }
  {
    key = "f6";
    command = "workbench.action.tasks.runTask";
    args = "build";
    when = "editorTextFocus";
  }
  {
    key = "f7";
    command = "workbench.action.tasks.runTask";
    args = "format";
    when = "editorTextFocus";
  }
  {
    key = "ctrl+f5";
    command = "workbench.action.tasks.runTask";
    args = "debug";
    when = "editorTextFocus";
  }
]
