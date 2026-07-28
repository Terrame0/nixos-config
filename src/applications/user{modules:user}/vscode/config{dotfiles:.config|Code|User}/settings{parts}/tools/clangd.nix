{...}: {
  "clangd.path" = "clangd";
  "clangd.trace" = "/tmp/clangd-log.txt";
  "clangd.arguments" = [
    "--background-index"
    "--clang-tidy"
    "--header-insertion=iwyu"
    "--completion-style=detailed"
    "--log=verbose"
    "--pch-storage=memory"
    "--function-arg-placeholders"
  ];
}
