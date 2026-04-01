{config, ...}: {
  textMateRules = [
    # -- light-gray
    {
      scope = [
        "punctuation" # punctuation
        "meta.property-list.scss" # scss property lists
        "punctuation.definition.entity.css" # css entity punctuation
        "meta.at-rule.include.scss" # scss include
        "keyword.operator" # operators
        "comment" # comments
      ];
      settings.foreground = config.style.palette.light-gray;
    }

    # -- white
    {
      scope = [
        "variable.other.object" # object vars
        "variable" # general vars
        "variable.parameter" # function params
        "variable.other.readwrite" # mutable vars
        "variable.scss" # scss vars
        "variable.other.object.property" # object properties
        "variable.other.property" # properties
        "entity.other.attribute-name" # attributes
        "entity.name.tag" # html tags
        "meta" # fallback meta
        "source.cpp" # cpp fallback
        "source.css" # css fallback
        "source.css.scss" # scss fallback
      ];
      settings.foreground = config.style.palette.white;
    }

    # -- purple
    {
      scope = [
        "keyword" # keywords
        "keyword.control" # control flow
        "keyword.other" # misc keywords
        "keyword.other.operator" # operator keywords
        "keyword.other.using" # using/import
        "keyword.other.unit" # units
        "constant.numeric.float.suffix" # float suffix
        "constant.numeric" # numbers
        "keyword.other.unit.suffix.floating-point" # float units
        "constant.language" # true/false/null
        "support.constant.property-value.css" # css constants
      ];
      settings.foreground = config.style.palette.purple;
    }

    # -- blue
    {
      scope = [
        "support.type.property-name.css" # css property names
        "entity.name.type" # types
        "storage.type" # type keywords
        "support.type" # built-in types
        "storage.modifier" # modifiers (const, static)
      ];
      settings.foreground = config.style.palette.blue;
    }

    # -- orange
    {
      scope = [
        "meta.function" # function meta
        "entity.name.function" # function names
        "support.function" # built-in functions
        "storage.type.struct" # struct
        "storage.type.class" # class
        "string" # strings
        "string.quoted" # quoted strings
        "string.template" # template strings
        "string.interpolated" # interpolated strings
      ];
      settings.foreground = config.style.palette.orange;
    }

    # -- aqua
    {
      scope = [
        "entity.name.scope-resolution" # ::
        "entity.name.namespace" # namespaces
        "entity.other.attribute-name.pseudo-class.css" # :hover
        "entity.other.attribute-name.class.css" # .class
      ];
      settings.foreground = config.style.palette.aqua;
    }

    # -- red
    {
      scope = [
        "storage.type.template" # templates / generics
        "entity.name.tag.wildcard.scss" # *
        "entity.name.tag.reference.scss" # references
        "meta.property-name.scss" # scss props
        "entity.name.tag.css" # css tags
        "source.css.scss" # scss root
      ];
      settings.foreground = config.style.palette.red;
    }
  ];
}
