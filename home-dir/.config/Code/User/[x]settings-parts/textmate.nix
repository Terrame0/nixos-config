{config, ...}: {
  textMateRules = [
    # -- punctuation
    {
      scope = [
        "punctuation"
        "meta.property-list.scss"
        "punctuation.definition.entity.css"
        "meta.at-rule.include.scss"
      ];
      settings.foreground = config.style.palette.light-gray;
    }

    # -- comments
    {
      scope = "comment";
      settings.foreground = config.style.palette.light-gray;
    }

    # -- variables
    {
      scope = [
        "variable.other.object"
        "variable"
        "variable.parameter"
        "variable.other.readwrite"
        "variable.scss"
      ];
      settings.foreground = config.style.palette.white;
    }

    # -- attributes and properties
    {
      scope = [
        "variable.other.object.property"
        "variable.other.property"
        "entity.other.attribute-name"
        "entity.name.tag"
      ];
      settings.foreground = config.style.palette.white;
    }

    # -- keywords
    {
      scope = [
        "keyword"
        "keyword.control"
        "keyword.other"
        "keyword.other.operator"
        "keyword.other.using"
      ];
      settings.foreground = config.style.palette.purple;
    }

    # -- operators
    {
      scope = "keyword.operator";
      settings.foreground = config.style.palette.light-gray;
    }

    # -- namespaces
    {
      scope = [
        "entity.name.scope-resolution"
        "entity.name.namespace"
      ];
      settings.foreground = config.style.palette.aqua;
    }

    # -- types
    {
      scope = [
        "support.type.property-name.css"
        "entity.name.type"
        "storage.type"
        "support.type"
      ];
      settings.foreground = config.style.palette.blue;
    }

    # -- storage modifiers
    {
      scope = [
        "storage.modifier"
      ];
      settings.foreground = config.style.palette.blue;
    }

    # -- functions
    {
      scope = [
        "meta.function"
        "entity.name.function"
        "support.function"
      ];
      settings.foreground = config.style.palette.orange;
    }

    # -- structures
    {
      scope = [
        "storage.type.struct"
        "storage.type.class"
      ];
      settings.foreground = config.style.palette.orange;
    }

    # -- important
    {
      scope = [
        "storage.type.template"
      ];
      settings.foreground = config.style.palette.red;
    }

    # -- strings
    {
      scope = [
        "string"
        "string.quoted"
        "string.template"
        "string.interpolated"
      ];
      settings.foreground = config.style.palette.orange;
    }

    # -- numeric values
    {
      scope = [
        "keyword.other.unit"
        "constant.numeric.float.suffix"
        "constant.numeric"
        "keyword.other.unit.suffix.floating-point"
      ];
      settings.foreground = config.style.palette.purple;
    }

    # -- constants
    {
      scope = [
        "constant.language"
        "support.constant.property-value.css"
      ];
      settings.foreground = config.style.palette.purple;
    }

    {
      scope = [
        "entity.name.tag.wildcard.scss"
        "entity.name.tag.reference.scss"
        "meta.property-name.scss"
        "entity.name.tag.css"
        "source.css.scss"
        "entity.name.tag.css"
      ];
      settings.foreground = config.style.palette.red;
    }

    {
      scope = [
        "entity.other.attribute-name.pseudo-class.css"
        "entity.other.attribute-name.class.css"
      ];
      settings.foreground = config.style.palette.aqua;
    }

    # -- fallback
    {
      scope = [
        "meta"
        "source.cpp"
        "source.css"
        "source.css.scss"
      ];
      settings.foreground = config.style.palette.white;
    }
  ];
}
