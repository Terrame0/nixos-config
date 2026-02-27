{
  pkgs,
  config-add,
  config,
  ...
}:
config-add "fns"
{
  bruh = file-data: let
    file-path = config.path.join file-data;
    store-path = pkgs.runCommand file-path {
      buildInputs = with pkgs; [sassc];
    } "sassc ${file-data.store-path} $out";
  in
    file-data
    // {
      store-path = store-path;
      extension = "css";
    };
}
