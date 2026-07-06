{...}: [
  {
    key = "ctrl+r";
    command = "workbench.action.tasks.runTask";
    args = "run";
    when = "editorTextFocus";
  }
  {
    key = "ctrl+b";
    command = "workbench.action.tasks.runTask";
    args = "build";
    when = "editorTextFocus";
  }
]
