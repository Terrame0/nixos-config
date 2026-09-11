{...}: {
  # -- keep vscode from leaking its own environment
  # and include paths into builds
  "terminal.integrated.inheritEnv" = false;
  "C_Cpp.default.includePath" = [];
}
