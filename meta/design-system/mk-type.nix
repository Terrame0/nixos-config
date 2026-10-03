{
  sundry,
  lib,
  ...
}: defs': value: let
  defs =
    sundry.attrs.validate {
      name = {
        check = value: lib.isString value && value != "";
        desc = "must be a non-empty type name string";
      };
      value-check = {
        check = value: lib.isFunction value;
        desc = "must be a validation predicate";
      };
      native-repr = {
        default = _: lib.id;
        check = value: lib.isFunction value;
        desc = "must be a function returning the native value";
      };
      consumer-repr = {
        default = _: value: {};
        check = value: lib.isFunction value;
        desc = "must be a function returning a set of rendered values";
      };
    }
    defs';
in
  if defs.value-check value
  then {
    type = defs.name;
    native = defs.native-repr value;
    to = let
      consumers = ["css" "scss" "lua" "qml" "rasi"];
      result = defs.consumer-repr value;
      comparison =
        sundry.attrs.compare
        result (lib.genAttrs consumers (_: "..."));
    in
      if comparison.missing == {}
      then result
      else
        throw ''
          a type definition is missing rendered values for the following consumers:
          ${sundry.str.pretty comparison.missing}
        '';
  }
  else throw "value '${lib.typeOf value}' did not pass type value validation"
