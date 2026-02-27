{
  pkgs,
  config-add,
  config,
  ...
}:
config-add "convert"
{
  scss = file-data: let
    file-path = config.path.join file-data;
    new-store-path = pkgs.runCommand file-path {
      buildInputs = with pkgs; [sassc];
    } "sassc ${file-data.store-path} $out";
  in
    file-data
    // {
      store-path = new-store-path;
      extension = "css";
    };
}
