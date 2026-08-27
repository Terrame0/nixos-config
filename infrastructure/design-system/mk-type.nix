{
  sundry,
  lib,
  ...
}: defs': value: let
  defs =
    sundry.attrs.validate {
      value-check = {
        check = value: lib.isFunction value;
        desc = "must be a validation predicate";
      };
      rendered-values = {
        default = _: value: {};
        check = value: lib.isFunction value;
        desc = "must be a function returning a set of rendered values";
      };
    }
    defs';
in
  if defs.value-check value
  then {
    inherit value;
    to = let
      consumers = ["scss" "lua" "qml" "rasi"];
      result = defs.rendered-values value;
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
