{
  sundry,
  lib,
  consumers,
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
      result = defs.consumer-repr value;
    in
      if !(lib.isAttrs result)
      then throw "a type definition must render its consumers to an attrset of strings"
      else let
        comparison =
          sundry.attrs.compare
          result (lib.genAttrs consumers (_: "..."));
      in
        if comparison.missing != {}
        then
          throw ''
            a type definition is missing rendered values for the following consumers:
            ${sundry.str.pretty comparison.missing}
          ''
        else if comparison.extra != {}
        then
          throw ''
            a type definition rendered values for consumers that are not registered:
            ${sundry.str.pretty comparison.extra}

            registered consumers: ${lib.concatStringsSep ", " consumers}
          ''
        else if !(lib.all lib.isString (lib.attrValues result))
        then throw "a type definition must render every consumer to a string"
        else result;
  }
  else throw "value '${lib.typeOf value}' did not pass type value validation"
