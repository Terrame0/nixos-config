{
  pkgs,
  config-add,
  config,
  ...
}:
config-add "convert"
{
  scss = file-data-in: let
    file-path = config.path.join file-data-in;
    store-path = pkgs.runCommand file-path {
      buildInputs = with pkgs; [sassc];
    } "sassc ${file-data-in.store-path} $out";
  in
    file-data-in
    // {
      store-path = store-path;
      extension = "css";
    };
}
