{
  sundry,
  lib,
  is-token,
  tokens,
  ...
}: args': let
  args =
    sundry.attrs.validate {
      file-path = {
        check = value: lib.isList value && lib.all lib.isString value;
        desc = "must be a vfs path to the partial relative to ~/.design-system";
      };
      consumer = {
        default = self: sundry.vfs.path.get.ext self.file-path;
        check = value: lib.isString value;
        desc = "must be a consumer name string";
      };
      body-fn = {
        default = _: lib.id;
        check = value: lib.isFunction value;
        desc = "must be a function that formats the entire partial body";
      };
      line-fn = {
        check = value: lib.isFunction value;
        desc = "must be a function that constructs a line from a name and a value";
      };
      name-fn = {
        default = _: sundry.str.join-with "-";
        check = value: lib.isFunction value;
        desc = "must be a function that turns a token path into a name string";
      };
    }
    args';
  inherit (args) body-fn line-fn name-fn file-path consumer;
in
  lib.pipe tokens [
    (sundry.attrs.walk-until is-token (_: token: token.to.${consumer}))
    (sundry.attrs.collapse (path: value: line-fn (name-fn path) value))
    (sundry.str.join-with "\n")
    body-fn
    (sundry.vfs.file.from-text file-path)
  ]
